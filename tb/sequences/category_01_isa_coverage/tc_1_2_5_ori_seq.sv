// =============================================================================
// Sequence: TC 1.2.5 - ORI Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: OR immediate
// =============================================================================

class tc_1_2_5_ori_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_2_5_ori_seq)
    
    function new(string name = "tc_1_2_5_ori_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting ORI sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: ORI - OR immediate
        // ======================================================================
        tr = rv32i_transaction::type_id::create("ori_test");
        start_item(tr);
        
        tr.test_name = "ORI Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: ORI test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "ORI sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_2_5_ori_seq
