// =============================================================================
// Sequence: TC 2.3.3 - BOTH_RS_FORWARD Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: Both rs1 and rs2 forward
// =============================================================================

class tc_2_3_3_both_rs_forward_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_3_3_both_rs_forward_seq)
    
    function new(string name = "tc_2_3_3_both_rs_forward_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BOTH_RS_FORWARD sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BOTH_RS_FORWARD - Both rs1 and rs2 forward
        // ======================================================================
        tr = rv32i_transaction::type_id::create("both_rs_forward_test");
        start_item(tr);
        
        tr.test_name = "BOTH_RS_FORWARD Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BOTH_RS_FORWARD test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BOTH_RS_FORWARD sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_3_3_both_rs_forward_seq
