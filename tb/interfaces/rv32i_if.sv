// =============================================================================
// RV32I Pipeline CPU Interface
// =============================================================================
// This interface connects the UVM testbench to the DUT (rv32i_top)
// =============================================================================

interface rv32i_if (
    input logic clk
);

    // ==========================================================================
    // DUT Control Signals
    // ==========================================================================
    logic arst_n;  // Active-low asynchronous reset
    
    // ==========================================================================
    // DUT Debug/Monitor Outputs
    // ==========================================================================
    logic [31:0] pc_out;
    logic [31:0] instruction;
    logic [31:0] rd1;
    logic [31:0] rd2;
    logic [31:0] m1;
    logic [31:0] m2;
    logic [31:0] alu_out;
    logic [31:0] wb_data;
    logic [4:0]  rd_addr;
    logic        reg_write;
    logic        mem_write;
    logic        mem_read;
    logic        branch_taken;
    logic [31:0] mem_addr;
    logic [31:0] mem_wdata;
    logic [31:0] mem_rdata;
    logic        jal;
    logic        jalr;
    
    // ==========================================================================
    // Clocking Blocks for Synchronous Operation
    // ==========================================================================
    
    // Driver clocking block (for driving inputs)
    clocking driver_cb @(posedge clk);
        output arst_n;
    endclocking
    
    // Monitor clocking block (for sampling outputs)
    clocking monitor_cb @(posedge clk);
        input pc_out;
        input instruction;
        input rd1;
        input rd2;
        input m1;
        input m2;
        input alu_out;
        input wb_data;
        input rd_addr;
        input reg_write;
        input mem_write;
        input mem_read;
        input branch_taken;
        input mem_addr;
        input mem_wdata;
        input mem_rdata;
        input jal;
        input jalr;
    endclocking
    
    // ==========================================================================
    // Modports (define access directions)
    // ==========================================================================
    
    modport driver (
        clocking driver_cb,
        input clk
    );
    
    modport monitor (
        clocking monitor_cb,
        input clk,
        input arst_n
    );
    
    modport dut (
        input  clk,
        input  arst_n,
        output pc_out,
        output instruction,
        output rd1,
        output rd2,
        output m1,
        output m2,
        output alu_out,
        output wb_data,
        output rd_addr,
        output reg_write,
        output mem_write,
        output mem_read,
        output branch_taken,
        output mem_addr,
        output mem_wdata,
        output mem_rdata,
        output jal,
        output jalr
    );

endinterface : rv32i_if
