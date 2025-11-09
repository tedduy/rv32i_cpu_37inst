# Test: tc_14_1_1_long_dep.S
# Instruction: LONG_DEP
# Auto-generated: Sun Nov 09 15:09:24 +0700 2025

.section .text
.globl _start
_start:
    li x1, 1
    add x2, x1, x1
    add x3, x2, x2
    add x4, x3, x3
    add x5, x4, x4
_end:
    j _end
