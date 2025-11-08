// =============================================================================
// MEM/WB Pipeline Register
// =============================================================================
// Stores data between Memory (MEM) and Write Back (WB) stages
// Includes memory read data, ALU results, and writeback control signals
// =============================================================================

module MEM_WB_Register #(
    parameter N = 32
)(
    input  logic             i_clk,
    input  logic             i_arst_n,
    
    // Inputs from MEM stage
    input  logic [N-1:0]     i_alu_result,
    input  logic [N-1:0]     i_mem_read_data,
    input  logic [N-1:0]     i_return_addr,
    input  logic [N-1:0]     i_immediate,
    input  logic [4:0]       i_rd_addr,
    
    // Control signals from MEM stage
    input  logic             i_reg_write,
    input  logic [1:0]       i_wb_sel,
    
    // Outputs to WB stage
    output logic [N-1:0]     o_alu_result,
    output logic [N-1:0]     o_mem_read_data,
    output logic [N-1:0]     o_return_addr,
    output logic [N-1:0]     o_immediate,
    output logic [4:0]       o_rd_addr,
    
    // Control signals to WB stage
    output logic             o_reg_write,
    output logic [1:0]       o_wb_sel
);

    always_ff @(posedge i_clk or negedge i_arst_n) begin
        if (!i_arst_n) begin
            // Reset: Clear all signals
            o_alu_result     <= 32'h0;
            o_mem_read_data  <= 32'h0;
            o_return_addr    <= 32'h0;
            o_immediate      <= 32'h0;
            o_rd_addr        <= 5'h0;
            
            // Clear control signals
            o_reg_write      <= 1'b0;
            o_wb_sel         <= 2'b0;
        end
        else begin
            // Normal operation: Pass data through
            o_alu_result     <= i_alu_result;
            o_mem_read_data  <= i_mem_read_data;
            o_return_addr    <= i_return_addr;
            o_immediate      <= i_immediate;
            o_rd_addr        <= i_rd_addr;
            
            // Pass control signals
            o_reg_write      <= i_reg_write;
            o_wb_sel         <= i_wb_sel;
        end
    end

endmodule
