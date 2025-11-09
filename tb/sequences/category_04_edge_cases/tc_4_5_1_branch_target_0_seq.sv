// =============================================================================
// Sequence: TC 4.5.1 - BRANCH_TARGET_0 Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Branch to address 0
// =============================================================================

class tc_4_5_1_branch_target_0_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_5_1_branch_target_0_seq)
    
    function new(string name = "tc_4_5_1_branch_target_0_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BRANCH_TARGET_0 sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BRANCH_TARGET_0 - Branch to address 0
        // ======================================================================
        tr = rv32i_transaction::type_id::create("branch_target_0_test");
        start_item(tr);
        
        tr.test_name = "BRANCH_TARGET_0 Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BRANCH_TARGET_0 test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BRANCH_TARGET_0 sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_5_1_branch_target_0_seq
