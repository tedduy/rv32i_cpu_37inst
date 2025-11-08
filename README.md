# RV32I CPU - 37 Instructions Implementation

A complete 5-stage pipelined RISC-V RV32I CPU implementation in SystemVerilog, supporting all 37 base integer instructions.

## 🎯 Features

- ✅ **Full RV32I ISA** - 37 instructions supported
- ✅ **5-Stage Pipeline** - IF → ID → EX → MEM → WB
- ✅ **Data Forwarding** - Minimize pipeline stalls
- ✅ **Hazard Detection** - Load-use and control hazards
- ✅ **Branch/Jump Support** - With pipeline flushing
- ✅ **Memory System** - Separate instruction and data memory
- ✅ **Testbench** - UVM-style verification environment

## 📊 Performance

- **Architecture**: 5-stage pipeline
- **Clock Frequency**: ~5x higher than single-cycle
- **CPI (Cycles Per Instruction)**: ~1.25-1.65 (with hazards)
- **Throughput**: ~1 instruction/cycle (ideal)

## 📁 Project Structure

```
rv32i_cpu_37inst/
├── rtl/                           # RTL Source Files
│   ├── core/                      # Core CPU modules
│   │   ├── pipeline/              # Pipeline registers
│   │   │   ├── IF_ID_Register.sv
│   │   │   ├── ID_EX_Register.sv
│   │   │   ├── EX_MEM_Register.sv
│   │   │   └── MEM_WB_Register.sv
│   │   │
│   │   ├── hazard/                # Hazard handling
│   │   │   ├── Hazard_Detection_Unit.sv
│   │   │   └── Forwarding_Unit.sv
│   │   │
│   │   └── stages/                # Pipeline stage modules
│   │       ├── Program_Counter.sv
│   │       ├── Instruction_Mem.sv
│   │       ├── Control_Unit.sv
│   │       ├── Reg_File.sv
│   │       ├── Immediate_Generation.sv
│   │       ├── ALU_Unit.sv
│   │       ├── Branch_Unit.sv
│   │       ├── Jump_Unit.sv
│   │       ├── Data_Memory.sv
│   │       └── Load_Store_Unit.sv
│   │
│   ├── common/                    # Common utilities
│   │   ├── adder_N_bit.sv
│   │   ├── mux2to1.sv
│   │   ├── mux3to1.sv
│   │   └── mux4to1.sv
│   │
│   └── top/                       # Top-level modules
│       ├── rv32i_top.sv           # Pipeline version (current)
│       └── rv32i_top_single_cycle.sv  # Single-cycle backup
│
├── tb/                            # Testbench
│   ├── tb_rv32i_top.sv           # Main testbench
│   ├── components/               # UVM-style components
│   └── sequences/                # Test sequences
│
├── docs/                          # Documentation
│   └── PIPELINE_ARCHITECTURE.md  # Pipeline design details
│
└── sim/                           # Simulation files
    ├── scripts/                   # Build/run scripts
    └── waveforms/                 # Waveform dumps
```

## 🔧 Supported Instructions (37 Total)

### Arithmetic & Logic (10)
- `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLT`, `SLTU`, `SLL`, `SRL`, `SRA`

### Immediate Operations (9)
- `ADDI`, `ANDI`, `ORI`, `XORI`, `SLTI`, `SLTIU`, `SLLI`, `SRLI`, `SRAI`

### Load/Store (8)
- `LW`, `LH`, `LB`, `LHU`, `LBU` (Loads)
- `SW`, `SH`, `SB` (Stores)

### Branch (6)
- `BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`

### Jump (2)
- `JAL`, `JALR`

### Upper Immediate (2)
- `LUI`, `AUIPC`

## 🚀 Getting Started

### Prerequisites
- QuestaSim or ModelSim
- TCL 8.5+
- Git

### Quick Start
```bash
# Clone repository
git clone https://github.com/tedduy/rv32i_cpu_37inst.git
cd rv32i_cpu_37inst

# Compile and run
make compile
make sim
make verify
```

