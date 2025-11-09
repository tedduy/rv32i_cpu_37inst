# Test: tc_6_8_1_addr_calculation.S
# Instruction: ADDR_CALC
# Auto-generated: Sun Nov 09 15:09:20 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 4
    add x3, x1, x2
    lw x4, 0(x3)
    data: .word 0, 100
_end:
    j _end
