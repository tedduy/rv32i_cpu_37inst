# Test: tc_1_1_25_bne.S
# Instruction: BNE
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    bne x1, x2, notequal
    li x3, 1
    notequal: li x4, 2
_end:
    j _end
