// =============================================================================
// Sequence: TC 2.4.2 - MULTIPLE_CONSUMERS Instruction
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: One producer, multiple consumers
// =============================================================================

class tc_2_4_2_multiple_consumers_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_2_4_2_multiple_consumers_seq)
    
    function new(string name = "tc_2_4_2_multiple_consumers_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting MULTIPLE_CONSUMERS sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: MULTIPLE_CONSUMERS - One producer, multiple consumers
        // ======================================================================
        tr = rv32i_transaction::type_id::create("multiple_consumers_test");
        start_item(tr);
        
        tr.test_name = "MULTIPLE_CONSUMERS Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: MULTIPLE_CONSUMERS test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "MULTIPLE_CONSUMERS sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_2_4_2_multiple_consumers_seq
