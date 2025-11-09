# Test: tc_4_2_2_underflow_sub.S
# Instruction: UDF_SUB
# Auto-generated: Sun Nov 09 15:09:16 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x80000000
    li x2, 1
    sub x3, x1, x2
_end:
    j _end
