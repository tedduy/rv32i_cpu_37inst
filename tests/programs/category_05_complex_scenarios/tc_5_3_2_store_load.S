# Test: tc_5_3_2_store_load.S
# Instruction: ST_LD
# Auto-generated: Sun Nov 09 15:09:18 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 100
    sw x2, 0(x1)
    lw x3, 0(x1)
    data: .word 0
_end:
    j _end
