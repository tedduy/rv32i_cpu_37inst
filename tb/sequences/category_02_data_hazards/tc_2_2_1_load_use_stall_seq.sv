// =============================================================================
// Sequence: TC 2.2.1 - LOAD_USE_STALL Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: Load-use hazard requires stall
// =============================================================================

class tc_2_2_1_load_use_stall_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_2_1_load_use_stall_seq)
    
    function new(string name = "tc_2_2_1_load_use_stall_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting LOAD_USE_STALL sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: LOAD_USE_STALL - Load-use hazard requires stall
        // ======================================================================
        tr = rv32i_transaction::type_id::create("load_use_stall_test");
        start_item(tr);
        
        tr.test_name = "LOAD_USE_STALL Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: LOAD_USE_STALL test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "LOAD_USE_STALL sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_2_1_load_use_stall_seq
