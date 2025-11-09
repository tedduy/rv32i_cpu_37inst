// =============================================================================
// Sequence: TC 1.5.4 - BGE Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Branch if greater/equal (signed)
// =============================================================================

class tc_1_5_4_bge_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_5_4_bge_seq)
    
    function new(string name = "tc_1_5_4_bge_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BGE sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BGE - Branch if greater/equal (signed)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("bge_test");
        start_item(tr);
        
        tr.test_name = "BGE Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BGE test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BGE sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_5_4_bge_seq
