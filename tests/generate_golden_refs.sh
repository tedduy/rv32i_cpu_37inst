#!/bin/bash
# Batch Golden Reference Generator for Spike ISA Simulator
# This script generates golden reference logs for all 184 RV32I test cases

set -e  # Exit on error

# Configuration
PROGRAMS_DIR="./programs"
GOLDEN_DIR="./golden"
SPIKE_ISA="RV32I"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "RV32I Golden Reference Generator (Spike)"
echo "=========================================="
echo ""

# Check if Spike is installed
if ! command -v spike &> /dev/null; then
    echo -e "${YELLOW}ERROR: Spike not found in PATH${NC}"
    echo "Please install Spike first. See: SPIKE_LINUX_INSTALL.md"
    echo ""
    echo "Quick install (Ubuntu/Debian):"
    echo "  sudo apt-get install device-tree-compiler libboost-regex-dev"
    echo "  git clone https://github.com/riscv-software-src/riscv-isa-sim.git"
    echo "  cd riscv-isa-sim"
    echo "  mkdir build && cd build"
    echo "  ../configure --prefix=/opt/riscv-spike"
    echo "  make -j\$(nproc)"
    echo "  sudo make install"
    echo "  export PATH=/opt/riscv-spike/bin:\$PATH"
    exit 1
fi

# Create golden directory
mkdir -p "$GOLDEN_DIR"

# Count ELF files
total_tests=$(ls -1 "$PROGRAMS_DIR"/tc_*.elf 2>/dev/null | wc -l)

if [ "$total_tests" -eq 0 ]; then
    echo -e "${YELLOW}ERROR: No test ELF files found in $PROGRAMS_DIR${NC}"
    exit 1
fi

echo -e "${BLUE}Found $total_tests ELF files${NC}"
echo ""

# Process each ELF file
count=0
success=0
failed=0

for elf in "$PROGRAMS_DIR"/tc_*.elf; do
    base=$(basename "$elf" .elf)
    count=$((count + 1))
    
    # Progress indicator
    printf "[%3d/%3d] Processing %-50s ... " "$count" "$total_tests" "$base"
    
    # Run Spike and capture output
    if spike -l --isa="$SPIKE_ISA" --log-commits "$elf" 2>&1 | \
        grep "core" > "$GOLDEN_DIR/${base}_spike.log" 2>/dev/null; then
        
        # Check if output file has content
        if [ -s "$GOLDEN_DIR/${base}_spike.log" ]; then
            echo -e "${GREEN}✓${NC}"
            success=$((success + 1))
        else
            echo -e "${YELLOW}✗ (empty)${NC}"
            failed=$((failed + 1))
        fi
    else
        echo -e "${YELLOW}✗ (failed)${NC}"
        failed=$((failed + 1))
    fi
done

# Summary
echo ""
echo "=========================================="
echo "SUMMARY"
echo "=========================================="
echo -e "Total Tests:  ${BLUE}$total_tests${NC}"
echo -e "Successful:   ${GREEN}$success${NC}"
echo -e "Failed:       ${YELLOW}$failed${NC}"
echo -e "Success Rate: $(awk "BEGIN {printf \"%.1f\", $success*100.0/$total_tests}")%"
echo "=========================================="
echo ""
echo "Golden reference logs saved to: $GOLDEN_DIR/"
echo ""

# Show sample output
if [ "$success" -gt 0 ]; then
    sample_log=$(ls "$GOLDEN_DIR"/*.log 2>/dev/null | head -1)
    if [ -n "$sample_log" ]; then
        echo "Sample output from $(basename "$sample_log"):"
        echo "---"
        head -10 "$sample_log"
        if [ $(wc -l < "$sample_log") -gt 10 ]; then
            echo "... (truncated)"
        fi
        echo "---"
    fi
fi

echo ""
echo -e "${GREEN}✅ Golden reference generation complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Copy golden logs back to Windows workspace (if using WSL)"
echo "2. Update UVM sequences with instruction encodings"
echo "3. Run UVM verification: make run TEST=rv32i_test"
