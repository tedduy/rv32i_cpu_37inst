// =============================================================================
// Sequence: TC 7.2.1 - X0_ALWAYS_ZERO Instruction
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: x0 remains zero
// =============================================================================

class tc_7_2_1_x0_always_zero_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_7_2_1_x0_always_zero_seq)
    
    function new(string name = "tc_7_2_1_x0_always_zero_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting X0_ALWAYS_ZERO sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: X0_ALWAYS_ZERO - x0 remains zero
        // ======================================================================
        tr = rv32i_transaction::type_id::create("x0_always_zero_test");
        start_item(tr);
        
        tr.test_name = "X0_ALWAYS_ZERO Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: X0_ALWAYS_ZERO test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "X0_ALWAYS_ZERO sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_7_2_1_x0_always_zero_seq
