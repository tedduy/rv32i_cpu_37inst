// =============================================================================
// Sequence: TC 1.3.3 - LHU Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Load halfword (unsigned)
// =============================================================================

class tc_1_3_3_lhu_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_3_3_lhu_seq)
    
    function new(string name = "tc_1_3_3_lhu_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting LHU sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: LHU - Load halfword (unsigned)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("lhu_test");
        start_item(tr);
        
        tr.test_name = "LHU Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: LHU test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "LHU sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_3_3_lhu_seq
