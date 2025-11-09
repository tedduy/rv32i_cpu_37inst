// =============================================================================
// Sequence: TC 11.1.2 - CPI_WITH_HAZARDS Instruction
// =============================================================================
// Category: Performance
// Priority: LOW
// Description: CPI with typical hazards
// =============================================================================

class tc_11_1_2_cpi_with_hazards_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_11_1_2_cpi_with_hazards_seq)
    
    function new(string name = "tc_11_1_2_cpi_with_hazards_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting CPI_WITH_HAZARDS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: CPI_WITH_HAZARDS - CPI with typical hazards
        // ======================================================================
        tr = rv32i_transaction::type_id::create("cpi_with_hazards_test");
        start_item(tr);
        
        tr.test_name = "CPI_WITH_HAZARDS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: CPI_WITH_HAZARDS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "CPI_WITH_HAZARDS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_11_1_2_cpi_with_hazards_seq
