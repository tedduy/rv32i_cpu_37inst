# Test: tc_1_1_37_sw.S
# Instruction: SW
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 0x12345678
    sw x2, 0(x1)
    data: .word 0
_end:
    j _end
