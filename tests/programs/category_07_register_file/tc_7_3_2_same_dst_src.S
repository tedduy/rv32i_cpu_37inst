# Test: tc_7_3_2_same_dst_src.S
# Instruction: SAME_DST
# Auto-generated: Sun Nov 09 15:09:21 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x1, x1, x1
    slli x1, x1, 1
_end:
    j _end
