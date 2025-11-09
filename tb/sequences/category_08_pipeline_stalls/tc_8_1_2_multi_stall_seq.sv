// =============================================================================
// Sequence: TC 8.1.2 - MULTI_STALL Instruction
// =============================================================================
// Category: Pipeline Stalls
// Priority: MEDIUM
// Description: Multiple consecutive stalls
// =============================================================================

class tc_8_1_2_multi_stall_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_8_1_2_multi_stall_seq)
    
    function new(string name = "tc_8_1_2_multi_stall_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MULTI_STALL sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MULTI_STALL - Multiple consecutive stalls
        // ======================================================================
        tr = rv32i_transaction::type_id::create("multi_stall_test");
        start_item(tr);
        
        tr.test_name = "MULTI_STALL Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MULTI_STALL test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MULTI_STALL sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_8_1_2_multi_stall_seq
