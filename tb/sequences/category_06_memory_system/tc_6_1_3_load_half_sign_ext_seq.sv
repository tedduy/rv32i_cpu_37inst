// =============================================================================
// Sequence: TC 6.1.3 - LOAD_HALF_SIGN_EXT Instruction
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: LH sign extension
// =============================================================================

class tc_6_1_3_load_half_sign_ext_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_6_1_3_load_half_sign_ext_seq)
    
    function new(string name = "tc_6_1_3_load_half_sign_ext_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting LOAD_HALF_SIGN_EXT sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: LOAD_HALF_SIGN_EXT - LH sign extension
        // ======================================================================
        tr = rv32i_transaction::type_id::create("load_half_sign_ext_test");
        start_item(tr);
        
        tr.test_name = "LOAD_HALF_SIGN_EXT Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: LOAD_HALF_SIGN_EXT test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "LOAD_HALF_SIGN_EXT sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_6_1_3_load_half_sign_ext_seq
