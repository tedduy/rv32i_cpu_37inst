# Test: tc_3_4_2_branch_chain.S
# Instruction: BR_CHAIN
# Auto-generated: Sun Nov 09 15:09:15 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 10
    beq x1, x2, t1
    li x3, 1
    t1: bne x1, x2, t2
    li x4, 2
    t2: nop
_end:
    j _end
