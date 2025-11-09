// =============================================================================
// Sequence: TC 3.5.2 - FLUSH_ID Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Flush ID stage
// =============================================================================

class tc_3_5_2_flush_id_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_5_2_flush_id_seq)
    
    function new(string name = "tc_3_5_2_flush_id_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting FLUSH_ID sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: FLUSH_ID - Flush ID stage
        // ======================================================================
        tr = rv32i_transaction::type_id::create("flush_id_test");
        start_item(tr);
        
        tr.test_name = "FLUSH_ID Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: FLUSH_ID test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "FLUSH_ID sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_5_2_flush_id_seq
