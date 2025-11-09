# =============================================================================
# Makefile for RV32I UVM Testbench
# =============================================================================
# Simulator: QuestaSim/ModelSim
# Language: SystemVerilog with UVM
# =============================================================================

# ==============================================================================
# Configuration
# ==============================================================================

# Simulator
SIM = vsim
VLOG = vlog
VLIB = vlib
VMAP = vmap

# Directories
RTL_DIR = ../rtl
TB_DIR = .
WORK_DIR = work
WAVE_DIR = waves
LOG_DIR = logs

# UVM Home (adjust based on your QuestaSim installation)
UVM_HOME = $(QUESTA_HOME)/verilog_src/uvm-1.2

# Compilation flags
VLOG_FLAGS = -sv
VLOG_FLAGS += +incdir+$(UVM_HOME)/src
VLOG_FLAGS += +define+UVM_NO_DPI
VLOG_FLAGS += -work $(WORK_DIR)
VLOG_FLAGS += -timescale=1ns/1ps
VLOG_FLAGS += +acc

# Simulation flags
VSIM_FLAGS = -work $(WORK_DIR)
VSIM_FLAGS += -voptargs=+acc
VSIM_FLAGS += -classdebug
VSIM_FLAGS += -uvmcontrol=all
VSIM_FLAGS += +UVM_TESTNAME=$(TEST)
VSIM_FLAGS += +UVM_VERBOSITY=$(VERBOSITY)

# Default test and verbosity
TEST ?= tc_1_1_1_add_test
VERBOSITY ?= UVM_MEDIUM

# GUI mode (set to 1 for GUI, 0 for batch)
GUI ?= 0

ifeq ($(GUI),1)
    VSIM_GUI = 
else
    VSIM_GUI = -c -do "run -all; quit -f"
endif

# ==============================================================================
# File Lists
# ==============================================================================

# RTL source files (order matters for dependencies)
RTL_SOURCES = \
	$(RTL_DIR)/adder_N_bit.sv \
	$(RTL_DIR)/mux2to1.sv \
	$(RTL_DIR)/mux4to1.sv \
	$(RTL_DIR)/Program_Counter.sv \
	$(RTL_DIR)/Instruction_Mem.sv \
	$(RTL_DIR)/Reg_File.sv \
	$(RTL_DIR)/Immediate_Generation.sv \
	$(RTL_DIR)/Control_Unit.sv \
	$(RTL_DIR)/ALU_Unit.sv \
	$(RTL_DIR)/Branch_Unit.sv \
	$(RTL_DIR)/Jump_Unit.sv \
	$(RTL_DIR)/Load_Store_Unit.sv \
	$(RTL_DIR)/Data_Memory.sv \
	$(RTL_DIR)/top/rv32i_top_pipeline.sv

# Testbench source files
TB_SOURCES = \
	$(TB_DIR)/interfaces/rv32i_if.sv \
	$(TB_DIR)/rv32i_pkg.sv \
	$(TB_DIR)/tb_rv32i_uvm.sv

# ==============================================================================
# Targets
# ==============================================================================

.PHONY: all clean compile sim run help

# Default target
all: compile

# Help target
help:
	@echo "==================================================================="
	@echo "  RV32I UVM Testbench Makefile"
	@echo "==================================================================="
	@echo "  Targets:"
	@echo "    make compile         - Compile RTL and testbench"
	@echo "    make sim             - Compile and run simulation"
	@echo "    make run             - Run simulation (no recompile)"
	@echo "    make clean           - Clean generated files"
	@echo "    make help            - Show this help"
	@echo ""
	@echo "  Options:"
	@echo "    TEST=<test_name>     - Specify test to run (default: $(TEST))"
	@echo "    VERBOSITY=<level>    - Set UVM verbosity (default: $(VERBOSITY))"
	@echo "                          Levels: UVM_NONE, UVM_LOW, UVM_MEDIUM,"
	@echo "                                  UVM_HIGH, UVM_FULL, UVM_DEBUG"
	@echo "    GUI=1                - Run with GUI (default: 0)"
	@echo ""
	@echo "  Examples:"
	@echo "    make sim TEST=tc_1_1_1_add_test"
	@echo "    make sim TEST=tc_1_1_1_add_test VERBOSITY=UVM_HIGH"
	@echo "    make sim TEST=tc_1_1_1_add_test GUI=1"
	@echo "==================================================================="

# Create directories
$(WORK_DIR):
	@echo "[Makefile] Creating work library..."
	@$(VLIB) $(WORK_DIR)
	@mkdir -p $(WAVE_DIR) $(LOG_DIR)

# Compile RTL and testbench
compile: $(WORK_DIR)
	@echo "[Makefile] Compiling UVM library..."
	@$(VLOG) $(VLOG_FLAGS) $(UVM_HOME)/src/uvm_pkg.sv
	@echo ""
	@echo "[Makefile] Compiling RTL files..."
	@$(VLOG) $(VLOG_FLAGS) $(RTL_SOURCES)
	@echo ""
	@echo "[Makefile] Compiling testbench files..."
	@$(VLOG) $(VLOG_FLAGS) $(TB_SOURCES)
	@echo ""
	@echo "[Makefile] Compilation complete!"
	@echo ""

# Run simulation
run:
	@echo "[Makefile] Running test: $(TEST)"
	@echo "[Makefile] Verbosity: $(VERBOSITY)"
	@echo ""
	@$(SIM) $(VSIM_FLAGS) $(VSIM_GUI) tb_rv32i_top

# Compile and run
sim: compile run

# Clean generated files
clean:
	@echo "[Makefile] Cleaning generated files..."
	@rm -rf $(WORK_DIR)
	@rm -rf $(WAVE_DIR)
	@rm -rf $(LOG_DIR)
	@rm -rf transcript
	@rm -rf vsim.wlf
	@rm -rf *.log
	@rm -rf modelsim.ini
	@echo "[Makefile] Clean complete!"

# ==============================================================================
# Additional Targets
# ==============================================================================

# Run with waveform dump
wave: VSIM_FLAGS += +DUMP_VCD
wave: compile
	@$(SIM) $(VSIM_FLAGS) tb_rv32i_top -do "log -r /*; run -all; quit -f"
	@echo "[Makefile] Waveform saved to waveform.vcd"

# Run regression (all tests)
regression:
	@echo "[Makefile] Running regression tests..."
	@make sim TEST=tc_1_1_1_add_test VERBOSITY=UVM_LOW
	# TODO: Add more tests here
	@echo "[Makefile] Regression complete!"

# View waveform
view_wave:
	@if [ -f vsim.wlf ]; then \
		$(SIM) -view vsim.wlf; \
	else \
		echo "[Makefile] ERROR: No waveform file found!"; \
	fi
