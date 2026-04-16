library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EX_Stage is
    Port ( -- WB and M stage control line input and outputs
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
           wb_WriteRegister: out STD_LOGIC_VECTOR (4 downto 0));
end EX_Stage;

architecture Structural of EX_Stage is

component ShiftLeft2 is 
    Port ( input : in STD_LOGIC_VECTOR (31 downto 0);
           output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Thirtytwo_bit_RCA is
    Port (     A : in STD_LOGIC_VECTOR (31 downto 0); -- 32 bit input
               B : in STD_LOGIC_VECTOR (31 downto 0); -- 32 bit input
               Cin : in STD_LOGIC; -- 1 bit input
               Sum : out STD_LOGIC_VECTOR (31 downto 0);-- 32 bit output
               Cout : out STD_LOGIC);-- 1 bit output
end component;

component MUX is
    generic(N: integer:=32);
    port(
            input1: in std_logic_vector(N-1 downto 0);
            input2: in std_logic_vector(N-1 downto 0);
            ctrl: in std_logic;
            output: out std_logic_vector(N-1 downto 0)
        );
end component;

component ALU is
    Port ( a1 : in STD_LOGIC_VECTOR (31 downto 0);
           a2 : in STD_LOGIC_VECTOR (31 downto 0);
           Cin: in std_logic;
           alu_ctrl : in STD_LOGIC_VECTOR (3 downto 0);
           Cout: out std_logic;
           alu_rslt : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component ALUControl is
    Port ( ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
           FunctionCode : in STD_LOGIC_VECTOR (5 downto 0);
           ALUOperation : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component MUX_5bit is
    port(
            input1: in std_logic_vector(4 downto 0);
            input2: in std_logic_vector(4 downto 0);
            ctrl: in std_logic;
            output: out std_logic_vector(4 downto 0)
        );
end component;

signal signextend_out, MUX32bit_out: std_logic_vector(31 downto 0);
signal MUX5bit_out: std_logic_vector(4 downto 0);
signal ALUControl_out: std_logic_vector(3 downto 0);
signal add_c_out, alu_c_out: std_logic;

begin

Shifter: Shiftleft2 port map(SignExtend, signextend_out);

Adder: Thirtytwo_bit_RCA port map(PC4_in, signextend_out, '0', JumpAddr, add_c_out);

MUX32bit: MUX port map(ReadData2, SignExtend, ALUSrc, MUX32bit_out);

A_L_U: ALU port map(ReadData1, MUX32bit_out, '0', ALUControl_out, alu_c_out, ALUresult);

A_L_U_ctrl: ALUControl port map (ALUOp, SignExtend(5 downto 0), ALUControl_out);

MUX5bit: MUX_5bit port map(RT, RD, RegDst, MUX5bit_out);

wb_WriteRegister <= MUX5bit_out;
RegWrite_out <= RegWrite_in;
MemtoReg_out <= MemtoReg_in;
MemWrite_out <= MemWrite_in;
MemRead_out <= MemRead_in;
Jump_out <= Jump_in;
WriteData <= ReadData2;

end Structural;
