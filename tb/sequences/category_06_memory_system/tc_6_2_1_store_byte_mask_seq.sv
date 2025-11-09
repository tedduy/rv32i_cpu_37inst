// =============================================================================
// Sequence: TC 6.2.1 - STORE_BYTE_MASK Instruction
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: SB byte masking
// =============================================================================

class tc_6_2_1_store_byte_mask_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_6_2_1_store_byte_mask_seq)
    
    function new(string name = "tc_6_2_1_store_byte_mask_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting STORE_BYTE_MASK sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: STORE_BYTE_MASK - SB byte masking
        // ======================================================================
        tr = rv32i_transaction::type_id::create("store_byte_mask_test");
        start_item(tr);
        
        tr.test_name = "STORE_BYTE_MASK Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: STORE_BYTE_MASK test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "STORE_BYTE_MASK sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_6_2_1_store_byte_mask_seq
