`timescale 1ns/1ps

// ================== RV32I Processor Testbench (IMM LOG + FIXED PHASE + SAME-CYCLE JUMP TAG) ==================
module tb_rv32i_top;

  // -------------------------------
  // Params khớp với DUT
  // -------------------------------
  localparam int N            = 32;
  localparam int IMEM_DEPTH   = 76;
  localparam int DMEM_BYTES   = 256;
  localparam int REG_DEPTH    = 32;
	localparam int MAX_LOG_INST = 34;  // Simple test: 35 instructions (0-34), stop after inst 33 completes WB
	localparam int PIPELINE_DEPTH = 5;  // 5-stage pipeline

  // Kết thúc chương trình sau lệnh cuối (mỗi lệnh 4B)
  localparam int LAST_PC_AFTER = IMEM_DEPTH * 4; // = 304

  // -------------------------------
  // Clock/Reset
  // -------------------------------
  reg clk;
  reg rst;                 // rst=1 → reset (active-high). DUT dùng i_arst_n = ~rst

  // -------------------------------
  // Wires match với tất cả output của top
  // -------------------------------
  wire [N-1:0] W_PC_out;
  wire [N-1:0] instruction;
  wire [N-1:0] W_RD1, W_RD2, W_m1, W_m2, W_ALUout;

  // Enhanced debug
  wire [N-1:0] W_WB_data;
  wire [4:0]   W_rd_addr;
  wire         W_reg_write, W_mem_write, W_mem_read;
  wire         W_branch_taken;
  wire [N-1:0] W_mem_addr, W_mem_wdata, W_mem_rdata;
  wire         W_jal, W_jalr;

  // -------------------------------
  // Theo dõi trạng thái
  // -------------------------------
  reg  [127:0] instr_name;
  reg  [127:0] phase_name;

  reg  [N-1:0] prev_pc;
  reg  [31:0]  instruction_count;
  reg  [7:0]   same_pc_count;
  reg          finish_req;

  // Phase tracking
  reg  [7:0]   current_phase;
  localparam PHASE_NOP    = 0,
             PHASE_R_TYPE = 1,
             PHASE_I_TYPE = 2,
             PHASE_LOAD   = 3,
             PHASE_JALR   = 4,
             PHASE_STORE  = 5,
             PHASE_BRANCH = 6,
             PHASE_U_TYPE = 7,
             PHASE_JAL    = 8;

  // -------------------------------
  // DUT
  // -------------------------------
  rv32i_top #(
    .N(N),
    .IMEM_DEPTH(IMEM_DEPTH),
    .DMEM_BYTES(DMEM_BYTES),
    .REG_DEPTH(REG_DEPTH)
  ) dut (
    .i_clk       (clk),
    .i_arst_n    (~rst),

    // Debug/Test outputs
    .W_PC_out    (W_PC_out),
    .instruction (instruction),
    .W_RD1       (W_RD1),
    .W_RD2       (W_RD2),
    .W_m1        (W_m1),
    .W_m2        (W_m2),
    .W_ALUout    (W_ALUout),

    // Enhanced debug outputs
    .W_WB_data      (W_WB_data),
    .W_rd_addr      (W_rd_addr),
    .W_reg_write    (W_reg_write),
    .W_mem_write    (W_mem_write),
    .W_mem_read     (W_mem_read),
    .W_branch_taken (W_branch_taken),
    .W_mem_addr     (W_mem_addr),
    .W_mem_wdata    (W_mem_wdata),
    .W_mem_rdata    (W_mem_rdata),
    .W_jal          (W_jal),
    .W_jalr         (W_jalr)
  );

  // -------------------------------
  // Clock 100MHz (10ns)
  // -------------------------------
  always #5 clk = ~clk;

  // -------------------------------
  // Phase detection theo dải PC (byte) — ĐÃ SỬA RANH GIỚI
  // -------------------------------
  // Mem[ 1..20]  PC:   4.. 80  -> R-TYPE
  // Mem[21..49]  PC:  84..196  -> I-TYPE
  // Mem[50..51]  PC: 200..204  -> JALR block
  // Mem[52..58]  PC: 208..232  -> STORE
  // Mem[59..70]  PC: 236..280  -> BRANCH
  // Mem[71..73]  PC: 284..296  -> U-TYPE
  // Mem[74..75]  PC: 296..300  -> JAL
  always @(*) begin
    case (1'b1)
      (W_PC_out == 32'd0):                           current_phase = PHASE_NOP;
      (W_PC_out >= 32'd4   && W_PC_out <= 32'd80 ):  current_phase = PHASE_R_TYPE;
      (W_PC_out >= 32'd84  && W_PC_out <= 32'd196):  current_phase = PHASE_I_TYPE;
      (W_PC_out >= 32'd200 && W_PC_out <= 32'd204):  current_phase = PHASE_JALR;
      (W_PC_out >= 32'd208 && W_PC_out <= 32'd232):  current_phase = PHASE_STORE;   // <= 232
      (W_PC_out >= 32'd236 && W_PC_out <= 32'd280):  current_phase = PHASE_BRANCH;  // từ 236
      (W_PC_out >= 32'd284 && W_PC_out <= 32'd296):  current_phase = PHASE_U_TYPE;
      (W_PC_out >= 32'd296 && W_PC_out <= 32'd300):  current_phase = PHASE_JAL;
      default:                                       current_phase = 8'hFF; // UNKNOWN
    endcase
  end

  // Phase name
  always @(*) begin
    case (current_phase)
      PHASE_NOP:     phase_name = "NOP        ";
      PHASE_R_TYPE:  phase_name = "R-TYPE     ";
      PHASE_I_TYPE:  phase_name = "I-TYPE     ";
      PHASE_LOAD:    phase_name = "LOAD       ";
      PHASE_JALR:    phase_name = "JALR       ";
      PHASE_STORE:   phase_name = "STORE      ";
      PHASE_BRANCH:  phase_name = "BRANCH     ";
      PHASE_U_TYPE:  phase_name = "U-TYPE     ";
      PHASE_JAL:     phase_name = "JAL        ";
      default:       phase_name = "UNKNOWN    ";
    endcase
  end

  // -------------------------------
  // Decoder tên lệnh (opcode/funct)
  // -------------------------------
  always @(*) begin
    case (instruction[6:0])
      7'b0110011: begin // R-type
        case (instruction[31:25])
          7'b0000000: begin
            case (instruction[14:12])
              3'b000: instr_name = "ADD       ";
              3'b001: instr_name = "SLL       ";
              3'b010: instr_name = "SLT       ";
              3'b011: instr_name = "SLTU      ";
              3'b100: instr_name = "XOR       ";
              3'b101: instr_name = "SRL       ";
              3'b110: instr_name = "OR        ";
              3'b111: instr_name = "AND       ";
              default: instr_name = "UNKNOWN_R ";
            endcase
          end
          7'b0100000: begin
            case (instruction[14:12])
              3'b000: instr_name = "SUB       ";
              3'b101: instr_name = "SRA       ";
              default: instr_name = "UNKNOWN_R ";
            endcase
          end
          default: instr_name = "UNKNOWN_R ";
        endcase
      end

      7'b0010011: begin // I-type arithmetic
        case (instruction[14:12])
          3'b000: instr_name = "ADDI      ";
          3'b010: instr_name = "SLTI      ";
          3'b011: instr_name = "SLTIU     ";
          3'b100: instr_name = "XORI      ";
          3'b110: instr_name = "ORI       ";
          3'b111: instr_name = "ANDI      ";
          3'b001: instr_name = "SLLI      ";
          3'b101: begin
            if (instruction[31:25] == 7'b0000000) instr_name = "SRLI      ";
            else if (instruction[31:25] == 7'b0100000) instr_name = "SRAI      ";
            else instr_name = "UNKNOWN_I ";
          end
          default: instr_name = "UNKNOWN_I ";
        endcase
      end

      7'b0000011: begin // Load
        case (instruction[14:12])
          3'b000: instr_name = "LB        ";
          3'b001: instr_name = "LH        ";
          3'b010: instr_name = "LW        ";
          3'b100: instr_name = "LBU       ";
          3'b101: instr_name = "LHU       ";
          default: instr_name = "UNKNOWN_L ";
        endcase
      end

      7'b0100011: begin // Store
        case (instruction[14:12])
          3'b000: instr_name = "SB        ";
          3'b001: instr_name = "SH        ";
          3'b010: instr_name = "SW        ";
          default: instr_name = "UNKNOWN_S ";
        endcase
      end

      7'b1100011: begin // Branch
        case (instruction[14:12])
          3'b000: instr_name = "BEQ       ";
          3'b001: instr_name = "BNE       ";
          3'b100: instr_name = "BLT       ";
          3'b101: instr_name = "BGE       ";
          3'b110: instr_name = "BLTU      ";
          3'b111: instr_name = "BGEU      ";
          default: instr_name = "UNKNOWN_B ";
        endcase
      end

      7'b0110111: instr_name = "LUI       ";
      7'b0010111: instr_name = "AUIPC     ";
      7'b1101111: instr_name = "JAL       ";
      7'b1100111: instr_name = (instruction[14:12] == 3'b000) ? "JALR      " : "UNKNOWN_J ";
      default:    instr_name = "UNKNOWN   ";
    endcase
  end

  // -------------------------------
  // Immediate decode (RV32I)
  // -------------------------------
  wire [31:0] imm_i = {{20{instruction[31]}}, instruction[31:20]};
  wire [31:0] imm_s = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
  wire [31:0] imm_b = {{19{instruction[31]}}, instruction[31], instruction[7],
                       instruction[30:25], instruction[11:8], 1'b0};
  wire [31:0] imm_u = {instruction[31:12], 12'b0};
  wire [31:0] imm_j = {{11{instruction[31]}}, instruction[31], instruction[19:12],
                       instruction[20], instruction[30:21], 1'b0};
  wire [4:0]  shamt = instruction[24:20];

  // -------------------------------
  // Chuỗi bổ sung để in imm/đích
  // -------------------------------
  string extra_str;

  always @(*) begin
    extra_str = "";
    unique case (instruction[6:0])
      7'b0010011: begin // I-type ALU
        case (instruction[14:12])
          3'b001, 3'b101: // SLLI / SRLI/SRAI
            extra_str = $sformatf("imm(shamt)=%0d (0x%02h)", shamt, shamt);
          default:
            extra_str = $sformatf("imm=%0d (0x%08h)", $signed(imm_i), imm_i);
        endcase
      end
      7'b0000011: begin // LOAD
        extra_str = $sformatf("imm=%0d (0x%08h) addr=%08h", $signed(imm_i), imm_i, W_mem_addr);
      end
      7'b0100011: begin // STORE
        extra_str = $sformatf("imm=%0d (0x%08h) addr=%08h", $signed(imm_s), imm_s, W_mem_addr);
      end
      7'b1100011: begin // BRANCH
        extra_str = $sformatf("imm=%0d (0x%08h) tgt~=%08h", $signed(imm_b), imm_b, W_PC_out + imm_b);
      end
      7'b0010111, 7'b0110111: begin // AUIPC/LUI
        extra_str = $sformatf("imm=%0d (0x%08h)", $signed(imm_u), imm_u);
      end
      7'b1101111: begin // JAL
        extra_str = $sformatf("imm=%0d (0x%08h) tgt~=%08h", $signed(imm_j), imm_j, W_PC_out + imm_j);
      end
      7'b1100111: begin // JALR
        extra_str = $sformatf("imm=%0d (0x%08h) tgt~=%08h",
                              $signed(imm_i), imm_i, (W_RD1 + imm_i) & 32'hFFFF_FFFE);
      end
      default: extra_str = "";
    endcase
  end

  // -------------------------------
  // SAME-CYCLE JUMP TAG: tính next_pc "kỳ vọng" trong cùng chu kỳ
  // -------------------------------
  wire [31:0] expected_seq_pc = W_PC_out + 32'd4;
  wire [31:0] tgt_now =
      (W_jalr)         ? ((W_RD1 + imm_i) & 32'hFFFF_FFFE) :
      (W_jal)          ? (W_PC_out + imm_j)                :
      (W_branch_taken) ? (W_PC_out + imm_b)                :
                         expected_seq_pc;

  wire jump_now = (tgt_now != expected_seq_pc);

  // -------------------------------
  // PC tracking / đếm / cảnh báo loop
  // -------------------------------
  always @(posedge clk) begin
    if (!rst && !finish_req) begin
      // In cảnh báo PC đổi ở chu kỳ kế tiếp (nếu có jump/branch/jalr)
      if (jump_now) begin
        $display("*** PC CHANGE NEXT: %h -> %h (Expected seq: %h) ***",
                 W_PC_out, tgt_now, expected_seq_pc);
      end

      prev_pc           <= W_PC_out;
      instruction_count <= instruction_count + 32'd1;
    end
  end

  // -------------------------------
  // LOG ĐẦY ĐỦ 2 DÒNG / CYCLE (CÓ IN IMMEDIATE + JUMP TAG CÙNG DÒNG)
  // -------------------------------
  int flush_cycles;  // Counter for pipeline flush after reaching MAX_LOG_INST
  
  always @(posedge clk) begin
    if (!rst && !finish_req) begin
      // Dòng 1
      $display("[%4d] T=%0t | %s | PC=%08h | %-10s | rs1=%2d rs2=%2d rd=%2d | ALU=%08h | RD1=%08h | RD2=%08h | %s %s",
               instruction_count, $time, phase_name, W_PC_out, instr_name,
               instruction[19:15], instruction[24:20], instruction[11:7],
               W_ALUout, W_RD1, W_RD2,
               jump_now ? "<<JUMP>>" : "",
               extra_str);

      // Dòng 2
      $display("          WB=%08h -> x%0d | RegW=%0b MemR=%0b MemW=%0b | BrTaken=%0b JAL=%0b JALR=%0b | MemA=%08h | WData=%08h | RData=%08h",
               W_WB_data, W_rd_addr,
               W_reg_write, W_mem_read, W_mem_write,
               W_branch_taken, W_jal, W_jalr,
               W_mem_addr, W_mem_wdata, W_mem_rdata);
      
      // Check if we've reached MAX_LOG_INST (instruction count at IF stage)
      if (instruction_count == MAX_LOG_INST) begin
        $display("*** Reached instruction %0d at IF stage (PC=%08h) ***", instruction_count, W_PC_out);
        $display("*** Waiting %0d cycles for pipeline to flush... ***", PIPELINE_DEPTH + 1);
        flush_cycles = 0;  // Start counting flush cycles
      end
      
      // If we've started flushing, count down
      if (instruction_count >= MAX_LOG_INST) begin
        flush_cycles = flush_cycles + 1;
        
        // After waiting for pipeline to drain, finish simulation
        if (flush_cycles >= (PIPELINE_DEPTH + 1)) begin
          finish_req <= 1'b1;
          $display("*** Pipeline flushed. Stopping simulation at T=%0t ***", $time);
          $finish;
        end
      end
    end
  end

  // -------------------------------
  // Điều kiện dừng (không in thêm sau khi finish)
  // -------------------------------
  always @(posedge clk) begin
    if (!rst && !finish_req) begin
      if (W_PC_out == prev_pc && prev_pc != 32'd0)
        same_pc_count <= same_pc_count + 8'd1;
      else
        same_pc_count <= 8'd0;

      if (same_pc_count > 8'd10 || W_PC_out >= LAST_PC_AFTER) begin
        finish_req <= 1'b1;
        if (same_pc_count > 8'd10)
          $display("*** WARNING: Possible infinite loop at PC=%h ***", W_PC_out);
        else
          $display("*** Program completed - reached end of instruction memory ***");
        $finish; // dừng ngay
      end
    end else if (rst) begin
      same_pc_count <= 8'd0;
    end
  end

  // -------------------------------
  // Init & stimulus
  // -------------------------------
  initial begin
    $timeformat(-9, 0, " ns", 10);
    clk               = 1'b0;
    rst               = 1'b1;
    finish_req        = 1'b0;

    instr_name        = "";
    phase_name        = "";
    prev_pc           = 32'd0;
    instruction_count = 32'd0;
    same_pc_count     = 8'd0;
    flush_cycles      = 0;

    // Waveform
    $dumpfile("rv32i_tb.vcd");
    $dumpvars(0, tb_rv32i_top);

    // Banner
    $display("\n========== RV32I PROCESSOR TEST ==========");
    $display("Test Program Contains:");
    $display("  - R-Type:  ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND");
    $display("  - I-Type:  ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI");
    $display("  - Load:    LB, LH, LW, LBU, LHU");
    $display("  - Store:   SB, SH, SW");
    $display("  - Branch:  BEQ, BNE, BLT, BGE, BLTU, BGEU");
    $display("  - U-Type:  LUI, AUIPC");
    $display("  - Jump:    JAL, JALR");
    $display("=================================================\n");

    // Giữ reset, rồi thả
    #100 rst = 1'b0;

    // Cho chạy đủ dài; $finish ở trên sẽ cắt ngay khi đạt điều kiện
    #5000;
    if (!finish_req) begin
      $display("\n========== TEST COMPLETED (timeout) ==========");
      $display("Total Instructions Executed: %0d", instruction_count);
      $display("Final PC: %h", W_PC_out);
      $finish;
    end
  end

endmodule
