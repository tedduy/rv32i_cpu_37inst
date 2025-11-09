# Test: tc_1_1_29_bgeu.S
# Instruction: BGEU
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    li x1, 20
    li x2, 10
    bgeu x1, x2, greater_u
    li x3, 1
    greater_u: li x4, 2
_end:
    j _end
