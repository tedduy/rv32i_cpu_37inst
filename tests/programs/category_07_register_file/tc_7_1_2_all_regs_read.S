# Test: tc_7_1_2_all_regs_read.S
# Instruction: ALL_RD
# Auto-generated: Sun Nov 09 15:09:20 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x2, x1, x1
    add x3, x1, x2
    add x4, x2, x3
_end:
    j _end
