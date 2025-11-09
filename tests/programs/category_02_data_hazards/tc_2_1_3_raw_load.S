# Test: tc_2_1_3_raw_load.S
# Instruction: RAW_LOAD
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    add x3, x2, x2
    data: .word 100
_end:
    j _end
