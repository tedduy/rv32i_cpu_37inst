// =============================================================================
// Test Case 11.2.1: SLT_EDGE_CASES
// =============================================================================
// Category: Arithmetic Corners
// Priority: MEDIUM
// Description: SLT boundary values
// =============================================================================

class tc_11_2_1_slt_edge_cases_test extends base_test;
    
    `uvm_component_utils(tc_11_2_1_slt_edge_cases_test)
    
    function new(string name = "tc_11_2_1_slt_edge_cases_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_11_2_1_slt_edge_cases_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_11_2_1_slt_edge_cases_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 11.2.1: SLT_EDGE_CASES ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_11_2_1_slt_edge_cases_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 11.2.1: SLT_EDGE_CASES Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_11_2_1_slt_edge_cases_test
