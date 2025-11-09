// =============================================================================
// Sequence: TC 4.1.2 - UNDERFLOW_SUB Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: SUB underflow
// =============================================================================

class tc_4_1_2_underflow_sub_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_1_2_underflow_sub_seq)
    
    function new(string name = "tc_4_1_2_underflow_sub_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting UNDERFLOW_SUB sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: UNDERFLOW_SUB - SUB underflow
        // ======================================================================
        tr = rv32i_transaction::type_id::create("underflow_sub_test");
        start_item(tr);
        
        tr.test_name = "UNDERFLOW_SUB Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: UNDERFLOW_SUB test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "UNDERFLOW_SUB sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_1_2_underflow_sub_seq
