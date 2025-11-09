// =============================================================================
// Sequence: TC 7.3.2 - ALL_SAME_REG Instruction
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: All operands same register
// =============================================================================

class tc_7_3_2_all_same_reg_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_7_3_2_all_same_reg_seq)
    
    function new(string name = "tc_7_3_2_all_same_reg_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ALL_SAME_REG sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ALL_SAME_REG - All operands same register
        // ======================================================================
        tr = rv32i_transaction::type_id::create("all_same_reg_test");
        start_item(tr);
        
        tr.test_name = "ALL_SAME_REG Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ALL_SAME_REG test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ALL_SAME_REG sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_7_3_2_all_same_reg_seq
