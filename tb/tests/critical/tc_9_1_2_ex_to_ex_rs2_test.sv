// =============================================================================
// Test Case 10.1.2: EX_TO_EX_RS2
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: EX-EX forward to rs2
// =============================================================================

class tc_10_1_2_ex_to_ex_rs2_test extends base_test;
    
    `uvm_component_utils(tc_10_1_2_ex_to_ex_rs2_test)
    
    function new(string name = "tc_10_1_2_ex_to_ex_rs2_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_10_1_2_ex_to_ex_rs2_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_10_1_2_ex_to_ex_rs2_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 10.1.2: EX_TO_EX_RS2 ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_10_1_2_ex_to_ex_rs2_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 10.1.2: EX_TO_EX_RS2 Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_10_1_2_ex_to_ex_rs2_test
