// =============================================================================
// Test Case 4.1.1: OVERFLOW_ADD
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: ADD overflow
// =============================================================================

class tc_4_1_1_overflow_add_test extends base_test;
    
    `uvm_component_utils(tc_4_1_1_overflow_add_test)
    
    function new(string name = "tc_4_1_1_overflow_add_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_4_1_1_overflow_add_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_4_1_1_overflow_add_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 4.1.1: OVERFLOW_ADD ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_4_1_1_overflow_add_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 4.1.1: OVERFLOW_ADD Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_4_1_1_overflow_add_test
