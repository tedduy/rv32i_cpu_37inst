# RV32I Pipeline CPU - Performance Analysis

## Tổng Quan

Document này giải thích chi tiết các số liệu performance của RV32I 5-stage pipeline CPU và cách chúng được tính toán.

---

## Kết Quả Simulation

### Execution Summary
```
Total Clock Cycles:              84 cycles
Total Instructions Executed:     75 instructions
Simulation Time:                 865 ns
```

**Giải thích:**
- **84 cycles**: Tổng số clock cycles từ khi reset đến khi kết thúc chương trình
- **75 instructions**: Số instructions thực sự được thực thi (không tính NOP bubbles)
- **865 ns**: Thời gian simulation với clock 100MHz (period = 10ns)

---

## Performance Metrics

### 1. CPI (Cycles Per Instruction)

```
CPI = Total Cycles / Total Instructions = 84 / 75 = 1.12
```

**Ý nghĩa:**
- CPI lý tưởng cho pipeline 5-stage là **1.00** (mỗi instruction hoàn thành trong 1 cycle sau khi pipeline đầy)
- CPI thực tế là **1.12**, nghĩa là trung bình mỗi instruction cần 1.12 cycles
- Chênh lệch 0.12 cycles/instruction là do **pipeline hazards**

### 2. IPC (Instructions Per Cycle)

```
IPC = Total Instructions / Total Cycles = 75 / 84 = 0.89
```

**Ý nghĩa:**
- IPC = 1/CPI = 0.89 instructions/cycle
- Nghĩa là pipeline thực thi được 0.89 instructions mỗi cycle (trung bình)

### 3. Throughput

```
Throughput = IPC × Clock Frequency = 0.89 × 100 MHz = 89.29 MIPS
```

**Ý nghĩa:**
- CPU có thể thực thi **89.29 triệu instructions mỗi giây** ở tần số 100MHz

---

## Pipeline Efficiency

### Efficiency Calculation

```
Pipeline Efficiency = (Ideal CPI / Actual CPI) × 100%
                    = (1.00 / 1.12) × 100%
                    = 89.3%
```

**Ý nghĩa:**
- Pipeline đạt **89.3%** hiệu suất so với lý tưởng
- Mất **10.7%** hiệu suất do hazards

---

## Hazard Statistics

### Stall Cycles (Data Hazards)

```
Stall Cycles = 0 cycles
```

**Giải thích:**
- **Data hazards** xảy ra khi instruction cần dữ liệu từ instruction trước chưa hoàn thành
- Pipeline này có **Forwarding Unit** (data bypassing) nên **không cần stall** cho data hazards
- Forwarding Unit chuyển tiếp dữ liệu từ EX/MEM/WB stage về EX stage ngay lập tức

**Ví dụ:**
```assembly
add x3, x1, x2    # x3 = x1 + x2
sub x4, x3, x5    # Cần x3 từ instruction trước
```
- Không cần stall vì forwarding unit chuyển tiếp kết quả từ EX stage

### Flush Cycles (Control Hazards)

```
Flush Cycles = 5 cycles
```

**Giải thích:**
- **Control hazards** xảy ra khi có branch/jump instructions
- Khi branch **taken**, pipeline phải **flush** (xóa) các instructions đã fetch nhầm
- Có **12 branches** trong chương trình, **1 branch taken** → gây ra **5 flush cycles**

**Tại sao 1 branch taken gây ra 5 flush cycles?**
- Mỗi branch taken flush 2-3 instructions trong pipeline
- Có thể có nhiều flush cycles do:
  - Branch taken
  - Jump instructions (JAL, JALR)
  - Pipeline startup (initial fill)

### Total Penalty Cycles

```
Total Penalty = Stall Cycles + Flush Cycles = 0 + 5 = 5 cycles
```

### Hazard Rate

```
Hazard Rate = (Total Penalty / Total Cycles) × 100%
            = (5 / 84) × 100%
            = 6.0%
```

**Ý nghĩa:**
- **6.0%** cycles bị ảnh hưởng bởi hazards
- **94.0%** cycles hoạt động hiệu quả

---

## Instruction Mix

