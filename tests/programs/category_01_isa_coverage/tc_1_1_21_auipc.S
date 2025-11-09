# Test: tc_1_1_21_auipc.S
# Instruction: AUIPC
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    auipc x1, 0
    auipc x2, 0x1000
    auipc x3, 0xFFFFF
_end:
    j _end
