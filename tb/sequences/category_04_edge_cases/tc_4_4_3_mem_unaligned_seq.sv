// =============================================================================
// Sequence: TC 4.4.3 - MEM_UNALIGNED Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Unaligned memory access
// =============================================================================

class tc_4_4_3_mem_unaligned_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_4_3_mem_unaligned_seq)
    
    function new(string name = "tc_4_4_3_mem_unaligned_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MEM_UNALIGNED sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MEM_UNALIGNED - Unaligned memory access
        // ======================================================================
        tr = rv32i_transaction::type_id::create("mem_unaligned_test");
        start_item(tr);
        
        tr.test_name = "MEM_UNALIGNED Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MEM_UNALIGNED test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MEM_UNALIGNED sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_4_3_mem_unaligned_seq
