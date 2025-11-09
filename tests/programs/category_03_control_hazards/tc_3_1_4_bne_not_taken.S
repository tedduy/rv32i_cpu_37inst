# Test: tc_3_1_4_bne_not_taken.S
# Instruction: BNE_NT
# Auto-generated: Sun Nov 09 15:09:14 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 10
    bne x1, x2, target
    li x3, 1
    li x4, 2
    target: nop
_end:
    j _end
