// =============================================================================
// Sequence: TC 9.1.1 - EX_TO_EX_RS1 Instruction
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: EX-EX forward to rs1
// =============================================================================

class tc_9_1_1_ex_to_ex_rs1_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_9_1_1_ex_to_ex_rs1_seq)
    
    function new(string name = "tc_9_1_1_ex_to_ex_rs1_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting EX_TO_EX_RS1 sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: EX_TO_EX_RS1 - EX-EX forward to rs1
        // ======================================================================
        tr = rv32i_transaction::type_id::create("ex_to_ex_rs1_test");
        start_item(tr);
        
        tr.test_name = "EX_TO_EX_RS1 Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: EX_TO_EX_RS1 test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "EX_TO_EX_RS1 sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_9_1_1_ex_to_ex_rs1_seq
