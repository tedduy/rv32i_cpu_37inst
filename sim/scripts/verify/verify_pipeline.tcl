# ==============================================================================
# RV32I Pipeline Verification Script (TCL)
# Compares single-cycle vs pipeline execution results
# ==============================================================================

# Color codes for terminal output
proc color {type text} {
    set colors {
        red     "\033\[0;31m"
        green   "\033\[0;32m"
        yellow  "\033\[1;33m"
        blue    "\033\[0;34m"
        cyan    "\033\[0;36m"
        reset   "\033\[0m"
    }
    set color_code [dict get $colors $type]
    set reset_code [dict get $colors reset]
    return "${color_code}${text}${reset_code}"
}

# ASCII symbols for better compatibility
proc sym {type} {
    set symbols {
        check   "\[OK\]"
        cross   "\[FAIL\]"
        arrow   "--->"
        info    "\[i\]"
    }
    return [dict get $symbols $type]
}

# Parse simulation log file and extract register values
proc parse_log_file {filename} {
    set registers [dict create]
    set instruction_count 0
    
    if {![file exists $filename]} {
        puts [color red "Error: File $filename not found"]
        return [dict create registers {} count 0]
    }
    
    set fp [open $filename r]
    while {[gets $fp line] >= 0} {
        # Match: WB=<hex_value> -> x<reg_num>
        if {[regexp {WB=([0-9a-fA-F]+)\s*->\s*x(\d+)} $line match value reg]} {
            set decimal_value [scan $value %x]
            if {$reg != 0} {
                dict set registers $reg $decimal_value
            }
        }
        
        # Count instructions: match [  N]
        if {[regexp {\[\s*\d+\]} $line]} {
            incr instruction_count
        }
    }
    close $fp
    
    return [dict create registers $registers count $instruction_count]
}

# Compare register values between two implementations
proc compare_registers {single_regs pipeline_regs} {
    set errors [list]
    set matches 0
    set total 0
    
    # Get all register numbers (1-31, excluding x0)
    set all_regs [list]
    foreach reg [dict keys $single_regs] {
        if {[lsearch $all_regs $reg] == -1} {
            lappend all_regs $reg
        }
    }
    foreach reg [dict keys $pipeline_regs] {
        if {[lsearch $all_regs $reg] == -1} {
            lappend all_regs $reg
        }
    }
    set all_regs [lsort -integer $all_regs]
    
    foreach reg $all_regs {
        incr total
        set single_has [dict exists $single_regs $reg]
        set pipeline_has [dict exists $pipeline_regs $reg]
        
        if {$single_has && $pipeline_has} {
            set single_val [dict get $single_regs $reg]
            set pipeline_val [dict get $pipeline_regs $reg]
            
            if {$single_val == $pipeline_val} {
                incr matches
            } else {
                lappend errors [format "x%-2d: Mismatch! Single=0x%08x, Pipeline=0x%08x" \
                    $reg $single_val $pipeline_val]
            }
        } elseif {$single_has && !$pipeline_has} {
            set single_val [dict get $single_regs $reg]
            lappend errors [format "x%-2d: Missing in pipeline (expected 0x%08x)" \
                $reg $single_val]
        } elseif {!$single_has && $pipeline_has} {
            set pipeline_val [dict get $pipeline_regs $reg]
            lappend errors [format "x%-2d: Extra in pipeline (value 0x%08x)" \
                $reg $pipeline_val]
        }
    }
    
    return [dict create errors $errors matches $matches total $total]
}

# Print register comparison report
proc print_comparison_report {sc_data pl_data} {
    set sc_regs [dict get $sc_data registers]
    set pl_regs [dict get $pl_data registers]
    set sc_count [dict get $sc_data count]
    set pl_count [dict get $pl_data count]
    
    puts ""
    puts [color blue "======================================================================"]
    puts [color blue "RV32I Pipeline Verification Report"]
    puts [color blue "======================================================================"]
    puts ""
    
    # Compare registers
    puts [color cyan "1. Register Value Comparison"]
    set cmp_result [compare_registers $sc_regs $pl_regs]
    set errors [dict get $cmp_result errors]
    set matches [dict get $cmp_result matches]
    set total [dict get $cmp_result total]
    
    if {[llength $errors] == 0} {
        puts "   [color green [sym check]] All registers match ($matches/$total)"
    } else {
        puts "   [color red [sym cross]] [llength $errors] register(s) mismatch:"
        foreach err $errors {
            puts "     • $err"
        }
    }
    
    # Compare instruction counts
    puts ""
    puts [color cyan "2. Instruction Count"]
    puts "   Single-cycle:  $sc_count instructions"
    puts "   Pipeline:      $pl_count instructions"
    
    if {$sc_count == $pl_count} {
        puts "   [color green [sym check]] Instruction counts match"
    } else {
        puts "   [color red [sym cross]] Instruction counts differ!"
    }
    
    # Performance analysis
    puts ""
    puts [color cyan "3. Performance Analysis"]
    puts "   Single-cycle CPI: 1.00 (by definition)"
    puts "   Pipeline CPI:     ~1.2-1.6 (typical with hazards)"
    puts "   [sym info] Note: Check simulation log for exact cycle count"
    
    # Summary
    puts ""
    puts [color cyan "4. Verification Summary"]
    puts "   ============================================================"
    
    if {[llength $errors] == 0 && $sc_count == $pl_count} {
        puts "   [color green >>>] ALL TESTS PASSED! [color green <<<]"
        puts "   ============================================================"
        puts ""
        puts "   The 5-stage pipeline produces identical results"
        puts "   to the single-cycle implementation!"
        return 0
    } else {
        puts "   [color red XXX] TESTS FAILED! Pipeline has errors [color red XXX]"
        puts "   ============================================================"
        puts ""
        puts "   Debug Steps:"
        puts "   1. Check waveform for first mismatch"
        puts "   2. Verify hazard detection logic"
        puts "   3. Check forwarding paths"
        puts "   4. Verify pipeline register updates"
        return 1
    }
}

# Main execution
proc main {argc argv} {
    set script_dir [file dirname [info script]]
    set sim_dir [file normalize "$script_dir/../.."]
    set log_dir [file normalize "$sim_dir/logs"]
    
    # Default log file paths
    set sc_log "$log_dir/single_cycle_output.log"
    set pl_log "$log_dir/pipeline_output.log"
    
    # Parse command line arguments
    if {$argc >= 2} {
        set sc_log [lindex $argv 0]
        set pl_log [lindex $argv 1]
    }
    
    puts [color blue "========================================"]
    puts [color blue "RV32I Pipeline Verification"]
    puts [color blue "========================================"]
    puts ""
    puts "Loading simulation logs..."
    puts "  Single-cycle: $sc_log"
    puts "  Pipeline:     $pl_log"
    
    # Parse both log files
    set sc_data [parse_log_file $sc_log]
    set pl_data [parse_log_file $pl_log]
    
    if {[dict get $sc_data count] == 0} {
        puts [color red "Error: Could not parse single-cycle log"]
        return 1
    }
    
    if {[dict get $pl_data count] == 0} {
        puts [color red "Error: Could not parse pipeline log"]
        return 1
    }
    
    # Print comparison report
    return [print_comparison_report $sc_data $pl_data]
}

# Run if executed directly
if {[info exists argv0] && $argv0 eq [info script]} {
    exit [main $argc $argv]
}
