// =============================================================================
// Test Case 14.1.2: IMM_20BIT_MAX
// =============================================================================
// Category: Immediate Values
// Priority: MEDIUM
// Description: 20-bit immediate max
// =============================================================================

class tc_14_1_2_imm_20bit_max_test extends base_test;
    
    `uvm_component_utils(tc_14_1_2_imm_20bit_max_test)
    
    function new(string name = "tc_14_1_2_imm_20bit_max_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override spike log file for this test
        spike_log_file = "tests/golden/tc_14_1_2_imm_20bit_max_spike.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.spike", 
                                    "spike_log_file", spike_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_14_1_2_imm_20bit_max_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 14.1.2: IMM_20BIT_MAX ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_14_1_2_imm_20bit_max_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 14.1.2: IMM_20BIT_MAX Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_14_1_2_imm_20bit_max_test
