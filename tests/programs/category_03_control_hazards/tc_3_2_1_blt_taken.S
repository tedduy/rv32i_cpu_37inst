# Test: tc_3_2_1_blt_taken.S
# Instruction: BLT_T
# Auto-generated: Sun Nov 09 15:09:14 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    blt x1, x2, target
    li x3, 1
    target: li x4, 2
_end:
    j _end
