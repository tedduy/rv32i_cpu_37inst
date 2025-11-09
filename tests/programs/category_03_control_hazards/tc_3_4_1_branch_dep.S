# Test: tc_3_4_1_branch_dep.S
# Instruction: BR_DEP
# Auto-generated: Sun Nov 09 15:09:15 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    addi x2, x1, 5
    beq x2, x1, target
    li x3, 1
    target: li x4, 2
_end:
    j _end
