library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_WB_Reg is
    Port ( clk : in STD_LOGIC;
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
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0));
end MEM_WB_Reg;

architecture Behavioral of MEM_WB_Reg is

begin

process(clk)
begin

    if reset = '1' then
        RegWrite_out <= '0';
        MemtoReg_out <= '0';
        
        elsif rising_edge(clk) then
            ReadData_out<= ReadData_in;
            ALUresult_out<=ALUresult_in;
            WriteRegister_out<=WriteRegister_in;
    end if;
end process;

end Behavioral;
