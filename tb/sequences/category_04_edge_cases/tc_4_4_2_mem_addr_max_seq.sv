// =============================================================================
// Sequence: TC 4.4.2 - MEM_ADDR_MAX Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Maximum memory address
// =============================================================================

class tc_4_4_2_mem_addr_max_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_4_2_mem_addr_max_seq)
    
    function new(string name = "tc_4_4_2_mem_addr_max_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MEM_ADDR_MAX sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MEM_ADDR_MAX - Maximum memory address
        // ======================================================================
        tr = rv32i_transaction::type_id::create("mem_addr_max_test");
        start_item(tr);
        
        tr.test_name = "MEM_ADDR_MAX Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MEM_ADDR_MAX test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MEM_ADDR_MAX sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_4_2_mem_addr_max_seq
