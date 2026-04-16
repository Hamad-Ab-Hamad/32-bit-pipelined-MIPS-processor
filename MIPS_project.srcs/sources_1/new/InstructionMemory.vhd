library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionMemory is
    Port ( Address : in STD_LOGIC_VECTOR (31 downto 0);
           Instruction : out STD_LOGIC_VECTOR (31 downto 0));
end InstructionMemory;

architecture Behavioral of InstructionMemory is

type memory16by32 is array (0 to 15) of std_logic_vector(31 downto 0);

signal InstMem: memory16by32 := (   x"02339022",--0x0000 2710      sub $s2, $s1, $s3
                                    x"024D5024",--0x0000 2714      and $t2, $s2, $t5
                                    x"020A5025",--0x0000 2718      or $t2, $s0, $t2
                                    x"01289820",--0x0000 271C      add1 $s3, $t1, $t0
                                    x"8E4B0064",--0x0000 2720      lw $t3, 100($s2)
                                    x"217400C8",--0x0000 2724      addi $s4, $t3, 200
                                    x"AD490064",--0x0000 2728      sw $t1, 100($t2)
                                    x"02284827",--0x0000 272C      nor $t1, $s1, $t0
                                    x"0252482A",--0x0000 2730      slt $t1, $s2, $s2
                                    x"08002710", --0x0000 2734      j $2500
                                    x"00000000",
                                    x"00000000",
                                    x"00000000",
                                    x"00000000",
                                    x"00000000",
                                    x"00000000"
                                );

begin
-- 0x0000 2710 => 10000 (decimal); 
-- when an address is greater than or equal to 0x0000 2710 
-- then change address to decimal, subtract 10000 from it and divide by 4
-- to allow word access 
Instruction <= x"00000000" when Address = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" else
               InstMem((to_integer(unsigned(Address)) - 10000) / 4);


--Instruction<= InstMem((to_integer(unsigned(Address)) - 10000) / 4);

end Behavioral;
