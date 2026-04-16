library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_5bit is
    Port ( input1 : in STD_LOGIC_VECTOR(4 downto 0);
           input2 : in STD_LOGIC_VECTOR(4 downto 0);
           ctrl : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(4 downto 0));
end MUX_5bit;

architecture Behavioral of MUX_5bit is

begin

    output <= input1 when ctrl = '0' else input2;

end Behavioral;
