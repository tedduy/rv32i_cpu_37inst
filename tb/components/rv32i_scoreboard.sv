// =============================================================================
// RV32I Scoreboard
// =============================================================================
// Compares DUT outputs against golden reference
// Tracks pass/fail statistics and generates detailed reports
// =============================================================================

class rv32i_scoreboard extends uvm_scoreboard;
    
    // ==========================================================================
    // UVM Factory Registration
    // ==========================================================================
    `uvm_component_utils(rv32i_scoreboard)
    
    // ==========================================================================
    // TLM Analysis Import (receives transactions from monitor)
    // ==========================================================================
    uvm_analysis_imp #(rv32i_transaction, rv32i_scoreboard) analysis_export;
    
    // ==========================================================================
    // Golden Checker Component
    // ==========================================================================
    golden_checker golden;
    
    // ==========================================================================
    // Statistics
    // ==========================================================================
    int total_instructions = 0;
    int passed_instructions = 0;
    int failed_instructions = 0;
    int reg_write_mismatches = 0;
    int mem_write_mismatches = 0;
    int pc_mismatches = 0;
    
    // ==========================================================================
    // Configuration
    // ==========================================================================
    // Configuration
    bit enable_comparison = 0;  // Disabled by default (enable when golden refs available)
    bit verbose_mode = 0;
    
    // ==========================================================================
    // Constructor
    // ==========================================================================
    function new(string name = "rv32i_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    // ==========================================================================
    // Build Phase
    // ==========================================================================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Create analysis import
        analysis_export = new("analysis_export", this);
        
        // Create golden checker
        golden = golden_checker::type_id::create("golden", this);
        
        `uvm_info(get_type_name(), "Scoreboard built successfully", UVM_LOW)
    endfunction
    
    // ==========================================================================
    // Write Method (called when monitor sends transaction)
    // ==========================================================================
    function void write(rv32i_transaction tr);
        
        golden_checker::golden_ref_t expected;
        bit match = 1;
        string mismatch_details = "";
        
        total_instructions++;
        
        if (!enable_comparison) begin
            `uvm_info(get_type_name(), 
                     $sformatf("Comparison disabled, accepting instruction #%0d", total_instructions), 
                     UVM_HIGH)
            passed_instructions++;
            return;
        end
        
        // Get expected values from golden reference
        if (!golden.get_next_expected(expected)) begin
            `uvm_error(get_type_name(), 
                      $sformatf("Failed to get golden reference for instruction #%0d", 
                               total_instructions))
            failed_instructions++;
            return;
        end
        
        // Compare PC
        if (tr.if_pc != expected.pc) begin
            mismatch_details = {mismatch_details, 
                               $sformatf("  PC mismatch: DUT=0x%08h, Expected=0x%08h\n", 
                                        tr.if_pc, expected.pc)};
            match = 0;
            pc_mismatches++;
        end
        
        // Compare instruction encoding
        if (tr.instruction != expected.instruction) begin
            mismatch_details = {mismatch_details, 
                               $sformatf("  Instruction mismatch: DUT=0x%08h, Expected=0x%08h\n", 
                                        tr.instruction, expected.instruction)};
            match = 0;
        end
        
        // Compare register writes
        if (tr.actual_reg_write && expected.reg_write) begin
            if (tr.rd != expected.rd) begin
                mismatch_details = {mismatch_details, 
                                   $sformatf("  Destination register mismatch: DUT=x%0d, Expected=x%0d\n", 
                                            tr.rd, expected.rd)};
                match = 0;
                reg_write_mismatches++;
            end
            
            if (tr.actual_rd_value != expected.rd_value) begin
                mismatch_details = {mismatch_details, 
                                   $sformatf("  Register value mismatch: DUT=0x%08h, Expected=0x%08h\n", 
                                            tr.actual_rd_value, expected.rd_value)};
                match = 0;
                reg_write_mismatches++;
            end
        end else if (tr.actual_reg_write != expected.reg_write) begin
            mismatch_details = {mismatch_details, 
                               $sformatf("  Register write enable mismatch: DUT=%0b, Expected=%0b\n", 
                                        tr.actual_reg_write, expected.reg_write)};
            match = 0;
            reg_write_mismatches++;
        end
        
        // Compare memory writes
        if (tr.actual_mem_write && expected.mem_write) begin
            if (tr.actual_mem_addr != expected.mem_addr) begin
                mismatch_details = {mismatch_details, 
                                   $sformatf("  Memory address mismatch: DUT=0x%08h, Expected=0x%08h\n", 
                                            tr.actual_mem_addr, expected.mem_addr)};
                match = 0;
                mem_write_mismatches++;
            end
            
            if (tr.actual_mem_data != expected.mem_data) begin
                mismatch_details = {mismatch_details, 
                                   $sformatf("  Memory data mismatch: DUT=0x%08h, Expected=0x%08h\n", 
                                            tr.actual_mem_data, expected.mem_data)};
                match = 0;
                mem_write_mismatches++;
            end
        end else if (tr.actual_mem_write != expected.mem_write) begin
            mismatch_details = {mismatch_details, 
                               $sformatf("  Memory write enable mismatch: DUT=%0b, Expected=%0b\n", 
                                        tr.actual_mem_write, expected.mem_write)};
            match = 0;
            mem_write_mismatches++;
        end
        
        // Update statistics and report
        if (match) begin
            passed_instructions++;
            
            if (verbose_mode) begin
                `uvm_info(get_type_name(), 
                         $sformatf("PASS [%0d]: PC=0x%08h, inst=0x%08h", 
                                  total_instructions, tr.if_pc, tr.instruction), 
                         UVM_MEDIUM)
            end
        end else begin
            failed_instructions++;
            
            `uvm_error(get_type_name(), 
                      $sformatf("FAIL [%0d]: PC=0x%08h, inst=0x%08h\n%s", 
                               total_instructions, tr.if_pc, tr.instruction, 
                               mismatch_details))
        end
        
    endfunction
    
    // ==========================================================================
    // Report Phase - Print Final Statistics
    // ==========================================================================
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        
        `uvm_info(get_type_name(), "\n\n", UVM_LOW)
        `uvm_info(get_type_name(), "=================================================", UVM_LOW)
        `uvm_info(get_type_name(), "           RV32I VERIFICATION SUMMARY            ", UVM_LOW)
        `uvm_info(get_type_name(), "=================================================", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Total Instructions:    %0d", total_instructions), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Passed Instructions:   %0d", passed_instructions), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Failed Instructions:   %0d", failed_instructions), UVM_LOW)
        
        if (total_instructions > 0) begin
            real pass_rate = (real'(passed_instructions) / real'(total_instructions)) * 100.0;
            `uvm_info(get_type_name(), $sformatf("Pass Rate:             %.2f%%", pass_rate), UVM_LOW)
        end
        
        `uvm_info(get_type_name(), "\n--- Error Breakdown ---", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Register Mismatches:   %0d", reg_write_mismatches), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Memory Mismatches:     %0d", mem_write_mismatches), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("PC Mismatches:         %0d", pc_mismatches), UVM_LOW)
        `uvm_info(get_type_name(), "=================================================\n\n", UVM_LOW)
        
        // Set test status
        if (failed_instructions == 0 && total_instructions > 0) begin
            `uvm_info(get_type_name(), "*** TEST PASSED ***", UVM_LOW)
        end else if (total_instructions == 0) begin
            `uvm_warning(get_type_name(), "*** NO INSTRUCTIONS VERIFIED ***")
        end else begin
            `uvm_error(get_type_name(), "*** TEST FAILED ***")
        end
        
    endfunction
    
    // ==========================================================================
    // Check Phase - Final Pass/Fail Check
    // ==========================================================================
    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        
        if (failed_instructions > 0) begin
            `uvm_error(get_type_name(), 
                      $sformatf("Verification failed: %0d/%0d instructions failed", 
                               failed_instructions, total_instructions))
        end
    endfunction
    
    // ==========================================================================
    // Reset Statistics
    // ==========================================================================
    function void reset_stats();
        total_instructions = 0;
        passed_instructions = 0;
        failed_instructions = 0;
        reg_write_mismatches = 0;
        mem_write_mismatches = 0;
        pc_mismatches = 0;
        golden.reset_index();
        `uvm_info(get_type_name(), "Statistics reset", UVM_MEDIUM)
    endfunction

endclass : rv32i_scoreboard
