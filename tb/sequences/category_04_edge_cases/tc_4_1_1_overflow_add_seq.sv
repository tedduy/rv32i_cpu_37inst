// =============================================================================
// Sequence: TC 4.1.1 - OVERFLOW_ADD Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: ADD overflow
// =============================================================================

class tc_4_1_1_overflow_add_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_1_1_overflow_add_seq)
    
    function new(string name = "tc_4_1_1_overflow_add_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting OVERFLOW_ADD sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: OVERFLOW_ADD - ADD overflow
        // ======================================================================
        tr = rv32i_transaction::type_id::create("overflow_add_test");
        start_item(tr);
        
        tr.test_name = "OVERFLOW_ADD Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: OVERFLOW_ADD test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "OVERFLOW_ADD sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_1_1_overflow_add_seq
