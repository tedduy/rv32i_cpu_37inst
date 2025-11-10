// =============================================================================
// Main Testbench Package
// =============================================================================
// Top-level package that imports all sub-packages
// Import this package in your testbench top module
// =============================================================================

package tb_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // Import all sub-packages in order
    import component_pkg::*;
    import seq_pkg::*;
    import test_pkg::*;

endpackage : tb_pkg
