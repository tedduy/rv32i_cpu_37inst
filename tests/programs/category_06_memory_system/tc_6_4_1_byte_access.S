# Test: tc_6_4_1_byte_access.S
# Instruction: BYTE_ACC
# Auto-generated: Sun Nov 09 15:09:19 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lb x2, 0(x1)
    lb x3, 1(x1)
    lb x4, 2(x1)
    data: .word 0x12345678
_end:
    j _end
