// =============================================================================
// Sequence: TC 7.3.1 - SAME_REG_SRC_DST Instruction
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: Same register as src and dst
// =============================================================================

class tc_7_3_1_same_reg_src_dst_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_7_3_1_same_reg_src_dst_seq)
    
    function new(string name = "tc_7_3_1_same_reg_src_dst_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SAME_REG_SRC_DST sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SAME_REG_SRC_DST - Same register as src and dst
        // ======================================================================
        tr = rv32i_transaction::type_id::create("same_reg_src_dst_test");
        start_item(tr);
        
        tr.test_name = "SAME_REG_SRC_DST Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SAME_REG_SRC_DST test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SAME_REG_SRC_DST sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_7_3_1_same_reg_src_dst_seq
