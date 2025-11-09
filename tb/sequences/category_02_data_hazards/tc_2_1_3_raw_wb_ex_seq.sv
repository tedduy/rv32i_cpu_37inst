// =============================================================================
// Sequence: TC 2.1.3 - RAW_WB_EX Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: RAW hazard WB-EX (no forward)
// =============================================================================

class tc_2_1_3_raw_wb_ex_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_1_3_raw_wb_ex_seq)
    
    function new(string name = "tc_2_1_3_raw_wb_ex_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting RAW_WB_EX sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: RAW_WB_EX - RAW hazard WB-EX (no forward)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("raw_wb_ex_test");
        start_item(tr);
        
        tr.test_name = "RAW_WB_EX Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: RAW_WB_EX test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "RAW_WB_EX sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_1_3_raw_wb_ex_seq
