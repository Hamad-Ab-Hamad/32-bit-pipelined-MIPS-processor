library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WB_Stage is
    Port ( RegWrite_in : in STD_LOGIC;
           MemtoReg : in STD_LOGIC;
           ReadData : in STD_LOGIC_VECTOR (31 downto 0);
           ALUresult : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : out STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in : in STD_LOGIC_VECTOR (4 downto 0);
           WriteRegister_out : out STD_LOGIC_VECTOR (4 downto 0);
           RegWrite_out : out STD_LOGIC);
end WB_Stage;

architecture Structural of WB_Stage is

component MUX is
    Generic ( N : Integer:= 32);
    
    Port ( input1 : in STD_LOGIC_VECTOR(N-1 downto 0);
           input2 : in STD_LOGIC_VECTOR(N-1 downto 0);
           ctrl : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(N-1 downto 0)
         );
end component;


begin

MUX32bit: MUX port map(ReadData,ALUresult,MemtoReg,WriteData);

RegWrite_out<=RegWrite_in;
WriteRegister_out<= WriteRegister_in;


end Structural;
