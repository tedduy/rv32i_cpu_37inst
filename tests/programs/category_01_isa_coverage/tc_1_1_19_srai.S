# Test: tc_1_1_19_srai.S
# Instruction: SRAI
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x80000000
    srai x2, x1, 4
    li x4, 0xFF00
    srai x5, x4, 8
_end:
    j _end
