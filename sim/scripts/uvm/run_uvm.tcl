# ==============================================================================
# UVM Simulation Runner (TCL)
# Runs UVM-based verification for RV32I CPU
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

set sim_dir [file join $project_root "sim"]
set work_dir [file join $sim_dir "work"]
set wave_dir [file join $sim_dir "waveforms"]
set coverage_dir [file join $sim_dir "coverage"]
set log_dir [file join $sim_dir "logs"]

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

# Parse command line arguments
set gui_mode 0
set test_name "rv32i_base_test"
set verbosity "UVM_MEDIUM"
set seed "random"

# Check for arguments
if {$argc > 0} {
    foreach arg $argv {
        if {$arg == "-gui"} {
            set gui_mode 1
        } elseif {[string match "-test=*" $arg]} {
            set test_name [string range $arg 6 end]
        } elseif {[string match "-verb=*" $arg]} {
            set verbosity [string range $arg 6 end]
        } elseif {[string match "-seed=*" $arg]} {
            set seed [string range $arg 6 end]
        }
    }
}

puts_header "RV32I CPU - UVM Simulation"
puts ""
puts_color cyan "Configuration:"
puts "  Test:      $test_name"
puts "  Verbosity: $verbosity"
puts "  Seed:      $seed"
puts "  Mode:      [expr {$gui_mode ? "GUI" : "Batch"}]"
puts ""

# Create waveform directory
if {![file exists $wave_dir]} {
    file mkdir $wave_dir
}

# Change to work directory
cd $work_dir

# Build simulation command
set sim_cmd "vsim"

if {$gui_mode} {
    append sim_cmd " -gui"
} else {
    append sim_cmd " -c"
}

# UVM options
append sim_cmd " -sv_seed $seed"
append sim_cmd " +UVM_TESTNAME=$test_name"
append sim_cmd " +UVM_VERBOSITY=$verbosity"
append sim_cmd " -voptargs=+acc"
append sim_cmd " -wlf $wave_dir/uvm_sim.wlf"

# Design top
append sim_cmd " work.rv32i_tb_top"

# UVM command line processor
append sim_cmd " +UVM_CONFIG_DB_TRACE"

puts_color cyan "Launching UVM simulation..."
puts ""

if {$gui_mode} {
    # GUI mode - add wave setup
    eval $sim_cmd -do {
        # Add waves for UVM transactions
        add wave -group "DUT Top" sim:/rv32i_tb_top/dut/*
        add wave -group "Interface" sim:/rv32i_tb_top/rv32i_if/*
        
        # Run simulation
        run -all
    }
} else {
    # Batch mode
    eval $sim_cmd -do {
        run -all
        coverage report -detail
        quit -f
    }
}

puts ""
puts_color green "(OK) UVM simulation completed"
puts ""
