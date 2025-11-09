# Test: tc_1_1_5_xor.S
# Instruction: XOR
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0xFF
    li x2, 0xAA
    xor x3, x1, x2
    li x4, 0xFFFF
    li x5, 0xFFFF
    xor x6, x4, x5
_end:
    j _end
