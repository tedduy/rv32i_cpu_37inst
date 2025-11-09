# Test: tc_1_1_30_lb.S
# Instruction: LB
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lb x2, 0(x1)
    lb x3, 1(x1)
    data: .byte 0x12, 0x34
_end:
    j _end
