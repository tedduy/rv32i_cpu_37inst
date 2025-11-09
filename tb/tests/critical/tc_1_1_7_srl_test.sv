// =============================================================================
// Test Case 1.1.7: SRL
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Logical right shift
// =============================================================================

class tc_1_1_7_srl_test extends base_test;
    
    `uvm_component_utils(tc_1_1_7_srl_test)
    
    function new(string name = "tc_1_1_7_srl_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_1_1_7_srl_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_1_1_7_srl_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 1.1.7: SRL ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_1_1_7_srl_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 1.1.7: SRL Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_1_1_7_srl_test
