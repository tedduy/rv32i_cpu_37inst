// =============================================================================
// Sequence: TC 6.4.3 - BACK_TO_BACK_MEM Instruction
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: Consecutive memory ops
// =============================================================================

class tc_6_4_3_back_to_back_mem_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_6_4_3_back_to_back_mem_seq)
    
    function new(string name = "tc_6_4_3_back_to_back_mem_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BACK_TO_BACK_MEM sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BACK_TO_BACK_MEM - Consecutive memory ops
        // ======================================================================
        tr = rv32i_transaction::type_id::create("back_to_back_mem_test");
        start_item(tr);
        
        tr.test_name = "BACK_TO_BACK_MEM Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BACK_TO_BACK_MEM test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BACK_TO_BACK_MEM sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_6_4_3_back_to_back_mem_seq
