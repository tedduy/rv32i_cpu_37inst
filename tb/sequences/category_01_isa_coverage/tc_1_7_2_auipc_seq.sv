// =============================================================================
// Sequence: TC 1.7.2 - AUIPC Instruction
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Add upper immediate to PC
// =============================================================================

class tc_1_7_2_auipc_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_1_7_2_auipc_seq)
    
    function new(string name = "tc_1_7_2_auipc_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting AUIPC sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: AUIPC - Add upper immediate to PC
        // ======================================================================
        tr = rv32i_transaction::type_id::create("auipc_test");
        start_item(tr);
        
        tr.test_name = "AUIPC Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: AUIPC test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "AUIPC sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_1_7_2_auipc_seq
