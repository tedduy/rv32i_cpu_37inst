// =============================================================================
// Sequence: TC 1.2.1 - ADDI Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Add immediate
// =============================================================================

class tc_1_2_1_addi_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_2_1_addi_seq)
    
    function new(string name = "tc_1_2_1_addi_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ADDI sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ADDI - Add immediate
        // ======================================================================
        tr = rv32i_transaction::type_id::create("addi_test");
        start_item(tr);
        
        tr.test_name = "ADDI Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ADDI test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ADDI sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_2_1_addi_seq
