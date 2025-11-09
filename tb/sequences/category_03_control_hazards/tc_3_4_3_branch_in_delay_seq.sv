// =============================================================================
// Sequence: TC 3.4.3 - BRANCH_IN_DELAY Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Branch in flush shadow
// =============================================================================

class tc_3_4_3_branch_in_delay_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_4_3_branch_in_delay_seq)
    
    function new(string name = "tc_3_4_3_branch_in_delay_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BRANCH_IN_DELAY sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BRANCH_IN_DELAY - Branch in flush shadow
        // ======================================================================
        tr = rv32i_transaction::type_id::create("branch_in_delay_test");
        start_item(tr);
        
        tr.test_name = "BRANCH_IN_DELAY Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BRANCH_IN_DELAY test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BRANCH_IN_DELAY sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_4_3_branch_in_delay_seq
