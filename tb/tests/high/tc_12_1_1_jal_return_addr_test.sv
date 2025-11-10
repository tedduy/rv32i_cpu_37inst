// =============================================================================
// Test Case 12.1.1: JAL_RETURN_ADDR
// =============================================================================
// Category: Jump & Link
// Priority: HIGH
// Description: JAL saves return address
// =============================================================================

class tc_12_1_1_jal_return_addr_test extends base_test;
    
    `uvm_component_utils(tc_12_1_1_jal_return_addr_test)
    
    function new(string name = "tc_12_1_1_jal_return_addr_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_12_1_1_jal_return_addr_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_12_1_1_jal_return_addr_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 12.1.1: JAL_RETURN_ADDR ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_12_1_1_jal_return_addr_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 12.1.1: JAL_RETURN_ADDR Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_12_1_1_jal_return_addr_test
