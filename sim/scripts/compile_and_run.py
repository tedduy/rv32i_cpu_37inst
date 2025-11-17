#!/usr/bin/env python3
"""
Script to compile and run Pipeline RV32I CPU simulation
"""

import subprocess
import sys
import os
from pathlib import Path

# Colors for terminal output
class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'

def print_header(text):
    print(f"\n{Colors.HEADER}{Colors.BOLD}{'='*60}{Colors.ENDC}")
    print(f"{Colors.HEADER}{Colors.BOLD}{text:^60}{Colors.ENDC}")
    print(f"{Colors.HEADER}{Colors.BOLD}{'='*60}{Colors.ENDC}\n")

def print_success(text):
    print(f"{Colors.OKGREEN}✓ {text}{Colors.ENDC}")

def print_error(text):
    print(f"{Colors.FAIL}✗ {text}{Colors.ENDC}")

def print_info(text):
    print(f"{Colors.OKCYAN}→ {text}{Colors.ENDC}")

def run_command(cmd, cwd=None, capture_output=True, show_output=False):
    """Run shell command and return result"""
    try:
        if capture_output and not show_output:
            result = subprocess.run(
                cmd, 
                shell=True, 
                cwd=cwd, 
                capture_output=True, 
                text=True,
                check=True
            )
            return result.returncode, result.stdout, result.stderr
        else:
            result = subprocess.run(cmd, shell=True, cwd=cwd, check=True)
            return result.returncode, "", ""
    except subprocess.CalledProcessError as e:
        return e.returncode, e.stdout if capture_output else "", e.stderr if capture_output else ""

