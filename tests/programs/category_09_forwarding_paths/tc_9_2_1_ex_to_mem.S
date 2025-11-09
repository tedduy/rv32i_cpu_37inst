# Test: tc_9_2_1_ex_to_mem.S
# Instruction: FWD_EX_MEM
# Auto-generated: Sun Nov 09 15:09:22 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 100
    sw x2, 0(x1)
    data: .word 0
_end:
    j _end
