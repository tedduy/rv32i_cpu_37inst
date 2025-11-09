# Test: tc_7_2_2_reg_rotate.S
# Instruction: REG_ROT
# Auto-generated: Sun Nov 09 15:09:21 +0700 2025

.section .text
.globl _start
_start:
    li x1, 1
    li x2, 2
    li x3, 3
    add x4, x1, x0
    add x1, x2, x0
    add x2, x3, x0
    add x3, x4, x0
_end:
    j _end
