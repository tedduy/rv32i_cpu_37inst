# Test: tc_2_4_1_bypass_ex.S
# Instruction: BP_EX
# Auto-generated: Sun Nov 09 15:09:13 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    addi x2, x1, 5
    add x3, x2, x0
_end:
    j _end
