// =============================================================================
// Sequence: TC 4.4.1 - MEM_ADDR_0 Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Memory address 0
// =============================================================================

class tc_4_4_1_mem_addr_0_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_4_1_mem_addr_0_seq)
    
    function new(string name = "tc_4_4_1_mem_addr_0_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MEM_ADDR_0 sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MEM_ADDR_0 - Memory address 0
        // ======================================================================
        tr = rv32i_transaction::type_id::create("mem_addr_0_test");
        start_item(tr);
        
        tr.test_name = "MEM_ADDR_0 Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MEM_ADDR_0 test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MEM_ADDR_0 sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_4_1_mem_addr_0_seq
