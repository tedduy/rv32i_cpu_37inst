// =============================================================================
// Sequence: TC 9.3.3 - ALU_TO_STORE Instruction
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: ALU result to store data
// =============================================================================

class tc_9_3_3_alu_to_store_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_9_3_3_alu_to_store_seq)
    
    function new(string name = "tc_9_3_3_alu_to_store_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ALU_TO_STORE sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ALU_TO_STORE - ALU result to store data
        // ======================================================================
        tr = rv32i_transaction::type_id::create("alu_to_store_test");
        start_item(tr);
        
        tr.test_name = "ALU_TO_STORE Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ALU_TO_STORE test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ALU_TO_STORE sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_9_3_3_alu_to_store_seq
