// ==============================================================================
// DE2-115 Top-Level Wrapper for RV32I Pipeline CPU
// ==============================================================================
// Board: Terasic DE2-115
// FPGA: Cyclone IV E EP4CE115F29C7
// ==============================================================================

module de2_115_top (
    // Clock and Reset
    input  logic        CLOCK_50,      // 50 MHz oscillator
    input  logic [3:0]  KEY,           // Push buttons (active low)
    
    // Switches and LEDs
    input  logic [17:0] SW,            // Slide switches
    output logic [17:0] LEDR,          // Red LEDs
    output logic [8:0]  LEDG,          // Green LEDs
    
    // 7-Segment Displays
    output logic [6:0]  HEX0,          // 7-segment display 0
    output logic [6:0]  HEX1,          // 7-segment display 1
    output logic [6:0]  HEX2,          // 7-segment display 2
    output logic [6:0]  HEX3,          // 7-segment display 3
    output logic [6:0]  HEX4,          // 7-segment display 4
    output logic [6:0]  HEX5,          // 7-segment display 5
    output logic [6:0]  HEX6,          // 7-segment display 6
    output logic [6:0]  HEX7           // 7-segment display 7
);

    // ==========================================================================
    // Clock and Reset
    // ==========================================================================
    logic clk;
    logic rst_n;
    
    // Use 50 MHz clock directly (or use PLL to generate higher frequency)
    assign clk = CLOCK_50;
    
    // Reset from KEY[0] (active low button)
    // Add synchronizer for reset
    logic rst_n_sync1, rst_n_sync2;
    always_ff @(posedge clk or negedge KEY[0]) begin
        if (!KEY[0]) begin
            rst_n_sync1 <= 1'b0;
            rst_n_sync2 <= 1'b0;
        end else begin
            rst_n_sync1 <= 1'b1;
            rst_n_sync2 <= rst_n_sync1;
        end
    end
    assign rst_n = rst_n_sync2;
    
    // ==========================================================================
    // CPU Debug Signals
    // ==========================================================================
    logic [31:0] W_PC_out;
    logic [31:0] W_instruction;
    logic [31:0] W_RD1, W_RD2;
    logic [31:0] W_m1, W_m2;
    logic [31:0] W_ALUout;
    logic [31:0] W_WB_data;
    logic [4:0]  W_rd_addr;
    logic        W_reg_write;
    logic        W_mem_write, W_mem_read;
    logic        W_branch_taken;
    logic [31:0] W_mem_addr;
    logic [31:0] W_mem_wdata, W_mem_rdata;
    logic        W_jal, W_jalr;
    logic        W_stall, W_flush;
    
    // ==========================================================================
    // CPU Instantiation
    // ==========================================================================
    rv32i_top cpu (
        .i_clk(clk),
        .i_arst_n(rst_n),
        // Debug outputs
        .W_PC_out(W_PC_out),
        .instruction(W_instruction),
        .W_RD1(W_RD1),
        .W_RD2(W_RD2),
        .W_m1(W_m1),
        .W_m2(W_m2),
        .W_ALUout(W_ALUout),
        .W_WB_data(W_WB_data),
        .W_rd_addr(W_rd_addr),
        .W_reg_write(W_reg_write),
        .W_mem_write(W_mem_write),
        .W_mem_read(W_mem_read),
        .W_branch_taken(W_branch_taken),
        .W_mem_addr(W_mem_addr),
        .W_mem_wdata(W_mem_wdata),
        .W_mem_rdata(W_mem_rdata),
        .W_jal(W_jal),
        .W_jalr(W_jalr),
        .W_stall(W_stall),
        .W_flush(W_flush)
    );
    
    // ==========================================================================
    // Debug Mode Selection (SW[2:0])
    // ==========================================================================
    // SW[2:0] = 000: Cycle counter
    // SW[2:0] = 001: Program Counter (PC)
    // SW[2:0] = 010: Instruction
    // SW[2:0] = 011: ALU Output
    // SW[2:0] = 100: Writeback Data
    // SW[2:0] = 101: Memory Address
    // SW[2:0] = 110: Instruction Counter
    // SW[2:0] = 111: Register Read Data (RD1)
    
    logic [2:0] debug_mode;
    assign debug_mode = SW[2:0];
    
    // Register debug outputs to improve timing
    logic [31:0] display_value_comb;
    logic [31:0] display_value;
    
    always_comb begin
        case (debug_mode)
            3'b000: display_value_comb = cycle_counter;
            3'b001: display_value_comb = W_PC_out;
            3'b010: display_value_comb = W_instruction;
            3'b011: display_value_comb = W_ALUout;
            3'b100: display_value_comb = W_WB_data;
            3'b101: display_value_comb = W_mem_addr;
            3'b110: display_value_comb = instruction_counter;
            3'b111: display_value_comb = W_RD1;
            default: display_value_comb = cycle_counter;
        endcase
    end
    
    // Pipeline register for timing
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            display_value <= 32'h0;
        else
            display_value <= display_value_comb;
    end
    
    // ==========================================================================
    // Debug Outputs
    // ==========================================================================
    
    // Cycle counter
    logic [31:0] cycle_counter;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cycle_counter <= 32'h0;
        else
            cycle_counter <= cycle_counter + 1;
    end
    
    // Instruction counter (count when reg_write = 1)
    logic [31:0] instruction_counter;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            instruction_counter <= 32'h0;
        else if (W_reg_write && W_rd_addr != 0)
            instruction_counter <= instruction_counter + 1;
    end
    
    // ==========================================================================
    // LED Outputs
    // ==========================================================================
    
    // LEDR[17:5]: Display selected value (lower 13 bits)
    assign LEDR[17:5] = display_value[12:0];
    
    // LEDR[4:0]: Show destination register (rd_addr)
    assign LEDR[4:0] = W_rd_addr;
    
    // LEDG[8:0]: CPU status indicators
    assign LEDG[0] = rst_n;              // Reset status (1 = running)
    assign LEDG[1] = W_reg_write;        // Register write activity
    assign LEDG[2] = W_mem_write;        // Memory write activity
    assign LEDG[3] = W_mem_read;         // Memory read activity
    assign LEDG[4] = W_branch_taken;     // Branch taken
    assign LEDG[5] = W_jal;              // JAL instruction
    assign LEDG[6] = W_jalr;             // JALR instruction
    assign LEDG[7] = W_stall;            // Pipeline stall
    assign LEDG[8] = W_flush;            // Pipeline flush
    
    // ==========================================================================
    // 7-Segment Displays
    // ==========================================================================
    // Display selected value based on SW[1:0]
    
    hex_to_7seg hex0_inst (.hex(display_value[3:0]),   .seg(HEX0));
    hex_to_7seg hex1_inst (.hex(display_value[7:4]),   .seg(HEX1));
    hex_to_7seg hex2_inst (.hex(display_value[11:8]),  .seg(HEX2));
    hex_to_7seg hex3_inst (.hex(display_value[15:12]), .seg(HEX3));
    hex_to_7seg hex4_inst (.hex(display_value[19:16]), .seg(HEX4));
    hex_to_7seg hex5_inst (.hex(display_value[23:20]), .seg(HEX5));
    hex_to_7seg hex6_inst (.hex(display_value[27:24]), .seg(HEX6));
    hex_to_7seg hex7_inst (.hex(display_value[31:28]), .seg(HEX7));
    
    // ==========================================================================
    // Switch Controls
    // ==========================================================================
    // SW[2:0]: Debug mode selection
    //   000 = Cycle counter
    //   001 = Program Counter (PC)
    //   010 = Current Instruction
    //   011 = ALU Output
    //   100 = Writeback Data
    //   101 = Memory Address
    //   110 = Instruction Counter
    //   111 = Register Read Data (RD1)
    // SW[17:3]: Reserved for future use
    
