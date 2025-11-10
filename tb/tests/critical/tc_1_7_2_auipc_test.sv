// =============================================================================
// Test Case 1.7.2: AUIPC
// =============================================================================
// Category: ISA Coverage
// Priority: CRITICAL
// Description: Add upper immediate to PC
// =============================================================================

class tc_1_7_2_auipc_test extends base_test;
    
    `uvm_component_utils(tc_1_7_2_auipc_test)
    
    function new(string name = "tc_1_7_2_auipc_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_1_7_2_auipc_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_1_7_2_auipc_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 1.7.2: AUIPC ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_1_7_2_auipc_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 1.7.2: AUIPC Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_1_7_2_auipc_test
