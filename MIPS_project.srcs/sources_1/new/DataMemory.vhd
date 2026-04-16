library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is
    Port ( 
           clk : in std_logic;
           reset: in std_logic;
           Address : in STD_LOGIC_VECTOR (31 downto 0);
           WriteData : in STD_LOGIC_VECTOR (31 downto 0);
           MemRead: in std_logic;
           MemWrite: in std_logic;
           ReadData : out STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type mem is array (0 to 15) of std_logic_vector(31 downto 0);

signal DataMem: mem := ( x"00000001", -- address starts at 0x1000 0000
                         x"00000002",
                         x"00000003",
                         x"00000004",
                         x"00000005",
                         x"00000006",
                         x"00000007",
                         x"00000008",
                         x"00000009",
                         x"00000010",
                         x"00000011",
                         x"00000012",
                         x"00000013",
                         x"00000014",
                         x"00000015",
                         x"00000016"
                       );

begin

    process(clk)
    
    begin
      if (reset = '1') then
        DataMem<= (others=>(others=>'0'));
        -- 0x1000 0000 is 268435456 in decimal
        elsif (rising_edge(clk) and MemWrite = '1' ) then
            --DataMem((to_integer(unsigned(Address)) - 268435456) / 4) <= WriteData;
            if Address < x"10000000" then
                DataMem(0) <= WriteData;
            else
                DataMem(to_integer(unsigned(Address))- 268435456 / 4) <= WriteData;
            end if; 
        --end if;
        
        --elsif(rising_edge(clk) and MemRead = '1') then
            
      end if;
      
      if (Address = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" or Address < x"10000000") then
        ReadData<=x"00000000";
        elsif (MemRead='1') then
            ReadData <= DataMem((to_integer(unsigned(Address)) - 268435456) / 4);
      end if;    
    end process;
--ReadData <= DataMem((to_integer(unsigned(Address)) - 268435456) / 4) when MemRead ='1' else (others=>'0');
end Behavioral;
