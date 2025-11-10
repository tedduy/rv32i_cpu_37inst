// =============================================================================
// Test Case 7.1.2: ALL_REGS_READ
// =============================================================================
// Category: Register File
// Priority: MEDIUM
// Description: Read from all registers
// =============================================================================

class tc_7_1_2_all_regs_read_test extends base_test;
    
    `uvm_component_utils(tc_7_1_2_all_regs_read_test)
    
    function new(string name = "tc_7_1_2_all_regs_read_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_7_1_2_all_regs_read_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_7_1_2_all_regs_read_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 7.1.2: ALL_REGS_READ ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_7_1_2_all_regs_read_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 7.1.2: ALL_REGS_READ Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_7_1_2_all_regs_read_test
