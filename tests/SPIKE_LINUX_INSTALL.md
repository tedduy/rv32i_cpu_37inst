# 🐧 Spike Installation Guide for Linux

**Target:** Build Spike ISA Simulator on Linux (native or WSL2)  
**Time:** 15-30 minutes  
**Date:** November 9, 2025

---

## ✅ Prerequisites Check

```bash
# Check if you have required tools
which gcc g++ make git
# Should show paths for all

# Check versions
gcc --version    # Need >= 7.0
g++ --version    # Need >= 7.0
make --version   # Need >= 3.8
```

---

## 📦 Step 1: Install Dependencies

### For Ubuntu/Debian:
```bash
sudo apt update
sudo apt install -y \
    build-essential \
    git \
    device-tree-compiler \
    libboost-regex-dev \
    libboost-system-dev \
    autoconf \
    automake \
    libtool
```

### For Fedora/RHEL:
```bash
sudo dnf install -y \
    gcc gcc-c++ \
    make \
    git \
    dtc \
    boost-devel \
    autoconf \
    automake \
    libtool
```

### For Arch Linux:
```bash
sudo pacman -S --noconfirm \
    base-devel \
    git \
    dtc \
    boost \
    autoconf \
    automake \
    libtool
```

---

## 🔽 Step 2: Clone Spike Repository

```bash
# Create tools directory
mkdir -p ~/tools
cd ~/tools

# Clone Spike
git clone https://github.com/riscv-software-src/riscv-isa-sim.git
cd riscv-isa-sim

# Check version
git log --oneline | head -1
```

---

## 🔨 Step 3: Build Spike

```bash
# Create build directory
mkdir build
cd build

# Configure for installation to /opt/riscv-spike
../configure --prefix=/opt/riscv-spike

# Or configure for user installation (no sudo needed)
# ../configure --prefix=$HOME/.local/riscv-spike

# Build (use all CPU cores)
make -j$(nproc)

# This takes 5-10 minutes...
```

**Expected output:**
```
...
CXX      spike.o
CXX      spike-log-parser.o
LINK     spike
LINK     spike-log-parser
LINK     libspike_main.a
...
```

---

## 📦 Step 4: Install Spike

```bash
# Install to system (needs sudo)
sudo make install

# Or for user install (no sudo)
# make install
```

**Files installed:**
```
/opt/riscv-spike/bin/spike        # Main simulator
/opt/riscv-spike/bin/spike-dasm   # Disassembler
/opt/riscv-spike/lib/...          # Libraries
```

---

## 🔧 Step 5: Setup PATH

```bash
# Add to PATH (for /opt install)
echo 'export PATH="/opt/riscv-spike/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Or for user install
# echo 'export PATH="$HOME/.local/riscv-spike/bin:$PATH"' >> ~/.bashrc
# source ~/.bashrc
```

---

## ✅ Step 6: Verify Installation

```bash
# Check Spike is available
which spike
# Should show: /opt/riscv-spike/bin/spike

# Check version
spike --version
# Should show: Spike RISC-V ISA Simulator 1.1.0

# Check help
spike --help | head -20
```

**Expected help output:**
```
usage: spike [host options] <target program> [target options]
Host Options:
  -p<n>                 Simulate <n> processors [default 1]
  -m<n>                 Provide <n> MiB of target memory [default 2048]
  -m<a:m,b:n,...>       Provide memory regions of size m and n bytes
                          at base addresses a and b (with 4 KiB alignment)
  --isa=<name>          RISC-V ISA string [default RV64IMAFDC]
  ...
```

---

## 🧪 Step 7: Test with Your Program

```bash
# Copy your compiled ELF to Linux
# If using WSL2:
cd /mnt/c/Users/BUUDUY/Workspace/rv32i_cpu_37inst/tests/programs

# Or if native Linux, copy via scp/usb/etc

# Run Spike with RV32I ISA
spike --isa=RV32I tc_1_1_1_add.elf

# Generate golden log
spike -l --isa=RV32I --log-commits tc_1_1_1_add.elf 2>&1 | \
    grep "core" > tc_1_1_1_add_spike.log

# View log
cat tc_1_1_1_add_spike.log | head -20
```

