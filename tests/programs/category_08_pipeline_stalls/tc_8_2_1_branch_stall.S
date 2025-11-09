# Test: tc_8_2_1_branch_stall.S
# Instruction: BR_STALL
# Auto-generated: Sun Nov 09 15:09:22 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 10
    beq x1, x2, target
    nop
    target: li x3, 100
_end:
    j _end
