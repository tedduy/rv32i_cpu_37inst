# Test: tc_9_5_1_no_fwd_x0.S
# Instruction: NO_FWD_X0
# Auto-generated: Sun Nov 09 15:09:23 +0700 2025

.section .text
.globl _start
_start:
    add x0, x1, x1
    add x2, x0, x0
_end:
    j _end
