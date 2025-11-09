# Test: tc_5_1_2_waw_stall.S
# Instruction: WAW_STALL
# Auto-generated: Sun Nov 09 15:09:17 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    addi x1, x1, 5
    addi x1, x1, 3
_end:
    j _end
