// =============================================================================
// Sequence: TC 3.2.1 - JAL_FORWARD Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: JAL forward jump
// =============================================================================

class tc_3_2_1_jal_forward_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_2_1_jal_forward_seq)
    
    function new(string name = "tc_3_2_1_jal_forward_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting JAL_FORWARD sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: JAL_FORWARD - JAL forward jump
        // ======================================================================
        tr = rv32i_transaction::type_id::create("jal_forward_test");
        start_item(tr);
        
        tr.test_name = "JAL_FORWARD Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: JAL_FORWARD test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "JAL_FORWARD sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_2_1_jal_forward_seq
