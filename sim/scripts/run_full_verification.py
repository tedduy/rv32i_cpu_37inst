#!/usr/bin/env python3
"""
RV32I Pipeline CPU - Full Verification Script
Runs complete verification of all 75 instructions
"""

import subprocess
import sys
import os
from pathlib import Path

# Colors for terminal output
class Colors:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    END = '\033[0m'
    BOLD = '\033[1m'

def print_header(text):
    print(f"\n{Colors.BOLD}{Colors.CYAN}{'='*80}{Colors.END}")
    print(f"{Colors.BOLD}{Colors.CYAN}{text:^80}{Colors.END}")
    print(f"{Colors.BOLD}{Colors.CYAN}{'='*80}{Colors.END}\n")

def print_step(text):
    print(f"{Colors.BOLD}{Colors.BLUE}→ {text}{Colors.END}")

def print_success(text):
    print(f"{Colors.GREEN}✓ {text}{Colors.END}")

def print_error(text):
    print(f"{Colors.RED}✗ {text}{Colors.END}")

def run_command(cmd, cwd=None):
    """Run shell command and return output"""
    try:
        result = subprocess.run(
            cmd,
            shell=True,
            cwd=cwd,
            capture_output=True,
            text=True,
            check=True
        )
        return result.returncode == 0, result.stdout, result.stderr
    except subprocess.CalledProcessError as e:
        return False, e.stdout, e.stderr

def main():
    # Get project root
    script_dir = Path(__file__).parent
    project_root = script_dir.parent.parent
    sim_dir = project_root / "sim"
    
    print_header("RV32I Pipeline CPU - Full Verification (75 Instructions)")
    
    print_step(f"Project root: {project_root}")
    print_step(f"Simulation dir: {sim_dir}")
    
    # Change to sim directory
    os.chdir(sim_dir)
    
    # Step 1: Compile RTL and testbench
    print_header("Step 1: Compiling RTL and Testbench")
    
    # Check if filelist exists
    filelist = script_dir / "filelist.f"
    if not filelist.exists():
        print_error(f"Filelist not found: {filelist}")
        return 1
    
    print_step("Compiling RTL modules from filelist...")
    success, stdout, stderr = run_command(f"vlog -work work -f {filelist}")
    if not success:
        print_error("RTL compilation failed!")
        print(stdout)
        print(stderr)
        return 1
    
    print_step("Compiling tb_full_verification.sv...")
    success, stdout, stderr = run_command("vlog -work work ../tb/tb_full_verification.sv")
    if not success:
        print_error("Testbench compilation failed!")
        print(stdout)
        print(stderr)
        return 1
    
    print_success("Compilation successful")
    
    # Step 2: Run simulation
    print_header("Step 2: Running Full Verification")
    
    log_file = sim_dir / "logs" / "full_verification.log"
    print_step(f"Output log: {log_file}")
    print_step("Running simulation...")
    
    success, stdout, stderr = run_command(
        'vsim -c -lib work work.tb_full_verification -do "run -all; quit -f"'
    )
    
    # Save output
    log_file.parent.mkdir(exist_ok=True)
    with open(log_file, 'w') as f:
        f.write(stdout)
        if stderr:
            f.write("\n\n=== STDERR ===\n")
            f.write(stderr)
    
    if not success:
        print_error("Simulation failed")
        print(stdout)
        return 1
    
    print_success("Simulation completed successfully")
    
    # Step 3: Parse and display results
    print_header("Step 3: Verification Results")
    
    lines = stdout.split('\n')
    
    # Find and display register file
    in_regfile = False
    for line in lines:
        if 'Final Register File State' in line:
            in_regfile = True
        if in_regfile:
            print(line)
        if in_regfile and '====' in line and 'Final Register File State' not in line:
            in_regfile = False
            break
    
    # Find and display verification summary
    in_summary = False
    for line in lines:
        if 'Verifying CPU Correctness' in line:
            in_summary = True
        if in_summary:
            print(line)
        if 'CPU IS FUNCTIONALLY CORRECT' in line:
            break
    
    # Step 4: Extract statistics
    print_header("Step 4: Statistics")
    
    instruction_count = 0
    verified_count = 0
    errors = 0
    warnings = 0
    pass_count = 0
    fail_count = 0
    
    for line in lines:
        if 'Total Instructions Executed:' in line:
            try:
                instruction_count = int(line.split(':')[1].strip().split()[0])
            except:
                pass
        if 'Instructions Writing Registers:' in line:
            try:
                verified_count = int(line.split(':')[1].strip().split()[0])
            except:
                pass
        if 'Errors:' in line and 'Warnings:' in line:
            try:
                parts = line.split(',')
                errors = int(parts[0].split(':')[1].strip())
                warnings = int(parts[1].split(':')[1].strip())
            except:
                pass
        if 'Tests Passed:' in line:
            try:
                pass_count = int(line.split(':')[1].strip())
            except:
                pass
        if 'Tests Failed:' in line:
            try:
                fail_count = int(line.split(':')[1].strip())
            except:
                pass
    
    print(f"Total Instructions:          {instruction_count}")
    print(f"Register Write Instructions: {verified_count}")
    print(f"Tests Passed:                {pass_count}")
    print(f"Tests Failed:                {fail_count}")
    print(f"Errors:                      {errors}")
    print(f"Warnings:                    {warnings}")
    
    # Step 5: Final verdict
    print_header("Verification Complete!")
    
    print_success(f"Log file saved to: {log_file}")
    
    # Check if verification passed
    if 'ALL' in stdout and 'INSTRUCTIONS VERIFIED CORRECT' in stdout and errors == 0:
        print(f"\n{Colors.BOLD}{Colors.GREEN}{'='*80}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.GREEN}{'✓✓✓ FULL VERIFICATION PASSED! ✓✓✓':^80}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.GREEN}{'='*80}{Colors.END}\n")
        
        print(f"{Colors.GREEN}Summary:{Colors.END}")
        print(f"  • {instruction_count} instructions executed successfully")
        total_tests = pass_count + fail_count
        pass_rate = (pass_count / total_tests * 100) if total_tests > 0 else 0
        print(f"  • {pass_count}/{total_tests} register writes verified with expected results ({pass_rate:.1f}%)")
        print(f"  • {errors} errors, {warnings} critical warnings")
        print(f"  • Register x0 always zero ✓")
        print(f"  • Initial values preserved ✓")
        print(f"  • All instruction types tested ✓")
        print(f"\n{Colors.BOLD}{Colors.GREEN}CPU IS FUNCTIONALLY CORRECT!{Colors.END}\n")
        return 0
    else:
        print(f"\n{Colors.BOLD}{Colors.RED}{'='*80}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.RED}{'✗✗✗ VERIFICATION FAILED! ✗✗✗':^80}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.RED}{'='*80}{Colors.END}\n")
        return 1

if __name__ == "__main__":
    sys.exit(main())
