# Test: tc_9_3_2_cross_fwd.S
# Instruction: CROSS_FWD
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    add x3, x1, x2
    add x4, x3, x2
    add x5, x3, x4
_end:
    j _end
