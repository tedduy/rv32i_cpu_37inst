# Test: tc_9_4_1_fwd_branch.S
# Instruction: FWD_BR
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    addi x2, x1, 5
    beq x2, x1, skip
    li x3, 1
    skip: nop
_end:
    j _end
