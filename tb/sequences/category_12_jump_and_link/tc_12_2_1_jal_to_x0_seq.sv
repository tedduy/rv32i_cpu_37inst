// =============================================================================
// Sequence: TC 12.2.1 - JAL_TO_X0 Instruction
// =============================================================================
// Category: Jump & Link
// Priority: HIGH
// Description: JAL with x0 as dest
// =============================================================================

class tc_12_2_1_jal_to_x0_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_12_2_1_jal_to_x0_seq)
    
    function new(string name = "tc_12_2_1_jal_to_x0_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting JAL_TO_X0 sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: JAL_TO_X0 - JAL with x0 as dest
        // ======================================================================
        tr = rv32i_transaction::type_id::create("jal_to_x0_test");
        start_item(tr);
        
        tr.test_name = "JAL_TO_X0 Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: JAL_TO_X0 test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "JAL_TO_X0 sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_12_2_1_jal_to_x0_seq
