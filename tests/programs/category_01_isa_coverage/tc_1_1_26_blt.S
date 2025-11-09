# Test: tc_1_1_26_blt.S
# Instruction: BLT
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    blt x1, x2, less
    li x3, 1
    less: li x4, 2
_end:
    j _end
