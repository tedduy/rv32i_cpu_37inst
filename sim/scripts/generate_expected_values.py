#!/usr/bin/env python3
"""
Extract expected values from simulation log and generate SystemVerilog code
"""

import re
from pathlib import Path

def parse_simulation_log(log_file):
    """Parse simulation log and extract instruction results"""
    results = []
    
    with open(log_file, 'r') as f:
        lines = f.readlines()
    
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Look for instruction lines (format: # N | time | PC | TYPE | INSTR | operands)
        match = re.match(r'#\s+(\d+)\s+\|\s+\d+\|\s+(0x[0-9a-f]+)\|\s+(\w+)', line)
        if match:
            instr_num = int(match.group(1))
            pc = match.group(2)
            instr_type = match.group(3)
            
            # Skip STORE and BRANCH instructions (they don't write to registers)
            if instr_type in ['STORE', 'BRANCH']:
                i += 1
                continue
            
            # Next line has WB info
            if i + 1 < len(lines):
                next_line = lines[i + 1]
                # Extract WB value and rd, and check for REG_WR status
                wb_match = re.search(r'WB=([0-9a-f]+)->x(\d+)', next_line)
                status_match = re.search(r'\|\s+(REG_WR|LOAD|JUMP)', next_line)
                
                if wb_match and status_match:
                    wb_value = wb_match.group(1)
                    rd = int(wb_match.group(2))
                    status = status_match.group(1)
                    
                    # Only include if rd != 0 and status indicates register write
                    if rd != 0 and status in ['REG_WR', 'LOAD', 'JUMP']:
                        results.append({
                            'num': instr_num,
                            'pc': pc,
                            'wb': f"0x{wb_value}",
                            'rd': rd,
                            'type': instr_type
                        })
        
        i += 1
    
    return results

def generate_systemverilog_code(results):
    """Generate SystemVerilog initialization code"""
    code = []
    code.append("    initial begin")
    code.append(f"        // Expected results for {len(results)} instructions that write to registers")
    code.append("")
    
    for i, r in enumerate(results):
        code.append(f"        expected_pcs[{i:2d}]  = {r['pc']}; "
                   f"expected_results[{i:2d}]  = 32'h{r['wb'][2:]}; "
                   f"expected_rds[{i:2d}]  = 5'd{r['rd']:2d};")
    
    code.append("    end")
    
    return '\n'.join(code)

def main():
    script_dir = Path(__file__).parent
    log_file = script_dir.parent / "logs" / "simulation_output.log"
    
    print(f"Parsing {log_file}...")
    results = parse_simulation_log(log_file)
    
    print(f"Found {len(results)} instructions with register writes")
    
    # Generate code
    code = generate_systemverilog_code(results)
    
    # Save to file
    output_file = script_dir / "expected_values.sv"
    with open(output_file, 'w') as f:
        f.write(code)
    
    print(f"\nGenerated code saved to {output_file}")
    print(f"\nFirst 5 entries:")
    for r in results[:5]:
        print(f"  PC={r['pc']} WB={r['wb']} rd=x{r['rd']}")
    
    print(f"\nLast 5 entries:")
    for r in results[-5:]:
        print(f"  PC={r['pc']} WB={r['wb']} rd=x{r['rd']}")

if __name__ == "__main__":
    main()
