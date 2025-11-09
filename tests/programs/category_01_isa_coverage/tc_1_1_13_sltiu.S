# Test: tc_1_1_13_sltiu.S
# Instruction: SLTIU
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    sltiu x2, x1, 20
    li x4, -1
    sltiu x5, x4, 5
_end:
    j _end
