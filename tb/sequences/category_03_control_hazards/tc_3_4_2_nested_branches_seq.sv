// =============================================================================
// Sequence: TC 3.4.2 - NESTED_BRANCHES Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Nested conditional branches
// =============================================================================

class tc_3_4_2_nested_branches_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_4_2_nested_branches_seq)
    
    function new(string name = "tc_3_4_2_nested_branches_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting NESTED_BRANCHES sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: NESTED_BRANCHES - Nested conditional branches
        // ======================================================================
        tr = rv32i_transaction::type_id::create("nested_branches_test");
        start_item(tr);
        
        tr.test_name = "NESTED_BRANCHES Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: NESTED_BRANCHES test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "NESTED_BRANCHES sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_4_2_nested_branches_seq
