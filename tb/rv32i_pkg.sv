// =============================================================================
// RV32I UVM Package
// =============================================================================
// Contains all UVM verification components
// =============================================================================

package rv32i_pkg;
    
    // Import UVM library
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // ==========================================================================
    // Package Parameters
    // ==========================================================================
    parameter int DATA_WIDTH = 32;
    parameter int REG_ADDR_WIDTH = 5;
    
    // ==========================================================================
    // Opcode Definitions (RV32I Base Integer Instruction Set)
    // ==========================================================================
    typedef enum logic [6:0] {
        OP_LUI    = 7'b0110111,  // Load Upper Immediate
        OP_AUIPC  = 7'b0010111,  // Add Upper Immediate to PC
        OP_JAL    = 7'b1101111,  // Jump and Link
        OP_JALR   = 7'b1100111,  // Jump and Link Register
        OP_BRANCH = 7'b1100011,  // Branch instructions
        OP_LOAD   = 7'b0000011,  // Load instructions
        OP_STORE  = 7'b0100011,  // Store instructions
        OP_ALUI   = 7'b0010011,  // ALU with immediate
        OP_ALU    = 7'b0110011   // ALU with register
    } opcode_e;
    
    // ==========================================================================
    // Funct3 Definitions for Branch Instructions
    // ==========================================================================
    typedef enum logic [2:0] {
        FUNCT3_BEQ  = 3'b000,
        FUNCT3_BNE  = 3'b001,
        FUNCT3_BLT  = 3'b100,
        FUNCT3_BGE  = 3'b101,
        FUNCT3_BLTU = 3'b110,
        FUNCT3_BGEU = 3'b111
    } branch_funct3_e;
    
    // ==========================================================================
    // Funct3 Definitions for Load Instructions
    // ==========================================================================
    typedef enum logic [2:0] {
        FUNCT3_LB  = 3'b000,
        FUNCT3_LH  = 3'b001,
        FUNCT3_LW  = 3'b010,
        FUNCT3_LBU = 3'b100,
        FUNCT3_LHU = 3'b101
    } load_funct3_e;
    
    // ==========================================================================
    // Funct3 Definitions for Store Instructions
    // ==========================================================================
    typedef enum logic [2:0] {
        FUNCT3_SB = 3'b000,
        FUNCT3_SH = 3'b001,
        FUNCT3_SW = 3'b010
    } store_funct3_e;
    
    // ==========================================================================
    // Funct3 Definitions for ALU Instructions
    // ==========================================================================
    typedef enum logic [2:0] {
        FUNCT3_ADD_SUB = 3'b000,
        FUNCT3_SLL     = 3'b001,
        FUNCT3_SLT     = 3'b010,
        FUNCT3_SLTU    = 3'b011,
        FUNCT3_XOR     = 3'b100,
        FUNCT3_SRL_SRA = 3'b101,
        FUNCT3_OR      = 3'b110,
        FUNCT3_AND     = 3'b111
    } alu_funct3_e;
    
    // ==========================================================================
    // Include all verification components in dependency order
    // ==========================================================================
    
    // Transaction class (base data packet)
    `include "rv32i_transaction.sv"
    
    // Sequencer (transaction generator controller)
    `include "rv32i_sequencer.sv"
    
    // Driver (drives transactions to DUT)
    `include "rv32i_driver.sv"
    
    // Monitor (captures DUT outputs)
    `include "rv32i_monitor.sv"
    
    // Spike checker (parses golden reference)
    `include "spike_checker.sv"
    
    // Scoreboard (compares DUT vs Spike)
    `include "rv32i_scoreboard.sv"
    
    // Agent (groups driver/monitor/sequencer)
    `include "rv32i_agent.sv"
    
    // Environment (top-level verification environment)
    `include "rv32i_env.sv"
    
    // Base test class
    `include "base_test.sv"

endpackage : rv32i_pkg
