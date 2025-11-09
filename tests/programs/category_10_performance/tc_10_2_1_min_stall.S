# Test: tc_10_2_1_min_stall.S
# Instruction: MIN_STALL
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    li x1, 1
    li x2, 2
    add x3, x1, x2
    li x4, 3
    add x5, x3, x4
_end:
    j _end
