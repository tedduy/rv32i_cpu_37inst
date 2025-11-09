# Test: tc_2_1_4_raw_double.S
# Instruction: RAW_DBL
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    li x1, 5
    add x2, x1, x1
    add x3, x2, x1
    add x4, x3, x2
_end:
    j _end
