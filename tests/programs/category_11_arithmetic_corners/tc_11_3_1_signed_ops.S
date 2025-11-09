# Test: tc_11_3_1_signed_ops.S
# Instruction: SGN_OPS
# Auto-generated: Sun Nov 09 15:09:24 +0700 2025

.section .text
.globl _start
_start:
    li x1, -1
    li x2, -10
    add x3, x1, x2
    slt x4, x1, x2
_end:
    j _end
