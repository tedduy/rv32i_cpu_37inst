# Test: tc_4_3_3_sra_neg.S
# Instruction: SRA_NEG
# Auto-generated: Sun Nov 09 15:09:16 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0x80000000
    li x2, 1
    sra x3, x1, x2
_end:
    j _end
