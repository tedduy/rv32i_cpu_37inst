# Test: tc_4_6_2_store_align.S
# Instruction: ST_ALIGN
# Auto-generated: Sun Nov 09 15:09:17 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 0x11223344
    sw x2, 0(x1)
    data: .word 0
_end:
    j _end
