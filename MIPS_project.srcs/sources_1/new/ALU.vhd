library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( a1 : in STD_LOGIC_VECTOR (31 downto 0);
           a2 : in STD_LOGIC_VECTOR (31 downto 0);
           Cin: in std_logic;
           alu_ctrl : in STD_LOGIC_VECTOR (3 downto 0);
           Cout: out std_logic;
           alu_rslt : out STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

signal temp_rslt: std_logic_vector(31 downto 0);
signal temp_add_rslt: std_logic_vector(31 downto 0);
signal temp_cout: std_logic;

Component Thirtytwo_bit_RCA
 Port ( 
           A : in STD_LOGIC_VECTOR (31 downto 0); -- 32 bit input
           B : in STD_LOGIC_VECTOR (31 downto 0); -- 32 bit input
           Cin : in STD_LOGIC; -- 1 bit input
           Sum : out STD_LOGIC_VECTOR (31 downto 0);-- 32 bit output
           Cout : out STD_LOGIC);-- 1 bit output
End Component;

begin

RCA: Thirtytwo_bit_RCA port map ( a1, a2, Cin, temp_add_rslt, temp_cout);

    process(a1, a2, alu_ctrl)

    begin

        case alu_ctrl is
            
            when "0000" => -- AND
                temp_rslt <= a1 and a2;
                
            when "0001" => -- OR
                temp_rslt <= a1 or a2;
                
            when "0010" => -- add
                --temp_rslt <= std_logic_vector(unsigned(A) + unsigned(B));
                temp_rslt <= temp_add_rslt;
                --temp_rslt <= A xor B xor (x"0000000" & Cin);
                --temp_cout <= (A and B) or (A and ("0000000000000000000000000000000" & Cin)) or (B and ("00000000000000000000000000000000000000" & Cin));
                
            when "0110" => -- sub
                temp_rslt <= std_logic_vector(unsigned(a1) - unsigned(a2));
                
            when "0111" => -- slt
                if (signed(a2) < signed(a1)) then 
                       temp_rslt <= x"00000001";
                else
                       temp_rslt <= x"00000000";
                end if;
            when "1100" => -- NOR
                temp_rslt <= a1 nor a2;
            
            --when "0000" => -- add1
               
        
            when others => null; 
                temp_rslt <= x"00000000";    
           end case;
    end process;

alu_rslt <= temp_rslt;
Cout <= temp_cout;

end Behavioral;
