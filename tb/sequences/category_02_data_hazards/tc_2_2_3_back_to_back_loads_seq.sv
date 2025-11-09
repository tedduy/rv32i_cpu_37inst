// =============================================================================
// Sequence: TC 2.2.3 - BACK_TO_BACK_LOADS Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: Consecutive load hazards
// =============================================================================

class tc_2_2_3_back_to_back_loads_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_2_3_back_to_back_loads_seq)
    
    function new(string name = "tc_2_2_3_back_to_back_loads_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BACK_TO_BACK_LOADS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BACK_TO_BACK_LOADS - Consecutive load hazards
        // ======================================================================
        tr = rv32i_transaction::type_id::create("back_to_back_loads_test");
        start_item(tr);
        
        tr.test_name = "BACK_TO_BACK_LOADS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BACK_TO_BACK_LOADS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BACK_TO_BACK_LOADS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_2_3_back_to_back_loads_seq
