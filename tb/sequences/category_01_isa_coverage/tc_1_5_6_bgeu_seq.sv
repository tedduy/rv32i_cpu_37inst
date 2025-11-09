// =============================================================================
// Sequence: TC 1.5.6 - BGEU Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Branch if greater/equal (unsigned)
// =============================================================================

class tc_1_5_6_bgeu_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_5_6_bgeu_seq)
    
    function new(string name = "tc_1_5_6_bgeu_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BGEU sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BGEU - Branch if greater/equal (unsigned)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("bgeu_test");
        start_item(tr);
        
        tr.test_name = "BGEU Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BGEU test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BGEU sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_5_6_bgeu_seq
