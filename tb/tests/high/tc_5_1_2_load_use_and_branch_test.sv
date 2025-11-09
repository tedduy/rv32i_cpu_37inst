// =============================================================================
// Test Case 5.1.2: LOAD_USE_AND_BRANCH
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Load-use with branch
// =============================================================================

class tc_5_1_2_load_use_and_branch_test extends base_test;
    
    `uvm_component_utils(tc_5_1_2_load_use_and_branch_test)
    
    function new(string name = "tc_5_1_2_load_use_and_branch_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_5_1_2_load_use_and_branch_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_5_1_2_load_use_and_branch_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 5.1.2: LOAD_USE_AND_BRANCH ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_5_1_2_load_use_and_branch_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 5.1.2: LOAD_USE_AND_BRANCH Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_5_1_2_load_use_and_branch_test
