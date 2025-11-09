// =============================================================================
// Sequence: TC 7.4.1 - RAPID_REUSE Instruction
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: Rapid register reuse
// =============================================================================

class tc_7_4_1_rapid_reuse_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_7_4_1_rapid_reuse_seq)
    
    function new(string name = "tc_7_4_1_rapid_reuse_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting RAPID_REUSE sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: RAPID_REUSE - Rapid register reuse
        // ======================================================================
        tr = rv32i_transaction::type_id::create("rapid_reuse_test");
        start_item(tr);
        
        tr.test_name = "RAPID_REUSE Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: RAPID_REUSE test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "RAPID_REUSE sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_7_4_1_rapid_reuse_seq
