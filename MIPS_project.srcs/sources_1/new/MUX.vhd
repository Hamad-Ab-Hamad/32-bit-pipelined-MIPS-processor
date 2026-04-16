library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Generic ( N : Integer:= 32);
    
    Port ( input1 : in STD_LOGIC_VECTOR(N-1 downto 0);
           input2 : in STD_LOGIC_VECTOR(N-1 downto 0);
           ctrl : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(N-1 downto 0));
end MUX;

architecture Behavioral of MUX is

begin

    output <= input1 when ctrl = '0' else input2;

end Behavioral;
