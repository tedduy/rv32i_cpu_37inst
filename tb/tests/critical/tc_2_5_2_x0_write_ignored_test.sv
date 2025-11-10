// =============================================================================
// Test Case 2.5.2: X0_WRITE_IGNORED
// =============================================================================
// Category: Data Hazards
// Priority: CRITICAL
// Description: x0 writes ignored
// =============================================================================

class tc_2_5_2_x0_write_ignored_test extends base_test;
    
    `uvm_component_utils(tc_2_5_2_x0_write_ignored_test)
    
    function new(string name = "tc_2_5_2_x0_write_ignored_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_2_5_2_x0_write_ignored_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_2_5_2_x0_write_ignored_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 2.5.2: X0_WRITE_IGNORED ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_2_5_2_x0_write_ignored_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 2.5.2: X0_WRITE_IGNORED Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_2_5_2_x0_write_ignored_test
