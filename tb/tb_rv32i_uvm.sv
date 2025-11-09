// =============================================================================
// RV32I Testbench Top Module
// =============================================================================
// Top-level testbench for RV32I pipeline CPU verification
// Instantiates DUT, interface, and starts UVM test
// =============================================================================

`timescale 1ns/1ps

module tb_rv32i_top;
    
    // ==========================================================================
    // Clock and Reset Generation
    // ==========================================================================
    logic clk;
    logic arst_n;
    
    // Clock generation: 100 MHz (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Reset generation
    initial begin
        arst_n = 0;
        #50;
        arst_n = 1;
    end
    
    // ==========================================================================
    // Interface Instantiation
    // ==========================================================================
    rv32i_if vif(clk);
    
    // ==========================================================================
    // DUT Instantiation
    // ==========================================================================
    rv32i_top #(
        .N(32),
        .IMEM_DEPTH(76),
        .DMEM_BYTES(256),
        .REG_DEPTH(32)
    ) dut (
        .i_clk(clk),
        .i_arst_n(vif.arst_n),
        .W_PC_out(vif.pc_out),
        .instruction(vif.instruction),
        .W_RD1(vif.rd1),
        .W_RD2(vif.rd2),
        .W_m1(vif.m1),
        .W_m2(vif.m2),
        .W_ALUout(vif.alu_out),
        .W_WB_data(vif.wb_data),
        .W_rd_addr(vif.rd_addr),
        .W_reg_write(vif.reg_write),
        .W_mem_write(vif.mem_write),
        .W_mem_read(vif.mem_read),
        .W_branch_taken(vif.branch_taken),
        .W_mem_addr(vif.mem_addr),
        .W_mem_wdata(vif.mem_wdata),
        .W_mem_rdata(vif.mem_rdata),
        .W_jal(vif.jal),
        .W_jalr(vif.jalr)
    );
    
    // ==========================================================================
    // UVM Configuration and Test Execution
    // ==========================================================================
    initial begin
        // Import UVM package
        import uvm_pkg::*;
        import rv32i_pkg::*;
        
        // Set virtual interface in config DB
        uvm_config_db#(virtual rv32i_if)::set(null, "*", "vif", vif);
        
        // Run test specified by +UVM_TESTNAME argument
        run_test();
    end
    
    // ==========================================================================
    // Waveform Dumping (for debugging)
    // ==========================================================================
    initial begin
        if ($test$plusargs("DUMP_VCD")) begin
            $dumpfile("waveform.vcd");
            $dumpvars(0, tb_rv32i_top);
            $display("[TB] VCD dumping enabled");
        end
    end
    
    // ==========================================================================
    // Simulation Timeout Watchdog
    // ==========================================================================
    initial begin
        #100000000; // 100ms timeout
        $display("[TB] ERROR: Simulation timeout!");
        $finish;
    end
    
    // ==========================================================================
    // Simulation Info
    // ==========================================================================
    initial begin
        $display("\n");
        $display("========================================");
        $display("  RV32I Pipeline CPU Testbench");
        $display("  Clock Period: 10ns (100 MHz)");
        $display("========================================");
        $display("\n");
    end

endmodule : tb_rv32i_top
