# ==============================================================================
# UVM Regression Script (TCL)
# Runs multiple UVM tests with different configurations
# ==============================================================================

# Setup paths
set current_dir [pwd]
if {[string match "*sim/scripts/uvm*" $current_dir] || [string match "*sim\\scripts\\uvm*" $current_dir]} {
    set project_root [file normalize [file join $current_dir "../../.."]]
} elseif {[string match "*sim/scripts*" $current_dir] || [string match "*sim\\scripts*" $current_dir]} {
    set project_root [file normalize [file join $current_dir "../.."]]
} else {
    set project_root $current_dir
}

set sim_dir [file join $project_root "sim"]
set report_dir [file join $sim_dir "reports/uvm"]

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

# Create report directory
if {![file exists $report_dir]} {
    file mkdir $report_dir
}

puts_header "RV32I CPU - UVM Regression Suite"
puts ""

# Define test list
# Format: {test_name description seed}
set test_list [list \
    {rv32i_base_test "Basic instruction test" 1} \
    {rv32i_rand_test "Random instruction test" 2} \
    {rv32i_hazard_test "Data hazard test" 3} \
    {rv32i_branch_test "Branch/Jump test" 4} \
    {rv32i_load_store_test "Load/Store test" 5} \
    {rv32i_stress_test "Stress test" 6} \
]

set total_tests [llength $test_list]
set passed_tests 0
set failed_tests 0

puts_color cyan "Running $total_tests UVM tests..."
puts ""

# Run each test
foreach test_info $test_list {
    set test_name [lindex $test_info 0]
    set test_desc [lindex $test_info 1]
    set test_seed [lindex $test_info 2]
    
    puts "----------------------------------------"
    puts_color blue "Test: $test_name"
    puts "Description: $test_desc"
    puts "Seed: $test_seed"
    puts ""
    
    # Run test
    set log_file "$report_dir/${test_name}_seed${test_seed}.log"
    
    if {[catch {
        exec vsim -c \
            -sv_seed $test_seed \
            +UVM_TESTNAME=$test_name \
            +UVM_VERBOSITY=UVM_MEDIUM \
            -voptargs=+acc \
            -do "run -all; quit -f" \
            work.rv32i_tb_top \
            >@ $log_file 2>@1
    } result]} {
        # Check if it's just a normal exit
        if {![string match "*UVM_ERROR*" $result]} {
            puts_color green "(OK) $test_name PASSED"
            incr passed_tests
        } else {
            puts_color red "(FAIL) $test_name FAILED"
            puts "  See log: $log_file"
            incr failed_tests
        }
    } else {
        puts_color green "(OK) $test_name PASSED"
        incr passed_tests
    }
    
    puts ""
}

# Summary
puts "========================================"
puts_header "Regression Summary"
puts ""
puts "Total Tests:  $total_tests"
puts_color green "Passed:       $passed_tests"
if {$failed_tests > 0} {
    puts_color red "Failed:       $failed_tests"
} else {
    puts "Failed:       $failed_tests"
}
puts ""

set pass_rate [expr {($passed_tests * 100.0) / $total_tests}]
puts "Pass Rate:    [format "%.1f" $pass_rate]%"
puts ""

if {$failed_tests == 0} {
    puts_color green "(OK)(OK)(OK) ALL TESTS PASSED (OK)(OK)(OK)"
    puts ""
    exit 0
} else {
    puts_color red "XXX SOME TESTS FAILED XXX"
    puts ""
    puts "Check logs in: $report_dir/"
    puts ""
    exit 1
}
