# Test: tc_1_1_33_lbu.S
# Instruction: LBU
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lbu x2, 0(x1)
    lbu x3, 1(x1)
    data: .byte 0xFF, 0x80
_end:
    j _end
