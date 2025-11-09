# Test: tc_1_1_10_sra.S
# Instruction: SRA
# Auto-generated: Sun Nov 09 15:09:09 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x80000000
    li x2, 4
    sra x3, x1, x2
_end:
    j _end
