// =============================================================================
// RTL Package
// =============================================================================
// Contains all RTL design parameters, typedefs, and common definitions
// NOTE: RTL module files are compiled separately via compile.f
// =============================================================================

package rtl_pkg;

    // =============================================================================
    // RV32I ISA Definitions
    // =============================================================================
    
    // Instruction field positions
    parameter OPCODE_LSB    = 0;
    parameter OPCODE_MSB    = 6;
    parameter RD_LSB        = 7;
    parameter RD_MSB        = 11;
    parameter FUNCT3_LSB    = 12;
    parameter FUNCT3_MSB    = 14;
    parameter RS1_LSB       = 15;
    parameter RS1_MSB       = 19;
    parameter RS2_LSB       = 20;
    parameter RS2_MSB       = 24;
    parameter FUNCT7_LSB    = 25;
    parameter FUNCT7_MSB    = 31;
    
    // Opcode definitions
    typedef enum logic [6:0] {
        OP_LOAD     = 7'b0000011,
        OP_STORE    = 7'b0100011,
        OP_BRANCH   = 7'b1100011,
        OP_JAL      = 7'b1101111,
        OP_JALR     = 7'b1100111,
        OP_LUI      = 7'b0110111,
        OP_AUIPC    = 7'b0010111,
        OP_OP_IMM   = 7'b0010011,
        OP_OP       = 7'b0110011
    } opcode_e;
    
    // Funct3 definitions for ALU operations
    typedef enum logic [2:0] {
        FUNCT3_ADD_SUB  = 3'b000,
        FUNCT3_SLL      = 3'b001,
        FUNCT3_SLT      = 3'b010,
        FUNCT3_SLTU     = 3'b011,
        FUNCT3_XOR      = 3'b100,
        FUNCT3_SRL_SRA  = 3'b101,
        FUNCT3_OR       = 3'b110,
        FUNCT3_AND      = 3'b111
    } funct3_alu_e;
    
    // Funct3 definitions for Load operations
    typedef enum logic [2:0] {
        FUNCT3_LB       = 3'b000,
        FUNCT3_LH       = 3'b001,
        FUNCT3_LW       = 3'b010,
        FUNCT3_LBU      = 3'b100,
        FUNCT3_LHU      = 3'b101
    } funct3_load_e;
    
    // Funct3 definitions for Store operations
    typedef enum logic [2:0] {
        FUNCT3_SB       = 3'b000,
        FUNCT3_SH       = 3'b001,
        FUNCT3_SW       = 3'b010
    } funct3_store_e;
    
    // Funct3 definitions for Branch operations
    typedef enum logic [2:0] {
        FUNCT3_BEQ      = 3'b000,
        FUNCT3_BNE      = 3'b001,
        FUNCT3_BLT      = 3'b100,
        FUNCT3_BGE      = 3'b101,
        FUNCT3_BLTU     = 3'b110,
        FUNCT3_BGEU     = 3'b111
    } funct3_branch_e;
    
    // =============================================================================
    // Pipeline Control Signals
    // =============================================================================
    
    // ALU operation codes
    typedef enum logic [3:0] {
        ALU_ADD     = 4'b0000,
        ALU_SUB     = 4'b0001,
        ALU_SLL     = 4'b0010,
        ALU_SLT     = 4'b0011,
        ALU_SLTU    = 4'b0100,
        ALU_XOR     = 4'b0101,
        ALU_SRL     = 4'b0110,
        ALU_SRA     = 4'b0111,
        ALU_OR      = 4'b1000,
        ALU_AND     = 4'b1001,
        ALU_PASS_B  = 4'b1010
    } alu_op_e;
    
    // Memory operation types
    typedef enum logic [1:0] {
        MEM_NONE    = 2'b00,
        MEM_READ    = 2'b01,
        MEM_WRITE   = 2'b10
    } mem_op_e;
    
    // Register writeback source
    typedef enum logic [1:0] {
        WB_ALU      = 2'b00,
        WB_MEM      = 2'b01,
        WB_PC4      = 2'b10
    } wb_src_e;
    
    // Branch/Jump types
    typedef enum logic [1:0] {
        BRANCH_NONE = 2'b00,
        BRANCH_COND = 2'b01,
        BRANCH_JAL  = 2'b10,
        BRANCH_JALR = 2'b11
    } branch_type_e;
    
    // Forwarding mux select
    typedef enum logic [1:0] {
        FWD_NONE    = 2'b00,
        FWD_EX_MEM  = 2'b01,
        FWD_MEM_WB  = 2'b10
    } forward_sel_e;
    
    // =============================================================================
    // Design Parameters
    // =============================================================================
    
    parameter int DATA_WIDTH    = 32;
    parameter int ADDR_WIDTH    = 32;
    parameter int REG_ADDR_WIDTH = 5;
    parameter int NUM_REGS      = 32;
    parameter int IMEM_DEPTH    = 1024;
    parameter int DMEM_DEPTH    = 1024;

endpackage : rtl_pkg
