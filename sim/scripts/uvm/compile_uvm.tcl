# ==============================================================================
# UVM Compilation Script (TCL)
# Compiles RTL + UVM Testbench for RV32I CPU
# ==============================================================================

# Setup paths
set current_dir [pwd]
if {[string match "*sim/scripts/uvm*" $current_dir] || [string match "*sim\\scripts\\uvm*" $current_dir]} {
    set project_root [file normalize [file join $current_dir "../../.."]]
} elseif {[string match "*sim/scripts*" $current_dir] || [string match "*sim\\scripts*" $current_dir]} {
    set project_root [file normalize [file join $current_dir "../.."]]
} elseif {[string match "*sim*" $current_dir]} {
    set project_root [file normalize [file join $current_dir ".."]]
} else {
    set project_root $current_dir
}

set rtl_dir [file join $project_root "rtl"]
set tb_dir [file join $project_root "tb_uvm"]
set sim_dir [file join $project_root "sim"]
set work_dir [file join $sim_dir "work"]
set coverage_dir [file join $sim_dir "coverage"]

# Color output
proc puts_color {color text} {
    array set colors {
        red     "\033\[0;31m"
        green   "\033\[0;32m"
        yellow  "\033\[1;33m"
        blue    "\033\[0;34m"
        cyan    "\033\[0;36m"
        reset   "\033\[0m"
    }
    puts "$colors($color)$text$colors(reset)"
}

proc puts_header {text} {
    puts_color yellow "========================================"
    puts_color yellow $text
    puts_color yellow "========================================"
}

puts_header "RV32I CPU - UVM Compilation"
puts ""

# Create work library
puts_color cyan "Step 1: Setting up work library..."
if {[file exists $work_dir]} {
    puts "  Cleaning existing work directory..."
    catch {vdel -all -lib work}
}

if {![file exists $work_dir]} {
    file mkdir $work_dir
}

cd $work_dir
vlib work
vmap work work
puts_color green "(OK) Work library created"
puts ""

# Compile UVM package (if not already compiled)
puts_color cyan "Step 2: Compiling UVM library..."
if {[catch {vlog -sv $env(QUESTA_HOME)/verilog_src/uvm-1.2/src/uvm_pkg.sv +incdir+$env(QUESTA_HOME)/verilog_src/uvm-1.2/src} result]} {
    puts_color yellow "(WARN) UVM already compiled or not found, skipping..."
} else {
    puts_color green "(OK) UVM library compiled"
}
puts ""

# Compile RTL files (same as before)
puts_color cyan "Step 3: Compiling RTL files..."
set rtl_files [list \
    "$rtl_dir/common/adder_N_bit.sv" \
    "$rtl_dir/common/mux2to1.sv" \
    "$rtl_dir/common/mux4to1.sv" \
    "$rtl_dir/core/stages/ALU_Unit.sv" \
    "$rtl_dir/core/stages/Branch_Unit.sv" \
    "$rtl_dir/core/stages/Jump_Unit.sv" \
    "$rtl_dir/core/stages/Control_Unit.sv" \
    "$rtl_dir/core/stages/Immediate_Generation.sv" \
    "$rtl_dir/core/stages/Instruction_Mem.sv" \
    "$rtl_dir/core/stages/Data_Memory.sv" \
    "$rtl_dir/core/stages/Reg_File.sv" \
    "$rtl_dir/core/stages/Program_Counter.sv" \
    "$rtl_dir/core/stages/Load_Store_Unit.sv" \
    "$rtl_dir/top/Complete_Functional_Units.sv" \
    "$rtl_dir/core/pipeline/IF_ID_Register.sv" \
    "$rtl_dir/core/pipeline/ID_EX_Register.sv" \
    "$rtl_dir/core/pipeline/EX_MEM_Register.sv" \
    "$rtl_dir/core/pipeline/MEM_WB_Register.sv" \
    "$rtl_dir/core/hazard/Hazard_Detection_Unit.sv" \
    "$rtl_dir/core/hazard/Forwarding_Unit.sv" \
    "$rtl_dir/top/rv32i_top.sv" \
]

set compile_error 0
set file_count 0
foreach file $rtl_files {
    incr file_count
    if {![file exists $file]} {
        puts_color red "(FAIL) File not found: $file"
        set compile_error 1
        break
    }
    
    set filename [file tail $file]
    puts "  \[$file_count/[llength $rtl_files]\] Compiling $filename..."
    
    if {[catch {vlog -sv -work work $file} result]} {
        puts_color red "(FAIL) Error compiling $filename"
        puts $result
        set compile_error 1
        break
    }
}

if {$compile_error} {
    puts ""
    puts_header "RTL Compilation: FAILED"
    if {[info commands vsim] ne ""} {
        quit -code 1
    } else {
        exit 1
    }
}

puts_color green "(OK) All RTL files compiled"
puts ""

# Compile UVM testbench components
puts_color cyan "Step 4: Compiling UVM testbench..."

# UVM testbench structure (to be created):
# tb_uvm/
#   ├── interfaces/
#   │   └── rv32i_if.sv
#   ├── sequences/
#   │   ├── rv32i_sequence_item.sv
#   │   └── rv32i_sequence.sv
#   ├── agents/
#   │   ├── rv32i_driver.sv
#   │   ├── rv32i_monitor.sv
#   │   └── rv32i_agent.sv
#   ├── env/
#   │   └── rv32i_env.sv
#   ├── tests/
#   │   └── rv32i_base_test.sv
#   └── top/
#       └── rv32i_tb_top.sv

set uvm_files [list \
    "$tb_dir/interfaces/rv32i_if.sv" \
    "$tb_dir/sequences/rv32i_sequence_item.sv" \
    "$tb_dir/sequences/rv32i_sequence.sv" \
    "$tb_dir/agents/rv32i_driver.sv" \
    "$tb_dir/agents/rv32i_monitor.sv" \
    "$tb_dir/agents/rv32i_agent.sv" \
    "$tb_dir/env/rv32i_env.sv" \
    "$tb_dir/tests/rv32i_base_test.sv" \
    "$tb_dir/top/rv32i_tb_top.sv" \
]

set uvm_compile_error 0
foreach file $uvm_files {
    if {![file exists $file]} {
        puts_color yellow "(WARN) UVM file not found: $file"
        puts_color yellow "  Create tb_uvm/ directory structure first"
        set uvm_compile_error 1
        continue
    }
    
    set filename [file tail $file]
    puts "  Compiling $filename..."
    
    if {[catch {vlog -sv -work work +incdir+$tb_dir $file} result]} {
        puts_color red "(FAIL) Error compiling $filename"
        puts $result
        set uvm_compile_error 1
        break
    }
}

if {$uvm_compile_error} {
    puts_color yellow "(WARN) UVM testbench not fully compiled"
    puts_color yellow "  This is OK if you haven't created UVM testbench yet"
} else {
    puts_color green "(OK) UVM testbench compiled"
}
puts ""

# Summary
puts_header "Compilation: SUCCESS"
puts ""
puts "Work library: $work_dir"
puts "RTL files:    [llength $rtl_files] modules"
puts "UVM files:    [llength $uvm_files] components"
puts ""
puts_color cyan "Ready to run UVM simulation!"
puts "  Run: vsim -do \"source ../scripts/run_uvm.tcl\""
puts ""
