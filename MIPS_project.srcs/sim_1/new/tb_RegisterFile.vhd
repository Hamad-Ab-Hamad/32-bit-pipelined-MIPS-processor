library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_RegisterFile is
--  Port ( );
end tb_RegisterFile;

architecture Behavioral of tb_RegisterFile is

signal tb_ReadRegister1, tb_ReadRegister2, tb_WriteRegister: std_logic_vector(4 downto 0);

signal  tb_WriteData, tb_ReadData1, tb_ReadData2: std_logic_vector(31 downto 0);

signal tb_RegWrite: std_logic;

signal tb_clk: std_logic:= '0';
signal tb_reset: std_logic:= '0';

constant clk_period: time:= 400ns;

begin

uut: entity work.RegisterFile(Behavioral)
        Port map ( 
                ReadRegister1 => tb_ReadRegister1,
                ReadRegister2 => tb_ReadRegister2,
                WriteRegister => tb_WriteRegister,
                WriteData => tb_WriteData,
                ReadData1 => tb_ReadData1,
                ReadData2 => tb_ReadData2,
                RegWrite => tb_RegWrite,
                CLK => tb_clk,
                RESET => tb_reset        
                 );


clk_process: process
begin

tb_clk <= '0';
wait for clk_period/2;

tb_clk<= '1';
wait for clk_period/2;

end process;


stim_proce: process
begin

-- To read data from register provided the address
--    for i in 0 to 30 loop
--        tb_ReadRegister1 <= std_logic_vector(to_unsigned(i,5));
--        tb_ReadRegister2 <= std_logic_vector(to_unsigned(i+1,5));
--        wait for 30ns;
--    end loop;
 
-- To write data to a register
--    tb_WriteRegister <= "10000"; -- write to $s0 register
--    tb_WriteData <= x"ABCDEF12";
--    wait for 30ns;
    
--    tb_RegWrite <= '1';
--    wait for 30ns;
    
--    tb_RegWrite <= '0';
--    wait for 30ns;

-- Read/Write data with clk
tb_RegWrite<='0';
tb_ReadRegister1<="10000";-- read $s0, expected ReadData1<= 0x00000016
wait for 200ns;

tb_RegWrite<='1';
tb_WriteRegister<="10000"; --write $s0
tb_WriteData <= x"ABCDEF12";
wait for 200ns;
 
tb_RegWrite<='0';
tb_ReadRegister1<="10000";-- read $s0, expected ReadData1 <= 0xABCDEF12
wait for 200ns;

tb_reset<= '1';
wait for 200ns;

tb_RegWrite<='0';
tb_ReadRegister1<="10000";-- read $s0, expected ReadData1<= 0x00000000
wait for 200ns;
 
end process;

end Behavioral;
