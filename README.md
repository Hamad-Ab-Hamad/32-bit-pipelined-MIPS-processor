# 32-bit Pipelined MIPS Processor — VHDL Implementation
 
A custom 32-bit RISC processor based on the MIPS ISA, implemented in VHDL and simulated in Xilinx Vivado. The design implements a classic 5-stage pipeline with a modular, stage-by-stage architecture.
 
---
 
## Overview
 
This processor was designed from scratch using behavioral and structural VHDL modeling. Each pipeline stage was implemented and verified independently before being connected into a full CPU structural model.
 
**Tools:** Xilinx Vivado 2019.2  
**Language:** VHDL  
**Architecture:** 32-bit RISC, 5-stage pipeline
 
---
 
## Pipeline Architecture
 
The processor implements the standard 5-stage MIPS pipeline:
 
```
IF_Stage → IF_ID_Reg → ID_Stage → ID_EX_Reg → EX_Stage → EX_MEM_Reg → MEM_Stage → MEM_WB_Reg → WB_Stage
```
 
Each stage is implemented as a separate structural VHDL component, with pipeline registers between stages to hold inter-stage signals.
 
### Stage 1 — Instruction Fetch (IF)
**Components:** PCMux, PC, InstructionMemory, Adder  
The PC increments by 4 each clock cycle on the rising edge. The PCMux selects between PC+4, a jump address (computed in EX), based on the PCsrc control signal. The fetched instruction and PC+4 are stored in the IF/ID register.
 
### Stage 2 — Instruction Decode / Register Read (ID)
**Components:** ControlUnit, RegisterFile, SignExtend  
The ControlUnit decodes the 6-bit opcode and generates all control signals (ALUOp, ALUSrc, MemRead, MemWrite, MemtoReg, RegDst, RegWrite, Jump). The RegisterFile reads two source registers. The 16-bit immediate is sign-extended to 32 bits. RT and RD addresses are forwarded to the ID/EX register for use in the EX stage.
 
### Stage 3 — Execute (EX)
**Components:** ALU, ALU_Control, MUX32bit, MUX5bit, Shifter, Adder  
The ALU_Control unit takes ALUOp and the function code field to determine the ALU operation. The MUX32bit selects between ReadData2 and the sign-extended immediate (for R-type vs I-type). The MUX5bit selects the destination register (RT for I-type, RD for R-type). The Shifter and Adder compute the jump target address from PC+4 and the sign-extended immediate.
 
### Stage 4 — Memory Access (MEM)
**Components:** DataMemory  
DataMemory handles load word (lw) and store word (sw) instructions. For R-type instructions, this stage passes values through to the MEM/WB register without memory access. MemRead and MemWrite control signals gate the memory operations.
 
### Stage 5 — Write Back (WB)
**Components:** MUX32bit  
The final MUX selects between the ALU result and the DataMemory read data based on MemtoReg. The selected value is written back to the destination register in the RegisterFile (loop back to ID stage).
 
---
 
## Supported Instructions
 
| # | Instruction | Type | Operation |
|---|-------------|------|-----------|
| 1 | sub | R | `$s2 = $s1 - $s3` |
| 2 | and | R | `$t2 = $s2 & $t5` |
| 3 | or | R | `$t2 = $s0 \| $t2` |
| 4 | add (RCA) | R | `$s3 = $t1 + $t0` |
| 5 | lw | I | `$t3 = Mem[$s2 + 100]` |
| 6 | addi | I | `$s4 = $t3 + 200` |
| 7 | sw | I | `Mem[$t2 + 100] = $t1` |
| 8 | nor | R | `$t1 = ~($s1 \| $t0)` |
| 9 | slt | R | `$t1 = ($s2 < $s2) ? 1 : 0` |
| 10 | j | J | `PC = 2500` |
 
---
 
## Control Unit Truth Table
 
| Signal | R-type | lw | sw | addi | j |
|--------|--------|----|----|------|---|
| RegDst | 1 | 0 | X | 0 | X |
| MemRead | 0 | 1 | 0 | 0 | 0 |
| MemtoReg | 1 | 1 | X | 0 | X |
| ALUOp[1:0] | 10 | 00 | 00 | 00 | 00 |
| MemWrite | 0 | 0 | 1 | 0 | 0 |
| ALUSrc | 0 | 1 | 1 | 1 | 0 |
| RegWrite | 1 | 1 | 0 | 1 | 0 |
| Jump | 0 | 0 | 0 | 0 | 1 |
 
All undefined signals default to 0 via a catch-all statement.
 
---
 
## Simulation Results
 
Each stage and each subcomponent has a dedicated testbench, verified in Vivado behavioral simulation.
 
**IF Stage:** PC initializes to `0x00002710`, increments by 4 each rising clock edge. Reset correctly returns PC to the initial address. First instruction fetched: `0x02339022` (sub $s2, $s1, $s3).
 
**ID Stage:** Instruction `0x02339022` correctly decoded. R-type control signals asserted after 400ns. ReadData1 = `0x17` ($s1), ReadData2 = `0x19` ($s3). SignExtend output = `0xFFFF9022`.
 
**EX Stage:** ALU computes `0x17 - 0x19 = 0xFFFFFFFE` (correct 2's complement result). JumpAddr computed as `0xFFFE679C`. WriteRegister correctly selected as register 12 (RD for R-type).
 
**MEM Stage:** R-type instruction passes through correctly. MemRead = 0, ReadData = `0x0` as expected. DataMemory component verified independently with read/write operations.
 
**WB Stage:** WriteData = `0xFFFFFFFE` correctly selected from ALU result via MemtoReg MUX for R-type instruction.
 
---
 
## Known Limitations
 
The full CPU integration (all 5 stages connected in `CPU.vhd`) has a known bug: the DataMemory component fails to correctly translate the ALUresult from hexadecimal into an array index when operating in the full pipeline context. Each stage and component works correctly in isolation. The bug is isolated to the interface between the EX stage ALUresult and the DataMemory address indexing logic in the integrated CPU.
 
This is a documented integration issue, not a design flaw in the individual stage implementations.
 
---
 
## Skills Demonstrated
 
- VHDL behavioral and structural modeling
- 5-stage pipeline datapath design
- FSM-based control unit design
- Modular hardware design with stage-level testbenches
- Xilinx Vivado simulation and schematic analysis
- MIPS ISA: R-type, I-type, and J-type instruction handling
