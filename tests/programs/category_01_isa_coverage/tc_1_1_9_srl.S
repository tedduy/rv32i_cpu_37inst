# Test: tc_1_1_9_srl.S
# Instruction: SRL
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x80
    li x2, 4
    srl x3, x1, x2
    li x4, 0xFF00
    li x5, 8
    srl x6, x4, x5
_end:
    j _end
