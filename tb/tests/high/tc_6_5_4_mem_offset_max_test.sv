// =============================================================================
// Test Case 6.5.4: MEM_OFFSET_MAX
// =============================================================================
// Category: Memory System
// Priority: HIGH
// Description: Maximum offset
// =============================================================================

class tc_6_5_4_mem_offset_max_test extends base_test;
    
    `uvm_component_utils(tc_6_5_4_mem_offset_max_test)
    
    function new(string name = "tc_6_5_4_mem_offset_max_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_6_5_4_mem_offset_max_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_6_5_4_mem_offset_max_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 6.5.4: MEM_OFFSET_MAX ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_6_5_4_mem_offset_max_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 6.5.4: MEM_OFFSET_MAX Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_6_5_4_mem_offset_max_test
