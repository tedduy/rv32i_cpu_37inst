# Test: tc_6_10_1_load_bypass.S
# Instruction: LD_BYPASS
# Auto-generated: Sun Nov 09 15:09:20 +0700 2025

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
