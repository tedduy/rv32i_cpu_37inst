// =============================================================================
// Sequence: TC 12.1.3 - SUB_UNDERFLOW Instruction
// =============================================================================
// Category: Arithmetic Corners
// Priority: MEDIUM
// Description: Subtraction underflow
// =============================================================================

class tc_12_1_3_sub_underflow_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_12_1_3_sub_underflow_seq)
    
    function new(string name = "tc_12_1_3_sub_underflow_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SUB_UNDERFLOW sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SUB_UNDERFLOW - Subtraction underflow
        // ======================================================================
        tr = rv32i_transaction::type_id::create("sub_underflow_test");
        start_item(tr);
        
        tr.test_name = "SUB_UNDERFLOW Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SUB_UNDERFLOW test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SUB_UNDERFLOW sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_12_1_3_sub_underflow_seq
