# Test: tc_1_1_31_lh.S
# Instruction: LH
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lh x2, 0(x1)
    lh x3, 2(x1)
    data: .half 0x1234, 0x5678
_end:
    j _end
