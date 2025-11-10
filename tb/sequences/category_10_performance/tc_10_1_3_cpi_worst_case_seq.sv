// =============================================================================
// Sequence: TC 10.1.3 - CPI_WORST_CASE Instruction
// =============================================================================
// Category: Performance
// Priority: LOW
// Description: CPI worst case scenario
// =============================================================================

class tc_10_1_3_cpi_worst_case_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_10_1_3_cpi_worst_case_seq)
    
    function new(string name = "tc_10_1_3_cpi_worst_case_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting CPI_WORST_CASE sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: CPI_WORST_CASE - CPI worst case scenario
        // ======================================================================
        tr = rv32i_transaction::type_id::create("cpi_worst_case_test");
        start_item(tr);
        
        tr.test_name = "CPI_WORST_CASE Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: CPI_WORST_CASE test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "CPI_WORST_CASE sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_10_1_3_cpi_worst_case_seq
