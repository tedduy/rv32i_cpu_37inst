// =============================================================================
// Test Case 5.3.3: NESTED_CALLS
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Nested function calls
// =============================================================================

class tc_5_3_3_nested_calls_test extends base_test;
    
    `uvm_component_utils(tc_5_3_3_nested_calls_test)
    
    function new(string name = "tc_5_3_3_nested_calls_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_5_3_3_nested_calls_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_5_3_3_nested_calls_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 5.3.3: NESTED_CALLS ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_5_3_3_nested_calls_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 5.3.3: NESTED_CALLS Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_5_3_3_nested_calls_test
