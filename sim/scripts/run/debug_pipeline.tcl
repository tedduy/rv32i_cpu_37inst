# ==============================================================================
# Pipeline Debug Script for QuestaSim (TCL)
# Compiles and launches GUI with comprehensive waveform setup
# ==============================================================================

# Setup paths
set script_dir [file dirname [info script]]
set project_root [file normalize "$script_dir/../../.."]
set rtl_dir "$project_root/rtl"
set tb_dir "$project_root/tb"
set sim_dir "$project_root/sim"
set work_dir "$sim_dir/work"
set wave_dir "$sim_dir/waveforms"

proc puts_header {text} {
    puts "========================================"
    puts $text
    puts "========================================"
}

puts_header "Pipeline Debug - QuestaSim GUI"
puts ""

# Clean previous compilation
puts "Cleaning previous build..."
if {[file exists $work_dir]} {
    cd $work_dir
    catch {vdel -all -lib work}
}
file delete -force $work_dir
file mkdir $work_dir
cd $work_dir
puts ""

# Create work library
puts "Creating work library..."
vlib work
vmap work work
puts ""

# Compile design files
puts "Compiling design files..."

set rtl_files [list \
    "$rtl_dir/common/adder_N_bit.sv" \
    "$rtl_dir/common/mux2to1.sv" \
    "$rtl_dir/common/mux4to1.sv" \
    "$rtl_dir/core/stages/ALU_Unit.sv" \
    "$rtl_dir/core/stages/Branch_Unit.sv" \
    "$rtl_dir/core/stages/Jump_Unit.sv" \
    "$rtl_dir/core/stages/Control_Unit.sv" \
    "$rtl_dir/core/stages/Immediate_Generation.sv" \
    "$rtl_dir/core/stages/Instruction_Mem.sv" \
    "$rtl_dir/core/stages/Data_Memory.sv" \
    "$rtl_dir/core/stages/Reg_File.sv" \
    "$rtl_dir/core/stages/Program_Counter.sv" \
    "$rtl_dir/core/stages/Load_Store_Unit.sv" \
    "$rtl_dir/core/stages/Complete_Functional_Units.sv" \
    "$rtl_dir/core/pipeline/IF_ID_Register.sv" \
    "$rtl_dir/core/pipeline/ID_EX_Register.sv" \
    "$rtl_dir/core/pipeline/EX_MEM_Register.sv" \
    "$rtl_dir/core/pipeline/MEM_WB_Register.sv" \
    "$rtl_dir/core/hazard/Hazard_Detection_Unit.sv" \
    "$rtl_dir/core/hazard/Forwarding_Unit.sv" \
    "$rtl_dir/top/rv32i_top.sv" \
    "$tb_dir/tb_rv32i_top.sv" \
]

foreach file $rtl_files {
    if {![file exists $file]} {
        puts "(FAIL) File not found: $file"
        exit 1
    }
    if {[catch {vlog -sv -work work $file} result]} {
        puts "(FAIL) Compilation failed for [file tail $file]"
        puts $result
        exit 1
    }
}

puts ""
puts "(OK) Compilation successful"
puts ""

# Create waveform directory
if {![file exists $wave_dir]} {
    file mkdir $wave_dir
}

# Launch GUI simulation
puts "Launching QuestaSim GUI..."
puts ""

vsim -gui work.tb_rv32i_top \
    -voptargs=+acc \
    -wlf "$wave_dir/wave.wlf" \
    +define+PIPELINE

# Configure waveform display
quietly WaveActivateNextPane {} 0

# ==============================================================================
# Clock & Reset
# ==============================================================================
add wave -noupdate -divider {Clock & Reset}
add wave -noupdate -label "CLK" /tb_rv32i_top/clk
add wave -noupdate -label "RST" /tb_rv32i_top/rst

# ==============================================================================
# Program Flow
# ==============================================================================
add wave -noupdate -divider {Program Flow}
add wave -noupdate -radix hexadecimal -label "IF_PC" /tb_rv32i_top/dut/if_pc_current
add wave -noupdate -radix hexadecimal -label "PC_Next" /tb_rv32i_top/dut/if_pc_next
add wave -noupdate -radix hexadecimal -label "IF_Instruction" /tb_rv32i_top/dut/if_instruction
add wave -noupdate -radix unsigned -label "Inst_Count" /tb_rv32i_top/instruction_count

