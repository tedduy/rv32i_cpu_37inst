// =============================================================================
// Sequence: TC 2.1.1 - RAW_EX_EX Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: RAW hazard EX-EX forwarding
// =============================================================================

class tc_2_1_1_raw_ex_ex_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_1_1_raw_ex_ex_seq)
    
    function new(string name = "tc_2_1_1_raw_ex_ex_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting RAW_EX_EX sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: RAW_EX_EX - RAW hazard EX-EX forwarding
        // ======================================================================
        tr = rv32i_transaction::type_id::create("raw_ex_ex_test");
        start_item(tr);
        
        tr.test_name = "RAW_EX_EX Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: RAW_EX_EX test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "RAW_EX_EX sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_1_1_raw_ex_ex_seq
