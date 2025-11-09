// =============================================================================
// Sequence: TC 1.3.4 - LB Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Load byte (signed)
// =============================================================================

class tc_1_3_4_lb_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_3_4_lb_seq)
    
    function new(string name = "tc_1_3_4_lb_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting LB sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: LB - Load byte (signed)
        // ======================================================================
        tr = rv32i_transaction::type_id::create("lb_test");
        start_item(tr);
        
        tr.test_name = "LB Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: LB test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "LB sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_3_4_lb_seq
