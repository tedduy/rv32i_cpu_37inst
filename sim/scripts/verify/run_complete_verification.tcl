# ==============================================================================
# RV32I Complete Verification with Compilation and Simulation (TCL)
# Automated workflow for single-cycle and pipeline testing
# ==============================================================================

# Setup paths
set script_dir [file dirname [info script]]
set project_root [file normalize "$script_dir/../.."]
set rtl_dir "$project_root/rtl"
set tb_dir "$project_root/tb"
set sim_dir "$project_root/sim"

# Color output
proc puts_color {color text} {
    set colors {
        red     "\033\[0;31m"
        green   "\033\[0;32m"
        yellow  "\033\[1;33m"
        blue    "\033\[0;34m"
        cyan    "\033\[0;36m"
        reset   "\033\[0m"
    }
    set code [dict get $colors $color]
    set reset [dict get $colors reset]
    puts "${code}${text}${reset}"
}

puts_color blue "========================================================================"
puts_color blue "RV32I Complete Verification - TCL Script"
puts_color blue "========================================================================"
puts ""

# Create work library if doesn't exist
if {![file exists work]} {
    puts_color yellow "Creating work library..."
    vlib work
    vmap work work
}

# ==============================================================================
# Step 1: Compile RTL and Testbench
# ==============================================================================
puts_color cyan "Step 1: Compiling RTL and Testbench..."

# Compile all SystemVerilog files
set sv_files [list \
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
    "$rtl_dir/core/stages/Complete_Functional_Units.sv" \
    "$rtl_dir/core/pipeline/IF_ID_Register.sv" \
    "$rtl_dir/core/pipeline/ID_EX_Register.sv" \
    "$rtl_dir/core/pipeline/EX_MEM_Register.sv" \
    "$rtl_dir/core/pipeline/MEM_WB_Register.sv" \
    "$rtl_dir/core/hazard/Hazard_Detection_Unit.sv" \
    "$rtl_dir/core/hazard/Forwarding_Unit.sv" \
    "$rtl_dir/top/rv32i_top.sv" \
    "$tb_dir/tb_rv32i_top.sv" \
]

foreach file $sv_files {
    if {[file exists $file]} {
        if {[catch {vlog -sv -work work $file} result]} {
            puts_color red "(FAIL) Error compiling $file"
            puts $result
            exit 1
        }
    } else {
        puts_color red "(FAIL) File not found: $file"
        exit 1
    }
}

puts_color green "(OK) All files compiled successfully"
puts ""

# ==============================================================================
# Step 2: Run Single-Cycle Simulation
# ==============================================================================
puts_color cyan "Step 2: Running Single-Cycle Simulation..."

# Set single-cycle mode define
set ::env(SIM_MODE) "SINGLE_CYCLE"

# Run simulation
if {[catch {
    vsim -c -do "
        vsim -voptargs=+acc work.tb_rv32i_top +define+SINGLE_CYCLE
        run -all
        quit -f
    " > "$sim_dir/single_cycle_output.log" 2>&1
} result]} {
    puts_color red "(FAIL) Single-cycle simulation failed"
    puts $result
    exit 1
}

# Check if simulation produced output
if {![file exists "$sim_dir/single_cycle_output.log"]} {
    puts_color red "(FAIL) Single-cycle log file not created"
    exit 1
}

# Count instructions in log
set fp [open "$sim_dir/single_cycle_output.log" r]
set sc_inst_count 0
while {[gets $fp line] >= 0} {
    if {[regexp {\[\s*\d+\]} $line]} {
        incr sc_inst_count
    }
}
close $fp

puts_color green "(OK) Single-cycle simulation completed"
puts "  Instructions executed: $sc_inst_count"
puts ""

# ==============================================================================
# Step 3: Run Pipeline Simulation
# ==============================================================================
puts_color cyan "Step 3: Running Pipeline Simulation..."

# Set pipeline mode define
set ::env(SIM_MODE) "PIPELINE"

# Run simulation
if {[catch {
    vsim -c -do "
        vsim -voptargs=+acc work.tb_rv32i_top +define+PIPELINE
        run -all
        quit -f
    " > "$sim_dir/pipeline_output.log" 2>&1
} result]} {
    puts_color red "(FAIL) Pipeline simulation failed"
    puts $result
    exit 1
}

# Check if simulation produced output
if {![file exists "$sim_dir/pipeline_output.log"]} {
    puts_color red "(FAIL) Pipeline log file not created"
    exit 1
}

# Count instructions in log
set fp [open "$sim_dir/pipeline_output.log" r]
set pl_inst_count 0
while {[gets $fp line] >= 0} {
    if {[regexp {\[\s*\d+\]} $line]} {
        incr pl_inst_count
    }
}
close $fp

puts_color green "(OK) Pipeline simulation completed"
puts "  Instructions executed: $pl_inst_count"
puts ""

# ==============================================================================
# Step 4: Compare Results
# ==============================================================================
puts_color cyan "Step 4: Comparing Results..."

# Source the verification script
source "$script_dir/verify_pipeline.tcl"

# Parse both logs
set sc_data [parse_log_file "$sim_dir/single_cycle_output.log"]
set pl_data [parse_log_file "$sim_dir/pipeline_output.log"]

# Print comparison report
set result [print_comparison_report $sc_data $pl_data]

# ==============================================================================
# Summary
# ==============================================================================
puts ""
puts_color blue "========================================================================"
puts_color blue "Verification Summary"
puts_color blue "========================================================================"
puts "Single-cycle log:  $sim_dir/single_cycle_output.log"
puts "Pipeline log:      $sim_dir/pipeline_output.log"
puts ""

if {$result == 0} {
    puts_color green "(OK)(OK)(OK) VERIFICATION PASSED (OK)(OK)(OK)"
    puts ""
    puts "Next Steps:"
    puts "1. Review performance metrics"
    puts "2. Analyze CPI and hazard statistics"
    puts "3. View waveform: vsim -view $sim_dir/waveforms/wave.wlf"
} else {
    puts_color red "(FAIL)(FAIL)(FAIL) VERIFICATION FAILED (FAIL)(FAIL)(FAIL)"
    puts ""
    puts "Next Steps:"
    puts "1. Review logs for detailed results"
    puts "2. Check waveform: vsim -view $sim_dir/waveforms/wave.wlf"
    puts "3. Run detailed analysis: tclsh verify_pipeline.tcl -v"
}

puts ""
exit $result
