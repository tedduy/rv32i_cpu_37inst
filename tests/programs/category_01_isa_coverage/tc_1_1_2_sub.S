# Test: tc_1_1_2_sub.S
# Instruction: SUB
# Auto-generated: Sun Nov 09 15:09:08 +0700 2025

.section .text
.globl _start
_start:
    li x1, 100
    li x2, 30
    sub x3, x1, x2
    li x4, 50
    li x5, 100
    sub x6, x4, x5
_end:
    j _end
