# ==============================================================================
# Final State Verification Script (TCL)
# Compares register file and memory contents at end of execution
# ==============================================================================

# Setup paths
set script_dir [file dirname [info script]]
set project_root [file normalize "$script_dir/../../.."]
set sim_dir "$project_root/sim"
set log_dir "$sim_dir/logs"
set report_dir "$sim_dir/reports"

# ANSI color codes
set RED "\033\[1;31m"
set GREEN "\033\[1;32m"
set YELLOW "\033\[1;33m"
set BLUE "\033\[1;36m"
set NC "\033\[0m"

proc puts_color {color text} {
    puts "${color}${text}${::NC}"
}

proc puts_header {text} {
    puts "========================================"
    puts $text
    puts "========================================"
}

puts_header "RV32I Final State Verification"
puts ""

# Check if log files exist
set sc_log "$log_dir/single_cycle_output.log"
set pl_log "$log_dir/pipeline_output.log"

if {![file exists $sc_log]} {
    puts_color $::RED "(FAIL) Single-cycle log not found!"
    puts "  Run full_verify.tcl first to generate logs"
    exit 1
}

if {![file exists $pl_log]} {
    puts_color $::RED "(FAIL) Pipeline log not found!"
    puts "  Run full_verify.tcl first to generate logs"
    exit 1
}

puts "Extracting final register states..."
puts ""

# ==============================================================================
# Extract final writeback values for each register
# ==============================================================================
proc extract_final_wb {logfile outfile} {
    set fp [open $logfile r]
    set content [read $fp]
    close $fp
    
    # Parse all writeback operations with RegW=1
    # Format: "WB=<value> -> x<num> | RegW=1"
    array set regs {}
    
    foreach line [split $content "\n"] {
        if {[regexp {RegW=1} $line] && [regexp {WB=([0-9a-f]+)\s+-> x(\d+)} $line match value reg]} {
            # Store latest value for each register (except x0)
            if {$reg != 0} {
                set regs($reg) $value
            }
        }
    }
    
    # Write final state to output file (all 32 registers)
    set outfp [open $outfile w]
    for {set i 0} {$i <= 31} {incr i} {
        if {$i == 0} {
            puts $outfp [format "x%-2d = 0x00000000" $i]
        } elseif {[info exists regs($i)]} {
            puts $outfp [format "x%-2d = 0x%s" $i $regs($i)]
        } else {
            puts $outfp [format "x%-2d = 0x00000000" $i]
        }
    }
    close $outfp
}

# ==============================================================================
# Extract memory write operations
# ==============================================================================
proc extract_memory {logfile outfile} {
    set fp [open $logfile r]
    set content [read $fp]
    close $fp
    
    # Parse all memory writes
    # Format: "MemW=1 | MemA=<addr> | WData=<value>"
    array set mem {}
    
    foreach line [split $content "\n"] {
        if {[regexp {MemW=1} $line] && [regexp {MemA=([0-9a-f]+).*WData=([0-9a-f]+)} $line match addr data]} {
            # Store latest value for each address
            set mem($addr) $data
        }
    }
    
    # Write memory state to output file (sorted by address)
    set outfp [open $outfile w]
    foreach addr [lsort [array names mem]] {
        puts $outfp [format "MEM\[0x%s\] = 0x%s" $addr $mem($addr)]
    }
    close $outfp
}

# Process single-cycle
puts "Processing single-cycle final state..."
extract_final_wb "$sc_log" "$report_dir/sc_final_regs.txt"
extract_memory "$sc_log" "$report_dir/sc_final_mem.txt"

# Process pipeline
puts "Processing pipeline final state..."
extract_final_wb "$pl_log" "$report_dir/pl_final_regs.txt"
extract_memory "$pl_log" "$report_dir/pl_final_mem.txt"

puts ""
puts_header "Register File Comparison"
puts ""

# ==============================================================================
# Compare register files
# ==============================================================================
proc compare_files {file1 file2} {
    set fp1 [open $file1 r]
    set content1 [read $fp1]
    close $fp1
    
    set fp2 [open $file2 r]
    set content2 [read $fp2]
    close $fp2
    
    return [string equal $content1 $content2]
}

