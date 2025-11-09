// =============================================================================
// Sequence: TC 1.5.5 - BLTU Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Branch if less than (unsigned)
// =============================================================================

class tc_1_5_5_bltu_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_5_5_bltu_seq)
    
    function new(string name = "tc_1_5_5_bltu_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BLTU sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BLTU - Branch if less than (unsigned)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("bltu_test");
        start_item(tr);
        
        tr.test_name = "BLTU Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BLTU test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BLTU sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_5_5_bltu_seq
