// =============================================================================
// Sequence: TC 6.1.2 - LOAD_BYTE_ZERO_EXT Instruction
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: LBU zero extension
// =============================================================================

class tc_6_1_2_load_byte_zero_ext_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_6_1_2_load_byte_zero_ext_seq)
    
    function new(string name = "tc_6_1_2_load_byte_zero_ext_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting LOAD_BYTE_ZERO_EXT sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: LOAD_BYTE_ZERO_EXT - LBU zero extension
        // ======================================================================
        tr = rv32i_transaction::type_id::create("load_byte_zero_ext_test");
        start_item(tr);
        
        tr.test_name = "LOAD_BYTE_ZERO_EXT Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: LOAD_BYTE_ZERO_EXT test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "LOAD_BYTE_ZERO_EXT sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_6_1_2_load_byte_zero_ext_seq
