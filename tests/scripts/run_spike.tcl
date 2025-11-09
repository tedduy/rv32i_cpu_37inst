# =============================================================================
# Spike Test Runner Script (TCL)
# =============================================================================
# Compiles RISC-V assembly and runs Spike to generate golden reference
# Usage: tclsh run_spike.tcl <test_file.S>
# =============================================================================

# =============================================================================
# Configuration
# =============================================================================

# Get script directory
set script_dir [file dirname [info script]]
set program_dir [file normalize "$script_dir/../programs"]
set golden_dir [file normalize "$script_dir/../golden"]
set build_dir [file normalize "$script_dir/../build"]

# RISC-V Toolchain (adjust for your installation)
set riscv_prefix "riscv64-unknown-elf-"
set gcc "${riscv_prefix}gcc"
set objcopy "${riscv_prefix}objcopy"
set objdump "${riscv_prefix}objdump"

# Spike simulator
set spike "spike"

# Compilation flags
set cflags "-march=rv32i -mabi=ilp32 -nostdlib -nostartfiles -Ttext=0x00000000"

# =============================================================================
# Helper Procedures
# =============================================================================

proc print_header {text} {
    puts ""
    puts "================================================================="
    puts "  $text"
    puts "================================================================="
}

proc print_step {step text} {
    puts "\[$step\] $text"
}

proc check_command {cmd} {
    if {[catch {exec which $cmd} result]} {
        return 0
    }
    return 1
}

# =============================================================================
# Compile Test Procedure
# =============================================================================

proc compile_test {asm_file} {
    global build_dir gcc objcopy objdump cflags
    
    set test_name [file rootname [file tail $asm_file]]
    set elf_file "$build_dir/${test_name}.elf"
    set bin_file "$build_dir/${test_name}.bin"
    set hex_file "$build_dir/${test_name}.hex"
    set dis_file "$build_dir/${test_name}.dis"
    
    print_header "Compiling: $test_name"
    
    # Create build directory
    file mkdir $build_dir
    
    # Compile to ELF
    print_step "1/5" "Compiling $asm_file to ELF..."
    if {[catch {exec $gcc {*}$cflags $asm_file -o $elf_file} result]} {
        puts "ERROR: Compilation failed!"
        puts $result
        return 0
    }
    
    # Generate binary
    print_step "2/5" "Extracting binary..."
    if {[catch {exec $objcopy -O binary $elf_file $bin_file} result]} {
        puts "ERROR: Binary extraction failed!"
        puts $result
        return 0
    }
    
    # Generate hex file
    print_step "3/5" "Generating hex file..."
    if {[catch {exec $objcopy -O verilog $elf_file $hex_file} result]} {
        puts "ERROR: Hex generation failed!"
        puts $result
        return 0
    }
    
    # Generate disassembly
    print_step "4/5" "Generating disassembly..."
    if {[catch {exec $objdump -d $elf_file} result]} {
        puts "ERROR: Disassembly failed!"
        puts $result
        return 0
    } else {
        set f [open $dis_file w]
        puts $f $result
        close $f
    }
    
    print_step "5/5" "Compilation complete!"
    puts "  ELF: $elf_file"
    puts "  HEX: $hex_file"
    puts "  DIS: $dis_file"
    puts ""
    
    return 1
}

# =============================================================================
# Run Spike Procedure
# =============================================================================

proc run_spike {asm_file} {
    global build_dir golden_dir spike
    
    set test_name [file rootname [file tail $asm_file]]
    set elf_file "$build_dir/${test_name}.elf"
    set log_file "$golden_dir/${test_name}_spike.log"
    
    print_header "Running Spike: $test_name"
    
    # Create golden directory
    file mkdir $golden_dir
    
    # Run Spike with logging
    print_step "1/2" "Executing in Spike simulator..."
    if {[catch {exec $spike --isa=RV32I -l --log-commits $elf_file 2>@1} result]} {
        # Spike may return non-zero but still generate output
        set spike_output $result
    } else {
        set spike_output $result
    }
    
    # Filter output for core traces
    set f [open $log_file w]
    foreach line [split $spike_output "\n"] {
        if {[string match "*core*" $line]} {
            puts $f $line
        }
    }
    close $f
    
    # Display sample output
    print_step "2/2" "Golden reference generated!"
    puts "  Log: $log_file"
    puts ""
    puts "Sample output (first 10 lines):"
    
    if {[catch {open $log_file r} f]} {
        puts "  (empty or no output)"
    } else {
        set count 0
        while {[gets $f line] >= 0 && $count < 10} {
            puts "  $line"
            incr count
        }
        close $f
    }
    puts ""
    
    return 1
}

# =============================================================================
# Main Script
# =============================================================================

proc main {argv} {
    global program_dir golden_dir build_dir gcc spike
    
    puts ""
    puts "======================================================================"
    puts "  RISC-V Spike Test Runner (TCL)"
    puts "======================================================================"
    puts ""
    
    # Check if assembly file provided
    if {[llength $argv] == 0} {
        puts "Usage: tclsh run_spike.tcl <test_file.S> \[<test_file2.S> ...\]"
        puts ""
        puts "Examples:"
        puts "  tclsh run_spike.tcl tc_1_1_1_add.S"
        puts "  tclsh run_spike.tcl ../programs/tc_1_1_1_add.S"
        puts ""
        exit 1
    }
    
    # Check toolchain
    puts "Checking RISC-V toolchain..."
    if {![check_command $gcc]} {
        puts "ERROR: $gcc not found!"
        puts "Please install RISC-V GNU toolchain and add to PATH"
        puts "Download: https://github.com/riscv-collab/riscv-gnu-toolchain"
        exit 1
    }
    puts "  ✓ GCC found"
    
    # Check Spike
    puts "Checking Spike simulator..."
    if {![check_command $spike]} {
        puts "ERROR: Spike not found!"
        puts "Please install Spike RISC-V ISA Simulator"
        puts "Download: https://github.com/riscv-software-src/riscv-isa-sim"
        exit 1
    }
    puts "  ✓ Spike found"
    puts ""
    
    # Process each test file
    foreach asm_file $argv {
        # Resolve path
        if {![file pathtype $asm_file] eq "absolute"} {
            if {[file exists $asm_file]} {
                set asm_file [file normalize $asm_file]
            } elseif {[file exists "$program_dir/$asm_file"]} {
                set asm_file [file normalize "$program_dir/$asm_file"]
            }
        }
        
        # Check if file exists
        if {![file exists $asm_file]} {
            puts "ERROR: File not found: $asm_file"
            continue
        }
        
        # Compile
        if {![compile_test $asm_file]} {
            puts "ERROR: Compilation failed for $asm_file"
            continue
        }
        
        # Run Spike
        if {![run_spike $asm_file]} {
            puts "ERROR: Spike execution failed for $asm_file"
            continue
        }
        
        puts "✓ Test completed successfully: [file tail $asm_file]"
        puts ""
    }
    
    puts "======================================================================"
    puts "  All tests completed!"
    puts "======================================================================"
    puts ""
    puts "Generated files:"
    puts "  Build artifacts: $build_dir"
    puts "  Golden logs:     $golden_dir"
    puts ""
}

# Run main
main $argv
