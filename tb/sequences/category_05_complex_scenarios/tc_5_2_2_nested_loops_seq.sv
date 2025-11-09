// =============================================================================
// Sequence: TC 5.2.2 - NESTED_LOOPS Instruction
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Nested loops
// =============================================================================

class tc_5_2_2_nested_loops_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_5_2_2_nested_loops_seq)
    
    function new(string name = "tc_5_2_2_nested_loops_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting NESTED_LOOPS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: NESTED_LOOPS - Nested loops
        // ======================================================================
        tr = rv32i_transaction::type_id::create("nested_loops_test");
        start_item(tr);
        
        tr.test_name = "NESTED_LOOPS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: NESTED_LOOPS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "NESTED_LOOPS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_5_2_2_nested_loops_seq
