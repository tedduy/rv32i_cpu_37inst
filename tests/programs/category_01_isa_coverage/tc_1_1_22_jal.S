# Test: tc_1_1_22_jal.S
# Instruction: JAL
# Auto-generated: Sun Nov 09 15:09:10 +0700 2025

.section .text
.globl _start
_start:
    jal x1, target
    li x2, 100
    target: li x3, 200
_end:
    j _end
