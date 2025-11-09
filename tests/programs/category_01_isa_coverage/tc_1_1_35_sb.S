# Test: tc_1_1_35_sb.S
# Instruction: SB
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 0x42
    sb x2, 0(x1)
    data: .byte 0
_end:
    j _end
