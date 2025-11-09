// =============================================================================
// Sequence: TC 1.1.6 - XOR Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Bitwise XOR
// =============================================================================

class tc_1_1_6_xor_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_1_6_xor_seq)
    
    function new(string name = "tc_1_1_6_xor_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting XOR sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: XOR - Bitwise XOR
        // ======================================================================
        tr = rv32i_transaction::type_id::create("xor_test");
        start_item(tr);
        
        tr.test_name = "XOR Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: XOR test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "XOR sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_1_6_xor_seq
