# Test: tc_1_1_18_srli.S
# Instruction: SRLI
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x80
    srli x2, x1, 4
    li x4, 0xFF00
    srli x5, x4, 8
_end:
    j _end
