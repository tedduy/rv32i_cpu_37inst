// =============================================================================
// RV32I Environment
// =============================================================================
// Top-level verification environment
// Instantiates and connects agent, scoreboard, and spike checker
// =============================================================================

class rv32i_env extends uvm_env;
    
    // ==========================================================================
    // UVM Factory Registration
    // ==========================================================================
    `uvm_component_utils(rv32i_env)
    
    // ==========================================================================
    // Environment Components
    // ==========================================================================
    rv32i_agent      agent;
    rv32i_scoreboard scoreboard;
    
    // ==========================================================================
    // Constructor
    // ==========================================================================
    function new(string name = "rv32i_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    // ==========================================================================
    // Build Phase
    // ==========================================================================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Create agent
        agent = rv32i_agent::type_id::create("agent", this);
        
        // Create scoreboard
        scoreboard = rv32i_scoreboard::type_id::create("scoreboard", this);
        
        `uvm_info(get_type_name(), "Environment built successfully", UVM_LOW)
    endfunction
    
    // ==========================================================================
    // Connect Phase
    // ==========================================================================
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect agent's analysis port to scoreboard's analysis export
        agent.analysis_port.connect(scoreboard.analysis_export);
        
        `uvm_info(get_type_name(), "Agent connected to scoreboard", UVM_MEDIUM)
    endfunction
    
    // ==========================================================================
    // End of Elaboration Phase
    // ==========================================================================
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        
        // Print topology
        `uvm_info(get_type_name(), "\n=== UVM Testbench Topology ===", UVM_LOW)
        uvm_top.print_topology();
    endfunction
    
    // ==========================================================================
    // Start of Simulation Phase
    // ==========================================================================
    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        
        `uvm_info(get_type_name(), 
                 "\n========================================\n  RV32I Pipeline Verification Started\n========================================", 
                 UVM_LOW)
    endfunction

endclass : rv32i_env
