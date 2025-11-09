# Test: tc_2_4_3_bypass_wb.S
# Instruction: BP_WB
# Auto-generated: Sun Nov 09 15:09:13 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    addi x2, x1, 5
    nop
    add x3, x2, x1
_end:
    j _end
