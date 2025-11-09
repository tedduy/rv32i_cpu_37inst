// =============================================================================
// Sequence: TC 7.1.1 - ALL_REGS_WRITE Instruction
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: Write to all registers
// =============================================================================

class tc_7_1_1_all_regs_write_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_7_1_1_all_regs_write_seq)
    
    function new(string name = "tc_7_1_1_all_regs_write_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ALL_REGS_WRITE sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ALL_REGS_WRITE - Write to all registers
        // ======================================================================
        tr = rv32i_transaction::type_id::create("all_regs_write_test");
        start_item(tr);
        
        tr.test_name = "ALL_REGS_WRITE Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ALL_REGS_WRITE test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ALL_REGS_WRITE sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_7_1_1_all_regs_write_seq
