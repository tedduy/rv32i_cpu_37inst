# Test: tc_3_3_3_jalr_basic.S
# Instruction: JALR_BASE
# Auto-generated: Sun Nov 09 15:09:15 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x100
    jalr x2, x1, 0
_end:
    j _end
