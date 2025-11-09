# Test: tc_2_4_2_bypass_mem.S
# Instruction: BP_MEM
# Auto-generated: Sun Nov 09 15:09:13 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    addi x3, x2, 10
    data: .word 100
_end:
    j _end
