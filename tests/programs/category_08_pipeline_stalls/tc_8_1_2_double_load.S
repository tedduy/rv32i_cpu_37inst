# Test: tc_8_1_2_double_load.S
# Instruction: DBL_LD
# Auto-generated: Sun Nov 09 15:09:22 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    lw x3, 4(x1)
    add x4, x2, x3
    data: .word 10, 20
_end:
    j _end
