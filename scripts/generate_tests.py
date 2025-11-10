#!/usr/bin/env python3
# =============================================================================
# RV32I UVM Test Generator
# =============================================================================
# Automatically generates UVM test sequences and test classes from test case
# specifications in TEST_CASES.md
# =============================================================================

import os
import re
from pathlib import Path

# =============================================================================
# Test Case Database - Based on TEST_CASES.md
# =============================================================================

TEST_CASES = {
    # Category 1: ISA Coverage (37 tests) - CRITICAL
    "1.1": [
        {"num": 1, "name": "ADD", "desc": "Basic addition"},
        {"num": 2, "name": "SUB", "desc": "Basic subtraction"},
        {"num": 3, "name": "SLL", "desc": "Logical left shift"},
        {"num": 4, "name": "SLT", "desc": "Set less than (signed)"},
        {"num": 5, "name": "SLTU", "desc": "Set less than (unsigned)"},
        {"num": 6, "name": "XOR", "desc": "Bitwise XOR"},
        {"num": 7, "name": "SRL", "desc": "Logical right shift"},
        {"num": 8, "name": "SRA", "desc": "Arithmetic right shift"},
        {"num": 9, "name": "OR", "desc": "Bitwise OR"},
        {"num": 10, "name": "AND", "desc": "Bitwise AND"},
    ],
    "1.2": [
        {"num": 1, "name": "ADDI", "desc": "Add immediate"},
        {"num": 2, "name": "SLTI", "desc": "Set less than immediate (signed)"},
        {"num": 3, "name": "SLTIU", "desc": "Set less than immediate (unsigned)"},
        {"num": 4, "name": "XORI", "desc": "XOR immediate"},
        {"num": 5, "name": "ORI", "desc": "OR immediate"},
        {"num": 6, "name": "ANDI", "desc": "AND immediate"},
        {"num": 7, "name": "SLLI", "desc": "Shift left logical immediate"},
        {"num": 8, "name": "SRLI", "desc": "Shift right logical immediate"},
        {"num": 9, "name": "SRAI", "desc": "Shift right arithmetic immediate"},
    ],
    "1.3": [
        {"num": 1, "name": "LW", "desc": "Load word"},
        {"num": 2, "name": "LH", "desc": "Load halfword (signed)"},
        {"num": 3, "name": "LHU", "desc": "Load halfword (unsigned)"},
        {"num": 4, "name": "LB", "desc": "Load byte (signed)"},
        {"num": 5, "name": "LBU", "desc": "Load byte (unsigned)"},
    ],
    "1.4": [
        {"num": 1, "name": "SW", "desc": "Store word"},
        {"num": 2, "name": "SH", "desc": "Store halfword"},
        {"num": 3, "name": "SB", "desc": "Store byte"},
    ],
    "1.5": [
        {"num": 1, "name": "BEQ", "desc": "Branch if equal"},
        {"num": 2, "name": "BNE", "desc": "Branch if not equal"},
        {"num": 3, "name": "BLT", "desc": "Branch if less than (signed)"},
        {"num": 4, "name": "BGE", "desc": "Branch if greater/equal (signed)"},
        {"num": 5, "name": "BLTU", "desc": "Branch if less than (unsigned)"},
        {"num": 6, "name": "BGEU", "desc": "Branch if greater/equal (unsigned)"},
    ],
    "1.6": [
        {"num": 1, "name": "JAL", "desc": "Jump and link"},
        {"num": 2, "name": "JALR", "desc": "Jump and link register"},
    ],
    "1.7": [
        {"num": 1, "name": "LUI", "desc": "Load upper immediate"},
        {"num": 2, "name": "AUIPC", "desc": "Add upper immediate to PC"},
    ],
    
    # Category 2: Data Hazards (16 tests) - CRITICAL
    "2.1": [
        {"num": 1, "name": "RAW_EX_EX", "desc": "RAW hazard EX-EX forwarding"},
        {"num": 2, "name": "RAW_MEM_EX", "desc": "RAW hazard MEM-EX forwarding"},
        {"num": 3, "name": "RAW_WB_EX", "desc": "RAW hazard WB-EX (no forward)"},
        {"num": 4, "name": "RAW_DOUBLE", "desc": "Double RAW hazard"},
    ],
    "2.2": [
        {"num": 1, "name": "LOAD_USE_STALL", "desc": "Load-use hazard requires stall"},
        {"num": 2, "name": "LOAD_FORWARD", "desc": "Load result forwarding"},
        {"num": 3, "name": "BACK_TO_BACK_LOADS", "desc": "Consecutive load hazards"},
    ],
    "2.3": [
        {"num": 1, "name": "RS1_FORWARD", "desc": "rs1 forwarding path"},
        {"num": 2, "name": "RS2_FORWARD", "desc": "rs2 forwarding path"},
        {"num": 3, "name": "BOTH_RS_FORWARD", "desc": "Both rs1 and rs2 forward"},
        {"num": 4, "name": "STORE_DATA_FORWARD", "desc": "Store data forwarding"},
    ],
    "2.4": [
        {"num": 1, "name": "CHAIN_RAW", "desc": "Chain of RAW dependencies"},
        {"num": 2, "name": "MULTIPLE_CONSUMERS", "desc": "One producer, multiple consumers"},
        {"num": 3, "name": "INTERLEAVED_HAZARDS", "desc": "Interleaved dependencies"},
    ],
    "2.5": [
        {"num": 1, "name": "X0_RAW", "desc": "RAW on x0 (should not forward)"},
        {"num": 2, "name": "X0_WRITE_IGNORED", "desc": "x0 writes ignored"},
    ],
    
    # Category 3: Control Hazards (16 tests) - CRITICAL
    "3.1": [
        {"num": 1, "name": "BRANCH_TAKEN", "desc": "Branch taken, flush pipeline"},
        {"num": 2, "name": "BRANCH_NOT_TAKEN", "desc": "Branch not taken"},
        {"num": 3, "name": "BACKWARD_BRANCH", "desc": "Backward branch (loop)"},
        {"num": 4, "name": "FORWARD_BRANCH", "desc": "Forward branch (skip)"},
    ],
    "3.2": [
        {"num": 1, "name": "JAL_FORWARD", "desc": "JAL forward jump"},
        {"num": 2, "name": "JAL_BACKWARD", "desc": "JAL backward jump"},
        {"num": 3, "name": "JALR_COMPUTED", "desc": "JALR with computed target"},
        {"num": 4, "name": "JALR_RETURN", "desc": "JALR for function return"},
    ],
    "3.3": [
        {"num": 1, "name": "BRANCH_AFTER_LOAD", "desc": "Branch with load dependency"},
        {"num": 2, "name": "BRANCH_WITH_FORWARD", "desc": "Branch with forwarding"},
        {"num": 3, "name": "JUMP_AFTER_ALU", "desc": "Jump after ALU operation"},
    ],
    "3.4": [
        {"num": 1, "name": "BACK_TO_BACK_BRANCHES", "desc": "Consecutive branches"},
        {"num": 2, "name": "NESTED_BRANCHES", "desc": "Nested conditional branches"},
        {"num": 3, "name": "BRANCH_IN_DELAY", "desc": "Branch in flush shadow"},
    ],
    "3.5": [
        {"num": 1, "name": "FLUSH_IF", "desc": "Flush IF stage"},
        {"num": 2, "name": "FLUSH_ID", "desc": "Flush ID stage"},
    ],
    
    # Category 4: Edge Cases (19 tests) - HIGH
    "4.1": [
        {"num": 1, "name": "OVERFLOW_ADD", "desc": "ADD overflow"},
        {"num": 2, "name": "UNDERFLOW_SUB", "desc": "SUB underflow"},
        {"num": 3, "name": "MAX_SHIFT", "desc": "Maximum shift amount"},
    ],
    "4.2": [
        {"num": 1, "name": "X0_READ", "desc": "Read from x0"},
        {"num": 2, "name": "X0_WRITE", "desc": "Write to x0"},
        {"num": 3, "name": "X0_BOTH", "desc": "x0 as source and dest"},
    ],
    "4.3": [
        {"num": 1, "name": "MAX_POS_IMM", "desc": "Maximum positive immediate"},
        {"num": 2, "name": "MAX_NEG_IMM", "desc": "Maximum negative immediate"},
        {"num": 3, "name": "ZERO_IMM", "desc": "Zero immediate"},
    ],
    "4.4": [
        {"num": 1, "name": "MEM_ADDR_0", "desc": "Memory address 0"},
        {"num": 2, "name": "MEM_ADDR_MAX", "desc": "Maximum memory address"},
        {"num": 3, "name": "MEM_UNALIGNED", "desc": "Unaligned memory access"},
    ],
    "4.5": [
        {"num": 1, "name": "BRANCH_TARGET_0", "desc": "Branch to address 0"},
        {"num": 2, "name": "BRANCH_SELF", "desc": "Branch to self (infinite loop)"},
        {"num": 3, "name": "BRANCH_MAX_OFFSET", "desc": "Maximum branch offset"},
    ],
    "4.6": [
        {"num": 1, "name": "ALL_ONES", "desc": "Operands all 1s"},
        {"num": 2, "name": "ALL_ZEROS", "desc": "Operands all 0s"},
        {"num": 3, "name": "ALTERNATING_BITS", "desc": "Alternating bit pattern"},
        {"num": 4, "name": "SINGLE_BIT", "desc": "Single bit set patterns"},
    ],
    
    # Category 5: Complex Scenarios (10 tests) - HIGH
    "5.1": [
        {"num": 1, "name": "RAW_AND_BRANCH", "desc": "Data hazard with branch"},
        {"num": 2, "name": "LOAD_USE_AND_BRANCH", "desc": "Load-use with branch"},
        {"num": 3, "name": "FORWARD_AND_JUMP", "desc": "Forwarding with jump"},
    ],
    "5.2": [
        {"num": 1, "name": "LOOP_WITH_HAZARDS", "desc": "Loop with data hazards"},
        {"num": 2, "name": "NESTED_LOOPS", "desc": "Nested loops"},
        {"num": 3, "name": "LOOP_UNROLL", "desc": "Partially unrolled loop"},
    ],
    "5.3": [
        {"num": 1, "name": "FUNCTION_CALL", "desc": "Function call with JAL"},
        {"num": 2, "name": "FUNCTION_RETURN", "desc": "Function return with JALR"},
        {"num": 3, "name": "NESTED_CALLS", "desc": "Nested function calls"},
    ],
    "5.4": [
        {"num": 1, "name": "MIXED_HAZARDS", "desc": "All hazard types mixed"},
    ],
    
    # Category 6: Memory System (17 tests) - HIGH
    "6.1": [
        {"num": 1, "name": "LOAD_BYTE_SIGN_EXT", "desc": "LB sign extension"},
        {"num": 2, "name": "LOAD_BYTE_ZERO_EXT", "desc": "LBU zero extension"},
        {"num": 3, "name": "LOAD_HALF_SIGN_EXT", "desc": "LH sign extension"},
        {"num": 4, "name": "LOAD_HALF_ZERO_EXT", "desc": "LHU zero extension"},
    ],
    "6.2": [
        {"num": 1, "name": "STORE_BYTE_MASK", "desc": "SB byte masking"},
        {"num": 2, "name": "STORE_HALF_MASK", "desc": "SH halfword masking"},
        {"num": 3, "name": "STORE_WORD", "desc": "SW full word"},
    ],
    "6.3": [
        {"num": 1, "name": "LOAD_WORD_ALIGN", "desc": "LW aligned access"},
        {"num": 2, "name": "LOAD_HALF_ALIGN", "desc": "LH at halfword boundary"},
        {"num": 3, "name": "STORE_ALIGN", "desc": "Aligned store operations"},
    ],
    "6.4": [
        {"num": 1, "name": "LOAD_STORE_SAME_ADDR", "desc": "Load then store same address"},
        {"num": 2, "name": "STORE_LOAD_FORWARD", "desc": "Store-to-load forwarding"},
        {"num": 3, "name": "BACK_TO_BACK_MEM", "desc": "Consecutive memory ops"},
    ],
    "6.5": [
        {"num": 1, "name": "MEM_OFFSET_POS", "desc": "Positive offset"},
        {"num": 2, "name": "MEM_OFFSET_NEG", "desc": "Negative offset"},
        {"num": 3, "name": "MEM_OFFSET_ZERO", "desc": "Zero offset"},
        {"num": 4, "name": "MEM_OFFSET_MAX", "desc": "Maximum offset"},
    ],
    
    # Category 7: Register File (8 tests) - MEDIUM
    "7.1": [
        {"num": 1, "name": "ALL_REGS_WRITE", "desc": "Write to all registers"},
        {"num": 2, "name": "ALL_REGS_READ", "desc": "Read from all registers"},
    ],
    "7.2": [
        {"num": 1, "name": "X0_ALWAYS_ZERO", "desc": "x0 remains zero"},
        {"num": 2, "name": "X0_AS_SOURCE", "desc": "x0 as operand source"},
    ],
    "7.3": [
        {"num": 1, "name": "SAME_REG_SRC_DST", "desc": "Same register as src and dst"},
        {"num": 2, "name": "ALL_SAME_REG", "desc": "All operands same register"},
    ],
    "7.4": [
        {"num": 1, "name": "RAPID_REUSE", "desc": "Rapid register reuse"},
        {"num": 2, "name": "REG_PING_PONG", "desc": "Alternating register usage"},
    ],
    
    # Category 8: Pipeline Stalls (6 tests) - MEDIUM
    "8.1": [
        {"num": 1, "name": "SINGLE_STALL", "desc": "Single cycle stall"},
        {"num": 2, "name": "MULTI_STALL", "desc": "Multiple consecutive stalls"},
    ],
    "8.2": [
        {"num": 1, "name": "STALL_RECOVERY", "desc": "Recovery after stall"},
        {"num": 2, "name": "STALL_THEN_BRANCH", "desc": "Branch after stall"},
    ],
    "8.3": [
        {"num": 1, "name": "BACK_TO_BACK_STALLS", "desc": "Consecutive stall conditions"},
        {"num": 2, "name": "STALL_PATTERNS", "desc": "Various stall patterns"},
    ],
    
    # Category 10: Forwarding Paths (9 tests) - CRITICAL
    "10.1": [
        {"num": 1, "name": "EX_TO_EX_RS1", "desc": "EX-EX forward to rs1"},
        {"num": 2, "name": "EX_TO_EX_RS2", "desc": "EX-EX forward to rs2"},
        {"num": 3, "name": "EX_TO_EX_BOTH", "desc": "EX-EX forward to both"},
    ],
    "10.2": [
        {"num": 1, "name": "MEM_TO_EX_RS1", "desc": "MEM-EX forward to rs1"},
        {"num": 2, "name": "MEM_TO_EX_RS2", "desc": "MEM-EX forward to rs2"},
        {"num": 3, "name": "MEM_TO_EX_BOTH", "desc": "MEM-EX forward to both"},
    ],
    "10.3": [
        {"num": 1, "name": "LOAD_FORWARD", "desc": "Load result forwarding"},
        {"num": 2, "name": "ALU_TO_BRANCH", "desc": "ALU result to branch"},
        {"num": 3, "name": "ALU_TO_STORE", "desc": "ALU result to store data"},
    ],
    
    # Category 11: Performance (3 tests) - LOW
    "11.1": [
        {"num": 1, "name": "CPI_NO_HAZARDS", "desc": "CPI with no hazards"},
        {"num": 2, "name": "CPI_WITH_HAZARDS", "desc": "CPI with typical hazards"},
        {"num": 3, "name": "CPI_WORST_CASE", "desc": "CPI worst case scenario"},
    ],
    
    # Category 12: Arithmetic Corners (6 tests) - MEDIUM
    "12.1": [
        {"num": 1, "name": "ADD_OVERFLOW_POS", "desc": "Positive overflow"},
        {"num": 2, "name": "ADD_OVERFLOW_NEG", "desc": "Negative overflow"},
        {"num": 3, "name": "SUB_UNDERFLOW", "desc": "Subtraction underflow"},
    ],
    "12.2": [
        {"num": 1, "name": "SLT_EDGE_CASES", "desc": "SLT boundary values"},
        {"num": 2, "name": "SLTU_EDGE_CASES", "desc": "SLTU boundary values"},
        {"num": 3, "name": "SHIFT_EDGE_CASES", "desc": "Shift boundary amounts"},
    ],
    
    # Category 13: Jump & Link (4 tests) - HIGH
    "13.1": [
        {"num": 1, "name": "JAL_RETURN_ADDR", "desc": "JAL saves return address"},
        {"num": 2, "name": "JALR_RETURN_ADDR", "desc": "JALR saves return address"},
    ],
    "13.2": [
        {"num": 1, "name": "JAL_TO_X0", "desc": "JAL with x0 as dest"},
        {"num": 2, "name": "JALR_TO_X0", "desc": "JALR with x0 as dest"},
    ],
    
    # Category 14: Immediate Values (4 tests) - MEDIUM
    "14.1": [
        {"num": 1, "name": "IMM_12BIT_MAX", "desc": "12-bit immediate max"},
        {"num": 2, "name": "IMM_20BIT_MAX", "desc": "20-bit immediate max"},
        {"num": 3, "name": "IMM_SIGN_EXT", "desc": "Immediate sign extension"},
        {"num": 4, "name": "IMM_ZERO_EXT", "desc": "Immediate zero extension"},
    ],
    
    # Category 15: Stress Tests (3 tests) - MEDIUM
    "15.1": [
        {"num": 1, "name": "LONG_SEQUENCE", "desc": "100+ instructions"},
        {"num": 2, "name": "DEEP_NESTING", "desc": "Deeply nested branches"},
        {"num": 3, "name": "MAX_DEPENDENCIES", "desc": "Maximum dependency chains"},
    ],
}

