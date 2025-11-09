# Test: tc_6_4_2_half_access.S
# Instruction: HALF_ACC
# Auto-generated: Sun Nov 09 15:09:19 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lh x2, 0(x1)
    lh x3, 2(x1)
    data: .word 0x12345678
_end:
    j _end
