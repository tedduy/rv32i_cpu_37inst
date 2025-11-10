// =============================================================================
// Test Case 4.4.2: MEM_ADDR_MAX
// =============================================================================
// Category: Edge Cases
// Priority: HIGH
// Description: Maximum memory address
// =============================================================================

class tc_4_4_2_mem_addr_max_test extends base_test;
    
    `uvm_component_utils(tc_4_4_2_mem_addr_max_test)
    
    function new(string name = "tc_4_4_2_mem_addr_max_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_4_4_2_mem_addr_max_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_4_4_2_mem_addr_max_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 4.4.2: MEM_ADDR_MAX ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_4_4_2_mem_addr_max_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 4.4.2: MEM_ADDR_MAX Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_4_4_2_mem_addr_max_test
