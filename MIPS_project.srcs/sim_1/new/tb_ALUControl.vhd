library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ALUControl is
--  Port ( );
end tb_ALUControl;

architecture Behavioral of tb_ALUControl is

signal tb_ALUOp: std_logic_vector(1 downto 0);
signal tb_FunctionCode: std_logic_vector(5 downto 0);
signal tb_ALUOperation: std_logic_vector(3 downto 0);

begin

uut: entity work.ALUControl(Behavioral)
        port map(
                    ALUOp => tb_ALUOp,
                    FunctionCode => tb_FunctionCode,
                    ALUOperation => tb_ALUOperation
                );

stim_Proc: Process
begin
-- R-Type instructions
    -- add1 instruction
tb_ALUOp <= "10";
tb_FunctionCode <= "100000"; 
wait for 30ns;

    -- sub instruction
tb_ALUOp <= "10";
tb_FunctionCode <= "100010"; 
wait for 30ns;

    -- AND instruction
tb_ALUOp <= "10";
tb_FunctionCode <= "100100"; 
wait for 30ns;

    -- OR instruction
tb_ALUOp <= "10";
tb_FunctionCode <= "100101"; 
wait for 30ns;

    -- NOR instruction
tb_ALUOp <= "10";
tb_FunctionCode <= "100111"; 
wait for 30ns;

    -- stl instruction
tb_ALUOp <= "10";
tb_FunctionCode <= "101010"; 
wait for 30ns;

-- addi instruction
tb_ALUOp <= "00";
tb_FunctionCode <= "XXXXXX";
wait for 30ns;

--lw instruction;
tb_ALUOp <= "00";
tb_FunctionCode <= "XXXXXX";
wait for 30ns;

--sw Instruction;
tb_ALUOp <= "00";
tb_FunctionCode <= "XXXXXX";
wait for 30ns;


end process;


end Behavioral;