### Makefile Targets
```bash
make help         # Show all available targets
make compile      # Compile RTL and testbench
make sim          # Run pipeline simulation
make gui          # Run with GUI
make debug        # Debug mode with waveforms
make verify       # Full verification (SC vs PL)
make clean        # Clean generated files
make info         # Project information
```

For detailed simulation guide, see [`sim/README.md`](sim/README.md).

## 📖 Architecture Overview

### Pipeline Stages

```
┌────────┐   ┌────────┐   ┌────────┐   ┌────────┐   ┌────────┐
│   IF   │ → │   ID   │ → │   EX   │ → │  MEM   │ → │   WB   │
└────────┘   └────────┘   └────────┘   └────────┘   └────────┘
    ↓            ↓            ↓            ↓            ↓
  Fetch      Decode      Execute      Memory       Write
  Inst       & Read      ALU/Branch   Access       Back
             Regs        /Jump        Data         Results
```

### Hazard Handling

#### 1. **Data Forwarding**
Forward results from later stages to avoid stalls:
```
EX/MEM → EX  (ALU result forwarding)
MEM/WB → EX  (Writeback data forwarding)
```

#### 2. **Load-Use Stalls**
Insert 1-cycle stall when load result is immediately needed:
```assembly
LW  x1, 0(x2)    # Cycle 1
ADD x3, x1, x4   # Cycle 2: STALL (need x1 from load)
```

#### 3. **Branch/Jump Flushing**
Flush 2 instructions when branch/jump is taken:
```assembly
BEQ x1, x2, target   # Cycle N
<wrong-path inst 1>  # FLUSHED
<wrong-path inst 2>  # FLUSHED
target: ...          # Cycle N+3
```

## 📚 Documentation

### Core Documentation
- **[sim/README.md](sim/README.md)** - Simulation workflow and directory structure
- **[docs/PIPELINE_ARCHITECTURE.md](docs/PIPELINE_ARCHITECTURE.md)** - Detailed pipeline design
- **[docs/CHALLENGES_AND_SOLUTIONS.md](docs/CHALLENGES_AND_SOLUTIONS.md)** - Implementation challenges
- **[docs/TCL_VERIFICATION_GUIDE.md](docs/TCL_VERIFICATION_GUIDE.md)** - TCL verification guide

### Quick Commands
```bash
make help    # Show all available Makefile targets
make info    # Show project information
```

## 🧪 Verification

The project includes comprehensive verification:
- **TCL-based verification** - Compare single-cycle vs pipeline execution
- **Automated testing** - Full regression suite
- **Waveform debugging** - Pre-configured signal groups
- **UVM infrastructure** - Ready for advanced constrained-random testing

### Verification Flow
```bash
make verify           # Full verification (compiles both modes, compares results)
make verify-quick     # Quick comparison using existing logs
make verify-final     # Final register/memory state comparison
```

See [`sim/README.md`](sim/README.md) for detailed verification guide.

## 🎓 Learning Resources

This project demonstrates:
- 5-stage pipeline design
- Hazard detection and forwarding
- RISC-V ISA implementation
- SystemVerilog RTL coding
- Verification methodologies

## 📈 Future Enhancements

- [ ] Branch prediction (1-bit, 2-bit)
- [ ] Cache hierarchy (I-cache, D-cache)
- [ ] M extension (Multiply/Divide)
- [ ] C extension (Compressed instructions)
- [ ] Performance counters
- [ ] Formal verification

## 🤝 Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 👤 Author

**tedduy**
- GitHub: [@tedduy](https://github.com/tedduy)

## 🙏 Acknowledgments

- RISC-V Foundation for the ISA specification
- Computer Architecture: A Quantitative Approach (Patterson & Hennessy)
- Digital Design and Computer Architecture (Harris & Harris)

## 📞 Contact

For questions or suggestions, please open an issue or contact the author.

---

**Last Updated:** November 8, 2025
