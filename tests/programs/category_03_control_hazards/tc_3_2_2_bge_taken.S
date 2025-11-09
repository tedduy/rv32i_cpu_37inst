# Test: tc_3_2_2_bge_taken.S
# Instruction: BGE_T
# Auto-generated: Sun Nov 09 15:09:14 +0700 2025

.section .text
.globl _start
_start:
    li x1, 20
    li x2, 10
    bge x1, x2, target
    li x3, 1
    target: li x4, 2
_end:
    j _end
