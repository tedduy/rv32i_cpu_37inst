# Test: tc_2_1_1_raw_rtype.S
# Instruction: RAW_R
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x2, x1, x1
    add x3, x2, x1
_end:
    j _end
