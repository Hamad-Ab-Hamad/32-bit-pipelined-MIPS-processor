library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ControlUnit is
--  Port ( );
end tb_ControlUnit;

architecture Behavioral of tb_ControlUnit is

signal tb_OPcode: std_logic_vector(5 downto 0);
signal tb_RegDst, tb_MemRead, tb_MemtoReg, tb_MemWrite, tb_ALUSrc, tb_RegWrite, tb_Jump: std_logic;
signal tb_ALUOp: std_logic_vector(1 downto 0);

begin

uut: entity work.ControUnit(Behavioral)
        port map(
                    OPcode => tb_OPcode,
                    RegDst=> tb_RegDst, 
                    MemRead=>tb_MemRead, 
                    MemtoReg=>tb_MemtoReg, 
                    MemWrite=> tb_MemWrite, 
                    ALUSrc=> tb_ALUSrc,
                    ALUOp => tb_ALUOp, 
                    RegWrite=> tb_RegWrite,
                    Jump=> tb_Jump
                );

stim_proc: process
begin

tb_OPcode <= "000000"; --R-type
wait for 30ns;

tb_OPcode<= "100011"; --lw
wait for 30ns;

tb_OPcode<= "001000"; --addi
wait for 30ns;

tb_OPcode<= "101011"; --sw
wait for 30ns;

tb_OPcode<= "000010"; --j
wait for 30ns;

end process;

end Behavioral;
