// =============================================================================
// Sequence: TC 4.3.2 - MAX_NEG_IMM Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Maximum negative immediate
// =============================================================================

class tc_4_3_2_max_neg_imm_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_3_2_max_neg_imm_seq)
    
    function new(string name = "tc_4_3_2_max_neg_imm_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MAX_NEG_IMM sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MAX_NEG_IMM - Maximum negative immediate
        // ======================================================================
        tr = rv32i_transaction::type_id::create("max_neg_imm_test");
        start_item(tr);
        
        tr.test_name = "MAX_NEG_IMM Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MAX_NEG_IMM test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MAX_NEG_IMM sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_3_2_max_neg_imm_seq
