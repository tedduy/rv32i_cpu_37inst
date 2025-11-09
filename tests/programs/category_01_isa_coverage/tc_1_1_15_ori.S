# Test: tc_1_1_15_ori.S
# Instruction: ORI
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0xF0
    ori x2, x1, 0x0F
    ori x3, x1, 0xFF
_end:
    j _end
