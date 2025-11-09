// =============================================================================
// Base Test Class
// =============================================================================
// Base class for all RV32I tests
// Provides common setup, configuration, and utility methods
// =============================================================================

class base_test extends uvm_test;
    
    // ==========================================================================
    // UVM Factory Registration
    // ==========================================================================
    `uvm_component_utils(base_test)
    
    // ==========================================================================
    // Test Environment
    // ==========================================================================
    rv32i_env env;
    
    // ==========================================================================
    // Configuration
    // ==========================================================================
    string spike_log_file = "tests/golden/spike_trace.log";
    int    num_instructions = 10;  // Default number of instructions to verify
    
    // ==========================================================================
    // Constructor
    // ==========================================================================
    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    // ==========================================================================
    // Build Phase
    // ==========================================================================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Create environment
        env = rv32i_env::type_id::create("env", this);
        
        // Set Spike log file in config DB
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
        
        `uvm_info(get_type_name(), 
                 $sformatf("Base test built with spike_log=%s", spike_log_file), 
                 UVM_MEDIUM)
    endfunction
    
    // ==========================================================================
    // End of Elaboration Phase
    // ==========================================================================
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        
        // Print test configuration
        `uvm_info(get_type_name(), "\n=== Test Configuration ===", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Test Name:           %s", get_name()), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Spike Log File:      %s", spike_log_file), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Num Instructions:    %0d", num_instructions), UVM_LOW)
        `uvm_info(get_type_name(), "==========================\n", UVM_LOW)
    endfunction
    
    // ==========================================================================
    // Run Phase (to be overridden by derived tests)
    // ==========================================================================
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        `uvm_info(get_type_name(), "Base test run_phase - override in derived test", UVM_MEDIUM)
        
    endtask
    
    // ==========================================================================
    // Report Phase
    // ==========================================================================
    function void report_phase(uvm_phase phase);
        uvm_report_server svr;
        super.report_phase(phase);
        
        svr = uvm_report_server::get_server();
        
        `uvm_info(get_type_name(), "\n", UVM_LOW)
        `uvm_info(get_type_name(), "=================================================", UVM_LOW)
        `uvm_info(get_type_name(), "              TEST SUMMARY REPORT                ", UVM_LOW)
        `uvm_info(get_type_name(), "=================================================", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Test Name:    %s", get_name()), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("UVM Errors:   %0d", svr.get_severity_count(UVM_ERROR)), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("UVM Warnings: %0d", svr.get_severity_count(UVM_WARNING)), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("UVM Fatals:   %0d", svr.get_severity_count(UVM_FATAL)), UVM_LOW)
        
        if (svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR) == 0) begin
            `uvm_info(get_type_name(), "*** TEST PASSED ***", UVM_LOW)
        end else begin
            `uvm_info(get_type_name(), "*** TEST FAILED ***", UVM_LOW)
        end
        
        `uvm_info(get_type_name(), "=================================================\n", UVM_LOW)
    endfunction

endclass : base_test
