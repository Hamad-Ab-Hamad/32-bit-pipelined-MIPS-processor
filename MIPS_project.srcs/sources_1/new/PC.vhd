library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( 
           clk: in std_logic;
           reset: in std_logic;
           Address_in : in STD_LOGIC_VECTOR (31 downto 0);
           Address_out : out STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is

type mem is array (0 to 0) of std_logic_vector(31 downto 0);

signal reg: mem;

signal temp:std_logic_vector(31 downto 0);

begin
process(clk)
begin

if (reset = '1') then
    --Address_out<= x"0000271C";
    reg(0)<= x"00002710";
elsif rising_edge(clk) then
    if Address_in = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
        reg(0) <= x"00002710";
    else
        reg(0) <= Address_in;
    end if;
    --Address_out<=x"0000271C" when Address_in = x"00000000";
--    if Address_in /= x"00000000" then
--        Address_out<= x"0000271C";
--    else 
--        Address_out<= Address_in;
--    end if;
      --Address_out<= x"0000271C";
end if;

end process;

Address_out<= reg(0);

end Behavioral;
