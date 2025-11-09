// =============================================================================
// Sequence: TC 3.1.2 - BRANCH_NOT_TAKEN Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Branch not taken
// =============================================================================

class tc_3_1_2_branch_not_taken_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_1_2_branch_not_taken_seq)
    
    function new(string name = "tc_3_1_2_branch_not_taken_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BRANCH_NOT_TAKEN sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BRANCH_NOT_TAKEN - Branch not taken
        // ======================================================================
        tr = rv32i_transaction::type_id::create("branch_not_taken_test");
        start_item(tr);
        
        tr.test_name = "BRANCH_NOT_TAKEN Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BRANCH_NOT_TAKEN test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BRANCH_NOT_TAKEN sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_1_2_branch_not_taken_seq
