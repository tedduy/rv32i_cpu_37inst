// =============================================================================
// RV32I CPU Compilation File List
// =============================================================================
// Usage: vlog -f compile.f
// Note: UVM library is compiled separately in Makefile
// =============================================================================

// Include directories for packages
+incdir+./rtl
+incdir+./tb
+incdir+./tb/components
+incdir+./tb/sequences
+incdir+./tb/tests

// =============================================================================
// RTL Package (definitions only - no modules)
// =============================================================================
./rtl/rtl_pkg.sv

// =============================================================================
// RTL Design Modules (compiled after package)
// =============================================================================

// Common modules
./rtl/common/adder_N_bit.sv
./rtl/common/mux2to1.sv
./rtl/common/mux3to1.sv
./rtl/common/mux4to1.sv

// Core - Stages
./rtl/core/stages/Program_Counter.sv
./rtl/core/stages/Instruction_Mem.sv
./rtl/core/stages/Reg_File.sv
./rtl/core/stages/Immediate_Generation.sv
./rtl/core/stages/Control_Unit.sv
./rtl/core/stages/ALU_Unit.sv
./rtl/core/stages/Branch_Unit.sv
./rtl/core/stages/Jump_Unit.sv
./rtl/core/stages/Load_Store_Unit.sv
./rtl/core/stages/Data_Memory.sv

// Core - Pipeline registers
./rtl/core/pipeline/IF_ID_Register.sv
./rtl/core/pipeline/ID_EX_Register.sv
./rtl/core/pipeline/EX_MEM_Register.sv
./rtl/core/pipeline/MEM_WB_Register.sv

// Core - Hazard handling
./rtl/core/hazard/Hazard_Detection_Unit.sv
./rtl/core/hazard/Forwarding_Unit.sv

// Top level design (pipeline version)
./rtl/top/rv32i_top.sv

// =============================================================================
// Testbench Packages
// =============================================================================
./tb/components/component_pkg.sv
./tb/sequences/seq_pkg.sv
./tb/tests/test_pkg.sv
./tb/tb_pkg.sv

// =============================================================================
// Master Package (imports all sub-packages)
// =============================================================================
./rv32i_pkg.sv

// =============================================================================
// Interface
// =============================================================================
./tb/interfaces/rv32i_if.sv

// =============================================================================
// Testbench Top
// =============================================================================
./tb/tb_rv32i_top.sv
