# =============================================================================
# Makefile for RV32I UVM Testbench
# =============================================================================
# Simulator: QuestaSim
# Uses compile.f for file list management
# All logs and work library in logs/ directory
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
RTL_DIR = rtl
TB_DIR = tb
SCRIPTS_DIR = scripts
LOG_DIR = logs
WORK_DIR = $(LOG_DIR)/work
WAVE_DIR = $(LOG_DIR)/waves
GOLDEN_LOG_DIR = $(LOG_DIR)/golden
NORMAL_LOG_DIR = $(LOG_DIR)/normal

# Compilation file
COMPILE_FILE = compile.f

# UVM Home (adjust based on your QuestaSim installation)
#UVM_HOME ?= C:/questasim64_2024.1/verilog_src/uvm-1.1d
UVM_HOME ?= /home/buuduy/questasim/verilog_src/uvm-1.1d

# Compilation flags
VLOG_FLAGS = -sv
VLOG_FLAGS += -work $(WORK_DIR)
VLOG_FLAGS += -timescale=1ns/1ps
VLOG_FLAGS += +acc
VLOG_FLAGS += +define+UVM_NO_DPI
VLOG_FLAGS += -suppress 2892,13314
VLOG_FLAGS += -L $(WORK_DIR)

# Coverage options (enable with COVERAGE=1)
ifeq ($(COVERAGE),1)
    VLOG_FLAGS += +cover=sbceft
    VSIM_FLAGS_COV = -coverage
    COV_ENABLED = yes
else
    COV_ENABLED = no
endif

# Simulation flags
VSIM_FLAGS = -work $(WORK_DIR)
VSIM_FLAGS += -voptargs=+acc
VSIM_FLAGS += -classdebug
VSIM_FLAGS += -uvmcontrol=all
VSIM_FLAGS += +UVM_TESTNAME=$(TEST)
VSIM_FLAGS += +UVM_VERBOSITY=$(VERBOSITY)
VSIM_FLAGS += $(VSIM_FLAGS_COV)
VSIM_FLAGS += -suppress 12110

# Determine log directory based on test type
ifeq ($(findstring golden,$(TEST)),golden)
    TEST_LOG_DIR = $(GOLDEN_LOG_DIR)
else
    TEST_LOG_DIR = $(NORMAL_LOG_DIR)
endif

VSIM_FLAGS += -logfile $(TEST_LOG_DIR)/sim_$(TEST).log
VSIM_FLAGS += -wlf $(WAVE_DIR)/$(TEST).wlf

# Default test and verbosity
TEST ?= tc_1_1_1_add_golden_test
VERBOSITY ?= UVM_MEDIUM

# GUI mode (set to 1 for GUI, 0 for batch)
GUI ?= 0

ifeq ($(GUI),1)
    VSIM_GUI = 
else
    VSIM_GUI = -c -do "run -all; quit -f"
endif

# ==============================================================================
# Targets
# ==============================================================================

.PHONY: all clean compile sim run help setup gen_golden check_golden run_all_golden run_all_tests run_all coverage_report coverage_merge regression_coverage view_wave

# Default target
all: setup compile

# Setup: Generate golden references if not exist
setup:
	@echo "==================================================================="
	@echo "  RV32I CPU Setup"
	@echo "==================================================================="
	@if [ ! -d "tb/tests/golden" ] || [ -z "$$(ls -A tb/tests/golden/*.log 2>/dev/null)" ]; then \
		echo "[Setup] Golden reference files not found."; \
		echo "[Setup] Generating golden references..."; \
		cd $(SCRIPTS_DIR) && python gen_golden.py; \
		echo "[Setup] Golden references generated successfully!"; \
	else \
		echo "[Setup] Golden reference files already exist. Skipping generation."; \
	fi
	@echo "==================================================================="
	@echo ""

# Generate golden references (force regenerate)
gen_golden:
	@echo "[Makefile] Generating golden reference files..."
	@cd $(SCRIPTS_DIR) && python gen_golden.py
	@echo "[Makefile] Golden references generated!"

# Check if golden files exist
check_golden:
	@if [ ! -d "tb/tests/golden" ] || [ -z "$$(ls -A tb/tests/golden/*_golden.log 2>/dev/null)" ]; then \
		echo ""; \
		echo "==================== WARNING ===================="; \
		echo "  Golden reference files not found!"; \
		echo "  Run: make gen_golden"; \
		echo "  Or:  make setup"; \
		echo "================================================="; \
		echo ""; \
		exit 1; \
	fi

