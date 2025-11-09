// =============================================================================
// Sequence: TC 2.1.4 - RAW_DOUBLE Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: Double RAW hazard
// =============================================================================

class tc_2_1_4_raw_double_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_1_4_raw_double_seq)
    
    function new(string name = "tc_2_1_4_raw_double_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting RAW_DOUBLE sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: RAW_DOUBLE - Double RAW hazard
        // ======================================================================
        tr = rv32i_transaction::type_id::create("raw_double_test");
        start_item(tr);
        
        tr.test_name = "RAW_DOUBLE Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: RAW_DOUBLE test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "RAW_DOUBLE sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_1_4_raw_double_seq
