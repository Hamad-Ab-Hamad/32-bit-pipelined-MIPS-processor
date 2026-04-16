library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_IFstage is
--  Port ( );
end tb_IFstage;

architecture Structural of tb_IFstage is

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;

signal tb_JumpAddr, tb_PC4, tb_Instruction_out: std_logic_vector(31 downto 0);
signal tb_PCsrc: std_logic;

begin

uut: entity work.IF_Stage(Structural) 
    port map(
                clk => tb_clk,
                reset => tb_reset,
                JumpAddr => tb_JumpAddr,
                PC4=> tb_PC4,
                Instruction_out=>tb_Instruction_out,
                PCsrc=>tb_PCsrc
            );

clk_process: process
begin

tb_clk <= '0';
wait for clk_period/2;

tb_clk<= '1';
wait for clk_period/2;

end process;

stim_proc: process
begin
wait for 400ns;
tb_JumpAddr<=x"00000000";
tb_reset<='0';
tb_PCsrc<='0';
wait for 400ns;

tb_reset<='1';
wait for 200ns;

end process;

end Structural;
