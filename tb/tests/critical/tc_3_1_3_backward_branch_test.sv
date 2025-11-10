// =============================================================================
// Test Case 3.1.3: BACKWARD_BRANCH
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Backward branch (loop)
// =============================================================================

class tc_3_1_3_backward_branch_test extends base_test;
    
    `uvm_component_utils(tc_3_1_3_backward_branch_test)
    
    function new(string name = "tc_3_1_3_backward_branch_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_3_1_3_backward_branch_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_3_1_3_backward_branch_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 3.1.3: BACKWARD_BRANCH ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_3_1_3_backward_branch_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 3.1.3: BACKWARD_BRANCH Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_3_1_3_backward_branch_test
