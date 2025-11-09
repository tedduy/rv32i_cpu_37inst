// =============================================================================
// Sequence: TC 5.4.1 - MIXED_HAZARDS Instruction
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: All hazard types mixed
// =============================================================================

class tc_5_4_1_mixed_hazards_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_5_4_1_mixed_hazards_seq)
    
    function new(string name = "tc_5_4_1_mixed_hazards_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MIXED_HAZARDS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MIXED_HAZARDS - All hazard types mixed
        // ======================================================================
        tr = rv32i_transaction::type_id::create("mixed_hazards_test");
        start_item(tr);
        
        tr.test_name = "MIXED_HAZARDS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MIXED_HAZARDS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MIXED_HAZARDS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_5_4_1_mixed_hazards_seq
