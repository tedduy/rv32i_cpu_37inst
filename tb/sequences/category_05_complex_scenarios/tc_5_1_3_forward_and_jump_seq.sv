// =============================================================================
// Sequence: TC 5.1.3 - FORWARD_AND_JUMP Instruction
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Forwarding with jump
// =============================================================================

class tc_5_1_3_forward_and_jump_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_5_1_3_forward_and_jump_seq)
    
    function new(string name = "tc_5_1_3_forward_and_jump_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting FORWARD_AND_JUMP sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: FORWARD_AND_JUMP - Forwarding with jump
        // ======================================================================
        tr = rv32i_transaction::type_id::create("forward_and_jump_test");
        start_item(tr);
        
        tr.test_name = "FORWARD_AND_JUMP Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: FORWARD_AND_JUMP test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "FORWARD_AND_JUMP sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_5_1_3_forward_and_jump_seq
