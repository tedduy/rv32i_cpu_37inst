# Test: tc_6_6_1_offset_positive.S
# Instruction: OFF_POS
# Auto-generated: Sun Nov 09 15:09:20 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 8(x1)
    data: .word 0, 0, 100
_end:
    j _end
