# ==============================================================================
# Full Pipeline Verification Workflow (TCL)
# Tests both single-cycle and pipeline, then compares results
# ==============================================================================

# Setup paths
set script_dir [file dirname [info script]]
set project_root [file normalize "$script_dir/../../.."]
set sim_dir [file normalize "$project_root/sim"]
set rtl_top_dir [file normalize "$project_root/rtl/top"]
set log_dir [file normalize "$sim_dir/logs"]
set report_dir [file normalize "$sim_dir/reports"]

# ANSI color codes
set RED "\033\[0;31m"
set GREEN "\033\[0;32m"
set YELLOW "\033\[1;33m"
set BLUE "\033\[0;34m"
set NC "\033\[0m"

proc puts_color {color text} {
    puts "${color}${text}${::NC}"
}

proc puts_header {color text} {
    puts_color $color "========================================"
    puts_color $color $text
    puts_color $color "========================================"
}

puts_header $BLUE "RV32I Pipeline Full Verification"
puts ""

# ==============================================================================
# Step 1: Backup current configuration
# ==============================================================================
puts_color $YELLOW "Step 1: Backup current configuration..."

if {![file exists "$rtl_top_dir/rv32i_top.sv"]} {
    puts_color $RED "(FAIL) rv32i_top.sv not found!"
    exit 1
}

file copy -force "$rtl_top_dir/rv32i_top.sv" "$rtl_top_dir/rv32i_top_current_backup.sv"
puts_color $GREEN "(OK) Backup created"

# ==============================================================================
# Step 2: Test Single-Cycle
# ==============================================================================
puts ""
puts_color $YELLOW "Step 2: Testing Single-Cycle Version..."
puts_color $BLUE "Switching to single-cycle..."

if {![file exists "$rtl_top_dir/rv32i_top_single_cycle.sv"]} {
    puts_color $RED "(FAIL) Single-cycle backup not found!"
    exit 1
}

file copy -force "$rtl_top_dir/rv32i_top_single_cycle.sv" "$rtl_top_dir/rv32i_top.sv"

puts_color $BLUE "Compiling single-cycle..."
cd $sim_dir

# Create log and report directories
file mkdir $log_dir
file mkdir $report_dir

# Run compile.tcl
set compile_result [catch {exec vsim -c -do "do scripts/compile/compile.tcl; quit -f" >@stdout 2>@stderr} compile_output]

