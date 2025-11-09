# Test: tc_1_1_17_slli.S
# Instruction: SLLI
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    li x1, 1
    slli x2, x1, 4
    slli x3, x1, 8
_end:
    j _end
