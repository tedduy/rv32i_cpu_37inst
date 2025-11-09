// =============================================================================
// Test Case 11.1.3: CPI_WORST_CASE
// =============================================================================
// Category: Performance
// Priority: LOW
// Description: CPI worst case scenario
// =============================================================================

class tc_11_1_3_cpi_worst_case_test extends base_test;
    
    `uvm_component_utils(tc_11_1_3_cpi_worst_case_test)
    
    function new(string name = "tc_11_1_3_cpi_worst_case_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_11_1_3_cpi_worst_case_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_11_1_3_cpi_worst_case_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 11.1.3: CPI_WORST_CASE ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_11_1_3_cpi_worst_case_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 11.1.3: CPI_WORST_CASE Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_11_1_3_cpi_worst_case_test
