# Test: tc_4_5_1_branch_zero.S
# Instruction: BR_ZERO
# Auto-generated: Sun Nov 09 15:09:17 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0
    li x2, 0
    beq x1, x2, target
    li x3, 1
    target: li x4, 2
_end:
    j _end
