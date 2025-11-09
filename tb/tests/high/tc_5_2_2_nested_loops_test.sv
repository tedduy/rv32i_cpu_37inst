// =============================================================================
// Test Case 5.2.2: NESTED_LOOPS
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Nested loops
// =============================================================================

class tc_5_2_2_nested_loops_test extends base_test;
    
    `uvm_component_utils(tc_5_2_2_nested_loops_test)
    
    function new(string name = "tc_5_2_2_nested_loops_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_5_2_2_nested_loops_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_5_2_2_nested_loops_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 5.2.2: NESTED_LOOPS ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_5_2_2_nested_loops_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 5.2.2: NESTED_LOOPS Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_5_2_2_nested_loops_test
