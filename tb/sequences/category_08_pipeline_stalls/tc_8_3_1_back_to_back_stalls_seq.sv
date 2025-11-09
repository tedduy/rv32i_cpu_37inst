// =============================================================================
// Sequence: TC 8.3.1 - BACK_TO_BACK_STALLS Instruction
// =============================================================================
// Category: Pipeline Stalls
// Priority: MEDIUM
// Description: Consecutive stall conditions
// =============================================================================

class tc_8_3_1_back_to_back_stalls_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_8_3_1_back_to_back_stalls_seq)
    
    function new(string name = "tc_8_3_1_back_to_back_stalls_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BACK_TO_BACK_STALLS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BACK_TO_BACK_STALLS - Consecutive stall conditions
        // ======================================================================
        tr = rv32i_transaction::type_id::create("back_to_back_stalls_test");
        start_item(tr);
        
        tr.test_name = "BACK_TO_BACK_STALLS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BACK_TO_BACK_STALLS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BACK_TO_BACK_STALLS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_8_3_1_back_to_back_stalls_seq
