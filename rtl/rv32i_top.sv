module rv32i_top #(
    parameter N = 32,
    parameter IMEM_DEPTH = 76,
    parameter DMEM_BYTES = 256,   // <-- đổi: số BYTE cho data RAM
    parameter REG_DEPTH = 32
)(
    input  logic i_clk,
    input  logic i_arst_n,
    
    // Debug/Test outputs for FPGA and testbench
    output logic [N-1:0] W_PC_out,        // Current PC
    output logic [N-1:0] instruction,     // Current instruction
    output logic [N-1:0] W_RD1,           // Register rs1 data
    output logic [N-1:0] W_RD2,           // Register rs2 data
    output logic [N-1:0] W_m1,            // ALU operand B (after mux)
    output logic [N-1:0] W_m2,            // Branch target address
    output logic [N-1:0] W_ALUout,        // ALU result
    
    // Enhanced debug outputs
    output logic [N-1:0] W_WB_data,       // Writeback data (to register file)
    output logic [4:0]   W_rd_addr,       // Destination register address
    output logic         W_reg_write,     // Register write enable
    output logic         W_mem_write,     // Memory write enable
    output logic         W_mem_read,      // Memory read enable
    output logic         W_branch_taken,  // Branch taken flag
    output logic [N-1:0] W_mem_addr,      // Memory address
    output logic [N-1:0] W_mem_wdata,     // Memory write data
    output logic [N-1:0] W_mem_rdata,     // Memory read data
    output logic         W_jal,           // JAL instruction active
    output logic         W_jalr           // JALR instruction active
);
    // ==========================================================================
    // Internal Signals
    // ==========================================================================
    
    // PC signals
    logic [N-1:0] pc_current, pc_next;
    
    // Control signals
    logic        reg_write, mem_read, mem_write;
    logic [2:0]  imm_sel;
    logic [1:0]  wb_sel, pc_sel;
    logic        alu_src, alu_a_sel;
    logic [3:0]  alu_ctrl;
    logic        branch_en;
    logic [2:0]  branch_type;
    logic [2:0]  mem_type;
    logic        jal, jalr;
    
    // Register file signals
    logic [4:0]  rs1_addr, rs2_addr, rd_addr;
    logic [N-1:0] rs1_data, rs2_data, rd_data;
    
    // Immediate generation
    logic [N-1:0] immediate;
    
    // ALU signals
    logic [N-1:0] alu_operand_a, alu_operand_b;
    logic [N-1:0] alu_result;
    logic         alu_zero;
    
    // Branch signals
    logic         branch_taken;
    
    // Jump signals
    logic [N-1:0] jump_target, return_addr;
    
    // Memory signals
    logic [N-1:0] mem_read_data, mem_write_data;
    logic [N-1:0] load_data, store_data;
    logic [3:0]   byte_enable;
    logic [N-1:0] mem_addr;
    
    // PC calculation signals
    logic [N-1:0] pc_plus_4, pc_branch_target;
    
    // ==========================================================================
    // Debug Output Assignments
    // ==========================================================================
    // Original debug signals
    assign W_PC_out     = pc_current;
    assign W_RD1        = rs1_data;
    assign W_RD2        = rs2_data;
    assign W_m1         = alu_operand_b;    // ALU operand B (immediate or rs2)
    assign W_m2         = pc_branch_target; // Branch target
    assign W_ALUout     = alu_result;
    
    // Enhanced debug signals
    assign W_WB_data      = rd_data;        // Writeback data
    assign W_rd_addr      = rd_addr;        // Destination register
    assign W_reg_write    = reg_write;      // Register write enable
    assign W_mem_write    = mem_write;      // Memory write enable
    assign W_mem_read     = mem_read;       // Memory read enable
    assign W_branch_taken = branch_taken;   // Branch taken
    assign W_mem_addr     = mem_addr;       // Memory address
    assign W_mem_wdata    = store_data;     // Memory write data
    assign W_mem_rdata    = load_data;      // Memory read data (after load unit)
    assign W_jal          = jal;            // JAL active
    assign W_jalr         = jalr;           // JALR active
    
    // ==========================================================================
    // Instruction Decode
    // ==========================================================================
    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign rd_addr  = instruction[11:7];
    
    // ==========================================================================
    // Module Instantiations
    // ==========================================================================
	 
	 adder_N_bit #(.N(N)) M1(
		.a(pc_current),
		.b(32'd4),
		.sum(pc_plus_4)
	 );
	 
	 adder_N_bit #(.N(N)) M2(
		.a(pc_current),
		.b(immediate),
		.sum(pc_branch_target)
	 );
    
    // Program Counter
    Program_Counter #(.N(N)) M3 (
        .i_clk(i_clk),
        .i_arst_n(i_arst_n),
        .i_PC(pc_next),
        .o_PC(pc_current)
    );
    
    // Instruction Memory
    Instruction_Mem #(
        .N(N),
        .DEPTH(IMEM_DEPTH)
    ) M4 (
        .i_clk(i_clk),
        .i_arst_n(i_arst_n),
        .i_addr(pc_current),
        .o_inst(instruction)
    );
    
    // Control Unit
    Control_Unit M5 (
        .i_instruction(instruction),
        .o_RegWrite(reg_write),
        .o_MemRead(mem_read),
        .o_MemWrite(mem_write),
        .o_ImmSel(imm_sel),
        .o_WBSel(wb_sel),
        .o_PCSel(pc_sel),
        .o_ALUSrc(alu_src),
        .o_ALUASel(alu_a_sel),
        .o_ALUCtrl(alu_ctrl),
        .o_BranchEn(branch_en),
        .o_BranchType(branch_type),
        .o_MemType(mem_type),
        .o_JAL(jal),
        .o_JALR(jalr)
    );
    
    // Register File
    Reg_File #(
        .N(N),
        .DEPTH(REG_DEPTH)
    ) M6 (
        .i_clk(i_clk),
        .i_arst_n(i_arst_n),
        .i_we(reg_write),
        .i_raddr1(rs1_addr),
        .i_raddr2(rs2_addr),
        .i_waddr(rd_addr),
        .i_wdata(rd_data),
        .o_rdata1(rs1_data),
        .o_rdata2(rs2_data)
    );
    
    // Immediate Generation
    Imm_Gen #(.N(N)) M7 (
        .i_inst(instruction),
        .o_imm(immediate)
    );
    
    // ALU operand selection
    assign alu_operand_a = alu_a_sel ? pc_current : rs1_data;
    assign alu_operand_b = alu_src ? immediate : rs2_data;
	 
    
    // ALU Unit
    ALU_Unit #(.N(N)) M10 (
        .i_operand_a(alu_operand_a),
        .i_operand_b(alu_operand_b),
        .i_alu_ctrl(alu_ctrl),
        .o_alu_result(alu_result),
        .o_zero_flag(alu_zero)
    );
    
    // Branch Unit
    Branch_Unit #(.N(N)) M11 (
        .i_rs1_data(rs1_data),
        .i_rs2_data(rs2_data),
        .i_branch_type(branch_type),
        .i_branch_enable(branch_en),
        .o_branch_taken(branch_taken)
    );
    
    // Jump Unit
    Jump_Unit #(.N(N)) M12 (
        .i_pc(pc_current),
        .i_rs1_data(rs1_data),
        .i_immediate(immediate),
        .i_jal(jal),
        .i_jalr(jalr),
        .o_jump_target(jump_target),
        .o_return_addr(return_addr)
    );
    
    // Memory address calculation
    assign mem_addr = alu_result;
    
    // Data Memory
    Data_Memory #(
        .N(N),
        .BYTES(DMEM_BYTES)
    ) M13 (
        .i_clk    (i_clk),
        .i_arst_n (i_arst_n),
        .i_we     (mem_write),
        .i_re     (mem_read),
        .i_addr   (mem_addr),     // địa chỉ byte từ ALU
        .i_wdata  (store_data),   // dữ liệu đã được LSU sắp xếp đúng thứ tự byte (little-endian)
        .i_wstrb  (byte_enable),  // byte-enable từ LSU (SB/SH/SW)
        .o_rdata  (mem_read_data) // word 32-bit thô; LSU dùng mem_addr[1:0] để chọn byte/half & extend
    );
	 
    // Load/Store Unit
    Load_Store_Unit #(.N(N)) M14 (
        .i_mem_type(mem_type),
        .i_mem_read(mem_read),
        .i_mem_write(mem_write),
        .i_byte_offset(mem_addr[1:0]),
        .i_mem_read_data(mem_read_data),
        .i_store_data(rs2_data),
        .o_load_data(load_data),
        .o_store_data(store_data),
        .o_byte_enable(byte_enable)
    );
    
    // ==========================================================================
    // Writeback Multiplexer
    // ==========================================================================
	 
	 mux4to1 #(.N(N)) M15 (
		  .i_d0(alu_result),   // 00 // WB_ALU - ALU result
		  .i_d1(load_data),    // 01 // WB_MEM - Memory data (Load instructions)
		  .i_d2(return_addr),  // 10 // WB_PC4 - PC + 4 (JAL/JALR return address)
		  .i_d3(immediate),    // 11 // WB_IMM - Immediate (LUI direct load)
		  .i_sel(wb_sel),
		  .o_y(rd_data)
		);

    
    // ==========================================================================
    // PC Next Logic
    // ==========================================================================
	 
	logic [31:0] branch_or_plus4; 
	
	assign branch_or_plus4 = branch_taken ? pc_branch_target : pc_plus_4;

	// i_d0=PLUS4, i_d1=BRANCH/PLUS4, i_d2=JAL, i_d3=JALR
	mux4to1 #(.N(32)) M16 (
	  .i_d0(pc_plus_4),
	  .i_d1(branch_or_plus4),
	  .i_d2(jump_target),
	  .i_d3(jump_target),
	  .i_sel(pc_sel),
	  .o_y(pc_next)
	);

endmodule