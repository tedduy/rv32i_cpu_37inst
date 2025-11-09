// =============================================================================
// Sequence: TC 4.6.3 - ALTERNATING_BITS Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Alternating bit pattern
// =============================================================================

class tc_4_6_3_alternating_bits_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_6_3_alternating_bits_seq)
    
    function new(string name = "tc_4_6_3_alternating_bits_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ALTERNATING_BITS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ALTERNATING_BITS - Alternating bit pattern
        // ======================================================================
        tr = rv32i_transaction::type_id::create("alternating_bits_test");
        start_item(tr);
        
        tr.test_name = "ALTERNATING_BITS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ALTERNATING_BITS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ALTERNATING_BITS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_6_3_alternating_bits_seq
