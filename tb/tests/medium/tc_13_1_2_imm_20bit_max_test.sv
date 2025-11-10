// =============================================================================
// Test Case 13.1.2: IMM_20BIT_MAX
// =============================================================================
// Category: Immediate Values
// Priority: MEDIUM
// Description: 20-bit immediate max
// =============================================================================

class tc_13_1_2_imm_20bit_max_test extends base_test;
    
    `uvm_component_utils(tc_13_1_2_imm_20bit_max_test)
    
    function new(string name = "tc_13_1_2_imm_20bit_max_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_13_1_2_imm_20bit_max_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_13_1_2_imm_20bit_max_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 13.1.2: IMM_20BIT_MAX ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_13_1_2_imm_20bit_max_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 13.1.2: IMM_20BIT_MAX Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_13_1_2_imm_20bit_max_test
