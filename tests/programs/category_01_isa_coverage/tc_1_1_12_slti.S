# Test: tc_1_1_12_slti.S
# Instruction: SLTI
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    slti x2, x1, 20
    slti x3, x1, 5
_end:
    j _end
