// =============================================================================
// Sequence: TC 6.5.3 - MEM_OFFSET_ZERO Instruction
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: Zero offset
// =============================================================================

class tc_6_5_3_mem_offset_zero_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_6_5_3_mem_offset_zero_seq)
    
    function new(string name = "tc_6_5_3_mem_offset_zero_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MEM_OFFSET_ZERO sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MEM_OFFSET_ZERO - Zero offset
        // ======================================================================
        tr = rv32i_transaction::type_id::create("mem_offset_zero_test");
        start_item(tr);
        
        tr.test_name = "MEM_OFFSET_ZERO Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MEM_OFFSET_ZERO test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MEM_OFFSET_ZERO sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_6_5_3_mem_offset_zero_seq
