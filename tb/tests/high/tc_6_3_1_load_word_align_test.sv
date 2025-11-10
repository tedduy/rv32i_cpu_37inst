// =============================================================================
// Test Case 6.3.1: LOAD_WORD_ALIGN
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: LW aligned access
// =============================================================================

class tc_6_3_1_load_word_align_test extends base_test;
    
    `uvm_component_utils(tc_6_3_1_load_word_align_test)
    
    function new(string name = "tc_6_3_1_load_word_align_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_6_3_1_load_word_align_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_6_3_1_load_word_align_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 6.3.1: LOAD_WORD_ALIGN ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_6_3_1_load_word_align_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 6.3.1: LOAD_WORD_ALIGN Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_6_3_1_load_word_align_test
