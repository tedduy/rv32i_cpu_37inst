# Test: tc_4_5_2_branch_far.S
# Instruction: BR_FAR
# Auto-generated: Sun Nov 09 15:09:17 +0700 2025

.section .text
.globl _start
_start:
    beq x0, x0, far
    nop
    nop
    nop
    far: li x1, 100
_end:
    j _end
