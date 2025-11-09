// =============================================================================
// RV32I Driver
// =============================================================================
// Drives transactions to the DUT through the virtual interface
// Manages reset, instruction loading, and CPU state setup
// =============================================================================

class rv32i_driver extends uvm_driver #(rv32i_transaction);
    
    // ==========================================================================
    // UVM Factory Registration
    // ==========================================================================
    `uvm_component_utils(rv32i_driver)
    
    // ==========================================================================
    // Virtual Interface
    // ==========================================================================
    virtual rv32i_if vif;
    
    // ==========================================================================
    // Configuration
    // ==========================================================================
    int reset_cycles = 5;        // Number of reset cycles
    int cycles_per_inst = 10;    // Max cycles to wait per instruction
    
    // ==========================================================================
    // Constructor
    // ==========================================================================
    function new(string name = "rv32i_driver", uvm_component parent = null);
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
        
        `uvm_info(get_type_name(), "Driver built successfully", UVM_LOW)
    endfunction
    
    // ==========================================================================
    // Run Phase
    // ==========================================================================
    task run_phase(uvm_phase phase);
        
        // Apply reset at start
        apply_reset();
        
        // Main driver loop
        forever begin
            // Get next transaction from sequencer
            seq_item_port.get_next_item(req);
            
            `uvm_info(get_type_name(), 
                     $sformatf("Driving transaction: %s", req.test_name), 
                     UVM_MEDIUM)
            
            // Drive the transaction
            drive_transaction(req);
            
            // Signal completion to sequencer
            seq_item_port.item_done();
        end
        
    endtask
    
    // ==========================================================================
    // Apply Reset
    // ==========================================================================
    task apply_reset();
        `uvm_info(get_type_name(), "Applying reset...", UVM_MEDIUM)
        
        vif.driver_cb.arst_n <= 1'b0;
        repeat(reset_cycles) @(vif.driver_cb);
        vif.driver_cb.arst_n <= 1'b1;
        repeat(2) @(vif.driver_cb);
        
        `uvm_info(get_type_name(), "Reset complete", UVM_MEDIUM)
    endtask
    
    // ==========================================================================
    // Drive Transaction
    // ==========================================================================
    task drive_transaction(rv32i_transaction tr);
        
        // In a file-based Spike approach, we don't actually drive instruction
        // directly into DUT. Instead:
        // 1. Instruction memory is pre-loaded via test program
        // 2. Driver just controls reset and lets CPU run
        // 3. Monitor captures outputs
        // 4. Scoreboard compares with Spike golden file
        
        // For this implementation, we'll wait for the instruction to complete
        // by monitoring PC advancement
        
        bit [31:0] start_pc;
        int cycle_count = 0;
        
        // Capture starting PC
        @(vif.driver_cb);
        start_pc = vif.pc_out;
        
        `uvm_info(get_type_name(), 
                 $sformatf("Waiting for instruction at PC=0x%08h", start_pc), 
                 UVM_HIGH)
        
        // Wait for PC to advance (instruction completed)
        while (cycle_count < cycles_per_inst) begin
            @(vif.driver_cb);
            cycle_count++;
            
            // Check if PC changed (instruction completed)
            if (vif.pc_out != start_pc) begin
                `uvm_info(get_type_name(), 
                         $sformatf("Instruction completed in %0d cycles, PC now 0x%08h", 
                                  cycle_count, vif.pc_out), 
                         UVM_HIGH)
                return;
            end
        end
        
        `uvm_warning(get_type_name(), 
                    $sformatf("Instruction timeout after %0d cycles at PC=0x%08h", 
                             cycles_per_inst, start_pc))
        
    endtask
    
    // ==========================================================================
    // Load Instruction Memory (Helper for direct testbench control)
    // ==========================================================================
    // Note: This would require backdoor access to instruction memory
    // In practice, use compiled test programs loaded via $readmemh
    task load_instruction(bit [31:0] addr, bit [31:0] inst);
        // TODO: Implement backdoor access to instruction memory if needed
        `uvm_info(get_type_name(), 
                 $sformatf("Load instruction 0x%08h at address 0x%08h", inst, addr), 
                 UVM_HIGH)
    endtask
    
    // ==========================================================================
    // Load Register File (Helper for setting up test conditions)
    // ==========================================================================
    task load_register(bit [4:0] addr, bit [31:0] data);
        // TODO: Implement backdoor access to register file if needed
        `uvm_info(get_type_name(), 
                 $sformatf("Load register x%0d with value 0x%08h", addr, data), 
                 UVM_HIGH)
    endtask

endclass : rv32i_driver
