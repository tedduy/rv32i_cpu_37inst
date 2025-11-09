# Test: tc_8_1_1_load_stall.S
# Instruction: LD_STALL
# Auto-generated: Sun Nov 09 15:09:21 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    add x3, x2, x2
    data: .word 100
_end:
    j _end
