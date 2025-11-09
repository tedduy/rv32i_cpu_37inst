// =============================================================================
// Sequence: TC 1.1.4 - SLT Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Set less than (signed)
// =============================================================================

class tc_1_1_4_slt_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_1_4_slt_seq)
    
    function new(string name = "tc_1_1_4_slt_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SLT sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SLT - Set less than (signed)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("slt_test");
        start_item(tr);
        
        tr.test_name = "SLT Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SLT test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SLT sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_1_4_slt_seq
