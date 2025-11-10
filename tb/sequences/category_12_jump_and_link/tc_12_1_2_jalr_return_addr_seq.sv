// =============================================================================
// Sequence: TC 12.1.2 - JALR_RETURN_ADDR Instruction
// =============================================================================
// Category: Jump & Link
// Priority: HIGH
// Description: JALR saves return address
// =============================================================================

class tc_12_1_2_jalr_return_addr_seq extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils(tc_12_1_2_jalr_return_addr_seq)
    
    function new(string name = "tc_12_1_2_jalr_return_addr_seq");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting JALR_RETURN_ADDR sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: JALR_RETURN_ADDR - JALR saves return address
        // ======================================================================
        tr = rv32i_transaction::type_id::create("jalr_return_addr_test");
        start_item(tr);
        
        tr.test_name = "JALR_RETURN_ADDR Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: JALR_RETURN_ADDR test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "JALR_RETURN_ADDR sequence completed", UVM_MEDIUM)
        
    endtask

endclass : tc_12_1_2_jalr_return_addr_seq
