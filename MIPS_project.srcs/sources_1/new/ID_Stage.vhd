library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID_Stage is
    Port ( id_clk : in STD_LOGIC;
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
           id_ALUSrc : out STD_LOGIC);
end ID_Stage;

architecture Structural of ID_Stage is

--component MUX is
--    generic(N: integer:=5);
--    port(
--            input1: in std_logic_vector(N-1 downto 0);
--            input2: in std_logic_vector(N-1 downto 0);
--            ctrl: in std_logic;
--            output: out std_logic_vector(N-1 downto 0)
--        );
--end component;

component SignExtend is
    port (
           Input : in STD_LOGIC_VECTOR(15 downto 0);
           Output : out STD_LOGIC_VECTOR(31 downto 0)
         );
end component;

component ControUnit is
    port(
           OPcode : in STD_LOGIC_VECTOR (5 downto 0);
           RegDst : out STD_LOGIC;
           MemRead : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR(1 downto 0);
           MemWrite : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           Jump: out STD_LOGIC
        );
end component;

component RegisterFile is
    port(
            -- Input
           ReadRegister1 : in STD_LOGIC_VECTOR (4 downto 0);
           ReadRegister2 : in STD_LOGIC_VECTOR (4 downto 0);
           WriteRegister : in STD_LOGIC_VECTOR (4 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           
           --Control line
           RegWrite : in STD_LOGIC;
           
           --Output
           ReadData1 : out STD_LOGIC_VECTOR (31 downto 0);
           ReadData2 : out STD_LOGIC_VECTOR (31 downto 0);
           
           --clock and reset
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC
        );
end component;

--signal s_RegDst: std_logic;
--signal MUX_out: std_logic_vector(4 downto 0);
        
begin

Control: ControUnit port map(id_Instruction(31 downto 26), id_RegDst, id_MemRead, id_MemtoReg, id_ALUOp, id_MemWrite, id_ALUSrc, id_RegWrite_out, id_Jump);

--MUXunit: MUX port map(id_Instruction(20 downto 16), id_Instruction(15 downto 11), s_RegDst, MUX_out);

RegFile: RegisterFile port map(id_Instruction(25 downto 21), id_Instruction(20 downto 16), wb_WriteRegister, wb_WriteData, wb_RegWrite_in
                               ,id_ReadData1, id_ReadData2, id_clk, id_reset);

EXT: SignExtend port map(id_Instruction(15 downto 0), id_SignExtend);

id_RT<= id_Instruction(20 downto 16);
id_RD<= id_Instruction(15 downto 11);
id_PC4_out <= id_PC4_in;
end Structural;
