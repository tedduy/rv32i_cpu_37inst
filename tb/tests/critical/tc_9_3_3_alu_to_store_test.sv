// =============================================================================
// Test Case 9.3.3: ALU_TO_STORE
// =============================================================================
// Category: Forwarding Paths
// Priority: CRITICAL
// Description: ALU result to store data
// =============================================================================

class tc_9_3_3_alu_to_store_test extends base_test;
    
    `uvm_component_utils(tc_9_3_3_alu_to_store_test)
    
    function new(string name = "tc_9_3_3_alu_to_store_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_9_3_3_alu_to_store_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_9_3_3_alu_to_store_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 9.3.3: ALU_TO_STORE ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_9_3_3_alu_to_store_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 9.3.3: ALU_TO_STORE Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_9_3_3_alu_to_store_test