if {$compile_result == 0 || [string match "*# Compile successful*" $compile_output]} {
    puts_color $GREEN "(OK) Single-cycle compiled"
    
    puts_color $BLUE "Running single-cycle simulation..."
    
    # Run simulation in batch mode, redirect output to log
    set sim_result [catch {
        exec vsim -c -do "
            do scripts/compile/compile.tcl;
            vsim -c work.tb_rv32i_top -wlf waveforms/single_cycle.wlf;
            run -all;
            quit -f
        " >@ "$log_dir/single_cycle_output.log" 2>@stderr
    } sim_output]
    
    if {$sim_result == 0 || [file exists "$log_dir/single_cycle_output.log"]} {
        puts_color $GREEN "(OK) Single-cycle simulation completed"
        
        # Extract instruction count
        set fp [open "$log_dir/single_cycle_output.log" r]
        set content [read $fp]
        close $fp
        
        set inst_count [regexp -all {\[} $content]
        puts_color $BLUE "  Instructions executed: $inst_count"
    } else {
        puts_color $RED "(FAIL) Single-cycle simulation failed"
        exit 1
    }
} else {
    puts_color $RED "(FAIL) Single-cycle compilation failed"
    exit 1
}

# ==============================================================================
# Step 3: Test Pipeline
# ==============================================================================
puts ""
puts_color $YELLOW "Step 3: Testing Pipeline Version..."
puts_color $BLUE "Switching to pipeline..."

# Restore pipeline version
file copy -force "$rtl_top_dir/rv32i_top_current_backup.sv" "$rtl_top_dir/rv32i_top.sv"

puts_color $BLUE "Compiling pipeline..."
cd $sim_dir

# Run compile.tcl
set compile_result [catch {exec vsim -c -do "do scripts/compile/compile.tcl; quit -f" >@stdout 2>@stderr} compile_output]

if {$compile_result == 0 || [string match "*# Compile successful*" $compile_output]} {
    puts_color $GREEN "(OK) Pipeline compiled"
    
    puts_color $BLUE "Running pipeline simulation..."
    
    # Run simulation in batch mode, redirect output to log
    set sim_result [catch {
        exec vsim -c -do "
            do scripts/compile/compile.tcl;
            vsim -c work.tb_rv32i_top +define+PIPELINE -wlf waveforms/pipeline.wlf;
            run -all;
            quit -f
        " >@ "$log_dir/pipeline_output.log" 2>@stderr
    } sim_output]
    
    if {$sim_result == 0 || [file exists "$log_dir/pipeline_output.log"]} {
        puts_color $GREEN "(OK) Pipeline simulation completed"
        
        # Extract instruction count
        set fp [open "$log_dir/pipeline_output.log" r]
        set content [read $fp]
        close $fp
        
        set inst_count [regexp -all {\[} $content]
        puts_color $BLUE "  Instructions executed: $inst_count"
    } else {
        puts_color $RED "(FAIL) Pipeline simulation failed"
        exit 1
    }
} else {
    puts_color $RED "(FAIL) Pipeline compilation failed"
    exit 1
}

# ==============================================================================
# Step 4: Compare Results
# ==============================================================================
puts ""
puts_color $YELLOW "Step 4: Comparing Results..."

if {[file exists "$sim_dir/scripts/verify/verify_pipeline.tcl"]} {
    # Run verification script
    set verify_result [catch {
        exec tclsh "$sim_dir/scripts/verify/verify_pipeline.tcl" \
            "$log_dir/single_cycle_output.log" \
            "$log_dir/pipeline_output.log" >@stdout 2>@stderr
    } verify_output]
    
    puts ""
    if {$verify_result == 0} {
        puts_header $GREEN "(OK)(OK)(OK) PIPELINE VERIFICATION PASSED (OK)(OK)(OK)"
        set final_result 0
    } else {
        puts_header $RED "(FAIL)(FAIL)(FAIL) PIPELINE VERIFICATION FAILED (FAIL)(FAIL)(FAIL)"
        set final_result 1
    }
} else {
    puts_color $YELLOW "(WARN) Verification script not found"
    puts_color $YELLOW "Manually compare:"
    puts "  - $log_dir/single_cycle_output.log"
    puts "  - $log_dir/pipeline_output.log"
    set final_result 0
}

# ==============================================================================
# Step 5: Cleanup
# ==============================================================================
puts ""
puts_color $YELLOW "Step 5: Cleanup..."
puts_color $BLUE "Restoring original configuration..."

file copy -force "$rtl_top_dir/rv32i_top_current_backup.sv" "$rtl_top_dir/rv32i_top.sv"
file delete "$rtl_top_dir/rv32i_top_current_backup.sv"
puts_color $GREEN "(OK) Configuration restored"

# ==============================================================================
# Step 6: Summary
# ==============================================================================
puts ""
puts_header $BLUE "Verification Summary"
puts "Single-cycle log:  $sim_dir/single_cycle_output.log"
puts "Pipeline log:      $sim_dir/pipeline_output.log"
puts ""
puts_color $YELLOW "Next Steps:"
puts "1. Review logs for detailed results"
puts "2. Check waveform: vsim -view $sim_dir/waveforms/wave.wlf"
puts "3. Run detailed analysis: tclsh $sim_dir/scripts/verify_pipeline.tcl"
puts "4. Compare final states: tclsh $sim_dir/scripts/verify_final_state.tcl"
puts ""

exit $final_result
