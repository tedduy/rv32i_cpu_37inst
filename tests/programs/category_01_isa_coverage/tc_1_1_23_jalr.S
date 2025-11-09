# Test: tc_1_1_23_jalr.S
# Instruction: JALR
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x100
    jalr x2, x1, 0
    li x3, 50
_end:
    j _end
