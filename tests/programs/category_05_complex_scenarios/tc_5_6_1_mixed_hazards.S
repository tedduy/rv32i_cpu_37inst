# Test: tc_5_6_1_mixed_hazards.S
# Instruction: MIX_HAZ
# Auto-generated: Sun Nov 09 15:09:18 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x2, x1, x1
    beq x2, x1, skip
    add x3, x2, x1
    skip: nop
_end:
    j _end