# ==============================================================================
# Pipeline Stage PCs
# ==============================================================================
add wave -noupdate -divider {Pipeline Stage PCs}
add wave -noupdate -radix hexadecimal -label "IF_PC" /tb_rv32i_top/dut/if_pc_current
add wave -noupdate -radix hexadecimal -label "ID_PC" /tb_rv32i_top/dut/id_pc
add wave -noupdate -radix hexadecimal -label "EX_PC" /tb_rv32i_top/dut/ex_pc
add wave -noupdate -radix hexadecimal -label "MEM_PC" /tb_rv32i_top/dut/mem_pc
add wave -noupdate -radix hexadecimal -label "WB_PC" /tb_rv32i_top/dut/wb_pc

# ==============================================================================
# Hazard Detection
# ==============================================================================
add wave -noupdate -divider {Hazard Detection}
add wave -noupdate -label "Stall_PC" /tb_rv32i_top/dut/stall_pc
add wave -noupdate -label "Stall_IF_ID" /tb_rv32i_top/dut/stall_if_id
add wave -noupdate -label "Flush_ID_EX" /tb_rv32i_top/dut/flush_id_ex
add wave -noupdate -label "Flush_IF_ID" /tb_rv32i_top/dut/flush_if_id
add wave -noupdate -label "Load_Use_Hazard" /tb_rv32i_top/dut/u_hazard_detection/load_use_hazard
add wave -noupdate -label "Control_Hazard" /tb_rv32i_top/dut/u_hazard_detection/control_hazard

# ==============================================================================
# Data Forwarding
# ==============================================================================
add wave -noupdate -divider {Data Forwarding}
add wave -noupdate -radix binary -label "Forward_A_Sel" /tb_rv32i_top/dut/forward_a_sel
add wave -noupdate -radix binary -label "Forward_B_Sel" /tb_rv32i_top/dut/forward_b_sel
add wave -noupdate -radix hexadecimal -label "EX_RS1_Data" /tb_rv32i_top/dut/ex_rs1_data
add wave -noupdate -radix hexadecimal -label "EX_RS1_Forwarded" /tb_rv32i_top/dut/ex_rs1_data_forwarded
add wave -noupdate -radix hexadecimal -label "EX_RS2_Data" /tb_rv32i_top/dut/ex_rs2_data
add wave -noupdate -radix hexadecimal -label "EX_RS2_Forwarded" /tb_rv32i_top/dut/ex_rs2_data_forwarded

# ==============================================================================
# Register Addresses
# ==============================================================================
add wave -noupdate -divider {Register Addresses}
add wave -noupdate -radix unsigned -label "ID_RS1" /tb_rv32i_top/dut/id_rs1_addr
add wave -noupdate -radix unsigned -label "ID_RS2" /tb_rv32i_top/dut/id_rs2_addr
add wave -noupdate -radix unsigned -label "ID_RD" /tb_rv32i_top/dut/id_rd_addr
add wave -noupdate -radix unsigned -label "EX_RS1" /tb_rv32i_top/dut/ex_rs1_addr
add wave -noupdate -radix unsigned -label "EX_RS2" /tb_rv32i_top/dut/ex_rs2_addr
add wave -noupdate -radix unsigned -label "EX_RD" /tb_rv32i_top/dut/ex_rd_addr
add wave -noupdate -radix unsigned -label "MEM_RD" /tb_rv32i_top/dut/mem_rd_addr
add wave -noupdate -radix unsigned -label "WB_RD" /tb_rv32i_top/dut/wb_rd_addr

# ==============================================================================
# Control Signals
# ==============================================================================
add wave -noupdate -divider {Control Signals - ID Stage}
add wave -noupdate -label "ID_RegWrite" /tb_rv32i_top/dut/id_reg_write
add wave -noupdate -label "ID_MemRead" /tb_rv32i_top/dut/id_mem_read
add wave -noupdate -label "ID_MemWrite" /tb_rv32i_top/dut/id_mem_write
add wave -noupdate -label "ID_Branch" /tb_rv32i_top/dut/id_branch_en

add wave -noupdate -divider {Control Signals - EX Stage}
add wave -noupdate -label "EX_RegWrite" /tb_rv32i_top/dut/ex_reg_write
add wave -noupdate -label "EX_MemRead" /tb_rv32i_top/dut/ex_mem_read
add wave -noupdate -label "EX_MemWrite" /tb_rv32i_top/dut/ex_mem_write
add wave -noupdate -label "EX_BranchTaken" /tb_rv32i_top/dut/ex_branch_taken

