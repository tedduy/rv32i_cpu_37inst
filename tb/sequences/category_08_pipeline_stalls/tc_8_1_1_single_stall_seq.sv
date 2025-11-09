// =============================================================================
// Sequence: TC 8.1.1 - SINGLE_STALL Instruction
// =============================================================================
// Category: Pipeline Stalls
// Priority: MEDIUM
// Description: Single cycle stall
// =============================================================================

class tc_8_1_1_single_stall_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_8_1_1_single_stall_seq)
    
    function new(string name = "tc_8_1_1_single_stall_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SINGLE_STALL sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SINGLE_STALL - Single cycle stall
        // ======================================================================
        tr = rv32i_transaction::type_id::create("single_stall_test");
        start_item(tr);
        
        tr.test_name = "SINGLE_STALL Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SINGLE_STALL test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SINGLE_STALL sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_8_1_1_single_stall_seq
