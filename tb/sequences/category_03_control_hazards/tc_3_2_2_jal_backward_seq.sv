// =============================================================================
// Sequence: TC 3.2.2 - JAL_BACKWARD Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: JAL backward jump
// =============================================================================

class tc_3_2_2_jal_backward_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_2_2_jal_backward_seq)
    
    function new(string name = "tc_3_2_2_jal_backward_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting JAL_BACKWARD sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: JAL_BACKWARD - JAL backward jump
        // ======================================================================
        tr = rv32i_transaction::type_id::create("jal_backward_test");
        start_item(tr);
        
        tr.test_name = "JAL_BACKWARD Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: JAL_BACKWARD test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "JAL_BACKWARD sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_2_2_jal_backward_seq
