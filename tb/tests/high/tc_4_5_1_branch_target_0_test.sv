// =============================================================================
// Test Case 4.5.1: BRANCH_TARGET_0
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Branch to address 0
// =============================================================================

class tc_4_5_1_branch_target_0_test extends base_test;
    
    `uvm_component_utils(tc_4_5_1_branch_target_0_test)
    
    function new(string name = "tc_4_5_1_branch_target_0_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_4_5_1_branch_target_0_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_4_5_1_branch_target_0_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 4.5.1: BRANCH_TARGET_0 ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_4_5_1_branch_target_0_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 4.5.1: BRANCH_TARGET_0 Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_4_5_1_branch_target_0_test
