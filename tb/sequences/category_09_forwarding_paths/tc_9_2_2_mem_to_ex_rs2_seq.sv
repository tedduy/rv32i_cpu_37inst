// =============================================================================
// Sequence: TC 9.2.2 - MEM_TO_EX_RS2 Instruction
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: MEM-EX forward to rs2
// =============================================================================

class tc_9_2_2_mem_to_ex_rs2_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_9_2_2_mem_to_ex_rs2_seq)
    
    function new(string name = "tc_9_2_2_mem_to_ex_rs2_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MEM_TO_EX_RS2 sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MEM_TO_EX_RS2 - MEM-EX forward to rs2
        // ======================================================================
        tr = rv32i_transaction::type_id::create("mem_to_ex_rs2_test");
        start_item(tr);
        
        tr.test_name = "MEM_TO_EX_RS2 Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MEM_TO_EX_RS2 test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MEM_TO_EX_RS2 sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_9_2_2_mem_to_ex_rs2_seq
