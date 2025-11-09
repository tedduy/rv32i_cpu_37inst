# Test: tc_2_3_1_war_basic.S
# Instruction: WAR_BASE
# Auto-generated: Sun Nov 09 15:09:13 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    add x1, x1, x2
    add x3, x1, x2
_end:
    j _end
