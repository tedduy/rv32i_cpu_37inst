# Test: tc_1_1_27_bge.S
# Instruction: BGE
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    li x1, 20
    li x2, 10
    bge x1, x2, greater
    li x3, 1
    greater: li x4, 2
_end:
    j _end
