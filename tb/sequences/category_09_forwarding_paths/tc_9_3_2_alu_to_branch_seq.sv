// =============================================================================
// Sequence: TC 9.3.2 - ALU_TO_BRANCH Instruction
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: ALU result to branch
// =============================================================================

class tc_9_3_2_alu_to_branch_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_9_3_2_alu_to_branch_seq)
    
    function new(string name = "tc_9_3_2_alu_to_branch_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ALU_TO_BRANCH sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ALU_TO_BRANCH - ALU result to branch
        // ======================================================================
        tr = rv32i_transaction::type_id::create("alu_to_branch_test");
        start_item(tr);
        
        tr.test_name = "ALU_TO_BRANCH Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ALU_TO_BRANCH test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ALU_TO_BRANCH sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_9_3_2_alu_to_branch_seq
