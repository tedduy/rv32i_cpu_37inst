# Test: tc_11_2_2_shift_zero.S
# Instruction: SH_ZERO
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0xFF
    li x2, 0
    sll x3, x1, x2
_end:
    j _end