# ==============================================================================
# ALU Signals
# ==============================================================================
add wave -noupdate -divider {ALU Operation}
add wave -noupdate -radix hexadecimal -label "EX_ALU_OpA" /tb_rv32i_top/dut/ex_alu_operand_a
add wave -noupdate -radix hexadecimal -label "EX_ALU_OpB" /tb_rv32i_top/dut/ex_alu_operand_b
add wave -noupdate -radix binary -label "EX_ALU_Ctrl" /tb_rv32i_top/dut/ex_alu_ctrl
add wave -noupdate -radix hexadecimal -label "EX_ALU_Result" /tb_rv32i_top/dut/ex_alu_result
add wave -noupdate -label "EX_ALU_Zero" /tb_rv32i_top/dut/ex_alu_zero

# ==============================================================================
# Memory Operations
# ==============================================================================
add wave -noupdate -divider {Memory Operations}
add wave -noupdate -radix hexadecimal -label "MEM_Address" /tb_rv32i_top/dut/mem_alu_result
add wave -noupdate -radix hexadecimal -label "MEM_WriteData" /tb_rv32i_top/dut/mem_write_data
add wave -noupdate -radix hexadecimal -label "MEM_ReadData" /tb_rv32i_top/dut/mem_read_data
add wave -noupdate -label "MEM_Read" /tb_rv32i_top/dut/mem_mem_read
add wave -noupdate -label "MEM_Write" /tb_rv32i_top/dut/mem_mem_write

# ==============================================================================
# Writeback Stage
# ==============================================================================
add wave -noupdate -divider {Writeback Stage}
add wave -noupdate -radix hexadecimal -label "WB_Data" /tb_rv32i_top/dut/wb_write_data
add wave -noupdate -radix unsigned -label "WB_RD" /tb_rv32i_top/dut/wb_rd_addr
add wave -noupdate -label "WB_RegWrite" /tb_rv32i_top/dut/wb_reg_write

# ==============================================================================
# Register File Contents (First 16 registers)
# ==============================================================================
add wave -noupdate -divider {Register File}
add wave -noupdate -radix hexadecimal -label "x0 (zero)" -itemcolor Yellow /tb_rv32i_top/dut/u_reg_file/regs(0)
add wave -noupdate -radix hexadecimal -label "x1 (ra)" /tb_rv32i_top/dut/u_reg_file/regs(1)
add wave -noupdate -radix hexadecimal -label "x2 (sp)" /tb_rv32i_top/dut/u_reg_file/regs(2)
add wave -noupdate -radix hexadecimal -label "x3" /tb_rv32i_top/dut/u_reg_file/regs(3)
add wave -noupdate -radix hexadecimal -label "x4" /tb_rv32i_top/dut/u_reg_file/regs(4)
add wave -noupdate -radix hexadecimal -label "x5" /tb_rv32i_top/dut/u_reg_file/regs(5)
add wave -noupdate -radix hexadecimal -label "x6" /tb_rv32i_top/dut/u_reg_file/regs(6)
add wave -noupdate -radix hexadecimal -label "x7" /tb_rv32i_top/dut/u_reg_file/regs(7)
add wave -noupdate -radix hexadecimal -label "x8" /tb_rv32i_top/dut/u_reg_file/regs(8)
add wave -noupdate -radix hexadecimal -label "x9" /tb_rv32i_top/dut/u_reg_file/regs(9)
add wave -noupdate -radix hexadecimal -label "x10" /tb_rv32i_top/dut/u_reg_file/regs(10)
add wave -noupdate -radix hexadecimal -label "x11" /tb_rv32i_top/dut/u_reg_file/regs(11)
add wave -noupdate -radix hexadecimal -label "x12" /tb_rv32i_top/dut/u_reg_file/regs(12)
add wave -noupdate -radix hexadecimal -label "x13" /tb_rv32i_top/dut/u_reg_file/regs(13)
add wave -noupdate -radix hexadecimal -label "x14" /tb_rv32i_top/dut/u_reg_file/regs(14)
add wave -noupdate -radix hexadecimal -label "x15" /tb_rv32i_top/dut/u_reg_file/regs(15)

# Configure wave window
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 200
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 10
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update

puts ""
puts "(OK) Waveform configured with comprehensive debug signals"
puts ""
puts "Ready to debug! Click 'Run -All' to start simulation."
puts ""

# Note: GUI stays open, don't exit
