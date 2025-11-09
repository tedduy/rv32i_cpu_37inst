# Test: tc_1_1_7_sltu.S
# Instruction: SLTU
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    sltu x3, x1, x2
    li x4, 0xFFFFFFFF
    li x5, 5
    sltu x6, x4, x5
_end:
    j _end
