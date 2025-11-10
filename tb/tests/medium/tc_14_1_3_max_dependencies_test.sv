// =============================================================================
// Test Case 14.1.3: MAX_DEPENDENCIES
// =============================================================================
// Category: Stress Tests
// Priority: MEDIUM
// Description: Maximum dependency chains
// =============================================================================

class tc_14_1_3_max_dependencies_test extends base_test;
    
    `uvm_component_utils(tc_14_1_3_max_dependencies_test)
    
    function new(string name = "tc_14_1_3_max_dependencies_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_14_1_3_max_dependencies_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_14_1_3_max_dependencies_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 14.1.3: MAX_DEPENDENCIES ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_14_1_3_max_dependencies_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 14.1.3: MAX_DEPENDENCIES Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_14_1_3_max_dependencies_test