**Expected golden log format:**
```
core   0: 0x00000000 (0x01000113) li      sp, 16
core   0: 0x00000004 (0x02000193) li      gp, 32
core   0: 0x00000008 (0x003100b3) add     ra, sp, gp
core   0: 0x0000000c (0xdeadc2b7) lui     t0, 0xdeadc
...
```

---

## 📋 Complete Command Summary

```bash
# One-line installation (Ubuntu/Debian)
sudo apt update && \
sudo apt install -y build-essential git device-tree-compiler libboost-regex-dev libboost-system-dev autoconf automake libtool && \
cd ~/tools && \
git clone https://github.com/riscv-software-src/riscv-isa-sim.git && \
cd riscv-isa-sim && \
mkdir build && cd build && \
../configure --prefix=/opt/riscv-spike && \
make -j$(nproc) && \
sudo make install && \
echo 'export PATH="/opt/riscv-spike/bin:$PATH"' >> ~/.bashrc && \
source ~/.bashrc && \
spike --help
```

---

## 🔄 Workflow Integration

### Generate Golden Reference:
```bash
# Navigate to your programs
cd /path/to/rv32i_cpu_37inst/tests/programs

# Compile (if not done on Windows)
riscv-none-elf-gcc -march=rv32i -mabi=ilp32 -nostartfiles \
    -Wl,-Ttext=0x0 tc_1_1_1_add.S -o tc_1_1_1_add.elf

# Generate golden log
spike -l --isa=RV32I --log-commits tc_1_1_1_add.elf 2>&1 | \
    grep "core" > ../golden/tc_1_1_1_add_spike.log

# Verify
cat ../golden/tc_1_1_1_add_spike.log
```

### Batch Generate All 158 Tests:
```bash
cd tests/programs

for test in tc_*.S; do
    base=$(basename $test .S)
    echo "Processing $base..."
    
    # Compile
    riscv-none-elf-gcc -march=rv32i -mabi=ilp32 -nostartfiles \
        -Wl,-Ttext=0x0 $test -o ${base}.elf
    
    # Generate golden log
    spike -l --isa=RV32I --log-commits ${base}.elf 2>&1 | \
        grep "core" > ../golden/${base}_spike.log
    
    echo "  ✅ ${base} done"
done

echo "All golden references generated!"
```

---

## 🐛 Troubleshooting

### Issue: "spike: command not found"
```bash
# Check PATH
echo $PATH | grep spike

# Re-source bashrc
source ~/.bashrc

# Or use full path
/opt/riscv-spike/bin/spike --help
```

### Issue: "error while loading shared libraries"
```bash
# Add library path
echo 'export LD_LIBRARY_PATH="/opt/riscv-spike/lib:$LD_LIBRARY_PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: Build fails with "No such file or directory"
```bash
# Make sure all dependencies installed
sudo apt install -y build-essential device-tree-compiler libboost-all-dev

# Clean and rebuild
cd ~/tools/riscv-isa-sim
rm -rf build
mkdir build && cd build
../configure --prefix=/opt/riscv-spike
make -j$(nproc)
```

---

## 🎯 Next Steps After Installation

1. ✅ Verify Spike works with tc_1_1_1_add.elf
2. ✅ Generate first golden reference
3. ➡️ Create batch script for all 158 tests
4. ➡️ Copy golden logs back to Windows
5. ➡️ Run UVM verification
6. ➡️ Compare DUT vs Spike results

---

## 💡 Pro Tips

**1. Use WSL2 for best Windows integration:**
```bash
# Access Windows files from WSL2
cd /mnt/c/Users/BUUDUY/Workspace/rv32i_cpu_37inst

# Files are shared, no need to copy!
```

**2. Create alias for convenience:**
```bash
echo 'alias spike32="spike --isa=RV32I"' >> ~/.bashrc
source ~/.bashrc

# Now use: spike32 program.elf
```

**3. Parallel golden generation:**
```bash
# Use GNU parallel for speed
sudo apt install parallel

ls tc_*.elf | parallel -j$(nproc) \
    'spike -l --isa=RV32I --log-commits {} 2>&1 | grep "core" > {.}_spike.log'
```

---

## 📞 Support

If you encounter issues:
1. Check Spike GitHub: https://github.com/riscv-software-src/riscv-isa-sim/issues
2. RISC-V Forum: https://groups.google.com/a/groups.riscv.org/g/sw-dev
3. Check dependencies: `ldd $(which spike)`

---

**Good luck! Spike should work perfectly on Linux! 🚀**
