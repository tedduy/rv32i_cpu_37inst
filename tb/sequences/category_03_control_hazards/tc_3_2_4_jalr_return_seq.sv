// =============================================================================
// Sequence: TC 3.2.4 - JALR_RETURN Instruction
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: JALR for function return
// =============================================================================

class tc_3_2_4_jalr_return_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_3_2_4_jalr_return_seq)
    
    function new(string name = "tc_3_2_4_jalr_return_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting JALR_RETURN sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: JALR_RETURN - JALR for function return
        // ======================================================================
        tr = rv32i_transaction::type_id::create("jalr_return_test");
        start_item(tr);
        
        tr.test_name = "JALR_RETURN Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: JALR_RETURN test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "JALR_RETURN sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_3_2_4_jalr_return_seq
