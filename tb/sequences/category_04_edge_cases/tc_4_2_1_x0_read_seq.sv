// =============================================================================
// Sequence: TC 4.2.1 - X0_READ Instruction
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Read from x0
// =============================================================================

class tc_4_2_1_x0_read_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_4_2_1_x0_read_seq)
    
    function new(string name = "tc_4_2_1_x0_read_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting X0_READ sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: X0_READ - Read from x0
        // ======================================================================
        tr = rv32i_transaction::type_id::create("x0_read_test");
        start_item(tr);
        
        tr.test_name = "X0_READ Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: X0_READ test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "X0_READ sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_4_2_1_x0_read_seq
