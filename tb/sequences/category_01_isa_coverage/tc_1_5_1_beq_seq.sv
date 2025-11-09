// =============================================================================
// Sequence: TC 1.5.1 - BEQ Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Branch if equal
// =============================================================================

class tc_1_5_1_beq_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_5_1_beq_seq)
    
    function new(string name = "tc_1_5_1_beq_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting BEQ sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: BEQ - Branch if equal
        // ======================================================================
        tr = rv32i_transaction::type_id::create("beq_test");
        start_item(tr);
        
        tr.test_name = "BEQ Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: BEQ test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "BEQ sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_5_1_beq_seq
