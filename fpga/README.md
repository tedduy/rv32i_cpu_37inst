# FPGA Implementation for DE2-115

This directory contains files for implementing the RV32I CPU on Terasic DE2-115 board.

## 📋 Board Specifications

- **Board:** Terasic DE2-115
- **FPGA:** Cyclone IV E EP4CE115F29C7
- **Logic Elements:** 114,480
- **Memory:** 3,888 Kbits M9K blocks
- **Clock:** 50 MHz oscillator
- **Speed Grade:** -7

## 📁 Files

### `de2_115_top.sv`
Top-level wrapper module that connects the CPU to DE2-115 I/O:
- Clock: 50 MHz from CLOCK_50
- Reset: KEY[0] (push button, active low)
- Debug outputs: LEDs and 7-segment displays

### `de2_115_pins.tcl`
Pin assignment script for Quartus Prime:
- All I/O pins mapped to DE2-115 board
- Run in Quartus: Tools → Tcl Scripts → Run Script

### `de2_115.sdc`
Timing constraints for Cyclone IV:
- Clock period: 20ns (50 MHz)
- Clock uncertainty: 0.3ns
- Asynchronous reset handling

## 🚀 Quick Start

### 1. Create Quartus Project

```bash
# Open Quartus Prime
# File → New Project Wizard

# Project settings:
# - Name: rv32i_de2_115
# - Top-level: de2_115_top
# - Device: EP4CE115F29C7
```

### 2. Add Files to Project

**RTL Files:**
```
fpga/de2_115_top.sv          (top-level wrapper)
rtl/top/rv32i_top.sv         (CPU top)
rtl/core/pipeline/*.sv       (pipeline registers)
rtl/core/hazard/*.sv         (hazard units)
rtl/core/stages/*.sv         (all stage modules)
rtl/common/*.sv              (muxes, adders)
```

**Constraint Files:**
```
fpga/de2_115.sdc
```

### 3. Set Top-Level Entity

```
Assignments → Settings → General
→ Top-level entity: de2_115_top
```

### 4. Apply Pin Assignments

```
Tools → Tcl Scripts → Run Script
→ Select: fpga/de2_115_pins.tcl
```

Or manually:
```
Assignments → Import Assignments
→ Select: fpga/de2_115_pins.tcl
```

### 5. Add SDC File

```
Assignments → Settings → Timing Analyzer
→ SDC File: fpga/de2_115.sdc
```

### 6. Compile

```
Processing → Start Compilation
```

Or use command line:
```bash
quartus_sh --flow compile rv32i_de2_115
```

### 7. Program FPGA

```
Tools → Programmer
→ Hardware Setup: USB-Blaster
→ Add File: output_files/de2_115_top.sof
→ Start
```

## 🔧 Expected Results

### Compilation Summary

**Resource Utilization (estimated):**
```
Logic Elements:     ~5,000 / 114,480 (4%)
Registers:          ~2,500
Memory Bits:        ~5,000 / 3,981,312 (0.1%)
M9K Blocks:         0-2 (may use registers instead)
PLLs:               0 (using 50 MHz directly)
```

**Timing:**
```
Fmax (Slow 1200mV 85C Model): ~60-80 MHz
Fmax (Fast 1200mV 0C Model):  ~100-120 MHz
Target: 50 MHz → Should PASS easily
```

### On-Board Behavior

**After programming:**

1. **Green LED 0:** Shows reset status (ON = running)
2. **Green LED 1:** Blinks with clock (very fast, may appear always ON)
3. **Green LEDs 8-2:** Slow counter (visible counting)
4. **Red LEDs 17-0:** Fast cycle counter (rapid blinking)
5. **7-Segment Displays:** Show 32-bit cycle counter in hex

**Expected:**
- All displays should be counting up
- LEDs should be blinking/changing
- This proves CPU is running!

## 🐛 Troubleshooting

### Compilation Errors

**"Can't find module rv32i_top"**
- Make sure all RTL files are added to project
- Check file paths

**"Syntax error in SystemVerilog"**
- Quartus version: Use Quartus Prime 18.0 or later
- Enable SystemVerilog: Assignments → Settings → Compiler Settings → Verilog HDL Input

**"Memory inference failed"**
- Quartus may not infer M9K for small memories
- This is OK - will use registers instead
- Check: Tools → Netlist Viewers → RTL Viewer

### Timing Errors

**"Setup timing not met"**
- Increase clock period in SDC: 20ns → 25ns (40 MHz)
- Enable optimization: Assignments → Settings → Compiler Settings
  → Optimization Mode: "High Performance Effort"

**"Hold timing not met"**
- Usually auto-fixed by Quartus
- If persists, check for combinational loops

### Programming Errors

**"Can't detect USB-Blaster"**
- Install Quartus Programmer drivers
- Check USB cable connection
- Try different USB port

**"FPGA not responding"**
- Power cycle the board
- Check MSEL pins (should be for JTAG mode)

## 📊 Performance Analysis

### After Compilation

**Check Fmax:**
```
Tools → Timing Analyzer
→ Tasks: Update Timing Netlist
→ Tasks: Report Fmax Summary
```

**Check Resource Usage:**
```
Processing → Compilation Report
→ Flow Summary
→ Resource Section
```

**View RTL:**
```
Tools → Netlist Viewers → RTL Viewer
→ See how Quartus synthesized your design
```

## 🎯 Next Steps

### 1. Verify CPU is Running
- Check LEDs and 7-segment displays counting
- If not counting → check reset (KEY[0])

### 2. Add Debug Features
- Connect PC output to LEDs
- Connect instruction output to 7-segment
- Add UART for printf debugging

### 3. Optimize Performance
- Try 75 MHz (13.33ns period)
- Try 100 MHz (10ns period)
- Check timing reports

### 4. Use SDRAM (Optional)
- DE2-115 has 128 MB SDRAM
- Can expand memory beyond 256 bytes
- Requires SDRAM controller

## 📝 Notes

- **Memory:** Quartus will automatically choose between M9K blocks and registers
- **Clock:** Using 50 MHz directly (no PLL) for simplicity
- **Reset:** Synchronized to avoid metastability
- **I/O:** All I/O are 3.3V or 2.5V LVTTL (safe for DE2-115)

## 🎓 For Khóa Luận

**Include in report:**
1. Screenshot of Quartus compilation summary
2. Resource utilization table
3. Fmax timing report
4. Photo/video of FPGA running (LEDs blinking)
5. RTL Viewer screenshot showing CPU structure

**This proves your CPU works on real hardware!** 🎉
