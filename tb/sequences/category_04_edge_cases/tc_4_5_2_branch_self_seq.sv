// =============================================================================
// Sequence: TC 4.5.2 - BRANCH_SELF Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Branch to self (infinite loop)
// =============================================================================

class tc_4_5_2_branch_self_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_5_2_branch_self_seq)
    
    function new(string name = "tc_4_5_2_branch_self_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BRANCH_SELF sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BRANCH_SELF - Branch to self (infinite loop)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("branch_self_test");
        start_item(tr);
        
        tr.test_name = "BRANCH_SELF Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BRANCH_SELF test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BRANCH_SELF sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_5_2_branch_self_seq
