// =============================================================================
// Test Case 4.2.1: X0_READ
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Read from x0
// =============================================================================

class tc_4_2_1_x0_read_test extends base_test;
    
    `uvm_component_utils(tc_4_2_1_x0_read_test)
    
    function new(string name = "tc_4_2_1_x0_read_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_4_2_1_x0_read_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_4_2_1_x0_read_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 4.2.1: X0_READ ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_4_2_1_x0_read_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 4.2.1: X0_READ Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_4_2_1_x0_read_test
