// =============================================================================
// Test Case 15.1.1: LONG_SEQUENCE
// =============================================================================
// Category: Stress Tests
// Priority: MEDIUM
// Description: 100+ instructions
// =============================================================================

class tc_15_1_1_long_sequence_test extends base_test;
    
    `uvm_component_utils(tc_15_1_1_long_sequence_test)
    
    function new(string name = "tc_15_1_1_long_sequence_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_15_1_1_long_sequence_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_15_1_1_long_sequence_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 15.1.1: LONG_SEQUENCE ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_15_1_1_long_sequence_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 15.1.1: LONG_SEQUENCE Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_15_1_1_long_sequence_test
