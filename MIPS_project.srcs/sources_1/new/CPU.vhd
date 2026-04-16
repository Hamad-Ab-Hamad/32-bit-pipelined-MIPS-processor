library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
  Port ( clk: in std_logic;
         reset: in std_logic );
end CPU;

architecture Structural of CPU is

component IF_Stage is
    port(
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           JumpAddr : in STD_LOGIC_VECTOR (31 downto 0);
           PCsrc : in STD_LOGIC;
           PC4 : out STD_LOGIC_VECTOR (31 downto 0);
           Instruction_out : out STD_LOGIC_VECTOR (31 downto 0)
        );
end component;

component IF_ID_Reg is
    port(
           clk: in std_logic;
           reset: in std_logic;
           PC4_in : in STD_LOGIC_VECTOR (31 downto 0);
           Instruction_in : in STD_LOGIC_VECTOR (31 downto 0);
           PC4_out : out STD_LOGIC_VECTOR (31 downto 0);
           Instruction_out : out STD_LOGIC_VECTOR (31 downto 0)
        );
end component;

component ID_Stage is
    port(
           id_clk : in STD_LOGIC;
           id_reset : in STD_LOGIC;
           
           id_PC4_in : in STD_LOGIC_VECTOR (31 downto 0); --from if stage

           id_PC4_out : out STD_LOGIC_VECTOR (31 downto 0);
           
           id_Instruction : in STD_LOGIC_VECTOR (31 downto 0); --from if stage

           wb_WriteRegister : in STD_LOGIC_VECTOR (4 downto 0);--from wb stage
           wb_WriteData : in STD_LOGIC_VECTOR (31 downto 0);--from wb stage
           
           id_ReadData1 : out STD_LOGIC_VECTOR (31 downto 0);
           id_ReadData2 : out STD_LOGIC_VECTOR (31 downto 0);
           id_SignExtend : out STD_LOGIC_VECTOR (31 downto 0);
           id_RT : out STD_LOGIC_VECTOR (4 downto 0);
           id_RD : out STD_LOGIC_VECTOR (4 downto 0);

           wb_RegWrite_in : in STD_LOGIC;--from wb stage

           id_RegWrite_out : out STD_LOGIC;
           id_MemtoReg : out STD_LOGIC;
           id_MemWrite : out STD_LOGIC;
           id_MemRead : out STD_LOGIC;
           id_Jump : out STD_LOGIC;
           id_RegDst : out STD_LOGIC;
           id_ALUOp : out STD_LOGIC_VECTOR (1 downto 0);
           id_ALUSrc : out STD_LOGIC
        );
end component;

component ID_EX_Reg is
    port(
            clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           --WB control lines
           RegWrite_in : in STD_LOGIC;
           MemtoReg_in : in STD_LOGIC;
           RegWrite_out : out STD_LOGIC;
           MemtoReg_out : out STD_LOGIC;
           
           --M control lines
           MemWrite_in : in STD_LOGIC;
           MemRead_in : in STD_LOGIC;
           Jump_in : in STD_LOGIC;
           MemWrite_out : out STD_LOGIC;
           MemRead_out : out STD_LOGIC;
           Jump_out : out STD_LOGIC;
           
           --EX control lines
           RegDst_in : in STD_LOGIC;
           ALUOp_in : in STD_LOGIC_VECTOR (1 downto 0);
           ALUSrc_in : in STD_LOGIC;
           RegDst_out : out STD_LOGIC;
           ALUOp_out : out STD_LOGIC_VECTOR (1 downto 0);
           ALUSrc_out : out STD_LOGIC;
           
           --datapath lines
           PC4_in: in std_logic_vector(31 downto 0);
           A1_in: in std_logic_vector(31 downto 0);
           A2_in: in std_logic_vector(31 downto 0);
           signext_in: in std_logic_vector(31 downto 0);
           rt_in: in std_logic_vector(4 downto 0);
           rd_in: in std_logic_vector(4 downto 0);
           
           PC4_out: out std_logic_vector(31 downto 0);
           A1_out: out std_logic_vector(31 downto 0);
           A2_out: out std_logic_vector(31 downto 0);
           signext_out: out std_logic_vector(31 downto 0);
           rt_out: out std_logic_vector(4 downto 0);
           rd_out: out std_logic_vector(4 downto 0)
        );        
end component;

