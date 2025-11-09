// =============================================================================
// Sequence: TC 1.6.1 - JAL Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Jump and link
// =============================================================================

class tc_1_6_1_jal_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_6_1_jal_seq)
    
    function new(string name = "tc_1_6_1_jal_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting JAL sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: JAL - Jump and link
        // ======================================================================
        tr = rv32i_transaction::type_id::create("jal_test");
        start_item(tr);
        
        tr.test_name = "JAL Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: JAL test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "JAL sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_6_1_jal_seq
