// =============================================================================
// Test Case 7.2.1: X0_ALWAYS_ZERO
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: x0 remains zero
// =============================================================================

class tc_7_2_1_x0_always_zero_test extends base_test;
    
    `uvm_component_utils(tc_7_2_1_x0_always_zero_test)
    
    function new(string name = "tc_7_2_1_x0_always_zero_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_7_2_1_x0_always_zero_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_7_2_1_x0_always_zero_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 7.2.1: X0_ALWAYS_ZERO ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_7_2_1_x0_always_zero_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 7.2.1: X0_ALWAYS_ZERO Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_7_2_1_x0_always_zero_test
