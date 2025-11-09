# Test: tc_14_3_1_mixed_stress.S
# Instruction: MIX_STRESS
# Auto-generated: Sun Nov 09 15:09:25 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    add x3, x2, x2
    sw x3, 4(x1)
    beq x3, x2, skip
    li x4, 100
    skip: nop
    data: .word 50, 0
_end:
    j _end
