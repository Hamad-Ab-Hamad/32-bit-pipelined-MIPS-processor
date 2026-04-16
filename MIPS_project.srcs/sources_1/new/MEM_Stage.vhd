library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_Stage is
    Port ( 
           clk: in std_logic;
           reset: in std_logic;
           Jump_in : in STD_LOGIC;
           Jump_out : out STD_LOGIC;
           MemRead : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           RegWrite_in: in std_logic;
           RegWrite_out: out std_logic;
           MemtoReg_in: in std_logic;
           MemtoReg_out: out std_logic;
           Address_in : in STD_LOGIC_VECTOR (31 downto 0);
           Address_out : out STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister_in: in std_logic_vector(4 downto 0);
           WriteRegister_out: out std_logic_vector(4 downto 0);
           ReadData : out STD_LOGIC_VECTOR (31 downto 0);
           JumpAddr_in : in STD_LOGIC_VECTOR(31 downto 0);
           JumpAddr_out : out STD_LOGIC_VECTOR(31 downto 0));
end MEM_Stage;

architecture Structural of MEM_Stage is

component DataMemory is
    port(
               clk : in std_logic;
               reset: in std_logic;
               Address : in STD_LOGIC_VECTOR (31 downto 0);
               WriteData : in STD_LOGIC_VECTOR (31 downto 0);
               MemRead: in std_logic;
               MemWrite: in std_logic;
               ReadData : out STD_LOGIC_VECTOR (31 downto 0) 
            );
end component;


begin

DataMem: DataMemory port map(clk, reset, Address_in, WriteData, MemRead, MemWrite
                            ,ReadData);

WriteRegister_out<=WriteRegister_in;
Address_out<= Address_in;
Jump_out <= Jump_in;
JumpAddr_out<=JumpAddr_in;
RegWrite_out<=RegWrite_in;
MemtoReg_out<=MemtoReg_in;

end Structural;
