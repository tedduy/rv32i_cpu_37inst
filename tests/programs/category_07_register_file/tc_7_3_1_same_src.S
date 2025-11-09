# Test: tc_7_3_1_same_src.S
# Instruction: SAME_SRC
# Auto-generated: Sun Nov 09 15:09:21 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x2, x1, x1
    and x3, x1, x1
    or x4, x1, x1
_end:
    j _end
