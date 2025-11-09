# Test: tc_2_7_1_x0_write.S
# Instruction: X0_WR
# Auto-generated: Sun Nov 09 15:09:13 +0700 2025

.section .text
.globl _start
_start:
    li x1, 100
    add x0, x1, x1
    add x2, x0, x1
_end:
    j _end
