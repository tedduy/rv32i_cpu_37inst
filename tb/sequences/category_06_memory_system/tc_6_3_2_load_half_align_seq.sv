// =============================================================================
// Sequence: TC 6.3.2 - LOAD_HALF_ALIGN Instruction
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: LH at halfword boundary
// =============================================================================

class tc_6_3_2_load_half_align_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_6_3_2_load_half_align_seq)
    
    function new(string name = "tc_6_3_2_load_half_align_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting LOAD_HALF_ALIGN sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: LOAD_HALF_ALIGN - LH at halfword boundary
        // ======================================================================
        tr = rv32i_transaction::type_id::create("load_half_align_test");
        start_item(tr);
        
        tr.test_name = "LOAD_HALF_ALIGN Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: LOAD_HALF_ALIGN test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "LOAD_HALF_ALIGN sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_6_3_2_load_half_align_seq
