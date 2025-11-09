#!/bin/bash
# Automated RISC-V RV32I Toolchain Installer for Windows
# Date: November 9, 2025

set -e

# Configuration
INSTALL_DIR="/c/tools"
XPACK_VERSION="13.2.0-2"
DOWNLOAD_URL="https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v${XPACK_VERSION}/xpack-riscv-none-elf-gcc-${XPACK_VERSION}-win32-x64.zip"
TOOLCHAIN_NAME="xpack-riscv-none-elf-gcc-${XPACK_VERSION}"
ZIPFILE="xpack-riscv-none-elf-gcc-${XPACK_VERSION}-win32-x64.zip"

echo "=========================================="
echo "RISC-V RV32I Toolchain Installer"
echo "=========================================="
echo ""
echo "Installing to: $INSTALL_DIR"
echo "Version: xPack RISC-V GCC $XPACK_VERSION"
echo ""

# Check if already installed
if command -v riscv-none-elf-gcc &> /dev/null; then
    echo "⚠️  RISC-V toolchain already installed:"
    riscv-none-elf-gcc --version | head -1
    echo ""
    read -p "Reinstall? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
fi

# Create installation directory
echo "Creating installation directory..."
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Download toolchain
echo ""
echo "Downloading xPack RISC-V GCC..."
echo "URL: $DOWNLOAD_URL"
echo ""

if [ -f "$ZIPFILE" ]; then
    echo "⚠️  Archive already exists. Skipping download."
else
    curl -L -O "$DOWNLOAD_URL" || {
        echo "❌ Download failed!"
        echo ""
        echo "Please download manually from:"
        echo "  https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases"
        echo ""
        echo "And extract to: $INSTALL_DIR"
        exit 1
    }
fi

# Extract toolchain
echo ""
echo "Extracting toolchain..."
if [ -d "$TOOLCHAIN_NAME" ]; then
    echo "⚠️  Removing existing installation..."
    rm -rf "$TOOLCHAIN_NAME"
fi

unzip -q "$ZIPFILE" || {
    echo "❌ Extraction failed!"
    exit 1
}

# Verify extraction
if [ ! -d "$TOOLCHAIN_NAME" ]; then
    echo "❌ Installation directory not found after extraction!"
    exit 1
fi

# Setup PATH
TOOLCHAIN_PATH="$INSTALL_DIR/$TOOLCHAIN_NAME/bin"

if [ ! -d "$TOOLCHAIN_PATH" ]; then
    echo "❌ Toolchain bin directory not found!"
    exit 1
fi

export PATH="$TOOLCHAIN_PATH:$PATH"

# Add to .bashrc if not already present
echo ""
echo "Updating ~/.bashrc..."

if grep -q "xpack-riscv-none-elf-gcc" ~/.bashrc 2>/dev/null; then
    echo "⚠️  PATH already configured in ~/.bashrc"
else
    cat >> ~/.bashrc << EOF

# RISC-V Toolchain (added $(date))
export PATH="$TOOLCHAIN_PATH:\$PATH"
EOF
    echo "✅ Added to ~/.bashrc"
fi

# Verify installation
echo ""
echo "=========================================="
echo "Verification"
echo "=========================================="
echo ""

if command -v riscv-none-elf-gcc &> /dev/null; then
    echo "✅ riscv-none-elf-gcc:"
    riscv-none-elf-gcc --version | head -1
    echo ""
    
    echo "✅ riscv-none-elf-as:"
    riscv-none-elf-as --version | head -1
    echo ""
    
    echo "✅ riscv-none-elf-objcopy:"
    riscv-none-elf-objcopy --version | head -1
    echo ""
    
    echo "✅ riscv-none-elf-objdump:"
    riscv-none-elf-objdump --version | head -1
    echo ""
else
    echo "❌ Installation verification failed!"
    echo "Toolchain not found in PATH."
    exit 1
fi

# Test compilation
echo "=========================================="
echo "Test Compilation"
echo "=========================================="
echo ""

TEST_FILE="/tmp/test_rv32i.S"
cat > "$TEST_FILE" << 'EOF'
.section .text
.globl _start
_start:
    li x1, 42
    li x2, 100
    add x3, x1, x2
    j _start
EOF

echo "Compiling test program..."
riscv-none-elf-gcc -march=rv32i -mabi=ilp32 -nostartfiles -Wl,-Ttext=0x0 "$TEST_FILE" -o /tmp/test_rv32i.elf || {
    echo "❌ Test compilation failed!"
    exit 1
}

echo "✅ Test compilation successful!"
echo ""

echo "Disassembly:"
riscv-none-elf-objdump -d /tmp/test_rv32i.elf | head -20
echo ""

# Cleanup test files
rm -f /tmp/test_rv32i.S /tmp/test_rv32i.elf

echo "=========================================="
echo "✅ Installation Complete!"
echo "=========================================="
echo ""
echo "Toolchain installed to:"
echo "  $TOOLCHAIN_PATH"
echo ""
echo "Tools available:"
echo "  - riscv-none-elf-gcc    (C compiler)"
echo "  - riscv-none-elf-as     (Assembler)"
echo "  - riscv-none-elf-ld     (Linker)"
echo "  - riscv-none-elf-objcopy (Binary converter)"
echo "  - riscv-none-elf-objdump (Disassembler)"
echo ""
echo "Compiler flags for RV32I:"
echo "  -march=rv32i -mabi=ilp32"
echo ""
echo "Next steps:"
echo "  1. Restart terminal or run: source ~/.bashrc"
echo "  2. Test: riscv-none-elf-gcc --version"
echo "  3. Compile your test: cd tests/programs && make"
echo ""
echo "📚 Documentation: tests/scripts/install_riscv_toolchain.md"
echo ""
