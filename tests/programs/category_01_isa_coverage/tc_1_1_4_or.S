# Test: tc_1_1_4_or.S
# Instruction: OR
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0xF0
    li x2, 0x0F
    or x3, x1, x2
    li x4, 0xAAAA
    li x5, 0x5555
    or x6, x4, x5
_end:
    j _end
