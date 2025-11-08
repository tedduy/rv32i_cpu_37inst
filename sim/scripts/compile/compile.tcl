# ==============================================================================
# RV32I CPU - Compilation Script (TCL)
# Supports ModelSim/QuestaSim
# ==============================================================================

# Determine project root directory
# When running in QuestaSim, use pwd-based paths
set current_dir [pwd]
if {[string match "*sim/scripts/compile*" $current_dir] || [string match "*sim\\scripts\\compile*" $current_dir]} {
    # Running from sim/scripts/compile
    set project_root [file normalize [file join $current_dir "../../.."]]
} elseif {[string match "*sim/scripts*" $current_dir] || [string match "*sim\\scripts*" $current_dir]} {
    # Running from sim/scripts
    set project_root [file normalize [file join $current_dir "../.."]]
} elseif {[string match "*sim*" $current_dir]} {
    # Running from sim
    set project_root [file normalize [file join $current_dir ".."]]
} else {
    # Running from project root
    set project_root $current_dir
}

set rtl_dir [file join $project_root "rtl"]
set tb_dir [file join $project_root "tb"]
set sim_dir [file join $project_root "sim"]
set work_dir [file join $sim_dir "work"]

# Color output procedures
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

# Main compilation
puts_header "RV32I CPU - Compilation Script"
puts ""

# Create and setup work library
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
puts_color green "\[OK\] Work library created"
puts ""

# Define all RTL files in order
puts_color cyan "Step 2: Compiling RTL files..."
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
        puts_color red "\[FAIL\] File not found: $file"
        set compile_error 1
        break
    }
    
    set filename [file tail $file]
    puts "  \[$file_count/[llength $rtl_files]\] Compiling $filename..."
    
    if {[catch {vlog -sv -work work $file} result]} {
        puts_color red "\[FAIL\] Error compiling $filename"
        puts $result
        set compile_error 1
        break
    }
}

if {$compile_error} {
    puts ""
    puts_header "RTL Compilation: FAILED"
    # Use quit -code for ModelSim, exit for tclsh
    if {[info commands vsim] ne ""} {
        quit -code 1
    } else {
        exit 1
    }
}

puts_color green "\[OK\] All RTL files compiled successfully"
puts ""

# Compile testbench
puts_color cyan "Step 3: Compiling testbench..."
set tb_files [list \
    "$tb_dir/tb_rv32i_top.sv" \
]

foreach file $tb_files {
    if {![file exists $file]} {
        puts_color red "\[FAIL\] Testbench file not found: $file"
        if {[info commands vsim] ne ""} {
            quit -code 1
        } else {
            exit 1
        }
    }
    
    set filename [file tail $file]
    puts "  Compiling $filename..."
    
    if {[catch {vlog -sv -work work $file} result]} {
        puts_color red "\[FAIL\] Error compiling testbench"
        puts $result
        if {[info commands vsim] ne ""} {
            quit -code 1
        } else {
            exit 1
        }
    }
}

puts_color green "\[OK\] Testbench compiled successfully"
puts ""

# Summary
puts_header "Compilation: SUCCESS"
puts ""
puts "Work library: $work_dir"
puts "RTL files:    [llength $rtl_files] modules"
puts "Testbench:    [llength $tb_files] files"
puts ""
puts_color cyan "Ready to simulate!"
puts "  Run: vsim -do \"source ../scripts/run_sim.tcl\""
puts ""

# Exit successfully (use quit for ModelSim, exit for tclsh)
if {[info commands vsim] ne ""} {
    # Running in ModelSim - don't exit, just return
    # quit -code 0
} else {
    exit 0
}
