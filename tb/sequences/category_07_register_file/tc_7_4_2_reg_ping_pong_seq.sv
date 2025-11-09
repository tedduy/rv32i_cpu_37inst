// =============================================================================
// Sequence: TC 7.4.2 - REG_PING_PONG Instruction
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: Alternating register usage
// =============================================================================

class tc_7_4_2_reg_ping_pong_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_7_4_2_reg_ping_pong_seq)
    
    function new(string name = "tc_7_4_2_reg_ping_pong_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting REG_PING_PONG sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: REG_PING_PONG - Alternating register usage
        // ======================================================================
        tr = rv32i_transaction::type_id::create("reg_ping_pong_test");
        start_item(tr);
        
        tr.test_name = "REG_PING_PONG Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: REG_PING_PONG test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "REG_PING_PONG sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_7_4_2_reg_ping_pong_seq
