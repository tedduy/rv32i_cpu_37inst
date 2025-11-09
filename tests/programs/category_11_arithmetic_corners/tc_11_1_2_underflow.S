# Test: tc_11_1_2_underflow.S
# Instruction: UDF
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x80000000
    li x2, 1
    sub x3, x1, x2
_end:
    j _end
