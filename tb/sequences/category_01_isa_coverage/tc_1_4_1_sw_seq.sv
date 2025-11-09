// =============================================================================
// Sequence: TC 1.4.1 - SW Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Store word
// =============================================================================

class tc_1_4_1_sw_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_4_1_sw_seq)
    
    function new(string name = "tc_1_4_1_sw_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting SW sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: SW - Store word
        // ======================================================================
        tr = rv32i_transaction::type_id::create("sw_test");
        start_item(tr);
        
        tr.test_name = "SW Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: SW test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "SW sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_4_1_sw_seq
