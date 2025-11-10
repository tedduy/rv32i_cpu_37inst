// =============================================================================
// Test Case 9.3.2: ALU_TO_BRANCH
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: ALU result to branch
// =============================================================================

class tc_9_3_2_alu_to_branch_test extends base_test;
    
    `uvm_component_utils(tc_9_3_2_alu_to_branch_test)
    
    function new(string name = "tc_9_3_2_alu_to_branch_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_9_3_2_alu_to_branch_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_9_3_2_alu_to_branch_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 9.3.2: ALU_TO_BRANCH ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_9_3_2_alu_to_branch_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 9.3.2: ALU_TO_BRANCH Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_9_3_2_alu_to_branch_test
