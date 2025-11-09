// =============================================================================
// Sequence: TC 3.3.1 - BRANCH_AFTER_LOAD Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Branch with load dependency
// =============================================================================

class tc_3_3_1_branch_after_load_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_3_1_branch_after_load_seq)
    
    function new(string name = "tc_3_3_1_branch_after_load_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BRANCH_AFTER_LOAD sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BRANCH_AFTER_LOAD - Branch with load dependency
        // ======================================================================
        tr = rv32i_transaction::type_id::create("branch_after_load_test");
        start_item(tr);
        
        tr.test_name = "BRANCH_AFTER_LOAD Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BRANCH_AFTER_LOAD test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BRANCH_AFTER_LOAD sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_3_1_branch_after_load_seq
