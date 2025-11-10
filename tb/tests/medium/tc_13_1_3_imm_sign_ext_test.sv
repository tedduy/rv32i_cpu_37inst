// =============================================================================
// Test Case 13.1.3: IMM_SIGN_EXT
// =============================================================================
// Category: Immediate Values
// Priority: MEDIUM
// Description: Immediate sign extension
// =============================================================================

class tc_13_1_3_imm_sign_ext_test extends base_test;
    
    `uvm_component_utils(tc_13_1_3_imm_sign_ext_test)
    
    function new(string name = "tc_13_1_3_imm_sign_ext_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_13_1_3_imm_sign_ext_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_13_1_3_imm_sign_ext_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 13.1.3: IMM_SIGN_EXT ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_13_1_3_imm_sign_ext_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 13.1.3: IMM_SIGN_EXT Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_13_1_3_imm_sign_ext_test