component EX_Stage is
    port(
            -- WB and M stage control line input and outputs
           RegWrite_in : in STD_LOGIC;
           RegWrite_out : out STD_LOGIC;
           MemtoReg_in : in STD_LOGIC;
           MemtoReg_out : out STD_LOGIC;
           MemWrite_in : in STD_LOGIC;
           MemWrite_out : out STD_LOGIC;
           MemRead_in : in STD_LOGIC;
           MemRead_out : out STD_LOGIC;
           Jump_in : in STD_LOGIC;
           Jump_out : out STD_LOGIC;
           
           -- EX stage control line inputs
           RegDst : in STD_LOGIC;
           ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
           ALUSrc : in STD_LOGIC;
           
           -- Inputs from ID stage
           PC4_in : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData1 : in STD_LOGIC_VECTOR (31 downto 0);
           ReadData2 : in STD_LOGIC_VECTOR (31 downto 0);
           SignExtend : in STD_LOGIC_VECTOR (31 downto 0);
           RT : in STD_LOGIC_VECTOR (4 downto 0);
           RD : in STD_LOGIC_VECTOR (4 downto 0);
           
           --Outputs from EX stage
           JumpAddr : out STD_LOGIC_VECTOR (31 downto 0);
           ALUresult: out STD_LOGIC_VECTOR (31 downto 0);
           WriteData: out STD_LOGIC_VECTOR (31 downto 0);
           wb_WriteRegister: out STD_LOGIC_VECTOR (4 downto 0)
        );
end component;        

component EX_MEM_Reg is
    port(
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           
           --WB control lines
           RegWrite_in : in STD_LOGIC;
           MemtoReg_in : in STD_LOGIC;
           RegWrite_out : out STD_LOGIC;
           MemtoReg_out : out STD_LOGIC;
           
           --M control lines
           MemWrite_in : in STD_LOGIC;
           MemRead_in : in STD_LOGIC;
           Jump_in : in STD_LOGIC;
           MemWrite_out : out STD_LOGIC;
           MemRead_out : out STD_LOGIC;
           Jump_out : out STD_LOGIC;
           
           --Datapath lines
           ALUresult_in : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData_in : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           ALUresult_out : out STD_LOGIC_VECTOR (31 downto 0);
           WriteData_out : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0);
           JumpAddr_in: in STD_LOGIC_VECTOR(31 downto 0);
           JumpAddr_out: out STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

component MEM_Stage is
    port(
           clk: in std_logic;
           reset: in std_logic;
           Jump_in : in STD_LOGIC;
           Jump_out : out STD_LOGIC;
           MemRead : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           RegWrite_in: in std_logic;
           RegWrite_out: out std_logic;
           MemtoReg_in: in std_logic;
           MemtoReg_out: out std_logic;
           Address_in : in STD_LOGIC_VECTOR (31 downto 0);
           Address_out : out STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in: in std_logic_vector(4 downto 0);
           WriteRegister_out: out std_logic_vector(4 downto 0);
           ReadData : out STD_LOGIC_VECTOR (31 downto 0);
           JumpAddr_in : in STD_LOGIC_VECTOR(31 downto 0);
           JumpAddr_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

component MEM_WB_Reg is
    port(
            clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           
           --WB control lines
           RegWrite_in : in STD_LOGIC;
           MemtoReg_in : in STD_LOGIC;
           RegWrite_out : out STD_LOGIC;
           MemtoReg_out : out STD_LOGIC;
           
           --Datapath lines
           ReadData_in : in STD_LOGIC_VECTOR (31 downto 0);
           ALUresult_in : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           ReadData_out : out STD_LOGIC_VECTOR (31 downto 0);
           ALUresult_out : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0)
        );
end component;

component WB_Stage is
    port(
            RegWrite_in : in STD_LOGIC;
           MemtoReg : in STD_LOGIC;
           ReadData : in STD_LOGIC_VECTOR (31 downto 0);
           ALUresult : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0);
           RegWrite_out : out STD_LOGIC
        );
end component;

-- stage signals
    --mem stage
signal MEM_Jump_out, mem_RegWrite_out, mem_MemtoReg_out: std_logic;
signal MEM_JumpAddr_out, mem_Address_out, mem_ReadData_out: std_logic_vector(31 downto 0);
signal mem_WriteRegister: std_logic_vector(4 downto 0);

    --if stage
signal IF_PC4, IF_Instruction: std_logic_vector(31 downto 0);

    --wb stage
signal wb_WriteRegister_out: std_logic_vector(4 downto 0);
signal wb_WriteData_out: std_logic_vector(31 downto 0);
signal wb_RegWrite_out: std_logic;

    --id stage
signal id_ReadData1_out, id_ReadData2_out, id_SignExtend_out: std_logic_vector(31 downto 0);
signal id_RT_out, id_RD_out: std_logic_vector(4 downto 0);
signal id_RegWrite_out,id_MemtoReg_out,id_MemWrite_out,id_MemRead_out,id_Jump_out,id_RegDst_out,id_ALUSrc_out: std_logic;
signal id_ALUOp_out: std_logic_vector(1 downto 0);

    --ex stage
signal ex_RegWrite_out, ex_MemtoReg_out, ex_MemWrite_out, ex_MemRead_out, ex_Jump_out: std_logic;
signal ex_JumpAddr_out, ex_ALUresult_out, ex_WriteData_out: std_logic_vector(31 downto 0);
signal ex_WriteRegister: std_logic_vector(4 downto 0);

-- register signals
signal IF_ID_PC4, IF_ID_Instruction: std_logic_vector(31 downto 0);
signal ID_PC4: std_logic_vector(31 downto 0);

