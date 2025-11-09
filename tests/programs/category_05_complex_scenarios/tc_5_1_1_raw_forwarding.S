# Test: tc_5_1_1_raw_forwarding.S
# Instruction: RAW_FWD
# Auto-generated: Sun Nov 09 15:09:17 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    add x2, x1, x1
    add x3, x2, x1
_end:
    j _end
