// =============================================================================
// RV32I Agent
// =============================================================================
// Encapsulates driver, monitor, and sequencer into a reusable verification agent
// Supports active/passive modes
// =============================================================================

class rv32i_agent extends uvm_agent;
    
    // ==========================================================================
    // UVM Factory Registration
    // ==========================================================================
    `uvm_component_utils(rv32i_agent)
    
    // ==========================================================================
    // Agent Components
    // ==========================================================================
    rv32i_driver     driver;
    rv32i_monitor    monitor;
    rv32i_sequencer  sequencer;
    
    // ==========================================================================
    // TLM Analysis Port (forwards monitor transactions)
    // ==========================================================================
    uvm_analysis_port #(rv32i_transaction) analysis_port;
    
    // ==========================================================================
    // Configuration
    // ==========================================================================
    uvm_active_passive_enum is_active = UVM_ACTIVE;
    
    // ==========================================================================
    // Constructor
    // ==========================================================================
    function new(string name = "rv32i_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    // ==========================================================================
    // Build Phase
    // ==========================================================================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Create monitor (always present)
        monitor = rv32i_monitor::type_id::create("monitor", this);
        
        // Create analysis port
        analysis_port = new("analysis_port", this);
        
        // Create driver and sequencer only in active mode
        if (is_active == UVM_ACTIVE) begin
            driver = rv32i_driver::type_id::create("driver", this);
            sequencer = rv32i_sequencer::type_id::create("sequencer", this);
            `uvm_info(get_type_name(), "Agent created in ACTIVE mode", UVM_MEDIUM)
        end else begin
            `uvm_info(get_type_name(), "Agent created in PASSIVE mode", UVM_MEDIUM)
        end
        
    endfunction
    
    // ==========================================================================
    // Connect Phase
    // ==========================================================================
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect monitor analysis port to agent's analysis port
        monitor.analysis_port.connect(analysis_port);
        
        // Connect driver to sequencer in active mode
        if (is_active == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
            `uvm_info(get_type_name(), "Driver connected to sequencer", UVM_HIGH)
        end
        
    endfunction

endclass : rv32i_agent
