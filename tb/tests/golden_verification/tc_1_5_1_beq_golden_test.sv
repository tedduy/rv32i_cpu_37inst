// =============================================================================
// Golden Verification Test: BEQ
// =============================================================================
// Verifies BEQ instruction against Python golden model
// =============================================================================

class tc_1_5_1_beq_golden_test extends base_test;
    
    `uvm_component_utils(tc_1_5_1_beq_golden_test)
    
    function new(string name = "tc_1_5_1_beq_golden_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        // Enable Spike/Golden checking
        enable_golden_check = 1;
        golden_log_file = "tests/golden/tc_1_5_1_beq_golden.log";
        
        super.build_phase(phase);
        
        // Enable comparison in scoreboard
        uvm_config_db#(bit)::set(this, "env.scoreboard", "enable_comparison", 1);
        
        `uvm_info(get_type_name(), 
                 $sformatf("BEQ Golden Test: golden_check=%0d, comparison=%0d", 
                          enable_golden_check, 1), 
                 UVM_MEDIUM)
    endfunction
    
    task run_phase(uvm_phase phase);
        tc_1_5_1_beq_seq seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), 
                 "=== Starting tc_1_5_1_beq with Golden Check ===", 
                 UVM_MEDIUM)
        
        seq = tc_1_5_1_beq_seq::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        #10000; // Wait for completion
        
        phase.drop_objection(this);
    endtask
    
endclass
