# RV32I CPU Verification (Luận văn/Đồ án)

Dự án này là một môi trường kiểm thử, đánh giá và xác minh cho CPU RISC-V RV32I 5-stage pipeline, phục vụ cho đề tài luận văn, đồ án tốt nghiệp hoặc nghiên cứu học thuật.

## 1. Build & Run

```bash
make setup          # Tạo cấu trúc thư mục, chuẩn bị môi trường
make compile        # Biên dịch thiết kế & testbench
make run_all        # Chạy toàn bộ 195 tests (37 golden + 158 functional)
make run TEST=<test_name>  # Chạy test đơn
make clean          # Xóa logs và file sinh ra
```

## 2. Cấu trúc thư mục
```
rtl/                # Mã nguồn RTL CPU
rtl/rtl_pkg.sv      # Package định nghĩa tham số, kiểu dữ liệu
rtl/top/            # Module rv32i_top.sv
rtl/core/           # Các module pipeline, hazard, stages
rtl/common/         # Module phụ trợ (adder, mux, ...)
tb/                 # Testbench UVM
  components/       # Các thành phần UVM (agent, driver, monitor, scoreboard, ...)
  sequences/        # Các sequence kiểm thử
  tests/            # Các test class
  interfaces/       # Interface kết nối DUT
logs/               # Log kết quả mô phỏng
  golden/           # Log các test golden
  normal/           # Log các test functional
  waves/            # File waveform (.wlf)
```

## 3. Loại test
- **Golden tests:** Kiểm tra tuân thủ ISA (37 tests)
- **Functional tests:** Kiểm tra hazard, edge case, pipeline, memory, ... (158 tests)

## 4. Main Targets
- `make setup` – Tạo cấu trúc thư mục, chuẩn bị môi trường
- `make compile` – Biên dịch toàn bộ
- `make run_all` – Chạy toàn bộ test
- `make run TEST=tc_1_1_1_add_golden_test` – Chạy test đơn
- `make clean` – Xóa logs và file sinh ra

## 5. Notes
- Simulator: QuestaSim 2024.1
- UVM: 1.1d
- Log files tự động lưu vào thư mục `logs/`
- Để xem kết quả, mở file log tương ứng trong `logs/golden/` hoặc `logs/normal/`

---
**Dự án tối ưu cho học thuật, luận văn, đồ án. Regression & coverage có thể mở rộng, xem Makefile để biết chi tiết.**
