// =============================================================================
// Component Package
// =============================================================================
// Contains all UVM components: transaction, driver, monitor, scoreboard, etc.
// =============================================================================

package component_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Transaction
    `include "components/rv32i_transaction.sv"
    
    // Components
    `include "components/rv32i_driver.sv"
    `include "components/rv32i_monitor.sv"
    `include "components/rv32i_sequencer.sv"
    `include "components/golden_checker.sv"
    `include "components/rv32i_scoreboard.sv"
    `include "components/rv32i_agent.sv"
    `include "components/rv32i_env.sv"

endpackage : component_pkg
