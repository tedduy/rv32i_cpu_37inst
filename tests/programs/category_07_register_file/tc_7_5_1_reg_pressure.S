# Test: tc_7_5_1_reg_pressure.S
# Instruction: REG_PRESS
# Auto-generated: Sun Nov 09 15:09:21 +0700 2025

.section .text
.globl _start
_start:
    li x1, 1
    li x2, 2
    li x3, 3
    li x4, 4
    li x5, 5
    add x6, x1, x2
    add x7, x3, x4
    add x8, x5, x6
    add x9, x7, x8
_end:
    j _end
