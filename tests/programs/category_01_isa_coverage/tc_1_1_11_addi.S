# Test: tc_1_1_11_addi.S
# Instruction: ADDI
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 100
    addi x2, x1, 50
    addi x3, x1, -20
_end:
    j _end
