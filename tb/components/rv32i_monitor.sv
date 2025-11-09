// =============================================================================
// RV32I Monitor
// =============================================================================
// Monitors DUT outputs and sends transactions to scoreboard via TLM port
// Captures pipeline state, register writes, memory accesses
// =============================================================================

class rv32i_monitor extends uvm_monitor;
    
    // ==========================================================================
    // UVM Factory Registration
    // ==========================================================================
    `uvm_component_utils(rv32i_monitor)
    
    // ==========================================================================
    // Virtual Interface
    // ==========================================================================
    virtual rv32i_if vif;
    
    // ==========================================================================
    // TLM Analysis Port (sends transactions to scoreboard)
    // ==========================================================================
    uvm_analysis_port #(rv32i_transaction) analysis_port;
    
    // ==========================================================================
    // Configuration
    // ==========================================================================
    bit monitor_enable = 1;      // Enable/disable monitoring
    
    // ==========================================================================
    // Constructor
    // ==========================================================================
    function new(string name = "rv32i_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    // ==========================================================================
    // Build Phase
    // ==========================================================================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Get virtual interface from config DB
        if (!uvm_config_db#(virtual rv32i_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found in config DB")
        
        // Create analysis port
        analysis_port = new("analysis_port", this);
        
        `uvm_info(get_type_name(), "Monitor built successfully", UVM_LOW)
    endfunction
    
    // ==========================================================================
    // Run Phase
    // ==========================================================================
    task run_phase(uvm_phase phase);
        
        rv32i_transaction tr;
        
        // Wait for reset to deassert
        @(posedge vif.arst_n);
        `uvm_info(get_type_name(), "Monitor started after reset", UVM_MEDIUM)
        
        // Main monitoring loop
        forever begin
            if (monitor_enable) begin
                tr = rv32i_transaction::type_id::create("monitored_tr");
                
                // Sample DUT outputs at clock edge
                collect_transaction(tr);
                
                // Send transaction to scoreboard
                if (tr.actual_reg_write || tr.actual_mem_write) begin
                    `uvm_info(get_type_name(), 
                             $sformatf("Monitored transaction at PC=0x%08h", tr.if_pc), 
                             UVM_HIGH)
                    analysis_port.write(tr);
                end
            end else begin
                @(vif.monitor_cb);
            end
        end
        
    endtask
    
    // ==========================================================================
    // Collect Transaction from DUT
    // ==========================================================================
    task collect_transaction(rv32i_transaction tr);
        
        // Sample at clock edge
        @(vif.monitor_cb);
        
        // Capture pipeline state
        tr.if_pc           = vif.monitor_cb.pc_out;
        tr.id_instruction  = vif.monitor_cb.instruction;
        tr.ex_alu_result   = vif.monitor_cb.alu_out;
        tr.mem_data        = vif.monitor_cb.mem_rdata;
        tr.wb_data         = vif.monitor_cb.wb_data;
        
        // Capture control signals
        tr.actual_reg_write = vif.monitor_cb.reg_write;
        tr.actual_mem_write = vif.monitor_cb.mem_write;
        
        // Capture register write (happens in WB stage)
        if (vif.monitor_cb.reg_write) begin
            tr.rd = vif.monitor_cb.rd_addr;
            tr.actual_rd_value = vif.monitor_cb.wb_data;
        end
        
        // Capture memory write (happens in MEM stage)
        if (vif.monitor_cb.mem_write) begin
            tr.actual_mem_addr = vif.monitor_cb.mem_addr;
            tr.actual_mem_data = vif.monitor_cb.mem_wdata;
        end
        
        // Capture branch/jump information
        if (vif.monitor_cb.branch_taken || vif.monitor_cb.jal || vif.monitor_cb.jalr) begin
            tr.actual_pc_next = vif.monitor_cb.pc_out;
        end
        
        // Extract instruction fields from instruction in ID stage
        tr.instruction = vif.monitor_cb.instruction;
        tr.opcode = tr.instruction[6:0];
        tr.rd     = tr.instruction[11:7];
        tr.funct3 = tr.instruction[14:12];
        tr.rs1    = tr.instruction[19:15];
        tr.rs2    = tr.instruction[24:20];
        tr.funct7 = tr.instruction[31:25];
        
        // Capture source operands
        tr.rs1_value = vif.monitor_cb.rd1;
        tr.rs2_value = vif.monitor_cb.rd2;
        
    endtask
    
    // ==========================================================================
    // Enable/Disable Monitoring
    // ==========================================================================
    function void enable_monitor();
        monitor_enable = 1;
        `uvm_info(get_type_name(), "Monitor enabled", UVM_MEDIUM)
    endfunction
    
    function void disable_monitor();
        monitor_enable = 0;
        `uvm_info(get_type_name(), "Monitor disabled", UVM_MEDIUM)
    endfunction

endclass : rv32i_monitor
