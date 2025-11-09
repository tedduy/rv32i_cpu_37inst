# Test: tc_2_5_2_chain_dep.S
# Instruction: CHAIN_DEP
# Auto-generated: Sun Nov 09 15:09:13 +0700 2025

.section .text
.globl _start
_start:
    li x1, 1
    slli x2, x1, 1
    slli x3, x2, 1
    slli x4, x3, 1
_end:
    j _end
