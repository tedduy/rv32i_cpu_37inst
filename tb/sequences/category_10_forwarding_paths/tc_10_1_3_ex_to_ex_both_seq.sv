// =============================================================================
// Sequence: TC 10.1.3 - EX_TO_EX_BOTH Instruction
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: EX-EX forward to both
// =============================================================================

class tc_10_1_3_ex_to_ex_both_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_10_1_3_ex_to_ex_both_seq)
    
    function new(string name = "tc_10_1_3_ex_to_ex_both_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting EX_TO_EX_BOTH sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: EX_TO_EX_BOTH - EX-EX forward to both
        // ======================================================================
        tr = rv32i_transaction::type_id::create("ex_to_ex_both_test");
        start_item(tr);
        
        tr.test_name = "EX_TO_EX_BOTH Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: EX_TO_EX_BOTH test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "EX_TO_EX_BOTH sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_10_1_3_ex_to_ex_both_seq
