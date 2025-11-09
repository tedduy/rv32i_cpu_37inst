# Test: tc_6_1_1_consecutive_loads.S
# Instruction: CONS_LD
# Auto-generated: Sun Nov 09 15:09:18 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    lw x3, 4(x1)
    lw x4, 8(x1)
    data: .word 1, 2, 3
_end:
    j _end
