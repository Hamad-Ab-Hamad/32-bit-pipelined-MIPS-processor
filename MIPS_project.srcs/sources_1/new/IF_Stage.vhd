library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_Stage is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           JumpAddr : in STD_LOGIC_VECTOR (31 downto 0);
           PCsrc : in STD_LOGIC;
           PC4 : out STD_LOGIC_VECTOR (31 downto 0);
           Instruction_out : out STD_LOGIC_VECTOR (31 downto 0));
end IF_Stage;

architecture Structural of IF_Stage is

component MUX is
    generic(N: integer:=32);
    port(
            input1: in std_logic_vector(N-1 downto 0);
            input2: in std_logic_vector(N-1 downto 0);
            ctrl: in std_logic;
            output: out std_logic_vector(N-1 downto 0)
        );
end component;

component PC is 
    Port ( 
               clk: in std_logic;
               reset: in std_logic;
               Address_in : in STD_LOGIC_VECTOR (31 downto 0);
               Address_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Thirtytwo_bit_RCA is
    Port (     A : in STD_LOGIC_VECTOR (31 downto 0); -- 32 bit input
               B : in STD_LOGIC_VECTOR (31 downto 0); -- 32 bit input
               Cin : in STD_LOGIC; -- 1 bit input
               Sum : out STD_LOGIC_VECTOR (31 downto 0);-- 32 bit output
               Cout : out STD_LOGIC);-- 1 bit output
end component;

component InstructionMemory is
    Port ( Address : in STD_LOGIC_VECTOR (31 downto 0);
           Instruction : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal PC_out, MUX_out, PC_plus_4: std_logic_vector(31 downto 0);
signal c_out: std_logic;

begin

MUXunit: MUX port map(PC_plus_4,JumpAddr,PCsrc,MUX_out);

PCunit: PC port map(clk,reset,MUX_out,PC_out);

Addunit: Thirtytwo_bit_RCA port map(PC_out, x"00000004", '0',PC_plus_4,c_out);

InstructionMemunit: InstructionMemory port map(PC_out, Instruction_out);
PC4<=PC_plus_4;
end Structural;
