# Test: tc_2_2_1_waw_consecutive.S
# Instruction: WAW_CONS
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    addi x1, x1, 5
    addi x1, x1, 3
_end:
    j _end
