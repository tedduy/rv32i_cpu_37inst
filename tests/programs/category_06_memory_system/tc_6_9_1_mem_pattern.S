# Test: tc_6_9_1_mem_pattern.S
# Instruction: MEM_PAT
# Auto-generated: Sun Nov 09 15:09:20 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    lw x3, 4(x1)
    data: .word 0xAAAAAAAA, 0x55555555
_end:
    j _end
