# Test: tc_1_1_36_sh.S
# Instruction: SH
# Auto-generated: Sun Nov 09 15:09:12 +0700 2025

.section .text
.globl _start
_start:
    la x1, data
    li x2, 0x1234
    sh x2, 0(x1)
    data: .half 0
_end:
    j _end
