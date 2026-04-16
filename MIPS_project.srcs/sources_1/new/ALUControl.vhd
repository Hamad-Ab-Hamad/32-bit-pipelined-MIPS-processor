library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALUControl is
    Port ( ALUOp : in STD_LOGIC_VECTOR (1 downto 0);
           FunctionCode : in STD_LOGIC_VECTOR (5 downto 0);
           ALUOperation : out STD_LOGIC_VECTOR (3 downto 0));
end ALUControl;

architecture Behavioral of ALUControl is

begin

ALUOperation(0) <= (FunctionCode(0) or FunctionCode(3)) and ALUOp(1) ;
ALUOperation(1) <= (not ALUOp(1)) or (not FunctionCode(2));
ALUOperation(2) <= (ALUOp(1) and FunctionCode(1)) or ALUOp(0);
ALUOperation(3) <= '0';

end Behavioral;
