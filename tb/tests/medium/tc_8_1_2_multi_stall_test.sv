// =============================================================================
// Test Case 8.1.2: MULTI_STALL
// =============================================================================
// Category: Pipeline Stalls
// Priority: MEDIUM
// Description: Multiple consecutive stalls
// =============================================================================

class tc_8_1_2_multi_stall_test extends base_test;
    
    `uvm_component_utils(tc_8_1_2_multi_stall_test)
    
    function new(string name = "tc_8_1_2_multi_stall_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_8_1_2_multi_stall_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_8_1_2_multi_stall_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 8.1.2: MULTI_STALL ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_8_1_2_multi_stall_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 8.1.2: MULTI_STALL Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_8_1_2_multi_stall_test
