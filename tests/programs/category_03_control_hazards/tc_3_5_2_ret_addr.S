# Test: tc_3_5_2_ret_addr.S
# Instruction: RET_ADDR
# Auto-generated: Sun Nov 09 15:09:15 +0700 2025

.section .text
.globl _start
_start:
    jal x1, func
    li x2, 99
    j end
    func: li x3, 50
    jalr x0, x1, 0
    end: nop
_end:
    j _end
