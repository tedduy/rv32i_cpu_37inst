# Test: tc_2_2_2_waw_interleaved.S
# Instruction: WAW_INT
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 20
    add x1, x2, x2
    addi x1, x1, 5
_end:
    j _end
