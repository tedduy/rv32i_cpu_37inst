// =============================================================================
// Sequence: TC 4.1.3 - MAX_SHIFT Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Maximum shift amount
// =============================================================================

class tc_4_1_3_max_shift_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_1_3_max_shift_seq)
    
    function new(string name = "tc_4_1_3_max_shift_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MAX_SHIFT sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MAX_SHIFT - Maximum shift amount
        // ======================================================================
        tr = rv32i_transaction::type_id::create("max_shift_test");
        start_item(tr);
        
        tr.test_name = "MAX_SHIFT Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MAX_SHIFT test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MAX_SHIFT sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_1_3_max_shift_seq
