// =============================================================================
// Sequence: TC 6.4.1 - LOAD_STORE_SAME_ADDR Instruction
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: Load then store same address
// =============================================================================

class tc_6_4_1_load_store_same_addr_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_6_4_1_load_store_same_addr_seq)
    
    function new(string name = "tc_6_4_1_load_store_same_addr_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting LOAD_STORE_SAME_ADDR sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: LOAD_STORE_SAME_ADDR - Load then store same address
        // ======================================================================
        tr = rv32i_transaction::type_id::create("load_store_same_addr_test");
        start_item(tr);
        
        tr.test_name = "LOAD_STORE_SAME_ADDR Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: LOAD_STORE_SAME_ADDR test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "LOAD_STORE_SAME_ADDR sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_6_4_1_load_store_same_addr_seq
