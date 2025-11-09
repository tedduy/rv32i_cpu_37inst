// =============================================================================
// Sequence: TC 5.1.1 - RAW_AND_BRANCH Instruction
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Data hazard with branch
// =============================================================================

class tc_5_1_1_raw_and_branch_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_5_1_1_raw_and_branch_seq)
    
    function new(string name = "tc_5_1_1_raw_and_branch_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting RAW_AND_BRANCH sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: RAW_AND_BRANCH - Data hazard with branch
        // ======================================================================
        tr = rv32i_transaction::type_id::create("raw_and_branch_test");
        start_item(tr);
        
        tr.test_name = "RAW_AND_BRANCH Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: RAW_AND_BRANCH test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "RAW_AND_BRANCH sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_5_1_1_raw_and_branch_seq
