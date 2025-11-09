# Test: tc_1_1_8_sll.S
# Instruction: SLL
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 1
    li x2, 4
    sll x3, x1, x2
    li x4, 0xFF
    li x5, 8
    sll x6, x4, x5
_end:
    j _end
