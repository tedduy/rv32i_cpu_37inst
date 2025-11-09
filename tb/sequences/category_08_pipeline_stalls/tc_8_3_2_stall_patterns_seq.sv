// =============================================================================
// Sequence: TC 8.3.2 - STALL_PATTERNS Instruction
// =============================================================================
// Category: Pipeline Stalls
// Priority: MEDIUM
// Description: Various stall patterns
// =============================================================================

class tc_8_3_2_stall_patterns_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_8_3_2_stall_patterns_seq)
    
    function new(string name = "tc_8_3_2_stall_patterns_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting STALL_PATTERNS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: STALL_PATTERNS - Various stall patterns
        // ======================================================================
        tr = rv32i_transaction::type_id::create("stall_patterns_test");
        start_item(tr);
        
        tr.test_name = "STALL_PATTERNS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: STALL_PATTERNS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "STALL_PATTERNS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_8_3_2_stall_patterns_seq
