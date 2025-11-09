# Test: tc_8_5_1_nop_insert.S
# Instruction: NOP_INS
# Auto-generated: Sun Nov 09 15:09:22 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    nop
    add x2, x1, x1
    nop
    add x3, x2, x1
_end:
    j _end
