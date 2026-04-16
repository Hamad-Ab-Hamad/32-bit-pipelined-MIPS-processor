library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_MUX is
--  Port ( );
end Tb_MUX;

architecture Behavioral of Tb_MUX is

constant N: integer := 5;

signal tb_input1 : STD_LOGIC_VECTOR(N-1 downto 0);
signal tb_input2 : STD_LOGIC_VECTOR(N-1 downto 0);
signal tb_ctrl : STD_LOGIC;
signal tb_output : STD_LOGIC_VECTOR(N-1 downto 0);


begin

uut: entity work.MUX(Behavioral)
    generic map (N => 5)
    port map(
        input1 => tb_input1,
        input2 => tb_input2,
        ctrl => tb_ctrl,
        output => tb_output
    );
    
stim_proc : process
begin
    --32 bit 2to1 MUX
--    tb_input1 <= x"11111111";
--    tb_input2 <= x"55555555";
    
--    tb_ctrl <= '0';
--    wait for 100ns;
    
--    tb_ctrl <= '1';
--    wait for 100ns;
    
    -- 5 bit 2to1 MUX
    tb_input1 <= "11111";
    tb_input2 <= "10101";
    
    tb_ctrl <= '0';
    wait for 100ns;
    
    tb_ctrl <= '1';
    wait for 100ns;

end process;

end Behavioral;
