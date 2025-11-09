# Test: tc_12_1_2_jal_backward.S
# Instruction: JAL_BCK
# Auto-generated: Sun Nov 09 15:09:24 +0700 2025

.section .text
.globl _start
_start:
    j skip
    target: li x3, 2
    j end
    skip: jal x1, target
    end: nop
_end:
    j _end
