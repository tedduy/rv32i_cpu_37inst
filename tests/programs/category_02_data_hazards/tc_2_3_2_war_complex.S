# Test: tc_2_3_2_war_complex.S
# Instruction: WAR_CPLX
# Auto-generated: Sun Nov 09 15:09:13 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    li x3, 30
    add x2, x1, x3
    add x4, x2, x3
_end:
    j _end