# Priority mapping
CATEGORY_PRIORITY = {
    1: "CRITICAL", 2: "CRITICAL", 3: "CRITICAL", 10: "CRITICAL",
    4: "HIGH", 5: "HIGH", 6: "HIGH", 13: "HIGH",
    7: "MEDIUM", 8: "MEDIUM", 11: "LOW", 12: "MEDIUM", 14: "MEDIUM", 15: "MEDIUM"
}

# Category names
CATEGORY_NAMES = {
    1: "ISA Coverage",
    2: "Data Hazards",
    3: "Control Hazards",
    4: "Edge Cases",
    5: "Complex Scenarios",
    6: "Memory System",
    7: "Register File",
    8: "Pipeline Stalls",
    10: "Forwarding Paths",
    11: "Performance",
    12: "Arithmetic Corners",
    13: "Jump & Link",
    14: "Immediate Values",
    15: "Stress Tests"
}

# =============================================================================
# Template Generators
# =============================================================================

def generate_sequence_template(cat, subcat, num, name, desc):
    """Generate UVM sequence file"""
    tc_id = f"{cat}_{subcat}_{num}"
    seq_name = f"tc_{tc_id}_{name.lower()}_seq"
    
    template = f'''// =============================================================================
// Sequence: TC {cat}.{subcat}.{num} - {name} Instruction
// =============================================================================
// Category: {CATEGORY_NAMES[int(cat)]}
// Priority: {CATEGORY_PRIORITY[int(cat)]}
// Description: {desc}
// =============================================================================

class {seq_name} extends uvm_sequence #(rv32i_transaction);
    
    `uvm_object_utils({seq_name})
    
    function new(string name = "{seq_name}");
        super.new(name);
    endfunction
    
    task body();
        rv32i_transaction tr;
        
        `uvm_info(get_type_name(), "Starting {name} sequence", UVM_MEDIUM)
        
        // ======================================================================
        // Test Case: {name} - {desc}
        // ======================================================================
        tr = rv32i_transaction::type_id::create("{name.lower()}_test");
        start_item(tr);
        
        tr.test_name = "{name} Test";
        // TODO: Configure instruction encoding and test values
        // tr.opcode = ...;
        // tr.funct3 = ...;
        // tr.rd = ...;
        // tr.rs1 = ...;
        // tr.rs2 = ...;
        // tr.instruction = {{tr.funct7, tr.rs2, tr.rs1, tr.funct3, tr.rd, tr.opcode}};
        
        finish_item(tr);
        `uvm_info(get_type_name(), "Sent: {name} test transaction", UVM_HIGH)
        
        `uvm_info(get_type_name(), "{name} sequence completed", UVM_MEDIUM)
        
    endtask

endclass : {seq_name}
'''
    return template