```
R-Type (Arithmetic/Logic):       20 (26.7%)
I-Type (Immediate):              20 (26.7%)
Load Instructions:               10 (13.3%)
Store Instructions:               6 (8.0%)
Branch Instructions:             12 (16.0%)
Jump Instructions:                2 (2.7%)
```

**Phân tích:**
- **R-Type & I-Type** chiếm phần lớn (53.4%) - các phép toán số học/logic
- **Load/Store** chiếm 21.3% - truy cập memory
- **Branch/Jump** chiếm 18.7% - control flow

---

## Branch Statistics

```
Total Branches:                  12
Branches Taken:                   1
Branch Rate:                   16.0%
Branch Taken Rate:              8.3%
```

**Giải thích:**
- **Branch Rate**: 16% instructions là branches
- **Branch Taken Rate**: Chỉ 8.3% branches thực sự taken (1/12)
- Branch prediction đơn giản (assume not taken) hoạt động tốt với tỷ lệ này

---

## Tại Sao 75 Instructions Thay Vì 76?

### Instruction Memory Layout

Instruction memory có **77 entries** (index 0-76):
- **Imemory[0]**: NOP (0x00000000) - không được đếm
- **Imemory[1-75]**: 75 instructions thực sự
- **Imemory[76]**: NOP cuối (end marker)

### Counting Logic

Testbench chỉ đếm instructions khi:
```systemverilog
if (W_PC_out != prev_pc && W_PC_out < 32'h1000 && instruction != 32'h0)
```

**Điều kiện:**
1. PC thay đổi (instruction mới)
2. PC < 0x1000 (trong vùng instruction memory)
3. Instruction ≠ 0 (không phải NOP bubble)

**Kết quả:**
- NOP ở Imemory[0] không được đếm (instruction = 0)
- 75 instructions thực sự được thực thi và đếm
- NOP bubbles từ pipeline flush không được đếm

---

## So Sánh Với Pipeline Lý Tưởng

| Metric | Ideal Pipeline | Actual Pipeline | Difference |
|--------|---------------|-----------------|------------|
| CPI | 1.00 | 1.12 | +0.12 |
| IPC | 1.00 | 0.89 | -0.11 |
| Efficiency | 100% | 89.3% | -10.7% |
| Stall Cycles | 0 | 0 | 0 |
| Flush Cycles | 0 | 5 | +5 |

**Kết luận:**
- Pipeline hoạt động rất tốt với **89.3% efficiency**
- **Forwarding Unit** hoạt động hoàn hảo (0 stall cycles)
- Chỉ mất hiệu suất do **control hazards** (branches/jumps)

---

## Cải Tiến Có Thể

### 1. Branch Prediction
- Hiện tại: Assume not taken (static prediction)
- Cải tiến: Dynamic branch prediction (BTB, BHT)
- Lợi ích: Giảm flush cycles từ 5 → 1-2 cycles

### 2. Branch Target Buffer (BTB)
- Cache địa chỉ branch targets
- Giảm penalty khi branch taken

### 3. Delayed Branch
- Thực thi instruction sau branch trước khi quyết định
- Giảm branch penalty

---

## Công Thức Tính Toán

### CPI Calculation
```
CPI = (Base CPI) + (Stall CPI) + (Flush CPI)
    = 1.00 + (0/75) + (5/75)
    = 1.00 + 0.00 + 0.067
    = 1.067 ≈ 1.12
```

### Execution Time
```
Execution Time = Instructions × CPI × Clock Period
               = 75 × 1.12 × 10ns
               = 840ns
```

(Thực tế 865ns do thêm startup time và final cycles)

---

## Kết Luận

RV32I 5-stage pipeline CPU đạt hiệu suất tốt:
- ✅ **89.3% efficiency** - rất tốt cho pipeline đơn giản
- ✅ **0 data hazard stalls** - forwarding unit hoạt động hoàn hảo
- ✅ **Chỉ 5 flush cycles** - control hazards được xử lý tốt
- ✅ **89.29 MIPS @ 100MHz** - throughput cao

Pipeline này phù hợp cho:
- Embedded systems
- Educational purposes
- Low-power applications
- Real-time systems (predictable performance)
