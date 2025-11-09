# Test: tc_5_2_1_branch_taken.S
# Instruction: BR_TAKEN
# Auto-generated: Sun Nov 09 15:09:18 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 10
    beq x1, x2, target
    li x3, 1
    target: li x4, 2
_end:
    j _end
