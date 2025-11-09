# Test: tc_4_2_3_signed_neg.S
# Instruction: SGN_NEG
# Auto-generated: Sun Nov 09 15:09:16 +0700 2025

.section .text
.globl _start
_start:
    li x1, -1
    li x2, -10
    add x3, x1, x2
_end:
    j _end