def generate_test_template(cat, subcat, num, name, desc, priority):
    """Generate UVM test class file"""
    tc_id = f"{cat}_{subcat}_{num}"
    test_name = f"tc_{tc_id}_{name.lower()}_test"
    seq_name = f"tc_{tc_id}_{name.lower()}_seq"
    
    template = f'''// =============================================================================
// Test Case {cat}.{subcat}.{num}: {name}
// =============================================================================
// Category: {CATEGORY_NAMES[int(cat)]}
// Priority: {priority}
// Description: {desc}
// =============================================================================

class {test_name} extends base_test;
    
    `uvm_component_utils({test_name})
    
    function new(string name = "{test_name}", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Override golden log file for this test
        golden_log_file = "tests/golden/tc_{tc_id}_{name.lower()}_golden.log";
        uvm_config_db#(string)::set(this, "env.scoreboard.golden", 
                                    "golden_log_file", golden_log_file);
    endfunction
    
    task run_phase(uvm_phase phase);
        {seq_name} seq;
        
        phase.raise_objection(this);
        
        `uvm_info(get_type_name(), "\\n=== Starting TC {cat}.{subcat}.{num}: {name} ===", UVM_LOW)
        
        // Create and start sequence
        seq = {seq_name}::type_id::create("seq");
        seq.start(env.agent.sequencer);
        
        // Wait for completion
        #1000;
        
        `uvm_info(get_type_name(), "=== TC {cat}.{subcat}.{num}: {name} Complete ===\\n", UVM_LOW)
        
        phase.drop_objection(this);
    endtask

endclass : {test_name}
'''
    return template

