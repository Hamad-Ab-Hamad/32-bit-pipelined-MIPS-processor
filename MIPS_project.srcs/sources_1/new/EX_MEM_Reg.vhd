library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EX_MEM_Reg is
    Port ( clk : in STD_LOGIC;
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
           JumpAddr_out: out STD_LOGIC_VECTOR(31 downto 0));
end EX_MEM_Reg;

architecture Behavioral of EX_MEM_Reg is

begin

process(clk)
begin

    if reset = '1' then
        
        RegWrite_out <= '0';
        MemtoReg_out <= '0';
        
        MemWrite_out<='0';
        MemRead_out<='0';
        Jump_out<='0';
        
        ALUresult_out<= x"00000000";
        WriteData_out<= x"00000000";
        WriteRegister_out<= "00000";
        JumpAddr_out<=x"00000000";
        
    elsif rising_edge(clk) then
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            
            MemWrite_out<=MemWrite_in;
            MemRead_out<=MemRead_in;
            Jump_out<=Jump_in;
            
            ALUresult_out<= ALUresult_in;
            WriteData_out<= WriteData_in;
            WriteRegister_out<= WriteRegister_in;
            JumpAddr_out<=JumpAddr_in;
    end if;
end process;
end Behavioral;
