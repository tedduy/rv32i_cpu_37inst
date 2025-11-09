#!/usr/bin/tclsh
# Complete Test Case Database for All 158 RV32I Tests
# This file contains instruction patterns for auto-generation

# Returns test patterns for a given category
proc get_test_patterns {category_id} {
    switch $category_id {
        1 { # ISA Coverage - 37 instructions
            return [list \
                {tc_1_1_1_add.S "ADD" {"li x1, 16" "li x2, 32" "add x3, x1, x2" "li x4, 0xFFFFFFFF" "li x5, 1" "add x6, x4, x5"}} \
                {tc_1_1_2_sub.S "SUB" {"li x1, 100" "li x2, 30" "sub x3, x1, x2" "li x4, 50" "li x5, 100" "sub x6, x4, x5"}} \
                {tc_1_1_3_and.S "AND" {"li x1, 0xFF" "li x2, 0x0F" "and x3, x1, x2" "li x4, 0xAAAA" "li x5, 0x5555" "and x6, x4, x5"}} \
                {tc_1_1_4_or.S "OR" {"li x1, 0xF0" "li x2, 0x0F" "or x3, x1, x2" "li x4, 0xAAAA" "li x5, 0x5555" "or x6, x4, x5"}} \
                {tc_1_1_5_xor.S "XOR" {"li x1, 0xFF" "li x2, 0xAA" "xor x3, x1, x2" "li x4, 0xFFFF" "li x5, 0xFFFF" "xor x6, x4, x5"}} \
                {tc_1_1_6_slt.S "SLT" {"li x1, 10" "li x2, 20" "slt x3, x1, x2" "li x4, -10" "li x5, 5" "slt x6, x4, x5"}} \
                {tc_1_1_7_sltu.S "SLTU" {"li x1, 10" "li x2, 20" "sltu x3, x1, x2" "li x4, 0xFFFFFFFF" "li x5, 5" "sltu x6, x4, x5"}} \
                {tc_1_1_8_sll.S "SLL" {"li x1, 1" "li x2, 4" "sll x3, x1, x2" "li x4, 0xFF" "li x5, 8" "sll x6, x4, x5"}} \
                {tc_1_1_9_srl.S "SRL" {"li x1, 0x80" "li x2, 4" "srl x3, x1, x2" "li x4, 0xFF00" "li x5, 8" "srl x6, x4, x5"}} \
                {tc_1_1_10_sra.S "SRA" {"li x1, 0x80000000" "li x2, 4" "sra x3, x1, x2"}} \
                {tc_1_1_11_addi.S "ADDI" {"li x1, 100" "addi x2, x1, 50" "addi x3, x1, -20"}} \
                {tc_1_1_12_slti.S "SLTI" {"li x1, 10" "slti x2, x1, 20" "slti x3, x1, 5"}} \
                {tc_1_1_13_sltiu.S "SLTIU" {"li x1, 10" "sltiu x2, x1, 20" "li x4, -1" "sltiu x5, x4, 5"}} \
                {tc_1_1_14_xori.S "XORI" {"li x1, 0xFF" "xori x2, x1, 0xAA" "xori x3, x1, 0xFF"}} \
                {tc_1_1_15_ori.S "ORI" {"li x1, 0xF0" "ori x2, x1, 0x0F" "ori x3, x1, 0xFF"}} \
                {tc_1_1_16_andi.S "ANDI" {"li x1, 0xFF" "andi x2, x1, 0x0F" "andi x3, x1, 0xF0"}} \
                {tc_1_1_17_slli.S "SLLI" {"li x1, 1" "slli x2, x1, 4" "slli x3, x1, 8"}} \
                {tc_1_1_18_srli.S "SRLI" {"li x1, 0x80" "srli x2, x1, 4" "li x4, 0xFF00" "srli x5, x4, 8"}} \
                {tc_1_1_19_srai.S "SRAI" {"li x1, 0x80000000" "srai x2, x1, 4" "li x4, 0xFF00" "srai x5, x4, 8"}} \
                {tc_1_1_20_lui.S "LUI" {"lui x1, 0x12345" "lui x2, 0xABCDE" "lui x3, 0xFFFFF"}} \
                {tc_1_1_21_auipc.S "AUIPC" {"auipc x1, 0" "auipc x2, 0x1000" "auipc x3, 0xFFFFF"}} \
                {tc_1_1_22_jal.S "JAL" {"jal x1, target" "li x2, 100" "target: li x3, 200"}} \
                {tc_1_1_23_jalr.S "JALR" {"li x1, 0x100" "jalr x2, x1, 0" "li x3, 50"}} \
                {tc_1_1_24_beq.S "BEQ" {"li x1, 10" "li x2, 10" "beq x1, x2, equal" "li x3, 1" "equal: li x4, 2"}} \
                {tc_1_1_25_bne.S "BNE" {"li x1, 10" "li x2, 20" "bne x1, x2, notequal" "li x3, 1" "notequal: li x4, 2"}} \
                {tc_1_1_26_blt.S "BLT" {"li x1, 10" "li x2, 20" "blt x1, x2, less" "li x3, 1" "less: li x4, 2"}} \
                {tc_1_1_27_bge.S "BGE" {"li x1, 20" "li x2, 10" "bge x1, x2, greater" "li x3, 1" "greater: li x4, 2"}} \
                {tc_1_1_28_bltu.S "BLTU" {"li x1, 10" "li x2, 20" "bltu x1, x2, less_u" "li x3, 1" "less_u: li x4, 2"}} \
                {tc_1_1_29_bgeu.S "BGEU" {"li x1, 20" "li x2, 10" "bgeu x1, x2, greater_u" "li x3, 1" "greater_u: li x4, 2"}} \
                {tc_1_1_30_lb.S "LB" {"la x1, data" "lb x2, 0(x1)" "lb x3, 1(x1)" "data: .byte 0x12, 0x34"}} \
                {tc_1_1_31_lh.S "LH" {"la x1, data" "lh x2, 0(x1)" "lh x3, 2(x1)" "data: .half 0x1234, 0x5678"}} \
                {tc_1_1_32_lw.S "LW" {"la x1, data" "lw x2, 0(x1)" "lw x3, 4(x1)" "data: .word 0x12345678, 0xABCDEF00"}} \
                {tc_1_1_33_lbu.S "LBU" {"la x1, data" "lbu x2, 0(x1)" "lbu x3, 1(x1)" "data: .byte 0xFF, 0x80"}} \
                {tc_1_1_34_lhu.S "LHU" {"la x1, data" "lhu x2, 0(x1)" "lhu x3, 2(x1)" "data: .half 0xFFFF, 0x8000"}} \
                {tc_1_1_35_sb.S "SB" {"la x1, data" "li x2, 0x42" "sb x2, 0(x1)" "data: .byte 0"}} \
                {tc_1_1_36_sh.S "SH" {"la x1, data" "li x2, 0x1234" "sh x2, 0(x1)" "data: .half 0"}} \
                {tc_1_1_37_sw.S "SW" {"la x1, data" "li x2, 0x12345678" "sw x2, 0(x1)" "data: .word 0"}} \
            ]
        }
        2 { # Data Hazards - 16 tests
            return [list \
                {tc_2_1_1_raw_rtype.S "RAW_R" {"li x1, 10" "add x2, x1, x1" "add x3, x2, x1"}} \
                {tc_2_1_2_raw_itype.S "RAW_I" {"li x1, 10" "addi x2, x1, 5" "addi x3, x2, 10"}} \
                {tc_2_1_3_raw_load.S "RAW_LOAD" {"la x1, data" "lw x2, 0(x1)" "add x3, x2, x2" "data: .word 100"}} \
                {tc_2_1_4_raw_double.S "RAW_DBL" {"li x1, 5" "add x2, x1, x1" "add x3, x2, x1" "add x4, x3, x2"}} \
                {tc_2_2_1_waw_consecutive.S "WAW_CONS" {"li x1, 10" "addi x1, x1, 5" "addi x1, x1, 3"}} \
                {tc_2_2_2_waw_interleaved.S "WAW_INT" {"li x1, 10" "li x2, 20" "add x1, x2, x2" "addi x1, x1, 5"}} \
                {tc_2_3_1_war_basic.S "WAR_BASE" {"li x1, 10" "li x2, 20" "add x1, x1, x2" "add x3, x1, x2"}} \
                {tc_2_3_2_war_complex.S "WAR_CPLX" {"li x1, 10" "li x2, 20" "li x3, 30" "add x2, x1, x3" "add x4, x2, x3"}} \
                {tc_2_4_1_bypass_ex.S "BP_EX" {"li x1, 10" "addi x2, x1, 5" "add x3, x2, x0"}} \
                {tc_2_4_2_bypass_mem.S "BP_MEM" {"la x1, data" "lw x2, 0(x1)" "addi x3, x2, 10" "data: .word 100"}} \
                {tc_2_4_3_bypass_wb.S "BP_WB" {"li x1, 10" "addi x2, x1, 5" "nop" "add x3, x2, x1"}} \
                {tc_2_5_1_multi_dep.S "MULTI_DEP" {"li x1, 10" "add x2, x1, x1" "add x3, x2, x1" "add x4, x3, x2"}} \
                {tc_2_5_2_chain_dep.S "CHAIN_DEP" {"li x1, 1" "slli x2, x1, 1" "slli x3, x2, 1" "slli x4, x3, 1"}} \
                {tc_2_6_1_load_use.S "LOAD_USE" {"la x1, data" "lw x2, 0(x1)" "add x3, x2, x2" "data: .word 50"}} \
                {tc_2_6_2_load_store.S "LD_ST" {"la x1, data" "lw x2, 0(x1)" "sw x2, 4(x1)" "data: .word 100, 0"}} \
                {tc_2_7_1_x0_write.S "X0_WR" {"li x1, 100" "add x0, x1, x1" "add x2, x0, x1"}} \
            ]
        }
        3 { # Control Hazards - 16 tests
            return [list \
                {tc_3_1_1_beq_taken.S "BEQ_T" {"li x1, 10" "li x2, 10" "beq x1, x2, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_3_1_2_beq_not_taken.S "BEQ_NT" {"li x1, 10" "li x2, 20" "beq x1, x2, target" "li x3, 1" "li x4, 2" "target: nop"}} \
                {tc_3_1_3_bne_taken.S "BNE_T" {"li x1, 10" "li x2, 20" "bne x1, x2, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_3_1_4_bne_not_taken.S "BNE_NT" {"li x1, 10" "li x2, 10" "bne x1, x2, target" "li x3, 1" "li x4, 2" "target: nop"}} \
                {tc_3_2_1_blt_taken.S "BLT_T" {"li x1, 10" "li x2, 20" "blt x1, x2, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_3_2_2_bge_taken.S "BGE_T" {"li x1, 20" "li x2, 10" "bge x1, x2, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_3_2_3_bltu_taken.S "BLTU_T" {"li x1, 10" "li x2, 20" "bltu x1, x2, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_3_2_4_bgeu_taken.S "BGEU_T" {"li x1, 20" "li x2, 10" "bgeu x1, x2, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_3_3_1_jal_forward.S "JAL_FWD" {"jal x1, target" "li x2, 1" "target: li x3, 2"}} \
                {tc_3_3_2_jal_backward.S "JAL_BCK" {"j skip" "target: li x3, 2" "j end" "skip: jal x1, target" "end: nop"}} \
                {tc_3_3_3_jalr_basic.S "JALR_BASE" {"li x1, 0x100" "jalr x2, x1, 0"}} \
                {tc_3_3_4_jalr_offset.S "JALR_OFF" {"la x1, target" "jalr x2, x1, 0" "li x3, 1" "target: li x4, 2"}} \
                {tc_3_4_1_branch_dep.S "BR_DEP" {"li x1, 10" "addi x2, x1, 5" "beq x2, x1, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_3_4_2_branch_chain.S "BR_CHAIN" {"li x1, 10" "li x2, 10" "beq x1, x2, t1" "li x3, 1" "t1: bne x1, x2, t2" "li x4, 2" "t2: nop"}} \
                {tc_3_5_1_nested_branch.S "NEST_BR" {"li x1, 10" "li x2, 10" "beq x1, x2, outer" "li x3, 1" "outer: beq x1, x2, inner" "li x4, 2" "inner: li x5, 3"}} \
                {tc_3_5_2_ret_addr.S "RET_ADDR" {"jal x1, func" "li x2, 99" "j end" "func: li x3, 50" "jalr x0, x1, 0" "end: nop"}} \
            ]
        }
        4 { # Edge Cases - 19 tests
            return [list \
                {tc_4_1_1_x0_read.S "X0_RD" {"li x1, 100" "add x2, x0, x0" "add x3, x1, x0"}} \
                {tc_4_1_2_x0_write.S "X0_WR" {"li x1, 100" "add x0, x1, x1" "add x2, x0, x0"}} \
                {tc_4_1_3_all_regs.S "ALL_REG" {"li x1, 1" "li x2, 2" "li x3, 3" "li x4, 4" "li x5, 5" "li x6, 6" "li x7, 7" "li x8, 8"}} \
                {tc_4_2_1_overflow_add.S "OVF_ADD" {"li x1, 0x7FFFFFFF" "li x2, 1" "add x3, x1, x2"}} \
                {tc_4_2_2_underflow_sub.S "UDF_SUB" {"li x1, 0x80000000" "li x2, 1" "sub x3, x1, x2"}} \
                {tc_4_2_3_signed_neg.S "SGN_NEG" {"li x1, -1" "li x2, -10" "add x3, x1, x2"}} \
                {tc_4_3_1_shift_max.S "SH_MAX" {"li x1, 1" "li x2, 31" "sll x3, x1, x2"}} \
                {tc_4_3_2_shift_zero.S "SH_ZERO" {"li x1, 0xFF" "li x2, 0" "sll x3, x1, x2"}} \
                {tc_4_3_3_sra_neg.S "SRA_NEG" {"li x1, 0x80000000" "li x2, 1" "sra x3, x1, x2"}} \
                {tc_4_4_1_imm_max.S "IMM_MAX" {"li x1, 0" "addi x2, x1, 2047"}} \
                {tc_4_4_2_imm_min.S "IMM_MIN" {"li x1, 0" "addi x2, x1, -2048"}} \
                {tc_4_4_3_lui_max.S "LUI_MAX" {"lui x1, 0xFFFFF"}} \
                {tc_4_5_1_branch_zero.S "BR_ZERO" {"li x1, 0" "li x2, 0" "beq x1, x2, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_4_5_2_branch_far.S "BR_FAR" {"beq x0, x0, far" "nop" "nop" "nop" "far: li x1, 100"}} \
                {tc_4_6_1_load_align.S "LD_ALIGN" {"la x1, data" "lw x2, 0(x1)" "lw x3, 4(x1)" "data: .word 0x12345678, 0xABCDEF00"}} \
                {tc_4_6_2_store_align.S "ST_ALIGN" {"la x1, data" "li x2, 0x11223344" "sw x2, 0(x1)" "data: .word 0"}} \
                {tc_4_7_1_byte_sign.S "BYTE_SGN" {"la x1, data" "lb x2, 0(x1)" "lbu x3, 0(x1)" "data: .byte 0xFF"}} \
                {tc_4_7_2_half_sign.S "HALF_SGN" {"la x1, data" "lh x2, 0(x1)" "lhu x3, 0(x1)" "data: .half 0xFFFF"}} \
                {tc_4_8_1_nop_sequence.S "NOP_SEQ" {"nop" "nop" "nop" "li x1, 100"}} \
            ]
        }
        5 { # Complex Scenarios - 10 tests
            return [list \
                {tc_5_1_1_raw_forwarding.S "RAW_FWD" {"li x1, 10" "add x2, x1, x1" "add x3, x2, x1"}} \
                {tc_5_1_2_waw_stall.S "WAW_STALL" {"li x1, 10" "addi x1, x1, 5" "addi x1, x1, 3"}} \
                {tc_5_2_1_branch_taken.S "BR_TAKEN" {"li x1, 10" "li x2, 10" "beq x1, x2, target" "li x3, 1" "target: li x4, 2"}} \
                {tc_5_2_2_branch_not_taken.S "BR_NTAKEN" {"li x1, 10" "li x2, 20" "beq x1, x2, target" "li x3, 1" "li x4, 2" "target: nop"}} \
                {tc_5_3_1_load_use_hazard.S "LD_USE" {"la x1, data" "lw x2, 0(x1)" "add x3, x2, x2" "data: .word 100"}} \
                {tc_5_3_2_store_load.S "ST_LD" {"la x1, data" "li x2, 100" "sw x2, 0(x1)" "lw x3, 0(x1)" "data: .word 0"}} \
                {tc_5_4_1_nested_loops.S "NEST_LOOP" {"li x1, 0" "li x2, 3" "outer: li x3, 0" "inner: addi x3, x3, 1" "blt x3, x2, inner" "addi x1, x1, 1" "blt x1, x2, outer"}} \
                {tc_5_5_1_function_call.S "FUNC_CALL" {"jal x1, func" "li x2, 100" "j end" "func: li x3, 50" "jalr x0, x1, 0" "end: nop"}} \
                {tc_5_6_1_mixed_hazards.S "MIX_HAZ" {"li x1, 10" "add x2, x1, x1" "beq x2, x1, skip" "add x3, x2, x1" "skip: nop"}} \
                {tc_5_7_1_pipeline_flush.S "PIPE_FLUSH" {"li x1, 10" "li x2, 10" "beq x1, x2, target" "nop" "nop" "target: li x3, 100"}} \
            ]
        }
        6 { # Memory System - 17 tests
            return [list \
                {tc_6_1_1_consecutive_loads.S "CONS_LD" {"la x1, data" "lw x2, 0(x1)" "lw x3, 4(x1)" "lw x4, 8(x1)" "data: .word 1, 2, 3"}} \
                {tc_6_1_2_consecutive_stores.S "CONS_ST" {"la x1, data" "li x2, 10" "sw x2, 0(x1)" "sw x2, 4(x1)" "data: .word 0, 0"}} \
                {tc_6_2_1_load_after_store.S "LD_AFT_ST" {"la x1, data" "li x2, 100" "sw x2, 0(x1)" "lw x3, 0(x1)" "data: .word 0"}} \
                {tc_6_2_2_store_after_load.S "ST_AFT_LD" {"la x1, data" "lw x2, 0(x1)" "addi x2, x2, 10" "sw x2, 0(x1)" "data: .word 50"}} \
                {tc_6_3_1_mixed_width_load.S "MIX_LD" {"la x1, data" "lb x2, 0(x1)" "lh x3, 0(x1)" "lw x4, 0(x1)" "data: .word 0x12345678"}} \
                {tc_6_3_2_mixed_width_store.S "MIX_ST" {"la x1, data" "li x2, 0xFF" "sb x2, 0(x1)" "li x3, 0x1234" "sh x3, 2(x1)" "data: .word 0, 0"}} \
                {tc_6_4_1_byte_access.S "BYTE_ACC" {"la x1, data" "lb x2, 0(x1)" "lb x3, 1(x1)" "lb x4, 2(x1)" "data: .word 0x12345678"}} \
                {tc_6_4_2_half_access.S "HALF_ACC" {"la x1, data" "lh x2, 0(x1)" "lh x3, 2(x1)" "data: .word 0x12345678"}} \
                {tc_6_5_1_signed_load.S "SGN_LD" {"la x1, data" "lb x2, 0(x1)" "lh x3, 0(x1)" "data: .byte 0xFF" ".half 0xFFFF"}} \
                {tc_6_5_2_unsigned_load.S "UNSIGN_LD" {"la x1, data" "lbu x2, 0(x1)" "lhu x3, 0(x1)" "data: .byte 0xFF" ".half 0xFFFF"}} \
                {tc_6_6_1_offset_positive.S "OFF_POS" {"la x1, data" "lw x2, 8(x1)" "data: .word 0, 0, 100"}} \
                {tc_6_6_2_offset_negative.S "OFF_NEG" {"la x1, data" "addi x1, x1, 8" "lw x2, -4(x1)" "data: .word 100, 0, 0"}} \
                {tc_6_7_1_aligned_access.S "ALIGN_ACC" {"la x1, data" "lw x2, 0(x1)" "lw x3, 4(x1)" "data: .word 0x12345678, 0xABCDEF00"}} \
                {tc_6_8_1_addr_calculation.S "ADDR_CALC" {"la x1, data" "li x2, 4" "add x3, x1, x2" "lw x4, 0(x3)" "data: .word 0, 100"}} \
                {tc_6_9_1_mem_pattern.S "MEM_PAT" {"la x1, data" "lw x2, 0(x1)" "lw x3, 4(x1)" "data: .word 0xAAAAAAAA, 0x55555555"}} \
                {tc_6_10_1_load_bypass.S "LD_BYPASS" {"la x1, data" "lw x2, 0(x1)" "nop" "add x3, x2, x2" "data: .word 50"}} \
                {tc_6_11_1_store_forward.S "ST_FWD" {"la x1, data" "li x2, 100" "sw x2, 0(x1)" "lw x3, 0(x1)" "data: .word 0"}} \
            ]
        }
        7 { # Register File - 8 tests
            return [list \
                {tc_7_1_1_all_regs_write.S "ALL_WR" {"li x1, 1" "li x2, 2" "li x3, 3" "li x4, 4" "li x5, 5" "li x6, 6" "li x7, 7" "li x8, 8" "li x9, 9" "li x10, 10"}} \
                {tc_7_1_2_all_regs_read.S "ALL_RD" {"li x1, 10" "add x2, x1, x1" "add x3, x1, x2" "add x4, x2, x3"}} \
                {tc_7_2_1_reg_swap.S "REG_SWAP" {"li x1, 10" "li x2, 20" "add x3, x1, x0" "add x1, x2, x0" "add x2, x3, x0"}} \
                {tc_7_2_2_reg_rotate.S "REG_ROT" {"li x1, 1" "li x2, 2" "li x3, 3" "add x4, x1, x0" "add x1, x2, x0" "add x2, x3, x0" "add x3, x4, x0"}} \
                {tc_7_3_1_same_src.S "SAME_SRC" {"li x1, 10" "add x2, x1, x1" "and x3, x1, x1" "or x4, x1, x1"}} \
                {tc_7_3_2_same_dst_src.S "SAME_DST" {"li x1, 10" "add x1, x1, x1" "slli x1, x1, 1"}} \
                {tc_7_4_1_x0_const.S "X0_CONST" {"add x1, x0, x0" "addi x2, x0, 10" "or x3, x0, x0"}} \
                {tc_7_5_1_reg_pressure.S "REG_PRESS" {"li x1, 1" "li x2, 2" "li x3, 3" "li x4, 4" "li x5, 5" "add x6, x1, x2" "add x7, x3, x4" "add x8, x5, x6" "add x9, x7, x8"}} \
            ]
        }
        7 { # Register File - 8 tests
            return [list \
                {tc_7_1_1_all_regs_write.S "ALL_WR" {"li x1, 1" "li x2, 2" "li x3, 3" "li x4, 4" "li x5, 5" "li x6, 6" "li x7, 7" "li x8, 8" "li x9, 9" "li x10, 10"}} \
                {tc_7_1_2_all_regs_read.S "ALL_RD" {"li x1, 10" "add x2, x1, x1" "add x3, x1, x2" "add x4, x2, x3"}} \
                {tc_7_2_1_reg_swap.S "REG_SWAP" {"li x1, 10" "li x2, 20" "add x3, x1, x0" "add x1, x2, x0" "add x2, x3, x0"}} \
                {tc_7_2_2_reg_rotate.S "REG_ROT" {"li x1, 1" "li x2, 2" "li x3, 3" "add x4, x1, x0" "add x1, x2, x0" "add x2, x3, x0" "add x3, x4, x0"}} \
                {tc_7_3_1_same_src.S "SAME_SRC" {"li x1, 10" "add x2, x1, x1" "and x3, x1, x1" "or x4, x1, x1"}} \
                {tc_7_3_2_same_dst_src.S "SAME_DST" {"li x1, 10" "add x1, x1, x1" "slli x1, x1, 1"}} \
                {tc_7_4_1_x0_const.S "X0_CONST" {"add x1, x0, x0" "addi x2, x0, 10" "or x3, x0, x0"}} \
                {tc_7_5_1_reg_pressure.S "REG_PRESS" {"li x1, 1" "li x2, 2" "li x3, 3" "li x4, 4" "li x5, 5" "add x6, x1, x2" "add x7, x3, x4" "add x8, x5, x6" "add x9, x7, x8"}} \
            ]
        }
        8 { # Pipeline Stalls - 6 tests
            return [list \
                {tc_8_1_1_load_stall.S "LD_STALL" {"la x1, data" "lw x2, 0(x1)" "add x3, x2, x2" "data: .word 100"}} \
                {tc_8_1_2_double_load.S "DBL_LD" {"la x1, data" "lw x2, 0(x1)" "lw x3, 4(x1)" "add x4, x2, x3" "data: .word 10, 20"}} \
                {tc_8_2_1_branch_stall.S "BR_STALL" {"li x1, 10" "li x2, 10" "beq x1, x2, target" "nop" "target: li x3, 100"}} \
                {tc_8_3_1_raw_stall.S "RAW_STALL" {"li x1, 10" "addi x2, x1, 5" "add x3, x2, x1"}} \
                {tc_8_4_1_mem_stall.S "MEM_STALL" {"la x1, data" "lw x2, 0(x1)" "sw x2, 4(x1)" "data: .word 100, 0"}} \
                {tc_8_5_1_nop_insert.S "NOP_INS" {"li x1, 10" "nop" "add x2, x1, x1" "nop" "add x3, x2, x1"}} \
            ]
        }
        9 { # Forwarding Paths - 9 tests
            return [list \
                {tc_9_1_1_ex_to_ex.S "FWD_EX_EX" {"li x1, 10" "add x2, x1, x1" "add x3, x2, x1"}} \
                {tc_9_1_2_mem_to_ex.S "FWD_MEM_EX" {"la x1, data" "lw x2, 0(x1)" "nop" "add x3, x2, x2" "data: .word 50"}} \
                {tc_9_1_3_wb_to_ex.S "FWD_WB_EX" {"li x1, 10" "add x2, x1, x1" "nop" "nop" "add x3, x2, x1"}} \
                {tc_9_2_1_ex_to_mem.S "FWD_EX_MEM" {"la x1, data" "li x2, 100" "sw x2, 0(x1)" "data: .word 0"}} \
                {tc_9_2_2_mem_to_mem.S "FWD_MEM_MEM" {"la x1, data" "lw x2, 0(x1)" "sw x2, 4(x1)" "data: .word 100, 0"}} \
                {tc_9_3_1_double_fwd.S "DBL_FWD" {"li x1, 10" "add x2, x1, x1" "add x3, x2, x2" "add x4, x3, x3"}} \
                {tc_9_3_2_cross_fwd.S "CROSS_FWD" {"li x1, 10" "li x2, 20" "add x3, x1, x2" "add x4, x3, x2" "add x5, x3, x4"}} \
                {tc_9_4_1_fwd_branch.S "FWD_BR" {"li x1, 10" "addi x2, x1, 5" "beq x2, x1, skip" "li x3, 1" "skip: nop"}} \
                {tc_9_5_1_no_fwd_x0.S "NO_FWD_X0" {"add x0, x1, x1" "add x2, x0, x0"}} \
            ]
        }
        10 { # Performance - 3 tests
            return [list \
                {tc_10_1_1_throughput.S "THRU" {"li x1, 1" "li x2, 2" "li x3, 3" "li x4, 4" "add x5, x1, x2" "add x6, x3, x4"}} \
                {tc_10_2_1_min_stall.S "MIN_STALL" {"li x1, 1" "li x2, 2" "add x3, x1, x2" "li x4, 3" "add x5, x3, x4"}} \
                {tc_10_3_1_cpi_test.S "CPI" {"li x1, 10" "add x2, x1, x1" "add x3, x2, x1" "add x4, x3, x2"}} \
            ]
        }
        11 { # Arithmetic Corners - 6 tests
            return [list \
                {tc_11_1_1_overflow.S "OVF" {"li x1, 0x7FFFFFFF" "li x2, 1" "add x3, x1, x2"}} \
                {tc_11_1_2_underflow.S "UDF" {"li x1, 0x80000000" "li x2, 1" "sub x3, x1, x2"}} \
                {tc_11_2_1_shift_max.S "SH_MAX" {"li x1, 1" "li x2, 31" "sll x3, x1, x2"}} \
                {tc_11_2_2_shift_zero.S "SH_ZERO" {"li x1, 0xFF" "li x2, 0" "sll x3, x1, x2"}} \
                {tc_11_3_1_signed_ops.S "SGN_OPS" {"li x1, -1" "li x2, -10" "add x3, x1, x2" "slt x4, x1, x2"}} \
                {tc_11_4_1_logic_patterns.S "LOGIC_PAT" {"li x1, 0xFFFF" "li x2, 0xAAAA" "and x3, x1, x2" "or x4, x1, x2" "xor x5, x1, x2"}} \
            ]
        }
        12 { # Jump and Link - 4 tests
            return [list \
                {tc_12_1_1_jal_forward.S "JAL_FWD" {"jal x1, target" "li x2, 1" "target: li x3, 2"}} \
                {tc_12_1_2_jal_backward.S "JAL_BCK" {"j skip" "target: li x3, 2" "j end" "skip: jal x1, target" "end: nop"}} \
                {tc_12_2_1_jalr_basic.S "JALR_BASE" {"la x1, target" "jalr x2, x1, 0" "li x3, 1" "target: li x4, 2"}} \
                {tc_12_3_1_ret_sequence.S "RET_SEQ" {"jal x1, func" "li x2, 100" "j end" "func: li x3, 50" "jalr x0, x1, 0" "end: nop"}} \
            ]
        }
        13 { # Immediate Values - 4 tests
            return [list \
                {tc_13_1_1_imm_max.S "IMM_MAX" {"li x1, 0" "addi x2, x1, 2047"}} \
                {tc_13_1_2_imm_min.S "IMM_MIN" {"li x1, 0" "addi x2, x1, -2048"}} \
                {tc_13_2_1_lui_test.S "LUI" {"lui x1, 0x12345" "lui x2, 0xFFFFF"}} \
                {tc_13_2_2_auipc_test.S "AUIPC" {"auipc x1, 0" "auipc x2, 0x1000"}} \
            ]
        }
        14 { # Stress Tests - 3 tests
            return [list \
                {tc_14_1_1_long_dep.S "LONG_DEP" {"li x1, 1" "add x2, x1, x1" "add x3, x2, x2" "add x4, x3, x3" "add x5, x4, x4"}} \
                {tc_14_2_1_many_branches.S "MANY_BR" {"li x1, 10" "beq x1, x1, t1" "t1: bne x1, x0, t2" "t2: blt x0, x1, t3" "t3: bge x1, x0, t4" "t4: nop"}} \
                {tc_14_3_1_mixed_stress.S "MIX_STRESS" {"la x1, data" "lw x2, 0(x1)" "add x3, x2, x2" "sw x3, 4(x1)" "beq x3, x2, skip" "li x4, 100" "skip: nop" "data: .word 50, 0"}} \
            ]
        }
        default {
            return [list]
        }
    }
}

# Generate assembly file
proc generate_asm_file {filename inst_name instructions} {
    set fp [open $filename w]
    puts $fp "# Test: [file tail $filename]"
    puts $fp "# Instruction: $inst_name"
    puts $fp "# Auto-generated: [clock format [clock seconds]]"
    puts $fp ""
    puts $fp ".section .text"
    puts $fp ".globl _start"
    puts $fp "_start:"
    foreach inst $instructions {
        puts $fp "    $inst"
    }
    puts $fp "_end:"
    puts $fp "    j _end"
    close $fp
    return 1
}

# Compile assembly to ELF and HEX
proc compile_test {asm_file} {
    set base [file rootname $asm_file]
    set elf "${base}.elf"
    set hex "${base}.hex"
    
    # Compile
    catch {exec riscv-none-elf-gcc -march=rv32i -mabi=ilp32 \
        -nostartfiles -Wl,-Ttext=0x0 $asm_file -o $elf 2>@1} msg
    
    if {![file exists $elf]} {
        puts "\[X\] Compile failed: $asm_file"
        return 0
    }
    
    # Generate hex
    catch {exec riscv-none-elf-objcopy -O verilog $elf $hex} msg
    
    puts "\[OK\] [file tail $base]: ELF + HEX"
    return 1
}

# Main procedure
proc main {argc argv} {
    puts "=========================================="
    puts "RV32I Test Generator - 158 Tests"
    puts "=========================================="
    
    set output_dir "../programs"
    file mkdir $output_dir
    
    set total 0
    set success 0
    
    set categories [list \
        {1 "ISA Coverage" 37} \
        {2 "Data Hazards" 16} \
        {3 "Control Hazards" 16} \
        {4 "Edge Cases" 19} \
        {5 "Complex Scenarios" 10} \
        {6 "Memory System" 17} \
        {7 "Register File" 8} \
        {8 "Pipeline Stalls" 6} \
        {9 "Forwarding Paths" 9} \
        {10 "Performance" 3} \
        {11 "Arithmetic Corners" 6} \
        {12 "Jump and Link" 4} \
        {13 "Immediate Values" 4} \
        {14 "Stress Tests" 3} \
    ]
    
    # Generate all categories
    foreach cat $categories {
        lassign $cat cat_id cat_name expected_count
        puts "\n>> Category $cat_id: $cat_name"
        puts [string repeat "-" 50]
        
        set cat_count 0
        foreach test [get_test_patterns $cat_id] {
            lassign $test filename inst instructions
            set path [file join $output_dir $filename]
            
            incr total
            incr cat_count
            generate_asm_file $path $inst $instructions
            
            if {[compile_test $path]} {
                incr success
            }
        }
        puts "   -> Generated: $cat_count tests"
    }
    
    puts "\n=========================================="
    puts "SUMMARY"
    puts "=========================================="
    puts "Total Tests: $total"
    puts "Successful:  $success"
    puts "Failed:      [expr {$total - $success}]"
    puts "Success Rate: [format "%.1f" [expr {$success * 100.0 / $total}]]%"
    puts "=========================================="
}

main $argc $argv
