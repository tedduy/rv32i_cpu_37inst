# RV32I Pipeline CPU - 5-Stage Implementation

A complete 5-stage pipelined RISC-V RV32I CPU implementation in SystemVerilog, supporting all 37 base integer instructions.

## 🎯 Features

- ✅ **Full RV32I ISA** - 37 instructions supported
- ✅ **5-Stage Pipeline** - IF → ID → EX → MEM → WB
- ✅ **Data Forwarding** - Minimize pipeline stalls
- ✅ **Hazard Detection** - Load-use and control hazards
- ✅ **Branch/Jump Support** - With pipeline flushing
- ✅ **Memory System** - Separate instruction and data memory
- ✅ **100% Verified** - 51/51 register writes verified (100% pass rate)

## 📊 Performance

- **Architecture**: 5-stage pipeline
- **Clock Frequency**: ~100 MHz (10ns period)
- **CPI (Cycles Per Instruction)**: 1.12 (measured)
- **Pipeline Efficiency**: 89.3%
- **Throughput**: ~89 MIPS @ 100MHz

## ✅ Verification Status

**PASSED - 100% Functional Correctness**

- 76 instructions executed successfully
- 51/51 register writes verified with expected results
- 0 errors, 0 critical warnings
- All 37 RV32I instruction types tested
- Pipeline hazard handling verified

