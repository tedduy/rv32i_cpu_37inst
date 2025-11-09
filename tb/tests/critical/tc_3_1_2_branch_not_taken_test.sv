// =============================================================================
// Test Case 3.1.2: BRANCH_NOT_TAKEN
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Branch not taken
// =============================================================================

class tc_3_1_2_branch_not_taken_test extends base_test;
    
    `uvm_component_utils(tc_3_1_2_branch_not_taken_test)
    
    function new(string name = "tc_3_1_2_branch_not_taken_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_3_1_2_branch_not_taken_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_3_1_2_branch_not_taken_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 3.1.2: BRANCH_NOT_TAKEN ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_3_1_2_branch_not_taken_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 3.1.2: BRANCH_NOT_TAKEN Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_3_1_2_branch_not_taken_test
