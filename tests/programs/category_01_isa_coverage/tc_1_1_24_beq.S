# Test: tc_1_1_24_beq.S
# Instruction: BEQ
# Auto-generated: Sun Nov 09 15:09:11 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 10
    beq x1, x2, equal
    li x3, 1
    equal: li x4, 2
_end:
    j _end
