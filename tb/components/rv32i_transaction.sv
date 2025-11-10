// =============================================================================
// RV32I Transaction Class
// =============================================================================
// Base transaction class for RV32I instructions and results
// Contains instruction encoding and execution results
// =============================================================================

class rv32i_transaction extends uvm_sequence_item;
    
    // ==========================================================================
    // UVM Factory Registration
    // ==========================================================================
    `uvm_object_utils(rv32i_transaction)
    
    // ==========================================================================
    // Instruction Fields
    // ==========================================================================
    rand bit [31:0] instruction;     // Full 32-bit instruction
    rand bit [6:0]  opcode;          // Instruction opcode
    rand bit [4:0]  rd;              // Destination register
    rand bit [4:0]  rs1;             // Source register 1
    rand bit [4:0]  rs2;             // Source register 2
    rand bit [2:0]  funct3;          // Function code 3
    rand bit [6:0]  funct7;          // Function code 7
    rand bit [31:0] immediate;       // Immediate value
    
    // ==========================================================================
    // Execution Context (for loading into CPU state before test)
    // ==========================================================================
    rand bit [31:0] rs1_value;       // Value to load into rs1 before execution
    rand bit [31:0] rs2_value;       // Value to load into rs2 before execution
    rand bit [31:0] pc_value;        // PC value when instruction executes
    
    // ==========================================================================
    // Expected Results (from golden reference)
    // ==========================================================================
    bit [31:0] expected_rd_value;    // Expected destination register value
    bit [31:0] expected_pc_next;     // Expected next PC
    bit [31:0] expected_mem_addr;    // Expected memory address (for load/store)
    bit [31:0] expected_mem_data;    // Expected memory data
    bit        expected_mem_write;   // Expected memory write enable
    bit        expected_reg_write;   // Expected register write enable
    
    // ==========================================================================
    // Actual Results (captured from DUT)
    // ==========================================================================
    bit [31:0] actual_rd_value;      // Actual destination register value
    bit [31:0] actual_pc_next;       // Actual next PC
    bit [31:0] actual_mem_addr;      // Actual memory address
    bit [31:0] actual_mem_data;      // Actual memory data
    bit        actual_mem_write;     // Actual memory write enable
    bit        actual_reg_write;     // Actual register write enable
    
    // ==========================================================================
    // Pipeline Monitoring
    // ==========================================================================
    bit [31:0] if_pc;                // PC in IF stage
    bit [31:0] id_instruction;       // Instruction in ID stage
    bit [31:0] ex_alu_result;        // ALU result in EX stage
    bit [31:0] mem_data;             // Memory data in MEM stage
    bit [31:0] wb_data;              // Write-back data in WB stage
    bit        forwarding_detected;  // Data forwarding occurred
    bit        stall_detected;       // Pipeline stall occurred
    bit        flush_detected;       // Pipeline flush occurred
    
    // ==========================================================================
    // Test Control
    // ==========================================================================
    string     test_name;            // Name of the test case
    bit        compare_enable;       // Enable comparison with golden reference
    int        instruction_num;      // Instruction number in sequence
    
    // ==========================================================================
    // Constraints
    // ==========================================================================
    
    // Ensure rd, rs1, rs2 are valid register addresses (0-31)
    constraint valid_registers {
        rd  inside {[0:31]};
        rs1 inside {[0:31]};
        rs2 inside {[0:31]};
    }
    
    // Ensure funct3 is valid (0-7)
    constraint valid_funct3 {
        funct3 inside {[0:7]};
    }
    
    // Ensure funct7 is valid (typically 0x00 or 0x20)
    constraint valid_funct7 {
        funct7 inside {7'h00, 7'h20};
    }
    
    // ==========================================================================
    // Constructor
    // ==========================================================================
    function new(string name = "rv32i_transaction");
        super.new(name);
        compare_enable = 1;  // Enable comparison by default
        instruction_num = 0;
    endfunction
    
    // ==========================================================================
    // UVM Methods
    // ==========================================================================
    
    // Convert transaction to string for printing
    function string convert2string();
        string s;
        s = $sformatf("\n=== RV32I Transaction ===\n");
        s = {s, $sformatf("Test: %s (Inst #%0d)\n", test_name, instruction_num)};
        s = {s, $sformatf("Instruction: 0x%08h\n", instruction)};
        s = {s, $sformatf("Opcode: 0x%02h, Funct3: 0x%01h, Funct7: 0x%02h\n", 
                         opcode, funct3, funct7)};
        s = {s, $sformatf("Registers: rd=x%0d, rs1=x%0d, rs2=x%0d\n", rd, rs1, rs2)};
        s = {s, $sformatf("PC: 0x%08h\n", pc_value)};
        s = {s, $sformatf("rs1_value: 0x%08h, rs2_value: 0x%08h\n", rs1_value, rs2_value)};
        
        if (compare_enable) begin
            s = {s, $sformatf("\n--- Expected Results (Golden) ---\n")};
            s = {s, $sformatf("rd_value: 0x%08h, pc_next: 0x%08h\n", 
                             expected_rd_value, expected_pc_next)};
            if (expected_mem_write)
                s = {s, $sformatf("mem_write: addr=0x%08h, data=0x%08h\n", 
                                 expected_mem_addr, expected_mem_data)};
            
            s = {s, $sformatf("\n--- Actual Results (DUT) ---\n")};
            s = {s, $sformatf("rd_value: 0x%08h, pc_next: 0x%08h\n", 
                             actual_rd_value, actual_pc_next)};
            if (actual_mem_write)
                s = {s, $sformatf("mem_write: addr=0x%08h, data=0x%08h\n", 
                                 actual_mem_addr, actual_mem_data)};
        end
        
        s = {s, "========================\n"};
        return s;
    endfunction
    
    // Deep copy for cloning transactions
    function void do_copy(uvm_object rhs);
        rv32i_transaction rhs_;
        if (!$cast(rhs_, rhs))
            `uvm_fatal("DO_COPY", "Cast failed")
        super.do_copy(rhs);
        
        this.instruction = rhs_.instruction;
        this.opcode = rhs_.opcode;
        this.rd = rhs_.rd;
        this.rs1 = rhs_.rs1;
        this.rs2 = rhs_.rs2;
        this.funct3 = rhs_.funct3;
        this.funct7 = rhs_.funct7;
        this.immediate = rhs_.immediate;
        this.rs1_value = rhs_.rs1_value;
        this.rs2_value = rhs_.rs2_value;
        this.pc_value = rhs_.pc_value;
        this.expected_rd_value = rhs_.expected_rd_value;
        this.expected_pc_next = rhs_.expected_pc_next;
        this.expected_mem_addr = rhs_.expected_mem_addr;
        this.expected_mem_data = rhs_.expected_mem_data;
        this.expected_mem_write = rhs_.expected_mem_write;
        this.expected_reg_write = rhs_.expected_reg_write;
        this.test_name = rhs_.test_name;
        this.compare_enable = rhs_.compare_enable;
        this.instruction_num = rhs_.instruction_num;
    endfunction
    
    // Compare two transactions
    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        rv32i_transaction rhs_;
        if (!$cast(rhs_, rhs))
            return 0;
        
        return (
            super.do_compare(rhs, comparer) &&
            (this.instruction == rhs_.instruction) &&
            (this.opcode == rhs_.opcode) &&
            (this.rd == rhs_.rd) &&
            (this.rs1 == rhs_.rs1) &&
            (this.rs2 == rhs_.rs2)
        );
    endfunction

endclass : rv32i_transaction
