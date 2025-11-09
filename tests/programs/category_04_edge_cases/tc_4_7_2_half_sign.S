# Test: tc_4_7_2_half_sign.S
# Instruction: HALF_SGN
# Auto-generated: Sun Nov 09 15:09:17 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lh x2, 0(x1)
    lhu x3, 0(x1)
    data: .half 0xFFFF
_end:
    j _end
