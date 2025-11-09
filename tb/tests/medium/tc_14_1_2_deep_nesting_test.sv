// =============================================================================
// Test Case 15.1.2: DEEP_NESTING
// =============================================================================
// Category: Stress Tests
// Priority: MEDIUM
// Description: Deeply nested branches
// =============================================================================

class tc_15_1_2_deep_nesting_test extends base_test;
    
    `uvm_component_utils(tc_15_1_2_deep_nesting_test)
    
    function new(string name = "tc_15_1_2_deep_nesting_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_15_1_2_deep_nesting_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_15_1_2_deep_nesting_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 15.1.2: DEEP_NESTING ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_15_1_2_deep_nesting_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 15.1.2: DEEP_NESTING Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_15_1_2_deep_nesting_test
