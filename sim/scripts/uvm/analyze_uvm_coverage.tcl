# ==============================================================================
# UVM Coverage Analysis Script (TCL)
# Analyzes functional coverage from UVM tests
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
set cov_dir [file join $sim_dir "coverage"]
set report_file [file join $cov_dir "coverage_report.txt"]

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

# Create coverage directory
if {![file exists $cov_dir]} {
    file mkdir $cov_dir
}

puts_header "RV32I CPU - UVM Coverage Analysis"
puts ""

puts_color cyan "Generating coverage report..."
puts ""

# Merge coverage databases
puts "Merging coverage databases..."
if {[catch {
    exec vcover merge -out $cov_dir/merged.ucdb $cov_dir/*.ucdb
} result]} {
    puts_color yellow "(WARN) No coverage databases found or merge failed"
}

# Generate coverage report
puts "Generating detailed report..."
if {[catch {
    exec vcover report -details -html -htmldir $cov_dir/html $cov_dir/merged.ucdb > $report_file
} result]} {
    puts_color red "(FAIL) Coverage report generation failed"
    puts $result
    exit 1
}

puts_color green "(OK) Coverage report generated"
puts ""

# Display summary
puts_color cyan "Coverage Summary:"
puts "  Report file: $report_file"
puts "  HTML report: $cov_dir/html/index.html"
puts ""

# Parse and display key metrics
if {[file exists $report_file]} {
    set fp [open $report_file r]
    set content [read $fp]
    close $fp
    
    # Extract coverage percentages (example patterns)
    if {[regexp {Statement Coverage:\s+(\d+\.\d+)%} $content match stmt_cov]} {
        puts "  Statement Coverage: $stmt_cov%"
    }
    if {[regexp {Branch Coverage:\s+(\d+\.\d+)%} $content match branch_cov]} {
        puts "  Branch Coverage:    $branch_cov%"
    }
    if {[regexp {Functional Coverage:\s+(\d+\.\d+)%} $content match func_cov]} {
        puts "  Functional Coverage: $func_cov%"
    }
}

puts ""
puts_color green "(OK) Coverage analysis complete"
puts ""
puts "Open HTML report:"
puts "  firefox $cov_dir/html/index.html"
puts ""
