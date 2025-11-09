# Test: tc_12_3_1_ret_sequence.S
# Instruction: RET_SEQ
# Auto-generated: Sun Nov 09 15:09:24 +0700 2025

.section .text
.globl _start
_start:
    jal x1, func
    li x2, 100
    j end
    func: li x3, 50
    jalr x0, x1, 0
    end: nop
_end:
    j _end
