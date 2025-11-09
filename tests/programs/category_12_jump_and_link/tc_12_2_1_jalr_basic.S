# Test: tc_12_2_1_jalr_basic.S
# Instruction: JALR_BASE
# Auto-generated: Sun Nov 09 15:09:24 +0700 2025

.section .text
.globl _start
_start:
    la x1, target
    jalr x2, x1, 0
    li x3, 1
    target: li x4, 2
_end:
    j _end
