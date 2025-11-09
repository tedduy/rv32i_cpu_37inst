// =============================================================================
// Test Case 12.2.3: SHIFT_EDGE_CASES
// =============================================================================
// Category: Arithmetic Corners
// Priority: MEDIUM
// Description: Shift boundary amounts
// =============================================================================

class tc_12_2_3_shift_edge_cases_test extends base_test;
    
    `uvm_component_utils(tc_12_2_3_shift_edge_cases_test)
    
    function new(string name = "tc_12_2_3_shift_edge_cases_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_12_2_3_shift_edge_cases_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_12_2_3_shift_edge_cases_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 12.2.3: SHIFT_EDGE_CASES ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_12_2_3_shift_edge_cases_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 12.2.3: SHIFT_EDGE_CASES Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_12_2_3_shift_edge_cases_test
