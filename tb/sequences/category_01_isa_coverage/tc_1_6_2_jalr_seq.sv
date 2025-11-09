// =============================================================================
// Sequence: TC 1.6.2 - JALR Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Jump and link register
// =============================================================================

class tc_1_6_2_jalr_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_6_2_jalr_seq)
    
    function new(string name = "tc_1_6_2_jalr_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting JALR sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: JALR - Jump and link register
        // ======================================================================
        tr = rv32i_transaction::type_id::create("jalr_test");
        start_item(tr);
        
        tr.test_name = "JALR Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: JALR test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "JALR sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_6_2_jalr_seq
