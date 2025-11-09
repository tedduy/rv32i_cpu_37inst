// =============================================================================
// Sequence: TC 1.2.3 - SLTIU Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Set less than immediate (unsigned)
// =============================================================================

class tc_1_2_3_sltiu_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_2_3_sltiu_seq)
    
    function new(string name = "tc_1_2_3_sltiu_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SLTIU sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SLTIU - Set less than immediate (unsigned)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("sltiu_test");
        start_item(tr);
        
        tr.test_name = "SLTIU Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SLTIU test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SLTIU sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_2_3_sltiu_seq
