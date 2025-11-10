// =============================================================================
// Sequence: TC 11.2.1 - SLT_EDGE_CASES Instruction
// =============================================================================
// Category: Arithmetic Corners
// Priority: MEDIUM
// Description: SLT boundary values
// =============================================================================

class tc_11_2_1_slt_edge_cases_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_11_2_1_slt_edge_cases_seq)
    
    function new(string name = "tc_11_2_1_slt_edge_cases_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SLT_EDGE_CASES sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SLT_EDGE_CASES - SLT boundary values
        // ======================================================================
        tr = rv32i_transaction::type_id::create("slt_edge_cases_test");
        start_item(tr);
        
        tr.test_name = "SLT_EDGE_CASES Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SLT_EDGE_CASES test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SLT_EDGE_CASES sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_11_2_1_slt_edge_cases_seq
