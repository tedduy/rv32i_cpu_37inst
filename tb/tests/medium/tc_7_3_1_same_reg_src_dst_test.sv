// =============================================================================
// Test Case 7.3.1: SAME_REG_SRC_DST
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: Same register as src and dst
// =============================================================================

class tc_7_3_1_same_reg_src_dst_test extends base_test;
    
    `uvm_component_utils(tc_7_3_1_same_reg_src_dst_test)
    
    function new(string name = "tc_7_3_1_same_reg_src_dst_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_7_3_1_same_reg_src_dst_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_7_3_1_same_reg_src_dst_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 7.3.1: SAME_REG_SRC_DST ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_7_3_1_same_reg_src_dst_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 7.3.1: SAME_REG_SRC_DST Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_7_3_1_same_reg_src_dst_test
