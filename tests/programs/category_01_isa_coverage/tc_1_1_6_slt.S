# Test: tc_1_1_6_slt.S
# Instruction: SLT
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    slt x3, x1, x2
    li x4, -10
    li x5, 5
    slt x6, x4, x5
_end:
    j _end
