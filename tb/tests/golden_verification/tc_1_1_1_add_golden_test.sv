// =============================================================================
// Test Case 1.1.1: ADD with Golden Reference Checking
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: ADD instruction with Python golden reference verification
// =============================================================================

class tc_1_1_1_add_golden_test extends base_test;
    
    `uvm_component_utils(tc_1_1_1_add_golden_test)
    
    function new(string name = "tc_1_1_1_add_golden_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        // ENABLE Spike checking for golden reference comparison
        enable_golden_check = 1;
        golden_log_file = "tests/golden/tc_1_1_1_add_golden.log";
        
        super.build_phase(phase);
        
        // Also enable scoreboard comparison
        uvm_config_db#(bit)::set(this, "env.scoreboard", 
                                "enable_comparison", 1);
        
        `uvm_info(get_type_name(), 
                 $sformatf("ADD Golden Test: golden_check=%0d, comparison=%0d", 
                          enable_golden_check, 1), 
                 UVM_LOW)
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_1_1_1_add_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 1.1.1: ADD with Golden Check ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_1_1_1_add_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 1.1.1: ADD Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_1_1_1_add_golden_test
