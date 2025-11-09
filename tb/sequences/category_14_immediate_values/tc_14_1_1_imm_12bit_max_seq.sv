// =============================================================================
// Sequence: TC 14.1.1 - IMM_12BIT_MAX Instruction
// =============================================================================
// Category: Immediate Values
// Priority: MEDIUM
// Description: 12-bit immediate max
// =============================================================================

class tc_14_1_1_imm_12bit_max_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_14_1_1_imm_12bit_max_seq)
    
    function new(string name = "tc_14_1_1_imm_12bit_max_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting IMM_12BIT_MAX sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: IMM_12BIT_MAX - 12-bit immediate max
        // ======================================================================
        tr = rv32i_transaction::type_id::create("imm_12bit_max_test");
        start_item(tr);
        
        tr.test_name = "IMM_12BIT_MAX Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: IMM_12BIT_MAX test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "IMM_12BIT_MAX sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_14_1_1_imm_12bit_max_seq
