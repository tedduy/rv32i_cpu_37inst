// =============================================================================
// Sequence: TC 2.5.1 - X0_RAW Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: RAW on x0 (should not forward)
// =============================================================================

class tc_2_5_1_x0_raw_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_5_1_x0_raw_seq)
    
    function new(string name = "tc_2_5_1_x0_raw_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting X0_RAW sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: X0_RAW - RAW on x0 (should not forward)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("x0_raw_test");
        start_item(tr);
        
        tr.test_name = "X0_RAW Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: X0_RAW test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "X0_RAW sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_5_1_x0_raw_seq
