// =============================================================================
// Test Case 10.1.1: EX_TO_EX_RS1
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: EX-EX forward to rs1
// =============================================================================

class tc_10_1_1_ex_to_ex_rs1_test extends base_test;
    
    `uvm_component_utils(tc_10_1_1_ex_to_ex_rs1_test)
    
    function new(string name = "tc_10_1_1_ex_to_ex_rs1_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_10_1_1_ex_to_ex_rs1_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_10_1_1_ex_to_ex_rs1_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 10.1.1: EX_TO_EX_RS1 ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_10_1_1_ex_to_ex_rs1_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 10.1.1: EX_TO_EX_RS1 Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_10_1_1_ex_to_ex_rs1_test
