// =============================================================================
// Sequence: TC 7.1.2 - ALL_REGS_READ Instruction
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: Read from all registers
// =============================================================================

class tc_7_1_2_all_regs_read_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_7_1_2_all_regs_read_seq)
    
    function new(string name = "tc_7_1_2_all_regs_read_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ALL_REGS_READ sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ALL_REGS_READ - Read from all registers
        // ======================================================================
        tr = rv32i_transaction::type_id::create("all_regs_read_test");
        start_item(tr);
        
        tr.test_name = "ALL_REGS_READ Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ALL_REGS_READ test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ALL_REGS_READ sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_7_1_2_all_regs_read_seq