# Help target
help:
	@echo "==================================================================="
	@echo "  RV32I UVM Testbench Makefile"
	@echo "==================================================================="
	@echo "  Quick Start:"
	@echo "    make setup           - Generate golden files (first time setup)"
	@echo "    make compile         - Compile RTL and testbench"
	@echo "    make run TEST=<name> - Run specific test"
	@echo "    make run_all         - Run ALL 195 tests (37 golden + 158 functional)"
	@echo ""
	@echo "  Main Targets:"
	@echo "    make setup           - Auto-generate golden reference files"
	@echo "    make compile         - Compile RTL and testbench"
	@echo "    make sim             - Compile and run simulation"
	@echo "    make run             - Run simulation (no recompile)"
	@echo "    make gen_golden      - Force regenerate golden files"
	@echo "    make run_all         - Run all 195 tests (complete verification)"
	@echo "    make run_all_golden  - Run all 37 golden verification tests"
	@echo "    make run_all_tests   - Run all 158 functional tests"
	@echo "    make clean           - Remove all generated files and logs"
	@echo "    make help            - Show this help"
	@echo ""
	@echo "  Coverage & Regression (Academic):"
	@echo "    make regression_coverage - Run all tests with coverage collection"
	@echo "    make coverage_report     - Generate HTML coverage report"
	@echo "    make coverage_merge      - Merge coverage from multiple runs"
	@echo ""
	@echo "  Options:"
	@echo "    TEST=<test_name>     - Specify test to run (default: $(TEST))"
	@echo "    VERBOSITY=<level>    - Set UVM verbosity (default: $(VERBOSITY))"
	@echo "                          Levels: UVM_NONE, UVM_LOW, UVM_MEDIUM,"
	@echo "                                  UVM_HIGH, UVM_FULL, UVM_DEBUG"
	@echo "    GUI=1                - Run with GUI (default: 0)"
	@echo "    COVERAGE=1           - Enable coverage collection"
	@echo ""
	@echo "  Examples:"
	@echo "    make setup                                    # First time setup"
	@echo "    make compile                                  # Compile design"
	@echo "    make run_all                                  # Run ALL 195 tests"
	@echo "    make run_all_golden                          # Run all 37 golden tests"
	@echo "    make run_all_tests                           # Run all 158 functional tests"
	@echo "    make run TEST=tc_1_1_1_add_golden_test       # Run golden test"
	@echo "    make run TEST=tc_1_1_1_add_test              # Run functional test"
	@echo "    make sim TEST=tc_1_1_1_add_test GUI=1        # Run with GUI"
	@echo "    make regression_coverage                      # Full regression + coverage"
	@echo "==================================================================="

# Create directories and work library
$(WORK_DIR):
	@echo "[Makefile] Creating directory structure..."
	@mkdir -p $(LOG_DIR)
	@mkdir -p $(WAVE_DIR)
	@mkdir -p $(GOLDEN_LOG_DIR)
	@mkdir -p $(NORMAL_LOG_DIR)
	@echo "[Makefile] Creating work library in $(WORK_DIR)..."
	@$(VLIB) $(WORK_DIR)
	@echo "[Makefile] Directory setup complete!"
	@echo ""

# Compile RTL and testbench using compile.f
# Combine UVM package and design file compilation into a single ordered
# vlog invocation to avoid duplicated compilation order issues and to
# ensure the UVM package is available before files that import it.
compile: $(WORK_DIR)
	@echo "==================================================================="
	@echo "  Compiling RV32I CPU with Package Structure"
	@echo "==================================================================="
	@echo "[Makefile] Compiling UVM package + design files (single step)..."
	@echo "[Makefile] Using compilation file: $(COMPILE_FILE)"
	@echo "[Makefile] Work library: $(WORK_DIR)"
	@echo ""
	@bash -c 'set -o pipefail; $(VLOG) $(VLOG_FLAGS) +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm_pkg.sv -f $(COMPILE_FILE) 2>&1 | tee $(LOG_DIR)/compile.log'
	@rc=$$?; \
	if [ $$rc -eq 0 ]; then \
		echo "==================================================================="; \
		echo "  ✓ Compilation Successful!"; \
		echo "==================================================================="; \
	else \
		echo "==================================================================="; \
		echo "  ✗ Compilation Failed! Check $(LOG_DIR)/compile.log"; \
		echo "==================================================================="; \
		exit $$rc; \
	fi
	@echo ""

# Run simulation
run:
	@echo "==================================================================="
	@echo "  Running Test: $(TEST)"
	@echo "  Verbosity: $(VERBOSITY)"
	@echo "==================================================================="
	@mkdir -p $(GOLDEN_LOG_DIR) $(NORMAL_LOG_DIR) $(WAVE_DIR)
	@$(SIM) $(VSIM_FLAGS) $(VSIM_GUI) tb_rv32i_top
	@# Move stacktrace files to logs directory if they exist
	@-mv -f vish_stacktrace.vstf $(LOG_DIR)/ 2>/dev/null || true
	@-mv -f vsim_stacktrace.vstf $(LOG_DIR)/ 2>/dev/null || true
	@echo ""
	@echo "  Log file: $(TEST_LOG_DIR)/sim_$(TEST).log"
	@echo "  Waveform: $(WAVE_DIR)/$(TEST).wlf"
	@echo "==================================================================="
	@echo ""

