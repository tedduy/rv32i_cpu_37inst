// =============================================================================
// Sequence: TC 7.2.2 - X0_AS_SOURCE Instruction
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: x0 as operand source
// =============================================================================

class tc_7_2_2_x0_as_source_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_7_2_2_x0_as_source_seq)
    
    function new(string name = "tc_7_2_2_x0_as_source_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting X0_AS_SOURCE sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: X0_AS_SOURCE - x0 as operand source
        // ======================================================================
        tr = rv32i_transaction::type_id::create("x0_as_source_test");
        start_item(tr);
        
        tr.test_name = "X0_AS_SOURCE Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: X0_AS_SOURCE test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "X0_AS_SOURCE sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_7_2_2_x0_as_source_seq
