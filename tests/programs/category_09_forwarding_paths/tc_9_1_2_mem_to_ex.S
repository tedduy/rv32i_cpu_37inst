# Test: tc_9_1_2_mem_to_ex.S
# Instruction: FWD_MEM_EX
# Auto-generated: Sun Nov 09 15:09:22 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    nop
    add x3, x2, x2
    data: .word 50
_end:
    j _end
