# Test: tc_11_1_1_overflow.S
# Instruction: OVF
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x7FFFFFFF
    li x2, 1
    add x3, x1, x2
_end:
    j _end
