# Test: tc_9_1_3_wb_to_ex.S
# Instruction: FWD_WB_EX
# Auto-generated: Sun Nov 09 15:09:22 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x2, x1, x1
    nop
    nop
    add x3, x2, x1
_end:
    j _end
