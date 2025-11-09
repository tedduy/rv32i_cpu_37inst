// =============================================================================
// Sequence: TC 4.5.3 - BRANCH_MAX_OFFSET Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Maximum branch offset
// =============================================================================

class tc_4_5_3_branch_max_offset_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_5_3_branch_max_offset_seq)
    
    function new(string name = "tc_4_5_3_branch_max_offset_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BRANCH_MAX_OFFSET sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BRANCH_MAX_OFFSET - Maximum branch offset
        // ======================================================================
        tr = rv32i_transaction::type_id::create("branch_max_offset_test");
        start_item(tr);
        
        tr.test_name = "BRANCH_MAX_OFFSET Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BRANCH_MAX_OFFSET test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BRANCH_MAX_OFFSET sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_5_3_branch_max_offset_seq