proc show_diff {file1 file2} {
    set fp1 [open $file1 r]
    set lines1 [split [read $fp1] "\n"]
    close $fp1
    
    set fp2 [open $file2 r]
    set lines2 [split [read $fp2] "\n"]
    close $fp2
    
    set len [expr {[llength $lines1] > [llength $lines2] ? [llength $lines1] : [llength $lines2]}]
    set has_diff 0
    
    puts "Line-by-line comparison:"
    puts [format "%-5s  %-25s  %-25s" "Line" "Single-Cycle" "Pipeline"]
    puts [string repeat "-" 60]
    
    for {set i 0} {$i < $len} {incr i} {
        set line1 [lindex $lines1 $i]
        set line2 [lindex $lines2 $i]
        
        if {$line1 ne $line2} {
            set has_diff 1
            puts_color $::RED [format "%-5d  %-25s  %-25s  ← DIFFER" $i $line1 $line2]
        }
    }
    
    return $has_diff
}

set regs_match [compare_files "$report_dir/sc_final_regs.txt" "$report_dir/pl_final_regs.txt"]

if {$regs_match} {
    puts_color $::GREEN "(OK)(OK)(OK) REGISTER FILES MATCH (OK)(OK)(OK)"
    puts ""
    puts "Final register state:"
    puts "--------------------"
    
    set fp [open "$report_dir/sc_final_regs.txt" r]
    set content [read $fp]
    close $fp
    
    # Show only non-zero registers
    foreach line [split $content "\n"] {
        if {[regexp {= 0x00000000$} $line]} {
            # Skip zero registers (except x0)
            if {![regexp {^x0\s} $line]} {
                continue
            }
        }
        if {$line ne ""} {
            puts $line
        }
    }
} else {
    puts_color $::RED "(FAIL)(FAIL)(FAIL) REGISTER FILES DIFFER (FAIL)(FAIL)(FAIL)"
    puts ""
    show_diff "$report_dir/sc_final_regs.txt" "$report_dir/pl_final_regs.txt"
}

puts ""
puts_header "Memory Comparison"
puts ""

# ==============================================================================
# Compare memory contents
# ==============================================================================
set mem_match [compare_files "$report_dir/sc_final_mem.txt" "$report_dir/pl_final_mem.txt"]

if {$mem_match} {
    puts_color $::GREEN "(OK)(OK)(OK) MEMORY CONTENTS MATCH (OK)(OK)(OK)"
    puts ""
    
    if {[file size "$report_dir/sc_final_mem.txt"] > 0} {
        puts "Final memory state:"
        puts "------------------"
        
        set fp [open "$report_dir/sc_final_mem.txt" r]
        puts [read $fp]
        close $fp
    } else {
        puts "No memory writes detected in test program"
    }
} else {
    puts_color $::RED "(FAIL)(FAIL)(FAIL) MEMORY CONTENTS DIFFER (FAIL)(FAIL)(FAIL)"
    puts ""
    show_diff "$report_dir/sc_final_mem.txt" "$report_dir/pl_final_mem.txt"
}

puts ""
puts_header "Verification Summary"
puts ""

if {$regs_match && $mem_match} {
    puts_color $::GREEN "(OK)(OK)(OK) PIPELINE VERIFICATION PASSED (OK)(OK)(OK)"
    puts ""
    puts "The 5-stage pipeline produces identical results"
    puts "to the single-cycle implementation!"
    puts ""
    exit 0
} else {
    puts_color $::RED "(FAIL)(FAIL)(FAIL) PIPELINE VERIFICATION FAILED (FAIL)(FAIL)(FAIL)"
    puts ""
    if {!$regs_match} {
        puts "  - Register file contents differ"
    }
    if {!$mem_match} {
        puts "  - Memory contents differ"
    }
    puts ""
    puts "Review the differences above to debug the pipeline."
    puts ""
    exit 1
}
