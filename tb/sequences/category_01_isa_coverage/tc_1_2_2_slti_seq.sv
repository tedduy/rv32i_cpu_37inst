// =============================================================================
// Sequence: TC 1.2.2 - SLTI Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Set less than immediate (signed)
// =============================================================================

class tc_1_2_2_slti_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_2_2_slti_seq)
    
    function new(string name = "tc_1_2_2_slti_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SLTI sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SLTI - Set less than immediate (signed)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("slti_test");
        start_item(tr);
        
        tr.test_name = "SLTI Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SLTI test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SLTI sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_2_2_slti_seq
