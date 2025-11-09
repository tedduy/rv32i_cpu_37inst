// =============================================================================
// Sequence: TC 1.4.2 - SH Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Store halfword
// =============================================================================

class tc_1_4_2_sh_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_4_2_sh_seq)
    
    function new(string name = "tc_1_4_2_sh_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SH sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SH - Store halfword
        // ======================================================================
        tr = rv32i_transaction::type_id::create("sh_test");
        start_item(tr);
        
        tr.test_name = "SH Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SH test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SH sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_4_2_sh_seq
