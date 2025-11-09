// =============================================================================
// Sequence: TC 10.1.2 - EX_TO_EX_RS2 Instruction
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: EX-EX forward to rs2
// =============================================================================

class tc_10_1_2_ex_to_ex_rs2_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_10_1_2_ex_to_ex_rs2_seq)
    
    function new(string name = "tc_10_1_2_ex_to_ex_rs2_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting EX_TO_EX_RS2 sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: EX_TO_EX_RS2 - EX-EX forward to rs2
        // ======================================================================
        tr = rv32i_transaction::type_id::create("ex_to_ex_rs2_test");
        start_item(tr);
        
        tr.test_name = "EX_TO_EX_RS2 Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: EX_TO_EX_RS2 test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "EX_TO_EX_RS2 sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_10_1_2_ex_to_ex_rs2_seq
