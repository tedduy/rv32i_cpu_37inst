# Test: tc_1_1_3_and.S
# Instruction: AND
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0xFF
    li x2, 0x0F
    and x3, x1, x2
    li x4, 0xAAAA
    li x5, 0x5555
    and x6, x4, x5
_end:
    j _end
