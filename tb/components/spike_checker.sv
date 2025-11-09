// =============================================================================
// Spike Checker Component
// =============================================================================
// Parses Spike ISA Simulator golden reference output files
// Provides expected values for scoreboard comparison
// =============================================================================

class spike_checker extends uvm_component;
    
    // ==========================================================================
    // UVM Factory Registration
    // ==========================================================================
    `uvm_component_utils(spike_checker)
    
    // ==========================================================================
    // Golden Reference Data Storage
    // ==========================================================================
    
    // Structure to hold expected state for one instruction
    typedef struct {
        bit [31:0] pc;              // Program counter
        bit [31:0] instruction;     // Instruction encoding
        bit [4:0]  rd;              // Destination register
        bit [31:0] rd_value;        // Expected rd value
        bit [31:0] pc_next;         // Expected next PC
        bit        reg_write;       // Register write expected
        bit        mem_write;       // Memory write expected
        bit [31:0] mem_addr;        // Memory address
        bit [31:0] mem_data;        // Memory data
        string     disasm;          // Disassembly string
    } spike_golden_t;
    
    // Array to hold all golden reference data
    spike_golden_t golden_data[$];
    int golden_index = 0;
    
    // ==========================================================================
    // Configuration
    // ==========================================================================
    string spike_log_file = "tests/golden/spike_trace.log";
    bit    golden_loaded = 0;
    
    // ==========================================================================
    // Constructor
    // ==========================================================================
    function new(string name = "spike_checker", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    // ==========================================================================
    // Build Phase
    // ==========================================================================
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Get spike log file path from config DB if available
        if (!uvm_config_db#(string)::get(this, "", "spike_log_file", spike_log_file))
            `uvm_info(get_type_name(), 
                     $sformatf("Using default spike log: %s", spike_log_file), 
                     UVM_MEDIUM)
        
        `uvm_info(get_type_name(), "Spike checker built successfully", UVM_LOW)
    endfunction
    
    // ==========================================================================
    // Start of Simulation Phase - Load Golden Reference
    // ==========================================================================
    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        load_golden_reference();
    endfunction
    
    // ==========================================================================
    // Load Golden Reference from Spike Log File
    // ==========================================================================
    function void load_golden_reference();
        int fd;
        string line;
        int line_num = 0;
        
        `uvm_info(get_type_name(), 
                 $sformatf("Loading Spike golden reference from: %s", spike_log_file), 
                 UVM_MEDIUM)
        
        fd = $fopen(spike_log_file, "r");
        if (fd == 0) begin
            `uvm_warning(get_type_name(), 
                        $sformatf("Cannot open Spike log file: %s", spike_log_file))
            return;
        end
        
        // Parse Spike trace file
        // Expected format: "core   0: 0x00000000 (0x00000013) x0  0x00000000"
        // Format: core <id>: <pc> (<inst>) <reg> <value>
        
        while (!$feof(fd)) begin
            string core_str, pc_str, inst_str, reg_str, val_str;
            bit [31:0] pc, inst, value;
            bit [4:0] rd;
            spike_golden_t entry;
            
            if ($fgets(line, fd)) begin
                line_num++;
                
                // Skip empty lines and comments
                if (line == "" || line[0] == "#" || line[0] == "\n")
                    continue;
                
                // Parse line: "core   0: 0x80000000 (0x00000297) x5  0x80000000"
                if ($sscanf(line, "core %d: 0x%h (0x%h) %s 0x%h", 
                           entry.pc, entry.pc, entry.instruction, reg_str, entry.rd_value) == 5) begin
                    
                    // Extract register number from "x5" format
                    if ($sscanf(reg_str, "x%d", rd) == 1) begin
                        entry.rd = rd;
                        entry.reg_write = (rd != 0);  // x0 writes are ignored
                    end else begin
                        entry.reg_write = 0;
                    end
                    
                    // Calculate next PC (default: PC + 4)
                    entry.pc_next = entry.pc + 4;
                    
                    // TODO: Parse memory operations from Spike output
                    entry.mem_write = 0;
                    entry.mem_addr = 0;
                    entry.mem_data = 0;
                    
                    // Store in golden data queue
                    golden_data.push_back(entry);
                    
                    `uvm_info(get_type_name(), 
                             $sformatf("Loaded golden [%0d]: PC=0x%08h, inst=0x%08h, x%0d=0x%08h", 
                                      golden_data.size()-1, entry.pc, entry.instruction, 
                                      entry.rd, entry.rd_value), 
                             UVM_HIGH)
                end else begin
                    `uvm_warning(get_type_name(), 
                                $sformatf("Failed to parse line %0d: %s", line_num, line))
                end
            end
        end
        
        $fclose(fd);
        
        golden_loaded = 1;
        `uvm_info(get_type_name(), 
                 $sformatf("Loaded %0d golden reference entries from Spike", 
                          golden_data.size()), 
                 UVM_MEDIUM)
    endfunction
    
    // ==========================================================================
    // Get Expected Values for Current Instruction
    // ==========================================================================
    function bit get_expected(input bit [31:0] pc, output spike_golden_t expected);
        
        if (!golden_loaded) begin
            `uvm_error(get_type_name(), "Golden reference not loaded!")
            return 0;
        end
        
        // Search for matching PC in golden data
        foreach (golden_data[i]) begin
            if (golden_data[i].pc == pc) begin
                expected = golden_data[i];
                `uvm_info(get_type_name(), 
                         $sformatf("Found golden match at index %0d for PC=0x%08h", 
                                  i, pc), 
                         UVM_HIGH)
                return 1;
            end
        end
        
        `uvm_warning(get_type_name(), 
                    $sformatf("No golden reference found for PC=0x%08h", pc))
        return 0;
        
    endfunction
    
    // ==========================================================================
    // Get Next Expected Entry (Sequential Access)
    // ==========================================================================
    function bit get_next_expected(output spike_golden_t expected);
        
        if (!golden_loaded) begin
            `uvm_error(get_type_name(), "Golden reference not loaded!")
            return 0;
        end
        
        if (golden_index >= golden_data.size()) begin
            `uvm_warning(get_type_name(), 
                        $sformatf("Golden index %0d exceeds data size %0d", 
                                 golden_index, golden_data.size()))
            return 0;
        end
        
        expected = golden_data[golden_index];
        golden_index++;
        
        `uvm_info(get_type_name(), 
                 $sformatf("Got golden entry %0d: PC=0x%08h, x%0d=0x%08h", 
                          golden_index-1, expected.pc, expected.rd, expected.rd_value), 
                 UVM_HIGH)
        
        return 1;
        
    endfunction
    
    // ==========================================================================
    // Reset Golden Index (for multiple test runs)
    // ==========================================================================
    function void reset_index();
        golden_index = 0;
        `uvm_info(get_type_name(), "Reset golden index to 0", UVM_MEDIUM)
    endfunction
    
    // ==========================================================================
    // Get Statistics
    // ==========================================================================
    function int get_golden_count();
        return golden_data.size();
    endfunction
    
    function int get_current_index();
        return golden_index;
    endfunction

endclass : spike_checker
