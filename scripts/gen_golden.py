#!/usr/bin/env python3
"""
Generate Golden References for All Tests
Uses Python RV32I simulator - no Spike needed
"""

import os
import sys
from rv32i_sim import RV32I
from test_definitions import ALL_TESTS


def generate_all_golden_refs(output_dir="../tb/tests/golden"):
    """Generate golden reference files"""
    
    os.makedirs(output_dir, exist_ok=True)
    
    print("=" * 80)
    print("  Generating Golden References")
    print("=" * 80)
    print()
    
    total = len(ALL_TESTS)
    success = 0
    
    for i, (test_name, test_info) in enumerate(ALL_TESTS.items(), 1):
        print(f"[{i:3d}/{total}] {test_name:40s} ", end="", flush=True)
        
        try:
            cpu = RV32I()
            
            # Initialize registers and memory
            for key, val in test_info.get('init', {}).items():
                if key.startswith('x'):
                    cpu.x[int(key[1:])] = val
                elif key == 'mem':
                    for addr, data in val.items():
                        cpu.mem_write(addr, data, 4)
            
            # Run program
            log = cpu.run(test_info['code'])
            
            # Write golden log
            output_file = os.path.join(output_dir, f"{test_name}_golden.log")
            with open(output_file, 'w') as f:
                f.write(f"# RV32I Golden Reference\n")
                f.write(f"# Test: {test_name}\n")
                f.write(f"# Description: {test_info['desc']}\n")
                f.write(f"# Instructions: {len(log)}\n#\n")
                f.write("# PC       INST     RD RD_VALUE  MW MEM_ADDR MEM_DATA\n")
                
                for e in log:
                    line = f"{e['pc']:08x} {e['inst']:08x} "
                    line += f"{e['rd']:02d} {e['rd_val']:08x} " if e['rd_w'] else "-- -------- "
                    line += f"W {e['mem_addr']:08x} {e['mem_data']:08x}" if e['mem_w'] else "- -------- --------"
                    f.write(line + "\n")
            
            print(f"[OK] {test_info['desc']}")
            success += 1
            
        except Exception as e:
            print(f"[FAIL] {str(e)[:50]}")
    
    print()
    print("=" * 80)
    print(f"  Generated: {success}/{total}")
    print("=" * 80)
    
    return 0 if success == total else 1


if __name__ == "__main__":
    sys.exit(generate_all_golden_refs())
