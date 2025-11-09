# Test: tc_3_3_4_jalr_offset.S
# Instruction: JALR_OFF
# Auto-generated: Sun Nov 09 15:09:15 +0700 2025

.section .text
.globl _start
_start:
    la x1, target
    jalr x2, x1, 0
    li x3, 1
    target: li x4, 2
_end:
    j _end
