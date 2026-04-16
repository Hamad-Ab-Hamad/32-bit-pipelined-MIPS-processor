library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity tb_ALU is
--  Port ( );
end tb_ALU;

architecture Behavioral of tb_ALU is
    signal tb_a1, tb_a2: std_logic_vector(31 downto 0); --input
    signal tb_alu_ctrl: std_logic_vector(3 downto 0); --input
    signal tb_Cin: std_logic;--input
    signal tb_Cout: std_logic;--output
    signal tb_alu_rslt: std_logic_vector (31 downto 0); --output

begin

uut: entity work.ALU(Behavioral) 
    port map(
        a1 => tb_a1,
        a2 => tb_a2,
        alu_ctrl => tb_alu_ctrl,
        Cin => tb_Cin,
        Cout => tb_Cout,
        alu_rslt => tb_alu_rslt
    );
    
 stim_proc: process
 begin
 
    tb_a1 <= x"FFFF0000";
    tb_a2 <= x"0000FFFF";
    tb_Cin <= '0';
    
    tb_alu_ctrl <= "0000"; --AND expected output = 0x00000000
    wait for 10ns;
    
    tb_alu_ctrl <= "0001"; --OR expected output = 0xFFFFFFFF
    wait for 10ns;
 
    tb_alu_ctrl <= "0010"; --add expected output = 0xFFFFFFFF, cout = 0
    wait for 10ns;
    
    tb_Cin <= '1';
    tb_alu_ctrl <= "0010"; --add expected output = 0xFFFFFFFE, cout = 1
    wait for 10ns;
    
    tb_alu_ctrl <= "0110"; --sub exptected output = 0xFFFE0001
    wait for 10ns;
    
    tb_alu_ctrl <= "0111"; --stl expceted output = 0x00000000
    wait for 10ns;
    
    tb_alu_ctrl <= "1100"; --NOR expceted output = 0x00000000
    wait for 10ns;
    
    
    
 
 end process;
 
end Behavioral;
