// =============================================================================
// Sequence: TC 2.4.3 - INTERLEAVED_HAZARDS Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: Interleaved dependencies
// =============================================================================

class tc_2_4_3_interleaved_hazards_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_4_3_interleaved_hazards_seq)
    
    function new(string name = "tc_2_4_3_interleaved_hazards_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting INTERLEAVED_HAZARDS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: INTERLEAVED_HAZARDS - Interleaved dependencies
        // ======================================================================
        tr = rv32i_transaction::type_id::create("interleaved_hazards_test");
        start_item(tr);
        
        tr.test_name = "INTERLEAVED_HAZARDS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: INTERLEAVED_HAZARDS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "INTERLEAVED_HAZARDS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_4_3_interleaved_hazards_seq
