library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_CPU is
--  Port ( );
end tb_CPU;

architecture Structural of tb_CPU is

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;

begin

uut: entity work.CPU(Structural)
    port map(
                clk => tb_clk,
                reset => tb_reset
            );

clk_process: process
begin

tb_clk <= '0';
wait for clk_period/2;

tb_clk<= '1';
wait for clk_period/2;

end process;


--stim_proc: process
--begin

--wait for 200ns;

--end process;


end Structural;
