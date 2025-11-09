// =============================================================================
// Test Case 13.2.1: JAL_TO_X0
// =============================================================================
// Category: Jump & Link
// Priority: HIGH
// Description: JAL with x0 as dest
// =============================================================================

class tc_13_2_1_jal_to_x0_test extends base_test;
    
    `uvm_component_utils(tc_13_2_1_jal_to_x0_test)
    
    function new(string name = "tc_13_2_1_jal_to_x0_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_13_2_1_jal_to_x0_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_13_2_1_jal_to_x0_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 13.2.1: JAL_TO_X0 ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_13_2_1_jal_to_x0_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 13.2.1: JAL_TO_X0 Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_13_2_1_jal_to_x0_test
