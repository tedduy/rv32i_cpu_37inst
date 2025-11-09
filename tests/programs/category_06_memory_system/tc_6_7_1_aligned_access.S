# Test: tc_6_7_1_aligned_access.S
# Instruction: ALIGN_ACC
# Auto-generated: Sun Nov 09 15:09:20 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    lw x3, 4(x1)
    data: .word 0x12345678, 0xABCDEF00
_end:
    j _end
