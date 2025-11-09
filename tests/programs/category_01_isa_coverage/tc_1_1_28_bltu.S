# Test: tc_1_1_28_bltu.S
# Instruction: BLTU
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    bltu x1, x2, less_u
    li x3, 1
    less_u: li x4, 2
_end:
    j _end
