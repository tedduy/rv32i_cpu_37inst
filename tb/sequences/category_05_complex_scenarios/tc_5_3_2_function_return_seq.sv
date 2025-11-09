// =============================================================================
// Sequence: TC 5.3.2 - FUNCTION_RETURN Instruction
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Function return with JALR
// =============================================================================

class tc_5_3_2_function_return_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_5_3_2_function_return_seq)
    
    function new(string name = "tc_5_3_2_function_return_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting FUNCTION_RETURN sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: FUNCTION_RETURN - Function return with JALR
        // ======================================================================
        tr = rv32i_transaction::type_id::create("function_return_test");
        start_item(tr);
        
        tr.test_name = "FUNCTION_RETURN Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: FUNCTION_RETURN test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "FUNCTION_RETURN sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_5_3_2_function_return_seq
