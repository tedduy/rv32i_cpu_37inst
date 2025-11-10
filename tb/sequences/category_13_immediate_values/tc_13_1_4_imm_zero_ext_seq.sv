// =============================================================================
// Sequence: TC 13.1.4 - IMM_ZERO_EXT Instruction
// =============================================================================
// Category: Immediate Values
// Priority: MEDIUM
// Description: Immediate zero extension
// =============================================================================

class tc_13_1_4_imm_zero_ext_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_13_1_4_imm_zero_ext_seq)
    
    function new(string name = "tc_13_1_4_imm_zero_ext_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting IMM_ZERO_EXT sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: IMM_ZERO_EXT - Immediate zero extension
        // ======================================================================
        tr = rv32i_transaction::type_id::create("imm_zero_ext_test");
        start_item(tr);
        
        tr.test_name = "IMM_ZERO_EXT Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: IMM_ZERO_EXT test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "IMM_ZERO_EXT sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_13_1_4_imm_zero_ext_seq
