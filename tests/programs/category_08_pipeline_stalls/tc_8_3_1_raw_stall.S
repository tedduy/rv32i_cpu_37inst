# Test: tc_8_3_1_raw_stall.S
# Instruction: RAW_STALL
# Auto-generated: Sun Nov 09 15:09:22 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    addi x2, x1, 5
    add x3, x2, x1
_end:
    j _end
