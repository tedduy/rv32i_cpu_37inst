# Test: tc_6_5_2_unsigned_load.S
# Instruction: UNSIGN_LD
# Auto-generated: Sun Nov 09 15:09:19 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lbu x2, 0(x1)
    lhu x3, 0(x1)
    data: .byte 0xFF
    .half 0xFFFF
_end:
    j _end
