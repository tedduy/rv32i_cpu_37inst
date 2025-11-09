// =============================================================================
// Sequence: TC 4.6.4 - SINGLE_BIT Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Single bit set patterns
// =============================================================================

class tc_4_6_4_single_bit_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_6_4_single_bit_seq)
    
    function new(string name = "tc_4_6_4_single_bit_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SINGLE_BIT sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SINGLE_BIT - Single bit set patterns
        // ======================================================================
        tr = rv32i_transaction::type_id::create("single_bit_test");
        start_item(tr);
        
        tr.test_name = "SINGLE_BIT Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SINGLE_BIT test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SINGLE_BIT sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_6_4_single_bit_seq
