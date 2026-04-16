library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_InstructionMemory is
--  Port ( );
end tb_InstructionMemory;

architecture Behavioral of tb_InstructionMemory is

signal tb_Address : std_logic_vector(31 downto 0) := x"0000270C";

signal tb_Instruction: std_logic_vector(31 downto 0);

begin

uut: entity work.InstructionMemory(Behavioral)
    port map(
                Address => tb_Address,
                Instruction => tb_Instruction
            );

stim_proc: process

begin

for i in 0 to 15 loop

tb_Address <= x"00002710" or std_logic_vector(to_unsigned(i*4,32)); --tb_address is expecting a 32 bit address from pc
wait for 30ns;
end loop;

end process;


end Behavioral;
