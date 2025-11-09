// =============================================================================
// Test Case 3.4.3: BRANCH_IN_DELAY
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Branch in flush shadow
// =============================================================================

class tc_3_4_3_branch_in_delay_test extends base_test;
    
    `uvm_component_utils(tc_3_4_3_branch_in_delay_test)
    
    function new(string name = "tc_3_4_3_branch_in_delay_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_3_4_3_branch_in_delay_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_3_4_3_branch_in_delay_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 3.4.3: BRANCH_IN_DELAY ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_3_4_3_branch_in_delay_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 3.4.3: BRANCH_IN_DELAY Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_3_4_3_branch_in_delay_test
