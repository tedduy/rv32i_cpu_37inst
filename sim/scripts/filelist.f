# RV32I CPU RTL File List
# Compile order for SystemVerilog modules
# Paths relative to project root

# ============================================
# 1. Common Utilities (no dependencies)
# ============================================
../../rtl/common/adder_N_bit.sv
../../rtl/common/mux2to1.sv
../../rtl/common/mux3to1.sv
../../rtl/common/mux4to1.sv

# ============================================
# 2. Core Stage Modules
# ============================================
../../rtl/core/stages/Program_Counter.sv
../../rtl/core/stages/Instruction_Mem.sv
../../rtl/core/stages/Control_Unit.sv
../../rtl/core/stages/Reg_File.sv
../../rtl/core/stages/Immediate_Generation.sv
../../rtl/core/stages/ALU_Unit.sv
../../rtl/core/stages/Branch_Unit.sv
../../rtl/core/stages/Jump_Unit.sv
../../rtl/core/stages/Data_Memory.sv
../../rtl/core/stages/Load_Store_Unit.sv

# ============================================
# 3. Pipeline Registers
# ============================================
../../rtl/core/pipeline/IF_ID_Register.sv
../../rtl/core/pipeline/ID_EX_Register.sv
../../rtl/core/pipeline/EX_MEM_Register.sv
../../rtl/core/pipeline/MEM_WB_Register.sv

# ============================================
# 4. Hazard Handling Units
# ============================================
../../rtl/core/hazard/Hazard_Detection_Unit.sv
../../rtl/core/hazard/Forwarding_Unit.sv

# ============================================
# 5. Top-Level Module
# ============================================
../../rtl/top/rv32i_top.sv

# ============================================
# 6. Testbench
# ============================================
../../tb/tb_rv32i_top.sv

# ============================================
# Optional: Single-Cycle Version
# ============================================
# rtl/top/rv32i_top_single_cycle.sv
