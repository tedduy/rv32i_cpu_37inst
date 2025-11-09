// =============================================================================
// Sequence: TC 4.6.1 - ALL_ONES Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Operands all 1s
// =============================================================================

class tc_4_6_1_all_ones_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_6_1_all_ones_seq)
    
    function new(string name = "tc_4_6_1_all_ones_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ALL_ONES sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ALL_ONES - Operands all 1s
        // ======================================================================
        tr = rv32i_transaction::type_id::create("all_ones_test");
        start_item(tr);
        
        tr.test_name = "ALL_ONES Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ALL_ONES test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ALL_ONES sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_6_1_all_ones_seq
