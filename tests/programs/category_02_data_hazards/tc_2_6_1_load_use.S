# Test: tc_2_6_1_load_use.S
# Instruction: LOAD_USE
# Auto-generated: Sun Nov 09 15:09:13 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    add x3, x2, x2
    data: .word 50
_end:
    j _end
