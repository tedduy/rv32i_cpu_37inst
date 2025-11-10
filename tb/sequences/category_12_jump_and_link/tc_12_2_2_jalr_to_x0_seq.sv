// =============================================================================
// Sequence: TC 12.2.2 - JALR_TO_X0 Instruction
// =============================================================================
// Category: Jump & Link
// Priority: HIGH
// Description: JALR with x0 as dest
// =============================================================================

class tc_12_2_2_jalr_to_x0_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_12_2_2_jalr_to_x0_seq)
    
    function new(string name = "tc_12_2_2_jalr_to_x0_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting JALR_TO_X0 sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: JALR_TO_X0 - JALR with x0 as dest
        // ======================================================================
        tr = rv32i_transaction::type_id::create("jalr_to_x0_test");
        start_item(tr);
        
        tr.test_name = "JALR_TO_X0 Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: JALR_TO_X0 test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "JALR_TO_X0 sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_12_2_2_jalr_to_x0_seq
