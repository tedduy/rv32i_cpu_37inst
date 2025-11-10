// =============================================================================
// Test Case 10.1.1: CPI_NO_HAZARDS
// =============================================================================
// Category: Performance
// Priority: LOW
// Description: CPI with no hazards
// =============================================================================

class tc_10_1_1_cpi_no_hazards_test extends base_test;
    
    `uvm_component_utils(tc_10_1_1_cpi_no_hazards_test)
    
    function new(string name = "tc_10_1_1_cpi_no_hazards_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_10_1_1_cpi_no_hazards_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_10_1_1_cpi_no_hazards_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 10.1.1: CPI_NO_HAZARDS ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_10_1_1_cpi_no_hazards_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 10.1.1: CPI_NO_HAZARDS Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_10_1_1_cpi_no_hazards_test
