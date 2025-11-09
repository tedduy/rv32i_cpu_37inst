// =============================================================================
// Sequence: TC 1.2.8 - SRLI Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Shift right logical immediate
// =============================================================================

class tc_1_2_8_srli_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_2_8_srli_seq)
    
    function new(string name = "tc_1_2_8_srli_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SRLI sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SRLI - Shift right logical immediate
        // ======================================================================
        tr = rv32i_transaction::type_id::create("srli_test");
        start_item(tr);
        
        tr.test_name = "SRLI Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SRLI test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SRLI sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_2_8_srli_seq
