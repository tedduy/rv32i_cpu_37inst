module Complete_Functional_Units (
  // Common inputs
  input  logic        clk,
  input  logic        rst,
  
  // Control inputs (from Control Unit)
  input  logic [3:0]  i_alu_ctrl,
  input  logic        i_alu_src,
  input  logic        i_alu_a_sel,
  input  logic        i_branch_enable,
  input  logic [2:0]  i_branch_type,
  input  logic        i_mem_read,
  input  logic        i_mem_write,
  input  logic [2:0]  i_mem_type,
  input  logic        i_jal,
  input  logic        i_jalr,
  
  // Data inputs
  input  logic [31:0] i_pc,
  input  logic [31:0] i_rs1_data,
  input  logic [31:0] i_rs2_data,
  input  logic [31:0] i_immediate,
  input  logic [31:0] i_mem_read_data,
  
  // Outputs
  output logic [31:0] o_alu_result,
  output logic        o_alu_zero,
  output logic        o_branch_taken,
  output logic [31:0] o_load_data,
  output logic [31:0] o_store_data,
  output logic [3:0]  o_byte_enable,
  output logic [31:0] o_jump_target,
  output logic [31:0] o_return_addr
);

  // Internal signals
  logic [31:0] alu_operand_a, alu_operand_b;
  logic [1:0] byte_offset;

  // ALU operand selection
  assign alu_operand_a = i_alu_a_sel ? i_pc : i_rs1_data;
  assign alu_operand_b = i_alu_src ? i_immediate : i_rs2_data;
  assign byte_offset = alu_operand_a[1:0] + i_immediate[1:0]; // Address calculation

  // ALU Unit - 19 operations
  ALU_Unit #(.N(32)) alu_unit (
    .i_operand_a(alu_operand_a),
    .i_operand_b(alu_operand_b),
    .i_alu_ctrl(i_alu_ctrl),
    .o_alu_result(o_alu_result),
    .o_zero_flag(o_alu_zero)
  );

  // Branch Unit - 6 operations
  Branch_Unit #(.N(32)) branch_unit (
    .i_rs1_data(i_rs1_data),
    .i_rs2_data(i_rs2_data),
    .i_branch_type(i_branch_type),
    .i_branch_enable(i_branch_enable),
    .o_branch_taken(o_branch_taken)
  );

  // Load/Store Unit - 8 operations
  Load_Store_Unit #(.N(32)) load_store_unit (
    .i_mem_type(i_mem_type),
    .i_mem_read(i_mem_read),
    .i_mem_write(i_mem_write),
    .i_byte_offset(byte_offset),
    .i_mem_read_data(i_mem_read_data),
    .i_store_data(i_rs2_data),
    .o_load_data(o_load_data),
    .o_store_data(o_store_data),
    .o_byte_enable(o_byte_enable)
  );

  // Jump Unit - 2 operations
  Jump_Unit #(.N(32)) jump_unit (
    .i_pc(i_pc),
    .i_rs1_data(i_rs1_data),
    .i_immediate(i_immediate),
    .i_jal(i_jal),
    .i_jalr(i_jalr),
    .o_jump_target(o_jump_target),
    .o_return_addr(o_return_addr)
  );

endmodule
