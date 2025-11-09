# Test: tc_9_2_2_mem_to_mem.S
# Instruction: FWD_MEM_MEM
# Auto-generated: Sun Nov 09 15:09:22 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    lw x2, 0(x1)
    sw x2, 4(x1)
    data: .word 100, 0
_end:
    j _end
