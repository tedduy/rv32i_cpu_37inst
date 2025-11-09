// =============================================================================
// Test Case 2.3.3: BOTH_RS_FORWARD
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: Both rs1 and rs2 forward
// =============================================================================

class tc_2_3_3_both_rs_forward_test extends base_test;
    
    `uvm_component_utils(tc_2_3_3_both_rs_forward_test)
    
    function new(string name = "tc_2_3_3_both_rs_forward_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_2_3_3_both_rs_forward_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_2_3_3_both_rs_forward_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 2.3.3: BOTH_RS_FORWARD ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_2_3_3_both_rs_forward_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 2.3.3: BOTH_RS_FORWARD Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_2_3_3_both_rs_forward_test
