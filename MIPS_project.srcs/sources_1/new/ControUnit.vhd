library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControUnit is
    Port ( OPcode : in STD_LOGIC_VECTOR (5 downto 0);
           RegDst : out STD_LOGIC;
           MemRead : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR(1 downto 0);
           MemWrite : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           Jump: out STD_LOGIC);
end ControUnit;

architecture Behavioral of ControUnit is

begin

process(OPcode)
begin

case OPcode is
        -- R-Type instruction
       when "000000" =>
            RegDst <= '1';
            MemRead<= '0';
            MemtoReg<= '1';
            ALUOp<= "10";
            MemWrite<= '0';
            ALUSrc<= '0';
            RegWrite<='1';
            Jump<= '0';
       
       --lw instruction
       when "100011" =>
            RegDst <= '0';
            MemRead<= '1';
            MemtoReg<= '1';
            ALUOp<= "00";
            MemWrite<= '0';
            ALUSrc<= '1';
            RegWrite<='1';
            Jump<= '0';
            
       --sw instruction
       when "101011" =>
            RegDst <= 'X';
            MemRead<= '0';
            MemtoReg<= 'X';
            ALUOp<= "00";
            MemWrite<= '1';
            ALUSrc<= '1';
            RegWrite<='0';
            Jump<= '0';
            
      --addi instruction
      when "001000" =>
            RegDst <= '0';
            MemRead<= '0';
            MemtoReg<= '0';
            ALUOp<= "00";
            MemWrite<= '0';
            ALUSrc<= '1';
            RegWrite<='1';
            Jump<= '0';
            
       --j instruction
       when "000010" =>
            RegDst <= 'X';
            MemRead<= '0';
            MemtoReg<= 'X';
            ALUOp<= "00";
            MemWrite<= '0';
            ALUSrc<= '0';
            RegWrite<='0';
            Jump<= '1';     
            
       when others=> null;
            RegDst <= '0';
            MemRead<= '0';
            MemtoReg<= '0';
            ALUOp<= "00";
            MemWrite<= '0';
            ALUSrc<= '0';
            RegWrite<='0';
            Jump<= '0';
            
       end case;
       
end process;

end Behavioral;
