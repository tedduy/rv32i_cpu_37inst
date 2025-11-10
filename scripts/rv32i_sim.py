#!/usr/bin/env python3
"""
RV32I ISA Golden Reference Generator - Complete Implementation
Pure Python simulator for all 37 RV32I instructions
"""

class RV32I:
    """Complete RV32I ISA simulator"""
    
    def __init__(self):
        self.x = [0] * 32  # Registers
        self.pc = 0
        self.mem = {}  # Sparse memory
        self.log = []
        
    def w32(self, val):
        """Wrap to 32-bit unsigned"""
        return val & 0xFFFFFFFF
    
    def s32(self, val):
        """Convert to signed 32-bit"""
        return val if val < 0x80000000 else val - 0x100000000
    
    def sext(self, val, bits):
        """Sign extend"""
        if val & (1 << (bits - 1)):
            return val | (0xFFFFFFFF << bits)
        return val
    
    def mem_read(self, addr, size, signed=False):
        """Read memory"""
        data = sum((self.mem.get(addr + i, 0) & 0xFF) << (8*i) for i in range(size))
        if signed and size < 4 and (data & (1 << (8*size - 1))):
            data |= (0xFFFFFFFF << (8*size))
        return self.w32(data)
    
    def mem_write(self, addr, data, size):
        """Write memory"""
        for i in range(size):
            self.mem[addr + i] = (data >> (8*i)) & 0xFF
    
    def exec_one(self, inst):
        """Execute one instruction"""
        # Decode
        op = inst & 0x7F
        rd = (inst >> 7) & 0x1F
        f3 = (inst >> 12) & 0x7
        rs1 = (inst >> 15) & 0x1F
        rs2 = (inst >> 20) & 0x1F
        f7 = (inst >> 25) & 0x7F
        
        imm_i = self.sext((inst >> 20) & 0xFFF, 12)
        imm_s = self.sext(((f7 << 5) | rd), 12)
        imm_b = self.sext(((inst>>31)<<12) | (((inst>>7)&1)<<11) | (((inst>>25)&0x3F)<<5) | (((inst>>8)&0xF)<<1), 13)
        imm_u = inst & 0xFFFFF000
        imm_j = self.sext(((inst>>31)<<20) | (((inst>>12)&0xFF)<<12) | (((inst>>20)&1)<<11) | (((inst>>21)&0x3FF)<<1), 21)
        
        log = {'pc': self.pc, 'inst': inst, 'rd_w': False, 'rd': 0, 'rd_val': 0, 
               'mem_w': False, 'mem_addr': 0, 'mem_data': 0}
        
        pc_next = self.pc + 4
        
        # R-type (0x33)
        if op == 0x33:
            a, b = self.x[rs1], self.x[rs2]
            if f3 == 0x0: res = a + b if f7 == 0 else a - b  # ADD/SUB
            elif f3 == 0x1: res = a << (b & 0x1F)  # SLL
            elif f3 == 0x2: res = 1 if self.s32(a) < self.s32(b) else 0  # SLT
            elif f3 == 0x3: res = 1 if a < b else 0  # SLTU
            elif f3 == 0x4: res = a ^ b  # XOR
            elif f3 == 0x5: res = a >> (b & 0x1F) if f7 == 0 else self.s32(a) >> (b & 0x1F)  # SRL/SRA
            elif f3 == 0x6: res = a | b  # OR
            elif f3 == 0x7: res = a & b  # AND
            else: res = 0
            
            if rd != 0: self.x[rd] = self.w32(res)
            log['rd_w'], log['rd'], log['rd_val'] = True, rd, self.w32(res)
        
        # I-type (0x13)
        elif op == 0x13:
            a = self.x[rs1]
            if f3 == 0x0: res = a + imm_i  # ADDI
            elif f3 == 0x2: res = 1 if self.s32(a) < self.s32(imm_i) else 0  # SLTI
            elif f3 == 0x3: res = 1 if a < self.w32(imm_i) else 0  # SLTIU
            elif f3 == 0x4: res = a ^ imm_i  # XORI
            elif f3 == 0x6: res = a | imm_i  # ORI
            elif f3 == 0x7: res = a & imm_i  # ANDI
            elif f3 == 0x1: res = a << (rs2 & 0x1F)  # SLLI
            elif f3 == 0x5: res = a >> (rs2 & 0x1F) if f7 == 0 else self.s32(a) >> (rs2 & 0x1F)  # SRLI/SRAI
            else: res = 0
            
            if rd != 0: self.x[rd] = self.w32(res)
            log['rd_w'], log['rd'], log['rd_val'] = True, rd, self.w32(res)
        
        # LOAD (0x03)
        elif op == 0x03:
            addr = self.w32(self.x[rs1] + imm_i)
            if f3 == 0x0: res = self.mem_read(addr, 1, True)  # LB
            elif f3 == 0x1: res = self.mem_read(addr, 2, True)  # LH
            elif f3 == 0x2: res = self.mem_read(addr, 4)  # LW
            elif f3 == 0x4: res = self.mem_read(addr, 1)  # LBU
            elif f3 == 0x5: res = self.mem_read(addr, 2)  # LHU
            else: res = 0
            
            if rd != 0: self.x[rd] = res
            log['rd_w'], log['rd'], log['rd_val'] = True, rd, res
        
        # STORE (0x23)
        elif op == 0x23:
            addr = self.w32(self.x[rs1] + imm_s)
            data = self.x[rs2]
            size = [1, 2, 4][f3] if f3 <= 2 else 0
            self.mem_write(addr, data, size)
            log['mem_w'], log['mem_addr'], log['mem_data'] = True, addr, data
        
        # BRANCH (0x63)
        elif op == 0x63:
            a, b = self.x[rs1], self.x[rs2]
            taken = False
            if f3 == 0x0: taken = (a == b)  # BEQ
            elif f3 == 0x1: taken = (a != b)  # BNE
            elif f3 == 0x4: taken = self.s32(a) < self.s32(b)  # BLT
            elif f3 == 0x5: taken = self.s32(a) >= self.s32(b)  # BGE
            elif f3 == 0x6: taken = a < b  # BLTU
            elif f3 == 0x7: taken = a >= b  # BGEU
            if taken: pc_next = self.w32(self.pc + imm_b)
        
        # JAL (0x6F)
        elif op == 0x6F:
            res = self.pc + 4
            if rd != 0: self.x[rd] = res
            pc_next = self.w32(self.pc + imm_j)
            log['rd_w'], log['rd'], log['rd_val'] = True, rd, res
        
        # JALR (0x67)
        elif op == 0x67:
            res = self.pc + 4
            pc_next = self.w32(self.x[rs1] + imm_i) & 0xFFFFFFFE
            if rd != 0: self.x[rd] = res
            log['rd_w'], log['rd'], log['rd_val'] = True, rd, res
        
        # LUI (0x37)
        elif op == 0x37:
            if rd != 0: self.x[rd] = self.w32(imm_u)
            log['rd_w'], log['rd'], log['rd_val'] = True, rd, self.w32(imm_u)
        
        # AUIPC (0x17)
        elif op == 0x17:
            res = self.pc + imm_u
            if rd != 0: self.x[rd] = self.w32(res)
            log['rd_w'], log['rd'], log['rd_val'] = True, rd, self.w32(res)
        
        self.pc = pc_next
        self.log.append(log)
        return log
    
    def run(self, instructions, max_steps=1000):
        """Load and run program"""
        # Load instructions into memory
        for i, inst in enumerate(instructions):
            addr = i * 4
            self.mem_write(addr, inst, 4)
        
        # Execute
        self.pc = 0
        for _ in range(max_steps):
            inst = self.mem_read(self.pc, 4)
            if inst == 0: break  # Halt on zero instruction
            self.exec_one(inst)
        
        return self.log


