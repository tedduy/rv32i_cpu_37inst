// =============================================================================
// Test Case 3.2.3: JALR_COMPUTED
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: JALR with computed target
// =============================================================================

class tc_3_2_3_jalr_computed_test extends base_test;
    
    `uvm_component_utils(tc_3_2_3_jalr_computed_test)
    
    function new(string name = "tc_3_2_3_jalr_computed_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_3_2_3_jalr_computed_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_3_2_3_jalr_computed_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 3.2.3: JALR_COMPUTED ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_3_2_3_jalr_computed_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 3.2.3: JALR_COMPUTED Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_3_2_3_jalr_computed_test
