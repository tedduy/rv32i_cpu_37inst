// =============================================================================
// Sequence: TC 3.5.1 - FLUSH_IF Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Flush IF stage
// =============================================================================

class tc_3_5_1_flush_if_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_5_1_flush_if_seq)
    
    function new(string name = "tc_3_5_1_flush_if_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting FLUSH_IF sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: FLUSH_IF - Flush IF stage
        // ======================================================================
        tr = rv32i_transaction::type_id::create("flush_if_test");
        start_item(tr);
        
        tr.test_name = "FLUSH_IF Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: FLUSH_IF test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "FLUSH_IF sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_5_1_flush_if_seq
