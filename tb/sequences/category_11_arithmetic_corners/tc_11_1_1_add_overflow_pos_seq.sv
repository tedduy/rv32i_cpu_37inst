// =============================================================================
// Sequence: TC 12.1.1 - ADD_OVERFLOW_POS Instruction
// =============================================================================
// Category: Arithmetic Corners
// Priority: MEDIUM
// Description: Positive overflow
// =============================================================================

class tc_12_1_1_add_overflow_pos_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_12_1_1_add_overflow_pos_seq)
    
    function new(string name = "tc_12_1_1_add_overflow_pos_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ADD_OVERFLOW_POS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ADD_OVERFLOW_POS - Positive overflow
        // ======================================================================
        tr = rv32i_transaction::type_id::create("add_overflow_pos_test");
        start_item(tr);
        
        tr.test_name = "ADD_OVERFLOW_POS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ADD_OVERFLOW_POS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ADD_OVERFLOW_POS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_12_1_1_add_overflow_pos_seq
