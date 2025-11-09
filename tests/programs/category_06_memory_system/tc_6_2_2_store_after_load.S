# Test: tc_6_2_2_store_after_load.S
# Instruction: ST_AFT_LD
# Auto-generated: Sun Nov 09 15:09:19 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    addi x2, x2, 10
    sw x2, 0(x1)
    data: .word 50
_end:
    j _end
