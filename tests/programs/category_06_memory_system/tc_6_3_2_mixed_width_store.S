# Test: tc_6_3_2_mixed_width_store.S
# Instruction: MIX_ST
# Auto-generated: Sun Nov 09 15:09:19 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 0xFF
    sb x2, 0(x1)
    li x3, 0x1234
    sh x3, 2(x1)
    data: .word 0, 0
_end:
    j _end
