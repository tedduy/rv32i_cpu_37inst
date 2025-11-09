source test_database.tcl
set patterns [get_test_patterns 9]
puts "Category 9 patterns: [llength $patterns]"
foreach p $patterns {
    puts "  - [lindex $p 0]"
}
