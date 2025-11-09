# Test: tc_4_7_1_byte_sign.S
# Instruction: BYTE_SGN
# Auto-generated: Sun Nov 09 15:09:17 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lb x2, 0(x1)
    lbu x3, 0(x1)
    data: .byte 0xFF
_end:
    j _end
