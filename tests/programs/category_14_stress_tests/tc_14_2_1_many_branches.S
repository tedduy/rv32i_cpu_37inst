# Test: tc_14_2_1_many_branches.S
# Instruction: MANY_BR
# Auto-generated: Sun Nov 09 15:09:25 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    beq x1, x1, t1
    t1: bne x1, x0, t2
    t2: blt x0, x1, t3
    t3: bge x1, x0, t4
    t4: nop
_end:
    j _end