def main():
    print_header("RV32I Pipeline CPU - Compile & Simulate")
    
    # Get project paths
    script_dir = Path(__file__).parent  # sim/scripts
    sim_dir = script_dir.parent  # sim
    project_root = sim_dir.parent  # project root
    rtl_dir = project_root / "rtl"
    work_dir = sim_dir / "work"
    logs_dir = sim_dir / "logs"
    
    print_info(f"Project root: {project_root}")
    print_info(f"Simulation dir: {sim_dir}")
    
    # Create directories
    logs_dir.mkdir(exist_ok=True)
    
    # Step 1: Compile common modules
    print_header("Step 1: Compiling Common Modules")
    
    common_files = [
        rtl_dir / "common" / "adder_N_bit.sv",
        rtl_dir / "common" / "mux2to1.sv",
        rtl_dir / "common" / "mux3to1.sv",
        rtl_dir / "common" / "mux4to1.sv",
    ]
    
    for file in common_files:
        print_info(f"Compiling {file.name}...")
        ret, _, _ = run_command(f"vlog -sv -work work {file}", cwd=sim_dir)
        if ret != 0:
            print_error(f"Failed to compile {file.name}")
            return 1
    
    print_success("Common modules compiled successfully")
    
    # Step 2: Compile core modules
    print_header("Step 2: Compiling Core Modules")
    
    core_files = [
        rtl_dir / "core" / "stages" / "ALU_Unit.sv",
        rtl_dir / "core" / "stages" / "Branch_Unit.sv",
        rtl_dir / "core" / "stages" / "Jump_Unit.sv",
        rtl_dir / "core" / "stages" / "Control_Unit.sv",
        rtl_dir / "core" / "stages" / "Immediate_Generation.sv",
        rtl_dir / "core" / "stages" / "Instruction_Mem.sv",
        rtl_dir / "core" / "stages" / "Data_Memory.sv",
        rtl_dir / "core" / "stages" / "Reg_File.sv",
        rtl_dir / "core" / "stages" / "Program_Counter.sv",
        rtl_dir / "core" / "stages" / "Load_Store_Unit.sv",
    ]
    
    for file in core_files:
        print_info(f"Compiling {file.name}...")
        ret, _, _ = run_command(f"vlog -sv -work work {file}", cwd=sim_dir)
        if ret != 0:
            print_error(f"Failed to compile {file.name}")
            return 1
    
    print_success("Core modules compiled successfully")
    
    # Step 3: Compile Pipeline-specific modules
    print_header("Step 3: Compiling Pipeline Modules")
    
    pipeline_files = [
        rtl_dir / "core" / "pipeline" / "IF_ID_Register.sv",
        rtl_dir / "core" / "pipeline" / "ID_EX_Register.sv",
        rtl_dir / "core" / "pipeline" / "EX_MEM_Register.sv",
        rtl_dir / "core" / "pipeline" / "MEM_WB_Register.sv",
        rtl_dir / "core" / "hazard" / "Hazard_Detection_Unit.sv",
        rtl_dir / "core" / "hazard" / "Forwarding_Unit.sv",
    ]
    
    for file in pipeline_files:
        print_info(f"Compiling {file.name}...")
        ret, _, _ = run_command(f"vlog -sv -work work {file}", cwd=sim_dir)
        if ret != 0:
            print_error(f"Failed to compile {file.name}")
            return 1
    
    print_success("Pipeline modules compiled successfully")
    
    # Step 4: Compile top module
    print_header("Step 4: Compiling Top Module")
    
    top_file = rtl_dir / "top" / "rv32i_top.sv"
    print_info(f"Compiling {top_file.name}...")
    ret, _, _ = run_command(f"vlog -sv -work work {top_file}", cwd=sim_dir)
    if ret != 0:
        print_error(f"Failed to compile {top_file.name}")
        return 1
    
    print_success("Top module compiled successfully")
    
    # Step 5: Compile testbench
    print_header("Step 5: Compiling Testbench")
    
    tb_file = project_root / "tb" / "tb_rv32i_pipeline.sv"
    print_info(f"Compiling {tb_file.name}...")
    ret, _, _ = run_command(f"vlog -sv -work work {tb_file}", cwd=sim_dir)
    if ret != 0:
        print_error(f"Failed to compile {tb_file.name}")
        return 1
    
    print_success("Testbench compiled successfully")
    
    # Step 6: Run simulation
    print_header("Step 6: Running Simulation")
    
    log_file = logs_dir / "simulation_output.log"
    print_info(f"Output log: {log_file}")
    
    sim_cmd = f"vsim -c -lib work work.tb_rv32i_pipeline -do 'run -all; quit -f' > {log_file} 2>&1"
    print_info("Running simulation...")
    ret, _, _ = run_command(sim_cmd, cwd=sim_dir)
    
    if ret != 0:
        print_error("Simulation failed")
        return 1
    
    print_success("Simulation completed successfully")
    
    # Step 7: Parse results
    print_header("Step 7: Simulation Results")
    
    if log_file.exists():
        with open(log_file, 'r') as f:
            content = f.read()
            
            # Count instructions (look for [   N] pattern)
            import re
            inst_count = len(re.findall(r'\[\s*\d+\]', content))
            
            # Check for errors (exclude "Errors: 0" lines)
            error_lines = [line for line in content.split('\n') if 'error' in line.lower()]
            errors = len([line for line in error_lines if not re.search(r'Errors:\s*0', line)])
            
            warning_lines = [line for line in content.split('\n') if 'warning' in line.lower()]
            warnings = len([line for line in warning_lines if not re.search(r'Warnings:\s*0', line)])
            
            # Get simulation time
            time_match = re.search(r'Time:\s+(\d+)\s+ns', content)
            sim_time = time_match.group(1) if time_match else "Unknown"
            
            print_info(f"Instructions executed: {inst_count}")
            print_info(f"Simulation time: {sim_time} ns")
            print_info(f"Errors: {errors}")
            print_info(f"Warnings: {warnings}")
            
            if errors == 0:
                print_success("No errors found!")
            else:
                print_error(f"Found {errors} error(s)")
    
    print_header("Simulation Complete!")
    print_success(f"Log file saved to: {log_file}")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
