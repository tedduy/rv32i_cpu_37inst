# Test: tc_6_1_2_consecutive_stores.S
# Instruction: CONS_ST
# Auto-generated: Sun Nov 09 15:09:19 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 10
    sw x2, 0(x1)
    sw x2, 4(x1)
    data: .word 0, 0
_end:
    j _end
