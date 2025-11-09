# Test: tc_9_3_1_double_fwd.S
# Instruction: DBL_FWD
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x2, x1, x1
    add x3, x2, x2
    add x4, x3, x3
_end:
    j _end
