# Test: tc_7_2_1_reg_swap.S
# Instruction: REG_SWAP
# Auto-generated: Sun Nov 09 15:09:21 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    add x3, x1, x0
    add x1, x2, x0
    add x2, x3, x0
_end:
    j _end
