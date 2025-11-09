# Test: tc_10_3_1_cpi_test.S
# Instruction: CPI
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x2, x1, x1
    add x3, x2, x1
    add x4, x3, x2
_end:
    j _end
