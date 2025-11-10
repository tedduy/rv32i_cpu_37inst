// =============================================================================
// Test Case 5.2.3: LOOP_UNROLL
// =============================================================================
// Category: Complex Scenarios
// Priority: HIGH
// Description: Partially unrolled loop
// =============================================================================

class tc_5_2_3_loop_unroll_test extends base_test;
    
    `uvm_component_utils(tc_5_2_3_loop_unroll_test)
    
    function new(string name = "tc_5_2_3_loop_unroll_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_5_2_3_loop_unroll_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_5_2_3_loop_unroll_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 5.2.3: LOOP_UNROLL ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_5_2_3_loop_unroll_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 5.2.3: LOOP_UNROLL Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_5_2_3_loop_unroll_test
