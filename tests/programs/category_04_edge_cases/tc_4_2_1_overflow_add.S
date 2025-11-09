# Test: tc_4_2_1_overflow_add.S
# Instruction: OVF_ADD
# Auto-generated: Sun Nov 09 15:09:16 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x7FFFFFFF
    li x2, 1
    add x3, x1, x2
_end:
    j _end
