// =============================================================================
// Test Case 14.1.2: DEEP_NESTING
// =============================================================================
// Category: Stress Tests
// Priority: MEDIUM
// Description: Deeply nested branches
// =============================================================================

class tc_14_1_2_deep_nesting_test extends base_test;
    
    `uvm_component_utils(tc_14_1_2_deep_nesting_test)
    
    function new(string name = "tc_14_1_2_deep_nesting_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_14_1_2_deep_nesting_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_14_1_2_deep_nesting_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 14.1.2: DEEP_NESTING ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_14_1_2_deep_nesting_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 14.1.2: DEEP_NESTING Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_14_1_2_deep_nesting_test
