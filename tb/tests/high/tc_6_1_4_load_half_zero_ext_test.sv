// =============================================================================
// Test Case 6.1.4: LOAD_HALF_ZERO_EXT
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: LHU zero extension
// =============================================================================

class tc_6_1_4_load_half_zero_ext_test extends base_test;
    
    `uvm_component_utils(tc_6_1_4_load_half_zero_ext_test)
    
    function new(string name = "tc_6_1_4_load_half_zero_ext_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_6_1_4_load_half_zero_ext_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_6_1_4_load_half_zero_ext_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 6.1.4: LOAD_HALF_ZERO_EXT ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_6_1_4_load_half_zero_ext_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 6.1.4: LOAD_HALF_ZERO_EXT Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_6_1_4_load_half_zero_ext_test
