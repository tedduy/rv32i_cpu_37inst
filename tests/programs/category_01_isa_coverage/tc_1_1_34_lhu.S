# Test: tc_1_1_34_lhu.S
# Instruction: LHU
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lhu x2, 0(x1)
    lhu x3, 2(x1)
    data: .half 0xFFFF, 0x8000
_end:
    j _end
