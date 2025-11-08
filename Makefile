# Makefile for RV32I CPU Project
# Supports ModelSim/QuestaSim simulation with TCL scripts

.PHONY: help compile sim clean gui debug tree info verify verify-quick test pipeline single-cycle

# Project directories
PROJECT_ROOT := $(shell pwd)
RTL_DIR      := $(PROJECT_ROOT)/rtl
TB_DIR       := $(PROJECT_ROOT)/tb
SIM_DIR      := $(PROJECT_ROOT)/sim
WORK_DIR     := $(SIM_DIR)/work
WAVE_DIR     := $(SIM_DIR)/waveforms
SCRIPT_DIR   := $(SIM_DIR)/scripts

# Tools
VSIM   := vsim
TCLSH  := tclsh

# Default target
help:
	@echo "========================================"
	@echo "RV32I CPU - Makefile Targets (TCL)"
	@echo "========================================"
	@echo "make compile      - Compile RTL and testbench (TCL)"
	@echo "make sim          - Run pipeline simulation"
	@echo "make gui          - Run simulation with GUI"
	@echo "make debug        - Debug mode with waveforms"
	@echo "make verify       - Full verification (SC vs PL)"
	@echo "make verify-quick - Quick verification check"
	@echo "make test         - Run test suite"
	@echo "make pipeline     - Run pipeline simulation"
	@echo "make single-cycle - Run single-cycle simulation"
	@echo "make clean        - Clean simulation files"
	@echo "make tree         - Show project structure"
	@echo "make info         - Show project information"
	@echo "make all          - Full compile and verify"
	@echo "========================================"

# Compile RTL and testbench using TCL script
compile:
	@echo "Compiling RV32I CPU with TCL..."
	@cd $(SIM_DIR) && $(VSIM) -c -do "do scripts/compile/compile.tcl; quit -f"
	@echo "Compilation complete!"

# Run pipeline simulation
sim: pipeline

# Run pipeline simulation in batch mode
pipeline:
	@echo "Running pipeline simulation..."
	@cd $(SIM_DIR) && $(VSIM) -c -do "do scripts/run/run_sim.tcl -pipeline -batch; quit -f"
	@echo "Pipeline simulation complete!"

# Run single-cycle simulation in batch mode
single-cycle:
	@echo "Running single-cycle simulation..."
	@cd $(SIM_DIR) && $(VSIM) -c -do "do scripts/run/run_sim.tcl -single-cycle -batch; quit -f"
	@echo "Single-cycle simulation complete!"

# Run simulation in GUI mode
gui:
	@echo "Opening GUI..."
	@cd $(SIM_DIR) && $(VSIM) -do "do scripts/run/run_sim.tcl -gui"

# Debug mode with comprehensive waveforms
debug:
	@echo "Launching debug mode with waveforms..."
	@cd $(SIM_DIR) && $(VSIM) -do "do scripts/run/debug_pipeline.tcl"

# Clean simulation files
clean:
	@echo "Cleaning simulation files..."
	@rm -rf $(WORK_DIR)
	@rm -rf $(WAVE_DIR)/*.wlf
	@rm -rf $(WAVE_DIR)/*.vcd
	@rm -rf $(SIM_DIR)/transcript
	@rm -rf $(SIM_DIR)/logs/*
	@rm -rf $(SIM_DIR)/reports/*
	@rm -rf $(SIM_DIR)/coverage/*
	@rm -rf vsim.wlf transcript
	@echo "Clean complete!"

# Show project structure
tree:
	@echo "Project Structure:"
	@tree -L 3 -I 'work|.git' $(PROJECT_ROOT) || find $(PROJECT_ROOT) -maxdepth 3 -type d

# Show project information
info:
	@echo "========================================"
	@echo "RV32I CPU - Project Information"
	@echo "========================================"
	@echo "Architecture: 5-stage pipeline"
	@echo "ISA: RV32I (37 instructions)"
	@echo "Language: SystemVerilog"
	@echo "Simulator: QuestaSim/ModelSim"
	@echo ""
	@echo "Quick Start:"
	@echo "  make compile  - Compile RTL"
	@echo "  make sim      - Run simulation"
	@echo "  make verify   - Full verification"
	@echo "  make help     - Show all targets"
	@echo ""
	@echo "Documentation:"
	@echo "  README.md           - Project overview"
	@echo "  sim/README.md       - Simulation guide"
	@echo "  docs/               - Detailed documentation"
	@echo "========================================"

# Full pipeline verification (single-cycle vs pipeline) using TCL
verify:
	@echo "Running full pipeline verification (TCL)..."
	@cd $(SCRIPT_DIR)/verify && $(TCLSH) full_verify.tcl

# Quick verification (compare existing logs)
verify-quick:
	@echo "Running quick verification..."
	@cd $(SCRIPT_DIR)/verify && $(TCLSH) verify_pipeline.tcl ../../logs/single_cycle_output.log ../../logs/pipeline_output.log

# Verify final state (registers and memory)
verify-final:
	@echo "Verifying final state..."
	@cd $(SCRIPT_DIR)/verify && $(TCLSH) verify_final_state.tcl

# Test suite (full verification)
test: verify

# Compile and run full verification
all: compile verify
