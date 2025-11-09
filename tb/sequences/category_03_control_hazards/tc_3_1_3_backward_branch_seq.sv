// =============================================================================
// Sequence: TC 3.1.3 - BACKWARD_BRANCH Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Backward branch (loop)
// =============================================================================

class tc_3_1_3_backward_branch_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_1_3_backward_branch_seq)
    
    function new(string name = "tc_3_1_3_backward_branch_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BACKWARD_BRANCH sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BACKWARD_BRANCH - Backward branch (loop)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("backward_branch_test");
        start_item(tr);
        
        tr.test_name = "BACKWARD_BRANCH Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BACKWARD_BRANCH test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BACKWARD_BRANCH sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_1_3_backward_branch_seq
