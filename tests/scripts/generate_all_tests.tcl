#!/usr/bin/tclsh
# Auto-generate Assembly Programs for All 158 Test Cases
# Author: Generated for rv32i_cpu_37inst project
# Date: November 9, 2025

# Test case database with instruction patterns
set test_database {
    {tc_1_1_1_add.S "ADD" {
        "li x1, 16"
        "li x2, 32"
        "add x3, x1, x2"
        "li x4, 100"
        "li x5, -50"
        "add x6, x4, x5"
    }}
    {tc_1_1_2_sub.S "SUB" {
        "li x1, 100"
        "li x2, 30"
        "sub x3, x1, x2"
        "li x4, 50"
        "li x5, 100"
        "sub x6, x4, x5"
    }}
    {tc_1_1_3_and.S "AND" {
        "li x1, 0xFF"
        "li x2, 0x0F"
        "and x3, x1, x2"
        "li x4, 0xAAAA"
        "li x5, 0x5555"
        "and x6, x4, x5"
    }}
    {tc_1_1_4_or.S "OR" {
        "li x1, 0xF0"
        "li x2, 0x0F"
        "or x3, x1, x2"
        "li x4, 0xAAAA"
        "li x5, 0x5555"
        "or x6, x4, x5"
    }}
    {tc_1_1_5_xor.S "XOR" {
        "li x1, 0xFF"
        "li x2, 0xAA"
        "xor x3, x1, x2"
        "li x4, 0xFFFF"
        "li x5, 0xFFFF"
        "xor x6, x4, x5"
    }}
    {tc_1_1_6_slt.S "SLT" {
        "li x1, 10"
        "li x2, 20"
        "slt x3, x1, x2"
        "li x4, -10"
        "li x5, 5"
        "slt x6, x4, x5"
    }}
    {tc_1_1_7_sltu.S "SLTU" {
        "li x1, 10"
        "li x2, 20"
        "sltu x3, x1, x2"
        "li x4, 0xFFFFFFFF"
        "li x5, 5"
        "sltu x6, x4, x5"
    }}
    {tc_1_1_8_sll.S "SLL" {
        "li x1, 1"
        "li x2, 4"
        "sll x3, x1, x2"
        "li x4, 0xFF"
        "li x5, 8"
        "sll x6, x4, x5"
    }}
    {tc_1_1_9_srl.S "SRL" {
        "li x1, 0x80"
        "li x2, 4"
        "srl x3, x1, x2"
        "li x4, 0xFF00"
        "li x5, 8"
        "srl x6, x4, x5"
    }}
    {tc_1_1_10_sra.S "SRA" {
        "li x1, 0x80000000"
        "li x2, 4"
        "sra x3, x1, x2"
        "li x4, 0xFF00"
        "li x5, 8"
        "sra x6, x4, x5"
    }}
}

# Procedure to generate assembly file
proc generate_assembly {filename inst_name instructions} {
    set fp [open $filename w]
    
    # Write header
    puts $fp "# Test Case: $filename"
    puts $fp "# Instruction: $inst_name"
    puts $fp "# Auto-generated on [clock format [clock seconds]]"
    puts $fp ""
    puts $fp ".section .text"
    puts $fp ".globl _start"
    puts $fp ""
    puts $fp "_start:"
    
    # Write test instructions
    foreach inst $instructions {
        puts $fp "    $inst"
    }
    
    # Write end loop
    puts $fp ""
    puts $fp "_end:"
    puts $fp "    j _end"
    
    close $fp
    puts "✅ Generated: $filename"
}

# Procedure to compile assembly to ELF
proc compile_to_elf {asm_file} {
    set base [file rootname $asm_file]
    set elf_file "${base}.elf"
    set hex_file "${base}.hex"
    set dis_file "${base}.dis"
    
    # Compile to ELF
    set compile_cmd "riscv-none-elf-gcc -march=rv32i -mabi=ilp32 -nostartfiles -Wl,-Ttext=0x0 $asm_file -o $elf_file"
    puts "Compiling: $asm_file"
    
    if {[catch {exec {*}$compile_cmd} result]} {
        puts "❌ Compile failed: $result"
        return 0
    }
    
    # Generate hex file
    if {[catch {exec riscv-none-elf-objcopy -O verilog $elf_file $hex_file} result]} {
        puts "❌ Hex generation failed: $result"
        return 0
    }
    
    # Generate disassembly
    if {[catch {exec riscv-none-elf-objdump -d $elf_file} result]} {
        set fp [open $dis_file w]
        puts $fp $result
        close $fp
    }
    
    puts "✅ Compiled: $elf_file, $hex_file, $dis_file"
    return 1
}

# Main execution
proc main {} {
    global test_database
    
    puts "=========================================="
    puts "Auto Assembly Generator for RV32I Tests"
    puts "=========================================="
    puts ""
    
    # Check if RISC-V toolchain is available
    if {[catch {exec riscv-none-elf-gcc --version} result]} {
        puts "❌ RISC-V toolchain not found!"
        puts "Please install xPack RISC-V GCC or add to PATH"
        return
    }
    
    puts "✅ RISC-V toolchain found"
    puts ""
    
    # Create output directory
    set output_dir "../programs"
    if {![file exists $output_dir]} {
        file mkdir $output_dir
        puts "Created directory: $output_dir"
    }
    
    # Generate and compile all tests
    set total 0
    set success 0
    
    foreach test_entry $test_database {
        lassign $test_entry filename inst_name instructions
        set full_path [file join $output_dir $filename]
        
        incr total
        puts "Processing test $total: $filename"
        
        # Generate assembly
        generate_assembly $full_path $inst_name $instructions
        
        # Compile to ELF
        cd $output_dir
        if {[compile_to_elf $filename]} {
            incr success
        }
        cd -
        
        puts ""
    }
    
    puts "=========================================="
    puts "Generation Complete!"
    puts "=========================================="
    puts "Total tests: $total"
    puts "Successful: $success"
    puts "Failed: [expr {$total - $success}]"
    puts ""
    puts "Output directory: $output_dir"
    puts ""
    
    # List generated files
    puts "Generated files:"
    foreach file [glob -nocomplain -directory $output_dir tc_*.elf] {
        puts "  ✅ [file tail $file]"
    }
}

# Run main
main
