# Test: tc_11_4_1_logic_patterns.S
# Instruction: LOGIC_PAT
# Auto-generated: Sun Nov 09 15:09:24 +0700 2025

.section .text
.globl _start
_start:
    li x1, 0xFFFF
    li x2, 0xAAAA
    and x3, x1, x2
    or x4, x1, x2
    xor x5, x1, x2
_end:
    j _end