signal ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_Jump, ID_EX_RegDst, ID_EX_ALUSrc: std_logic;
signal ID_EX_ALUOp: std_logic_vector(1 downto 0);
signal ID_EX_PC4, ID_EX_A1, ID_EX_A2, ID_EX_Signext: std_logic_vector(31 downto 0);
signal ID_EX_RT, ID_EX_RD: STD_LOGIC_VECTOR(4 downto 0);

signal EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_Jump: std_logic;
signal EX_MEM_ALUresult, EX_MEM_WriteData, EX_MEM_JumpAddr: std_logic_vector(31 downto 0);
signal EX_MEM_WriteRegister: std_logic_vector(4 downto 0);

signal MEM_WB_RegWrite, MEM_WB_MemtoReg: std_logic;
signal MEM_WB_ReadData, MEM_WB_ALUresult: std_logic_vector(31 downto 0); 
signal MEM_WB_WriteRegister: std_logic_vector(4 downto 0);

begin

Stage_IF: IF_Stage port map(clk, reset, MEM_JumpAddr_out, MEM_Jump_out, IF_PC4, IF_Instruction);

Reg1: IF_ID_Reg port map(clk, reset, IF_PC4, IF_Instruction, IF_ID_PC4, IF_ID_Instruction);

Stage_ID: ID_Stage port map(clk, reset, IF_ID_PC4, ID_PC4, IF_ID_Instruction,
                            wb_WriteRegister_out, wb_WriteData_out,
                            id_ReadData1_out,id_ReadData2_out,
                            id_SignExtend_out,id_RT_out,id_RD_out,
                            wb_RegWrite_out,id_RegWrite_out,
                            id_MemtoReg_out,id_MemWrite_out,
                            id_MemRead_out,id_Jump_out,
                            id_RegDst_out,id_ALUOp_out,id_ALUSrc_out);
                            
Reg2: ID_EX_Reg port map(clk, reset, id_RegWrite_out,id_MemtoReg_out,ID_EX_RegWrite, ID_EX_MemtoReg,
                         id_MemWrite_out,id_MemRead_out,id_Jump_out,ID_EX_MemWrite,ID_EX_MemRead,ID_EX_Jump,
                         id_RegDst_out,id_ALUOp_out,id_ALUSrc_out,ID_EX_RegDst,ID_EX_ALUOp,ID_EX_ALUSrc,
                         ID_PC4,id_ReadData1_out,id_ReadData2_out,id_SignExtend_out,id_RT_out,id_RD_out,
                         ID_EX_PC4,ID_EX_A1,ID_EX_A2,ID_EX_Signext,ID_EX_RT,ID_EX_RD);

Stage_EX: EX_Stage port map(ID_EX_RegWrite, ex_RegWrite_out, ID_EX_MemtoReg, ex_MemtoReg_out,
                            ID_EX_MemWrite, ex_MemWrite_out, ID_EX_MemRead, ex_MemRead_out, ID_EX_Jump, ex_Jump_out,
                            ID_EX_RegDst, ID_EX_ALUOp, ID_EX_ALUSrc,
                            ID_EX_PC4, ID_EX_A1, ID_EX_A2, ID_EX_Signext, ID_EX_RT, ID_EX_RD,
                            ex_JumpAddr_out, ex_ALUresult_out, ex_WriteData_out, ex_WriteRegister);

Reg3: EX_MEM_Reg port map(clk, reset, ex_RegWrite_out, ex_MemtoReg_out, EX_MEM_RegWrite, EX_MEM_MemtoReg,
                          ex_MemWrite_out, ex_MemRead_out, ex_Jump_out, EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_Jump,
                          ex_ALUresult_out, ex_WriteData_out, ex_WriteRegister, EX_MEM_ALUresult, EX_MEM_WriteData, EX_MEM_WriteRegister,
                          ex_JumpAddr_out, EX_MEM_JumpAddr);

Stage_MEM: MEM_Stage port map(clk, reset, EX_MEM_Jump, MEM_Jump_out, EX_MEM_MemRead, EX_MEM_MemWrite,
                               EX_MEM_RegWrite, mem_RegWrite_out, EX_MEM_MemtoReg, mem_MemtoReg_out,
                               EX_MEM_ALUresult, mem_Address_out, EX_MEM_WriteData,
                               EX_MEM_WriteRegister, mem_WriteRegister, mem_ReadData_out, EX_MEM_JumpAddr, MEM_JumpAddr_out);

Reg4: MEM_WB_Reg port map(clk, reset, mem_RegWrite_out, mem_MemtoReg_out, MEM_WB_RegWrite, MEM_WB_MemtoReg,
                          mem_ReadData_out, mem_Address_out, mem_WriteRegister,
                          MEM_WB_ReadData, MEM_WB_ALUresult, MEM_WB_WriteRegister);

Stage_WB: WB_Stage port map(MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_ReadData, MEM_WB_ALUresult, 
                            wb_WriteData_out, MEM_WB_WriteRegister, wb_WriteRegister_out, wb_RegWrite_out);

end Structural;
