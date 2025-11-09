# Test: tc_6_5_1_signed_load.S
# Instruction: SGN_LD
# Auto-generated: Sun Nov 09 15:09:19 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lb x2, 0(x1)
    lh x3, 0(x1)
    data: .byte 0xFF
    .half 0xFFFF
_end:
    j _end
