// =============================================================================
// Sequence Package
// =============================================================================
// Contains all test sequences organized by category (158 sequences total)
// =============================================================================

package seq_pkg;

    import uvm_pkg::*;
    import component_pkg::*;
    `include "uvm_macros.svh"

    // =============================================================================
    // Category 01: ISA Coverage (37 sequences)
    // =============================================================================
    `include "sequences/category_01_isa_coverage/tc_1_1_1_add_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_10_and_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_2_sub_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_3_sll_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_4_slt_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_5_sltu_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_6_xor_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_7_srl_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_8_sra_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_1_9_or_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_1_addi_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_2_slti_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_3_sltiu_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_4_xori_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_5_ori_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_6_andi_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_7_slli_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_8_srli_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_2_9_srai_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_3_1_lw_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_3_2_lh_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_3_3_lhu_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_3_4_lb_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_3_5_lbu_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_4_1_sw_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_4_2_sh_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_4_3_sb_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_5_1_beq_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_5_2_bne_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_5_3_blt_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_5_4_bge_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_5_5_bltu_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_5_6_bgeu_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_6_1_jal_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_6_2_jalr_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_7_1_lui_seq.sv"
    `include "sequences/category_01_isa_coverage/tc_1_7_2_auipc_seq.sv"

    // =============================================================================
    // Category 02: Data Hazards (16 sequences)
    // =============================================================================
    `include "sequences/category_02_data_hazards/tc_2_1_1_raw_ex_ex_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_1_2_raw_mem_ex_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_1_3_raw_wb_ex_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_1_4_raw_double_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_2_1_load_use_stall_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_2_2_load_forward_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_2_3_back_to_back_loads_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_3_1_rs1_forward_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_3_2_rs2_forward_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_3_3_both_rs_forward_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_3_4_store_data_forward_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_4_1_chain_raw_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_4_2_multiple_consumers_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_4_3_interleaved_hazards_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_5_1_x0_raw_seq.sv"
    `include "sequences/category_02_data_hazards/tc_2_5_2_x0_write_ignored_seq.sv"

    // =============================================================================
    // Category 03: Control Hazards (16 sequences)
    // =============================================================================
    `include "sequences/category_03_control_hazards/tc_3_1_1_branch_taken_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_1_2_branch_not_taken_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_1_3_backward_branch_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_1_4_forward_branch_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_2_1_jal_forward_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_2_2_jal_backward_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_2_3_jalr_computed_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_2_4_jalr_return_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_3_1_branch_after_load_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_3_2_branch_with_forward_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_3_3_jump_after_alu_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_4_1_back_to_back_branches_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_4_2_nested_branches_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_4_3_branch_in_delay_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_5_1_flush_if_seq.sv"
    `include "sequences/category_03_control_hazards/tc_3_5_2_flush_id_seq.sv"

    // =============================================================================
    // Category 04: Edge Cases (20 sequences)
    // =============================================================================
    `include "sequences/category_04_edge_cases/tc_4_1_1_overflow_add_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_1_2_underflow_sub_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_1_3_max_shift_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_2_1_x0_read_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_2_2_x0_write_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_2_3_x0_both_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_3_1_max_pos_imm_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_3_2_max_neg_imm_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_3_3_zero_imm_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_4_1_mem_addr_0_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_4_2_mem_addr_max_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_4_3_mem_unaligned_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_5_1_branch_target_0_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_5_2_branch_self_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_5_3_branch_max_offset_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_6_1_all_ones_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_6_2_all_zeros_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_6_3_alternating_bits_seq.sv"
    `include "sequences/category_04_edge_cases/tc_4_6_4_single_bit_seq.sv"

    // =============================================================================
    // Category 05: Complex Scenarios (10 sequences)
    // =============================================================================
    `include "sequences/category_05_complex_scenarios/tc_5_1_1_raw_and_branch_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_1_2_load_use_and_branch_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_1_3_forward_and_jump_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_2_1_loop_with_hazards_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_2_2_nested_loops_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_2_3_loop_unroll_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_3_1_function_call_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_3_2_function_return_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_3_3_nested_calls_seq.sv"
    `include "sequences/category_05_complex_scenarios/tc_5_4_1_mixed_hazards_seq.sv"

    // =============================================================================
    // Category 06: Memory System (16 sequences)
    // =============================================================================
    `include "sequences/category_06_memory_system/tc_6_1_1_load_byte_sign_ext_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_1_2_load_byte_zero_ext_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_1_3_load_half_sign_ext_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_1_4_load_half_zero_ext_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_2_1_store_byte_mask_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_2_2_store_half_mask_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_2_3_store_word_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_3_1_load_word_align_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_3_2_load_half_align_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_3_3_store_align_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_4_1_load_store_same_addr_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_4_2_store_load_forward_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_4_3_back_to_back_mem_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_5_1_mem_offset_pos_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_5_2_mem_offset_neg_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_5_3_mem_offset_zero_seq.sv"
    `include "sequences/category_06_memory_system/tc_6_5_4_mem_offset_max_seq.sv"

    // =============================================================================
    // Category 07: Register File (8 sequences)
    // =============================================================================
    `include "sequences/category_07_register_file/tc_7_1_1_all_regs_write_seq.sv"
    `include "sequences/category_07_register_file/tc_7_1_2_all_regs_read_seq.sv"
    `include "sequences/category_07_register_file/tc_7_2_1_x0_always_zero_seq.sv"
    `include "sequences/category_07_register_file/tc_7_2_2_x0_as_source_seq.sv"
    `include "sequences/category_07_register_file/tc_7_3_1_same_reg_src_dst_seq.sv"
    `include "sequences/category_07_register_file/tc_7_3_2_all_same_reg_seq.sv"
    `include "sequences/category_07_register_file/tc_7_4_1_rapid_reuse_seq.sv"
    `include "sequences/category_07_register_file/tc_7_4_2_reg_ping_pong_seq.sv"

    // =============================================================================
    // Category 08: Pipeline Stalls (6 sequences)
    // =============================================================================
    `include "sequences/category_08_pipeline_stalls/tc_8_1_1_single_stall_seq.sv"
    `include "sequences/category_08_pipeline_stalls/tc_8_1_2_multi_stall_seq.sv"
    `include "sequences/category_08_pipeline_stalls/tc_8_2_1_stall_recovery_seq.sv"
    `include "sequences/category_08_pipeline_stalls/tc_8_2_2_stall_then_branch_seq.sv"
    `include "sequences/category_08_pipeline_stalls/tc_8_3_1_back_to_back_stalls_seq.sv"
    `include "sequences/category_08_pipeline_stalls/tc_8_3_2_stall_patterns_seq.sv"

    // =============================================================================
    // Category 09: Forwarding Paths (9 sequences)
    // =============================================================================
    `include "sequences/category_09_forwarding_paths/tc_9_1_1_ex_to_ex_rs1_seq.sv"
    `include "sequences/category_09_forwarding_paths/tc_9_1_2_ex_to_ex_rs2_seq.sv"
    `include "sequences/category_09_forwarding_paths/tc_9_1_3_ex_to_ex_both_seq.sv"
    `include "sequences/category_09_forwarding_paths/tc_9_2_1_mem_to_ex_rs1_seq.sv"
    `include "sequences/category_09_forwarding_paths/tc_9_2_2_mem_to_ex_rs2_seq.sv"
    `include "sequences/category_09_forwarding_paths/tc_9_2_3_mem_to_ex_both_seq.sv"
    `include "sequences/category_09_forwarding_paths/tc_9_3_1_load_forward_seq.sv"
    `include "sequences/category_09_forwarding_paths/tc_9_3_2_alu_to_branch_seq.sv"
    `include "sequences/category_09_forwarding_paths/tc_9_3_3_alu_to_store_seq.sv"

    // =============================================================================
    // Category 10: Performance (3 sequences)
    // =============================================================================
    `include "sequences/category_10_performance/tc_10_1_1_cpi_no_hazards_seq.sv"
    `include "sequences/category_10_performance/tc_10_1_2_cpi_with_hazards_seq.sv"
    `include "sequences/category_10_performance/tc_10_1_3_cpi_worst_case_seq.sv"

    // =============================================================================
    // Category 11: Arithmetic Corners (6 sequences)
    // =============================================================================
    `include "sequences/category_11_arithmetic_corners/tc_11_1_1_add_overflow_pos_seq.sv"
    `include "sequences/category_11_arithmetic_corners/tc_11_1_2_add_overflow_neg_seq.sv"
    `include "sequences/category_11_arithmetic_corners/tc_11_1_3_sub_underflow_seq.sv"
    `include "sequences/category_11_arithmetic_corners/tc_11_2_1_slt_edge_cases_seq.sv"
    `include "sequences/category_11_arithmetic_corners/tc_11_2_2_sltu_edge_cases_seq.sv"
    `include "sequences/category_11_arithmetic_corners/tc_11_2_3_shift_edge_cases_seq.sv"

    // =============================================================================
    // Category 12: Jump and Link (4 sequences)
    // =============================================================================
    `include "sequences/category_12_jump_and_link/tc_12_1_1_jal_return_addr_seq.sv"
    `include "sequences/category_12_jump_and_link/tc_12_1_2_jalr_return_addr_seq.sv"
    `include "sequences/category_12_jump_and_link/tc_12_2_1_jal_to_x0_seq.sv"
    `include "sequences/category_12_jump_and_link/tc_12_2_2_jalr_to_x0_seq.sv"

    // =============================================================================
    // Category 13: Immediate Values (4 sequences)
    // =============================================================================
    `include "sequences/category_13_immediate_values/tc_13_1_1_imm_12bit_max_seq.sv"
    `include "sequences/category_13_immediate_values/tc_13_1_2_imm_20bit_max_seq.sv"
    `include "sequences/category_13_immediate_values/tc_13_1_3_imm_sign_ext_seq.sv"
    `include "sequences/category_13_immediate_values/tc_13_1_4_imm_zero_ext_seq.sv"

    // =============================================================================
    // Category 14: Stress Tests (3 sequences)
    // =============================================================================
    `include "sequences/category_14_stress_tests/tc_14_1_1_long_sequence_seq.sv"
    `include "sequences/category_14_stress_tests/tc_14_1_2_deep_nesting_seq.sv"
    `include "sequences/category_14_stress_tests/tc_14_1_3_max_dependencies_seq.sv"

endpackage : seq_pkg