# =============================================================================
# Main Generation Function
# =============================================================================

def generate_all_tests():
    """Generate all test sequences and test classes"""
    
    # Script is in scripts/, need to go up to root, then into tb/
    base_dir = Path(__file__).parent.parent / "tb"
    seq_dir = base_dir / "sequences"
    test_dir = base_dir / "tests"
    
    print(f"Generating test files...")
    print(f"Base directory: {base_dir}")
    print(f"Sequences directory: {seq_dir}")
    print(f"Tests directory: {test_dir}")
    print()
    
    total_generated = 0
    
    for cat_subcat, tests in TEST_CASES.items():
        cat, subcat = cat_subcat.split('.')
        cat_num = int(cat)
        priority = CATEGORY_PRIORITY.get(cat_num, "MEDIUM")
        cat_name = CATEGORY_NAMES.get(cat_num, "Unknown")
        
        # Create category directory for sequences
        cat_dir_name = f"category_{cat.zfill(2)}_{cat_name.lower().replace(' ', '_').replace('&', 'and')}"
        cat_seq_dir = seq_dir / cat_dir_name
        cat_seq_dir.mkdir(parents=True, exist_ok=True)
        
        # Create priority directory for tests
        priority_dir = test_dir / priority.lower()
        priority_dir.mkdir(parents=True, exist_ok=True)
        
        for test in tests:
            num = test["num"]
            name = test["name"]
            desc = test["desc"]
            
            tc_id = f"{cat}_{subcat}_{num}"
            
            # Generate sequence file
            seq_filename = f"tc_{tc_id}_{name.lower()}_seq.sv"
            seq_filepath = cat_seq_dir / seq_filename
            seq_content = generate_sequence_template(cat, subcat, num, name, desc)
            
            with open(seq_filepath, 'w') as f:
                f.write(seq_content)
            
            # Generate test file
            test_filename = f"tc_{tc_id}_{name.lower()}_test.sv"
            test_filepath = priority_dir / test_filename
            test_content = generate_test_template(cat, subcat, num, name, desc, priority)
            
            with open(test_filepath, 'w') as f:
                f.write(test_content)
            
            total_generated += 1
            
            if total_generated % 10 == 0:
                print(f"  Generated {total_generated} test cases...")
    
    print(f"\n✅ Successfully generated {total_generated} test cases!")
    print(f"   - Sequences in: {seq_dir}")
    print(f"   - Tests in: {test_dir}")
    
    return total_generated

# =============================================================================
# Entry Point
# =============================================================================

if __name__ == "__main__":
    print("="*70)
    print("  RV32I UVM Test Generator")
    print("="*70)
    count = generate_all_tests()
    print(f"\nGeneration complete! Total test cases: {count}")
    print("="*70)
