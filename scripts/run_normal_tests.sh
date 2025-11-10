#!/bin/bash
# =============================================================================
# RV32I Functional Test Suite Runner
# =============================================================================
# Run all 158 functional tests (Critical/High/Medium/Low priority)
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

# Print header
echo ""
echo -e "${BOLD}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║          RV32I CPU - Functional Test Suite (158 Tests)           ║${NC}"
echo -e "${BOLD}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Verification Level: Functional (Design verification without golden model)${NC}"
echo ""

# Get list of functional tests from test package (exclude golden tests)
test_list=$(grep '`include "tests/' tb/tests/test_pkg.sv | grep -v 'golden_verification' | grep -v 'base_test' | sed 's/.*\/\(tc_[^.]*\)_test.sv.*/\1/')

# Check if we found tests
if [ -z "$test_list" ]; then
    echo -e "${RED}Error: No functional tests found in tb/tests/test_pkg.sv${NC}"
    exit 1
fi

for test_name in $test_list; do
    total=$((total + 1))
    
    # Show progress header every 20 tests
    if [ $((total % 20)) -eq 1 ]; then
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        printf "${CYAN}Tests %3d-%3d${NC}\n" $total $((total + 19 < 158 ? total + 19 : 158))
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    fi
    
    # Show test name
    printf "[%3d/158] %-45s" $total "$test_name"
    
    # Run test silently
    make run TEST="${test_name}_test" VERBOSITY=UVM_LOW > /dev/null 2>&1
    
    # Check result from log file
    log_file="logs/normal/sim_${test_name}_test.log"
    if [ -f "$log_file" ] && grep -q "TEST PASSED\|UVM_INFO.*Simulation complete" "$log_file"; then
        echo -e "${GREEN}✓ PASSED${NC}"
        PASSED_TESTS+=("$test_name")
        passed=$((passed + 1))
    else
        echo -e "${RED}✗ FAILED${NC}"
        FAILED_TESTS+=("$test_name")
        failed=$((failed + 1))
    fi
done

# Calculate pass rate
if [ $total -eq 0 ]; then
    pass_rate="0.0"
else
    pass_rate=$(awk "BEGIN {printf \"%.1f\", ($passed/$total)*100}")
fi

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