endmodule

// ==============================================================================
// Hex to 7-Segment Decoder
// ==============================================================================
module hex_to_7seg (
    input  logic [3:0] hex,
    output logic [6:0] seg
);
    // 7-segment encoding (active low)
    //     0
    //    ---
    // 5 |   | 1
    //    ---  <- 6
    // 4 |   | 2
    //    ---
    //     3
    
    always_comb begin
        case (hex)
            4'h0: seg = 7'b1000000; // 0
            4'h1: seg = 7'b1111001; // 1
            4'h2: seg = 7'b0100100; // 2
            4'h3: seg = 7'b0110000; // 3
            4'h4: seg = 7'b0011001; // 4
            4'h5: seg = 7'b0010010; // 5
            4'h6: seg = 7'b0000010; // 6
            4'h7: seg = 7'b1111000; // 7
            4'h8: seg = 7'b0000000; // 8
            4'h9: seg = 7'b0010000; // 9
            4'hA: seg = 7'b0001000; // A
            4'hB: seg = 7'b0000011; // b
            4'hC: seg = 7'b1000110; // C
            4'hD: seg = 7'b0100001; // d
            4'hE: seg = 7'b0000110; // E
            4'hF: seg = 7'b0001110; // F
            default: seg = 7'b1111111; // blank
        endcase
    end
endmodule
