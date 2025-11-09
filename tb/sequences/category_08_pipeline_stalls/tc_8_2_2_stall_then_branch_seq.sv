// =============================================================================
// Sequence: TC 8.2.2 - STALL_THEN_BRANCH Instruction
// =============================================================================
// Category: Pipeline Stalls
// Priority: MEDIUM
// Description: Branch after stall
// =============================================================================

class tc_8_2_2_stall_then_branch_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_8_2_2_stall_then_branch_seq)
    
    function new(string name = "tc_8_2_2_stall_then_branch_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting STALL_THEN_BRANCH sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: STALL_THEN_BRANCH - Branch after stall
        // ======================================================================
        tr = rv32i_transaction::type_id::create("stall_then_branch_test");
        start_item(tr);
        
        tr.test_name = "STALL_THEN_BRANCH Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: STALL_THEN_BRANCH test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "STALL_THEN_BRANCH sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_8_2_2_stall_then_branch_seq
