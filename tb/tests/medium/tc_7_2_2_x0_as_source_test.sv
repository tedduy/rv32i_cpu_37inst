// =============================================================================
// Test Case 7.2.2: X0_AS_SOURCE
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: x0 as operand source
// =============================================================================

class tc_7_2_2_x0_as_source_test extends base_test;
    
    `uvm_component_utils(tc_7_2_2_x0_as_source_test)
    
    function new(string name = "tc_7_2_2_x0_as_source_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_7_2_2_x0_as_source_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_7_2_2_x0_as_source_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 7.2.2: X0_AS_SOURCE ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_7_2_2_x0_as_source_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 7.2.2: X0_AS_SOURCE Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_7_2_2_x0_as_source_test