See \`docs/VERIFICATION_SUMMARY.md\` for details.

---

## 🚀 Quick Start

### Prerequisites
- QuestaSim or ModelSim
- Python 3.6+
- Make (optional)

### Run Full Verification (Recommended)

\`\`\`bash
make verify
\`\`\`

**Expected Output:**
\`\`\`
✓✓✓ FULL VERIFICATION PASSED! ✓✓✓

Summary:
  • 76 instructions executed successfully
  • 51/51 register writes verified (100.0%)
  • 0 errors, 0 critical warnings

CPU IS FUNCTIONALLY CORRECT!
\`\`\`

### Run Basic Simulation

\`\`\`bash
make all
\`\`\`

### Clean Generated Files

\`\`\`bash
make clean
\`\`\`

---

## 📁 Project Structure

\`\`\`
rv32i_cpu_37inst/
│
├── rtl/                           # RTL Source Files
│   ├── core/                      # Core CPU modules
│   │   ├── pipeline/              # Pipeline registers (IF/ID, ID/EX, EX/MEM, MEM/WB)
│   │   │   ├── IF_ID_Register.sv
│   │   │   ├── ID_EX_Register.sv
│   │   │   ├── EX_MEM_Register.sv
│   │   │   └── MEM_WB_Register.sv
│   │   │
│   │   ├── hazard/                # Hazard handling units
│   │   │   ├── Hazard_Detection_Unit.sv  # Detects load-use hazards
│   │   │   └── Forwarding_Unit.sv        # Data forwarding logic
│   │   │
│   │   └── stages/                # Pipeline stage modules
│   │       ├── Program_Counter.sv        # PC with branch/jump support
│   │       ├── Instruction_Mem.sv        # Instruction memory (ROM)
│   │       ├── Control_Unit.sv           # Instruction decoder
│   │       ├── Reg_File.sv               # 32 x 32-bit register file
│   │       ├── Immediate_Generation.sv   # Immediate value generator
│   │       ├── ALU_Unit.sv               # Arithmetic Logic Unit
│   │       ├── Branch_Unit.sv            # Branch condition checker
│   │       ├── Jump_Unit.sv              # Jump target calculator
│   │       ├── Data_Memory.sv            # Data memory (RAM)
│   │       └── Load_Store_Unit.sv        # Load/store logic
│   │
│   ├── common/                    # Common utility modules
│   │   ├── adder_N_bit.sv         # N-bit adder
│   │   ├── mux2to1.sv             # 2-to-1 multiplexer
│   │   ├── mux3to1.sv             # 3-to-1 multiplexer
│   │   └── mux4to1.sv             # 4-to-1 multiplexer
│   │
│   └── top/                       # Top-level integration
│       └── rv32i_top.sv           # Pipeline CPU top module
│
├── tb/                            # Testbenches
│   ├── tb_rv32i_pipeline.sv       # Main testbench with detailed logging
│   └── tb_full_verification.sv    # Full verification testbench (51 tests)
│
├── sim/                           # Simulation directory
│   ├── scripts/                   # Automation scripts
│   │   ├── compile_and_run.py            # Main simulation script
│   │   ├── run_full_verification.py      # Full verification script
│   │   ├── generate_expected_values.py   # Generate expected values
│   │   ├── expected_values.sv            # Expected values (reference)
│   │   ├── filelist.f                    # RTL file list
│   │   └── README.md                     # Scripts documentation
│   │
│   ├── logs/                      # Simulation logs (generated)
│   │   ├── simulation_output.log         # Basic simulation log
│   │   └── full_verification.log         # Verification log
│   │
│   └── work/                      # QuestaSim work library (generated)
│
├── docs/                          # Documentation
│   ├── VERIFICATION_SUMMARY.md    # Quick verification summary
│   ├── VERIFICATION_REPORT.md     # Detailed verification report
│   └── PERFORMANCE_ANALYSIS.md    # Performance metrics & analysis
│
├── Makefile                       # Build automation
└── README.md                      # This file
\`\`\`

---

## 🔧 Supported Instructions (37 Total)

### Arithmetic & Logic (10)
- \`ADD\`, \`SUB\`, \`AND\`, \`OR\`, \`XOR\`, \`SLT\`, \`SLTU\`, \`SLL\`, \`SRL\`, \`SRA\`

### Immediate Operations (9)
- \`ADDI\`, \`ANDI\`, \`ORI\`, \`XORI\`, \`SLTI\`, \`SLTIU\`, \`SLLI\`, \`SRLI\`, \`SRAI\`

### Load/Store (8)
- \`LW\`, \`LH\`, \`LB\`, \`LHU\`, \`LBU\` (Loads)
- \`SW\`, \`SH\`, \`SB\` (Stores)

### Branch (6)
- \`BEQ\`, \`BNE\`, \`BLT\`, \`BGE\`, \`BLTU\`, \`BGEU\`

### Jump (2)
- \`JAL\`, \`JALR\`

### Upper Immediate (2)
- \`LUI\`, \`AUIPC\`

---

## 🛠️ Makefile Commands

### Quick Reference

| Command | Description |
|---------|-------------|
| \`make verify\` | Run full verification (recommended) |
| \`make all\` | Run basic simulation |
| \`make clean\` | Clean all generated files |
| \`make info\` | Show project information |
| \`make check-tools\` | Check required tools |
| \`make summary\` | Show verification summary |
| \`make help\` | Show all commands |

### Common Workflows

**First Time Setup:**
\`\`\`bash
make check-tools  # Check if tools are installed
make info         # Show project info
make verify       # Run verification
\`\`\`

**Development:**
\`\`\`bash
# Make changes to RTL...
make verify-clean  # Clean and verify
\`\`\`

**Quick Test:**
\`\`\`bash
make test  # Clean + verify + summary
\`\`\`

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| \`README.md\` | Project overview (this file) |
| \`docs/VERIFICATION_SUMMARY.md\` | Quick verification summary |
| \`docs/VERIFICATION_REPORT.md\` | Detailed verification report |
| \`docs/PERFORMANCE_ANALYSIS.md\` | Performance metrics |
| \`sim/scripts/README.md\` | Scripts documentation |

---

## 🎓 Educational Use

This project is ideal for:
- ✅ Computer architecture courses
- ✅ Digital design projects
- ✅ RISC-V learning
- ✅ Pipeline CPU understanding
- ✅ Thesis/capstone projects

---

**Status:** ✅ Fully verified and ready for use

**Last Updated:** November 17, 2025
