// =============================================================================
// Sequence: TC 1.4.3 - SB Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Store byte
// =============================================================================

class tc_1_4_3_sb_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_4_3_sb_seq)
    
    function new(string name = "tc_1_4_3_sb_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SB sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SB - Store byte
        // ======================================================================
        tr = rv32i_transaction::type_id::create("sb_test");
        start_item(tr);
        
        tr.test_name = "SB Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SB test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SB sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_4_3_sb_seq
