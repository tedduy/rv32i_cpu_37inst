#!/bin/bash
# =============================================================================
# RV32I Golden Verification Test Suite Runner
# =============================================================================
# Run all 37 ISA golden verification tests with golden model checking
# =============================================================================

# Determine root directory
if [ -d "tb" ] && [ -f "Makefile" ]; then
    # Already in root
    ROOT_DIR="$(pwd)"
elif [ -d "../tb" ] && [ -f "../Makefile" ]; then
    # Running from scripts directory
    ROOT_DIR="$(cd .. && pwd)"
else
    echo "Error: Cannot find project root directory"
    exit 1
fi

cd "$ROOT_DIR"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Arrays to track results
declare -a PASSED_TESTS
declare -a FAILED_TESTS

total=0
passed=0
failed=0

# Golden test list (37 tests)
GOLDEN_TESTS=(
    "tc_1_1_1_add_golden_test"
    "tc_1_1_2_sub_golden_test"
    "tc_1_1_3_sll_golden_test"
    "tc_1_1_4_slt_golden_test"
    "tc_1_1_5_sltu_golden_test"
    "tc_1_1_6_xor_golden_test"
    "tc_1_1_7_srl_golden_test"
    "tc_1_1_8_sra_golden_test"
    "tc_1_1_9_or_golden_test"
    "tc_1_1_10_and_golden_test"
    "tc_1_2_1_addi_golden_test"
    "tc_1_2_2_slti_golden_test"
    "tc_1_2_3_sltiu_golden_test"
    "tc_1_2_4_xori_golden_test"
    "tc_1_2_5_ori_golden_test"
    "tc_1_2_6_andi_golden_test"
    "tc_1_2_7_slli_golden_test"
    "tc_1_2_8_srli_golden_test"
    "tc_1_2_9_srai_golden_test"
    "tc_1_3_1_lw_golden_test"
    "tc_1_3_2_lh_golden_test"
    "tc_1_3_3_lhu_golden_test"
    "tc_1_3_4_lb_golden_test"
    "tc_1_3_5_lbu_golden_test"
    "tc_1_4_1_sw_golden_test"
    "tc_1_4_2_sh_golden_test"
    "tc_1_4_3_sb_golden_test"
    "tc_1_5_1_beq_golden_test"
    "tc_1_5_2_bne_golden_test"
    "tc_1_5_3_blt_golden_test"
    "tc_1_5_4_bge_golden_test"
    "tc_1_5_5_bltu_golden_test"
    "tc_1_5_6_bgeu_golden_test"
    "tc_1_6_1_jal_golden_test"
    "tc_1_6_2_jalr_golden_test"
    "tc_1_7_1_lui_golden_test"
    "tc_1_7_2_auipc_golden_test"
)

# Print header
echo ""
echo -e "${BOLD}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║         RV32I CPU - Golden Verification Suite (37 Tests)         ║${NC}"
echo -e "${BOLD}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Verification Level: Full ISA verification with Python golden model${NC}"
echo ""

# Run each test
for test in "${GOLDEN_TESTS[@]}"; do
    total=$((total + 1))
    
    # Show progress header every 10 tests
    if [ $((total % 10)) -eq 1 ]; then
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        printf "${CYAN}Tests %2d-%2d${NC}\n" $total $((total + 9 < 37 ? total + 9 : 37))
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    fi
    
    # Show test name
    printf "[%2d/37] %-45s" $total "$test"
    
    # Run test and capture output
    if make run TEST=$test VERBOSITY=UVM_LOW 2>&1 | grep -q "TEST PASSED"; then
        echo -e "${GREEN}✓ PASSED${NC}"
        PASSED_TESTS+=("$test")
        passed=$((passed + 1))
    else
        echo -e "${RED}✗ FAILED${NC}"
        FAILED_TESTS+=("$test")
        failed=$((failed + 1))
    fi
done

# Calculate pass rate
pass_rate=$(awk "BEGIN {printf \"%.1f\", ($passed/$total)*100}")

# Print summary
echo ""
echo -e "${BOLD}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║                    Test Suite Summary                             ║${NC}"
echo -e "${BOLD}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Total Tests:${NC}  $total"
echo -e "${GREEN}Passed:${NC}       $passed"
echo -e "${RED}Failed:${NC}       $failed"
echo -e "${YELLOW}Pass Rate:${NC}    ${pass_rate}%"
echo ""

# Show failed tests if any
if [ $failed -gt 0 ]; then
    echo -e "${RED}${BOLD}Failed Tests:${NC}"
    for test in "${FAILED_TESTS[@]}"; do
        echo -e "  ${RED}✗${NC} $test"
    done
    echo ""
fi

echo -e "${BOLD}═══════════════════════════════════════════════════════════════════${NC}"

# Exit with appropriate code
if [ $failed -eq 0 ]; then
    echo -e "${GREEN}${BOLD}✓ ALL TESTS PASSED!${NC}"
    echo ""
    exit 0
else
    echo -e "${RED}${BOLD}✗ $failed TEST(S) FAILED${NC}"
    echo ""
    exit 1
fi
