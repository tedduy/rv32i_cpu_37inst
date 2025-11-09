// =============================================================================
// Sequence: TC 2.5.2 - X0_WRITE_IGNORED Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: x0 writes ignored
// =============================================================================

class tc_2_5_2_x0_write_ignored_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_5_2_x0_write_ignored_seq)
    
    function new(string name = "tc_2_5_2_x0_write_ignored_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting X0_WRITE_IGNORED sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: X0_WRITE_IGNORED - x0 writes ignored
        // ======================================================================
        tr = rv32i_transaction::type_id::create("x0_write_ignored_test");
        start_item(tr);
        
        tr.test_name = "X0_WRITE_IGNORED Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: X0_WRITE_IGNORED test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "X0_WRITE_IGNORED sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_5_2_x0_write_ignored_seq
