// =============================================================================
// Sequence: TC 1.1.7 - SRL Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Logical right shift
// =============================================================================

class tc_1_1_7_srl_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_1_7_srl_seq)
    
    function new(string name = "tc_1_1_7_srl_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SRL sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SRL - Logical right shift
        // ======================================================================
        tr = rv32i_transaction::type_id::create("srl_test");
        start_item(tr);
        
        tr.test_name = "SRL Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SRL test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SRL sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_1_7_srl_seq
