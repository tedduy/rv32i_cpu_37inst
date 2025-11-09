// =============================================================================
// Test Case 1.1.1: ADD
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Basic addition
// =============================================================================

class tc_1_1_1_add_test extends base_test;
    
    `uvm_component_utils(tc_1_1_1_add_test)
    
    function new(string name = "tc_1_1_1_add_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_1_1_1_add_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_1_1_1_add_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 1.1.1: ADD ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_1_1_1_add_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 1.1.1: ADD Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_1_1_1_add_test
