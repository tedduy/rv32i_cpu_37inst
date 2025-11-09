// =============================================================================
// Test Case 8.2.1: STALL_RECOVERY
// =============================================================================
// Category: Pipeline Stalls
// Priority: MEDIUM
// Description: Recovery after stall
// =============================================================================

class tc_8_2_1_stall_recovery_test extends base_test;
    
    `uvm_component_utils(tc_8_2_1_stall_recovery_test)
    
    function new(string name = "tc_8_2_1_stall_recovery_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_8_2_1_stall_recovery_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_8_2_1_stall_recovery_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 8.2.1: STALL_RECOVERY ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_8_2_1_stall_recovery_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 8.2.1: STALL_RECOVERY Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_8_2_1_stall_recovery_test
