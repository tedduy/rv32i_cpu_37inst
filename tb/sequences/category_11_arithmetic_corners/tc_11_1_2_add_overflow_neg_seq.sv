// =============================================================================
// Sequence: TC 11.1.2 - ADD_OVERFLOW_NEG Instruction
// =============================================================================
// Category: Arithmetic Corners
// Priority: MEDIUM
// Description: Negative overflow
// =============================================================================

class tc_11_1_2_add_overflow_neg_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_11_1_2_add_overflow_neg_seq)
    
    function new(string name = "tc_11_1_2_add_overflow_neg_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ADD_OVERFLOW_NEG sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ADD_OVERFLOW_NEG - Negative overflow
        // ======================================================================
        tr = rv32i_transaction::type_id::create("add_overflow_neg_test");
        start_item(tr);
        
        tr.test_name = "ADD_OVERFLOW_NEG Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ADD_OVERFLOW_NEG test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ADD_OVERFLOW_NEG sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_11_1_2_add_overflow_neg_seq
