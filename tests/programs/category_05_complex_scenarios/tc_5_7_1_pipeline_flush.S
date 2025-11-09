# Test: tc_5_7_1_pipeline_flush.S
# Instruction: PIPE_FLUSH
# Auto-generated: Sun Nov 09 15:09:18 +0700 2025

.section .text
.globl _start
_start:
    li x1, 10
    li x2, 10
    beq x1, x2, target
    nop
    nop
    target: li x3, 100
_end:
    j _end
