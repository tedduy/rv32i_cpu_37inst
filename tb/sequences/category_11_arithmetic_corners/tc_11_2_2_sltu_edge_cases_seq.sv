// =============================================================================
// Sequence: TC 12.2.2 - SLTU_EDGE_CASES Instruction
// =============================================================================
// Category: Arithmetic Corners
// Priority: MEDIUM
// Description: SLTU boundary values
// =============================================================================

class tc_12_2_2_sltu_edge_cases_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_12_2_2_sltu_edge_cases_seq)
    
    function new(string name = "tc_12_2_2_sltu_edge_cases_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SLTU_EDGE_CASES sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SLTU_EDGE_CASES - SLTU boundary values
        // ======================================================================
        tr = rv32i_transaction::type_id::create("sltu_edge_cases_test");
        start_item(tr);
        
        tr.test_name = "SLTU_EDGE_CASES Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SLTU_EDGE_CASES test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SLTU_EDGE_CASES sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_12_2_2_sltu_edge_cases_seq
