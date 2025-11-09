# Test: tc_3_5_1_nested_branch.S
# Instruction: NEST_BR
# Auto-generated: Sun Nov 09 15:09:15 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 10
    beq x1, x2, outer
    li x3, 1
    outer: beq x1, x2, inner
    li x4, 2
    inner: li x5, 3
_end:
    j _end