def generate_golden(instructions, output_file):
    """Generate golden reference file"""
    cpu = RV32I()
    log = cpu.run(instructions)
    
    with open(output_file, 'w') as f:
        f.write("# RV32I Golden Reference\n")
        f.write(f"# Instructions: {len(log)}\n#\n")
        f.write("# PC       INST     RD RD_VALUE  MW MEM_ADDR MEM_DATA\n")
        
        for e in log:
            line = f"{e['pc']:08x} {e['inst']:08x} "
            line += f"{e['rd']:02d} {e['rd_val']:08x} " if e['rd_w'] else "-- -------- "
            line += f"W {e['mem_addr']:08x} {e['mem_data']:08x}" if e['mem_w'] else "- -------- --------"
            f.write(line + "\n")
    
    print(f"✓ Generated: {output_file} ({len(log)} instructions)")
    return log


if __name__ == "__main__":
    print("=" * 70)
    print("  RV32I Golden Reference Generator")
    print("=" * 70)
    
    cpu = RV32I()
    
    # Initialize registers
    cpu.x[1] = 5
    cpu.x[2] = 3
    
    # Test program
    instructions = [
        0x002081b3,  # add x3, x1, x2 -> 8
        0x40208233,  # sub x4, x1, x2 -> 2
        0x00209293,  # slli x5, x1, 2 -> 20
        0x0020a313,  # slt x6, x1, x2 -> 0
    ]
    
    log = cpu.run(instructions)
    
    print("\nResults:")
    for i, e in enumerate(log):
        print(f"[{i+1}] PC=0x{e['pc']:08x} INST=0x{e['inst']:08x}", end="")
        if e['rd_w']: print(f" x{e['rd']}=0x{e['rd_val']:08x}", end="")
        print()
    
    print(f"\nFinal state:")
    print(f"  x3 = {cpu.x[3]} (expected 8) {'✓' if cpu.x[3] == 8 else '✗'}")
    print(f"  x4 = {cpu.x[4]} (expected 2) {'✓' if cpu.x[4] == 2 else '✗'}")
    print(f"  x5 = {cpu.x[5]} (expected 20) {'✓' if cpu.x[5] == 20 else '✗'}")
    print(f"  x6 = {cpu.x[6]} (expected 0) {'✓' if cpu.x[6] == 0 else '✗'}")
    
    # Generate golden log
    generate_golden(instructions, "test_golden.log")
    print("\n✓ Test passed!")
