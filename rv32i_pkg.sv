// =============================================================================
// RV32I Complete Package
// =============================================================================
// Master package that imports all sub-packages (RTL + Testbench)
// Import this in your testbench top module for complete access
// =============================================================================

package rv32i_pkg;

    // Import UVM
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // Import RTL package (parameters, typedefs, functions)
    import rtl_pkg::*;
    
    // Import Testbench packages
    import component_pkg::*;  // UVM components
    import seq_pkg::*;        // Test sequences
    import test_pkg::*;       // Test classes

endpackage : rv32i_pkg