# Compile and run
sim: compile run

# Clean generated files
clean:
	@echo "[Makefile] Cleaning all generated files..."
	@echo "[Makefile] Removing logs directory..."
	@-rm -rf $(LOG_DIR)
	@-rm -rf transcript vsim.wlf modelsim.ini *.log
	@-rm -rf vish_stacktrace.vstf vsim_stacktrace.vstf
	@echo "[Makefile] Clean complete!"
	@echo ""

# ==============================================================================
# Additional Targets
# ==============================================================================

# Run with waveform dump
wave: VSIM_FLAGS += +DUMP_VCD
wave: compile
	@mkdir -p $(WAVE_DIR)
	@$(SIM) $(VSIM_FLAGS) tb_rv32i_top -do "log -r /*; run -all; quit -f"
	@echo "[Makefile] Waveform saved to $(WAVE_DIR)/$(TEST).wlf"
	@echo ""

# Run regression (all tests)
regression: compile
	@echo "[Makefile] Running regression tests..."
	@make run TEST=tc_1_1_1_add_golden_test VERBOSITY=UVM_LOW
	# TODO: Add more tests here
	@echo "[Makefile] Regression complete!"

# Run all 37 golden verification tests
run_all_golden: check_golden compile
	@echo "==================================================================="
	@echo "  Running All 37 Golden Verification Tests"
	@echo "==================================================================="
	@bash $(SCRIPTS_DIR)/run_golden_tests.sh
	@echo ""
	@echo "==================================================================="
	@echo "  Golden Test Suite Complete!"
	@echo "==================================================================="

# Run all 158 functional tests
run_all_tests: compile
	@echo "==================================================================="
	@echo "  Running All 158 Functional Tests"
	@echo "==================================================================="
	@if [ -f $(SCRIPTS_DIR)/run_normal_tests.sh ]; then \
		bash $(SCRIPTS_DIR)/run_normal_tests.sh; \
	else \
		echo ""; \
		echo "  Note: No comprehensive test script found."; \
		echo "  Running sample tests instead..."; \
		echo ""; \
		make run TEST=tc_1_1_1_add_test VERBOSITY=UVM_LOW; \
		echo ""; \
	fi
	@echo ""
	@echo "==================================================================="
	@echo "  Functional Test Suite Complete!"
	@echo "==================================================================="

# Run ALL 195 tests (37 golden + 158 functional)
run_all: check_golden compile
	@echo ""
	@bash $(SCRIPTS_DIR)/run_golden_tests.sh
	@echo ""
	@bash $(SCRIPTS_DIR)/run_normal_tests.sh
	@echo ""

# ==============================================================================
# Coverage Targets (Academic/Research)
# ==============================================================================

# Generate coverage report
coverage_report:
	@echo "==================================================================="
	@echo "  Generating Coverage Report"
	@echo "==================================================================="
	@mkdir -p $(LOG_DIR)/coverage
	@vcover report -html -output $(LOG_DIR)/coverage/html $(WORK_DIR)/covdb
	@echo ""
	@echo "  Coverage report generated: $(LOG_DIR)/coverage/html/index.html"
	@echo "==================================================================="

# Merge coverage from all tests
coverage_merge:
	@echo "==================================================================="
	@echo "  Merging Coverage Data"
	@echo "==================================================================="
	@mkdir -p $(LOG_DIR)/coverage
	@vcover merge -out $(LOG_DIR)/coverage/merged.ucdb $(WORK_DIR)/covdb
	@echo "  Coverage data merged: $(LOG_DIR)/coverage/merged.ucdb"
	@echo "==================================================================="

# Run regression with coverage
regression_coverage: clean
	@echo "==================================================================="
	@echo "  Running Regression with Coverage Collection"
	@echo "==================================================================="
	@$(MAKE) compile COVERAGE=1
	@$(MAKE) run_all COVERAGE=1
	@$(MAKE) coverage_report
	@echo ""
	@echo "==================================================================="
	@echo "  Regression with Coverage Complete!"
	@echo "  Report: $(LOG_DIR)/coverage/html/index.html"
	@echo "==================================================================="

# Extract coverage
extract_coverage:
	@bash $(SCRIPTS_DIR)/extract_coverage.sh
	@echo "Functional coverage summary saved to logs/coverage/regression_coverage.log"

# View waveform
view_wave:
	@if [ -f $(WAVE_DIR)/$(TEST).wlf ]; then \
		$(SIM) -view $(WAVE_DIR)/$(TEST).wlf; \
	else \
		echo "[Makefile] ERROR: No waveform file found for $(TEST)!"; \
		echo "[Makefile] Available waveforms:"; \
		ls -1 $(WAVE_DIR)/*.wlf 2>/dev/null || echo "  (none)"; \
	fi
