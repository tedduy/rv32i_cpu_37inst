// =============================================================================
// Sequence: TC 4.3.3 - ZERO_IMM Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Zero immediate
// =============================================================================

class tc_4_3_3_zero_imm_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_3_3_zero_imm_seq)
    
    function new(string name = "tc_4_3_3_zero_imm_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ZERO_IMM sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ZERO_IMM - Zero immediate
        // ======================================================================
        tr = rv32i_transaction::type_id::create("zero_imm_test");
        start_item(tr);
        
        tr.test_name = "ZERO_IMM Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ZERO_IMM test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ZERO_IMM sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_3_3_zero_imm_seq
