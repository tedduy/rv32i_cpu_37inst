# Test: tc_5_4_1_nested_loops.S
# Instruction: NEST_LOOP
# Auto-generated: Sun Nov 09 15:09:18 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0
    li x2, 3
    outer: li x3, 0
    inner: addi x3, x3, 1
    blt x3, x2, inner
    addi x1, x1, 1
    blt x1, x2, outer
_end:
    j _end
