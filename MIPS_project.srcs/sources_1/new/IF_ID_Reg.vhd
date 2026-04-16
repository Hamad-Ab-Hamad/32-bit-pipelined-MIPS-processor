library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_ID_Reg is
    Port ( 
           clk: in std_logic;
           reset: in std_logic;
           PC4_in : in STD_LOGIC_VECTOR (31 downto 0);
           Instruction_in : in STD_LOGIC_VECTOR (31 downto 0);
           PC4_out : out STD_LOGIC_VECTOR (31 downto 0);
           Instruction_out : out STD_LOGIC_VECTOR (31 downto 0));
end IF_ID_Reg;

architecture Behavioral of IF_ID_Reg is

begin

process(clk)
begin

if reset ='1' then
    PC4_out <= x"00000000";
    Instruction_out<= x"00000000";
    
    elsif rising_edge(clk) then
        PC4_out <= PC4_in;
        Instruction_out<= Instruction_in;
end if;


end process;


end Behavioral;
