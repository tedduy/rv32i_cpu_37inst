// =============================================================================
// Sequence: TC 5.2.1 - LOOP_WITH_HAZARDS Instruction
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Loop with data hazards
// =============================================================================

class tc_5_2_1_loop_with_hazards_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_5_2_1_loop_with_hazards_seq)
    
    function new(string name = "tc_5_2_1_loop_with_hazards_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting LOOP_WITH_HAZARDS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: LOOP_WITH_HAZARDS - Loop with data hazards
        // ======================================================================
        tr = rv32i_transaction::type_id::create("loop_with_hazards_test");
        start_item(tr);
        
        tr.test_name = "LOOP_WITH_HAZARDS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: LOOP_WITH_HAZARDS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "LOOP_WITH_HAZARDS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_5_2_1_loop_with_hazards_seq
