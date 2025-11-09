# Test: tc_4_8_1_nop_sequence.S
# Instruction: NOP_SEQ
# Auto-generated: Sun Nov 09 15:09:17 +0700 2025

.section .text
.globl _start
_start:
    nop
    nop
    nop
    li x1, 100
_end:
    j _end
