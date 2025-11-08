# ==============================================================================
# RV32I CPU - Simulation Script (TCL)
# Supports ModelSim/QuestaSim
# ==============================================================================

# Determine project directories
set script_dir [file dirname [info script]]
set project_root [file normalize "$script_dir/../../.."]
set sim_dir "$project_root/sim"
set work_dir "$sim_dir/work"
set wave_dir "$sim_dir/waveforms"
set log_dir "$sim_dir/logs"
set output_log "$log_dir/simulation_output.log"

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

# Main simulation
puts_header "RV32I CPU - Simulation"
puts ""

# Check if work library exists
if {![file exists $work_dir]} {
    puts_color red "Error: Work directory not found!"
    puts_color yellow "Please run: vsim -do compile.tcl"
    exit 1
}

# Create waveform and log directories
if {![file exists $wave_dir]} {
    file mkdir $wave_dir
}
if {![file exists $log_dir]} {
    file mkdir $log_dir
}

# Change to work directory
cd $work_dir

# Parse command line arguments
set gui_mode 0
set pipeline_mode 0
set dump_waves 1

if {$argc > 0} {
    foreach arg $argv {
        if {$arg eq "-gui"} {
            set gui_mode 1
        } elseif {$arg eq "-pipeline"} {
            set pipeline_mode 1
        } elseif {$arg eq "-nowaves"} {
            set dump_waves 0
        }
    }
}

# Display configuration
puts_color cyan "Configuration:"
puts "  Top module:   tb_rv32i_top"
puts "  Mode:         [expr {$pipeline_mode ? "Pipeline" : "Single-Cycle"}]"
puts "  GUI:          [expr {$gui_mode ? "Yes" : "No (Batch)"}]"
puts "  Waveform:     $wave_dir/wave.wlf"
puts "  Log file:     $output_log"
puts ""

# Prepare simulation defines
set sim_defines ""
if {$pipeline_mode} {
    set sim_defines "+define+PIPELINE"
} else {
    set sim_defines "+define+SINGLE_CYCLE"
}

# Run simulation
puts_color green "Starting simulation..."
puts ""

if {$gui_mode} {
    # GUI Mode
    puts_color yellow "Running in GUI mode..."
    puts_color cyan "Opening QuestaSim GUI..."
    
    vsim -gui work.tb_rv32i_top \
        -voptargs="+acc" \
        -wlf "$wave_dir/wave.wlf" \
        {*}$sim_defines
    
    # Add waves
    add wave -divider "Clock and Reset"
    add wave -hex sim:/tb_rv32i_top/clk
    add wave -hex sim:/tb_rv32i_top/rst
    
    add wave -divider "CPU Signals"
    add wave -hex sim:/tb_rv32i_top/dut/W_PC_out
    add wave -hex sim:/tb_rv32i_top/dut/W_inst
    
    add wave -divider "Register File"
    add wave -hex sim:/tb_rv32i_top/dut/u_reg_file/regs
    
    # Run simulation
    run -all
    
} else {
    # Batch Mode
    puts_color yellow "Running in batch mode..."
    
    # Open log file
    set log_fp [open $output_log w]
    
    # Load design
    if {[catch {
        vsim -c work.tb_rv32i_top \
            -voptargs="+acc" \
            -wlf "$wave_dir/wave.wlf" \
            {*}$sim_defines
    } result]} {
        puts_color red "Error loading design:"
        puts $result
        close $log_fp
        exit 1
    }
    
    # Redirect transcript
    transcript file $output_log
    transcript on
    
    # Run simulation
    puts_color cyan "Running simulation..."
    if {[catch {run -all} result]} {
        puts_color red "Simulation error:"
        puts $result
        transcript off
        close $log_fp
        quit -f
        exit 1
    }
    
    # Close log
    transcript off
    close $log_fp
    
    # Success
    puts ""
    puts_header "Simulation: COMPLETED (OK)"
    puts ""
    puts_color blue "Waveform saved to: $wave_dir/wave.wlf"
    puts_color yellow "View waveform: vsim -view $wave_dir/wave.wlf"
    puts ""
    puts_color cyan "Output log: $output_log"
    
    # Extract statistics from log
    if {[file exists $output_log]} {
        set log_fp [open $output_log r]
        set inst_count 0
        while {[gets $log_fp line] >= 0} {
            if {[regexp {\[\s*\d+\]} $line]} {
                incr inst_count
            }
        }
        close $log_fp
        puts "  Instructions executed: $inst_count"
    }
    
    puts ""
    quit -f
}

exit 0
