// =============================================================================
// Sequence: TC 14.1.2 - DEEP_NESTING Instruction
// =============================================================================
// Category: Stress Tests
// Priority: MEDIUM
// Description: Deeply nested branches
// =============================================================================

class tc_14_1_2_deep_nesting_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_14_1_2_deep_nesting_seq)
    
    function new(string name = "tc_14_1_2_deep_nesting_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting DEEP_NESTING sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: DEEP_NESTING - Deeply nested branches
        // ======================================================================
        tr = rv32i_transaction::type_id::create("deep_nesting_test");
        start_item(tr);
        
        tr.test_name = "DEEP_NESTING Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: DEEP_NESTING test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "DEEP_NESTING sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_14_1_2_deep_nesting_seq
