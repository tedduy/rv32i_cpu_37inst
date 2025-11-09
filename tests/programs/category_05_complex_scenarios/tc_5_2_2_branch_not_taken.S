# Test: tc_5_2_2_branch_not_taken.S
# Instruction: BR_NTAKEN
# Auto-generated: Sun Nov 09 15:09:18 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    beq x1, x2, target
    li x3, 1
    li x4, 2
    target: nop
_end:
    j _end
