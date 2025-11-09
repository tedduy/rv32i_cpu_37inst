// =============================================================================
// RV32I Sequencer
// =============================================================================
// Standard UVM sequencer for rv32i_transaction
// =============================================================================

class rv32i_sequencer extends uvm_sequencer #(rv32i_transaction);
    
    // UVM Factory Registration
    `uvm_component_utils(rv32i_sequencer)
    
    // Constructor
    function new(string name = "rv32i_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
endclass : rv32i_sequencer
