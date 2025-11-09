# Test: tc_12_1_1_jal_forward.S
# Instruction: JAL_FWD
# Auto-generated: Sun Nov 09 15:09:24 +0700 2025

.section .text
.globl _start
_start:
    jal x1, target
    li x2, 1
    target: li x3, 2
_end:
    j _end
