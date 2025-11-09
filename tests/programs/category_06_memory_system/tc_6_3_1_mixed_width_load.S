# Test: tc_6_3_1_mixed_width_load.S
# Instruction: MIX_LD
# Auto-generated: Sun Nov 09 15:09:19 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lb x2, 0(x1)
    lh x3, 0(x1)
    lw x4, 0(x1)
    data: .word 0x12345678
_end:
    j _end
