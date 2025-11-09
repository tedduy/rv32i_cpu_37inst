# Test: tc_1_1_1_add.S
# Instruction: ADD
# Auto-generated: Sun Nov 09 15:09:08 +0700 2025

.section .text
.globl _start
_start:
    li x1, 16
    li x2, 32
    add x3, x1, x2
    li x4, 0xFFFFFFFF
    li x5, 1
    add x6, x4, x5
_end:
    j _end
