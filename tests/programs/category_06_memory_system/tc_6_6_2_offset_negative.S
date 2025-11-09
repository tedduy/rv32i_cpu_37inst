# Test: tc_6_6_2_offset_negative.S
# Instruction: OFF_NEG
# Auto-generated: Sun Nov 09 15:09:20 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    addi x1, x1, 8
    lw x2, -4(x1)
    data: .word 100, 0, 0
_end:
    j _end
