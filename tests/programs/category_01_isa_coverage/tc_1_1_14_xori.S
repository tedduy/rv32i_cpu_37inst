# Test: tc_1_1_14_xori.S
# Instruction: XORI
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0xFF
    xori x2, x1, 0xAA
    xori x3, x1, 0xFF
_end:
    j _end
