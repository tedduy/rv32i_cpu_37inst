# Test: tc_1_1_16_andi.S
# Instruction: ANDI
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0xFF
    andi x2, x1, 0x0F
    andi x3, x1, 0xF0
_end:
    j _end
