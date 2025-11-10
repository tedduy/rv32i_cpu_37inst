// =============================================================================
// Test Case 3.3.3: JUMP_AFTER_ALU
// =============================================================================
// Category: Control Hazards
// Priority: CRITICAL
// Description: Jump after ALU operation
// =============================================================================

class tc_3_3_3_jump_after_alu_test extends base_test;
    
    `uvm_component_utils(tc_3_3_3_jump_after_alu_test)
    
    function new(string name = "tc_3_3_3_jump_after_alu_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_3_3_3_jump_after_alu_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_3_3_3_jump_after_alu_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\n=== Starting TC 3.3.3: JUMP_AFTER_ALU ===", UVM_LOW)
        
        // Create and start sequence
        seq = tc_3_3_3_jump_after_alu_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC 3.3.3: JUMP_AFTER_ALU Complete ===\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : tc_3_3_3_jump_after_alu_test
