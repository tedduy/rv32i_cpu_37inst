// =============================================================================
// Test Case 13.1.1: JAL_RETURN_ADDR
// =============================================================================
// Category: Jump & Link
// Priority: HIGH
// Description: JAL saves return address
// =============================================================================

class tc_13_1_1_jal_return_addr_test extends base_test;
    
    `uvm_component_utils(tc_13_1_1_jal_return_addr_test)
    
    function new(string name = "tc_13_1_1_jal_return_addr_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_13_1_1_jal_return_addr_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_13_1_1_jal_return_addr_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 13.1.1: JAL_RETURN_ADDR ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_13_1_1_jal_return_addr_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 13.1.1: JAL_RETURN_ADDR Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_13_1_1_jal_return_addr_test
