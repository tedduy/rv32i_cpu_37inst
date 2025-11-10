// =============================================================================
// Test Case 11.1.1: ADD_OVERFLOW_POS
// =============================================================================
// Category: Arithmetic Corners
// Priority: MEDIUM
// Description: Positive overflow
// =============================================================================

class tc_11_1_1_add_overflow_pos_test extends base_test;
    
    `uvm_component_utils(tc_11_1_1_add_overflow_pos_test)
    
    function new(string name = "tc_11_1_1_add_overflow_pos_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_11_1_1_add_overflow_pos_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_11_1_1_add_overflow_pos_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 11.1.1: ADD_OVERFLOW_POS ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_11_1_1_add_overflow_pos_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 11.1.1: ADD_OVERFLOW_POS Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_11_1_1_add_overflow_pos_test
