library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID_EX_Reg is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           --WB control lines
           RegWrite_in : in STD_LOGIC;
           MemtoReg_in : in STD_LOGIC;
           RegWrite_out : out STD_LOGIC;
           MemtoReg_out : out STD_LOGIC;
           
           --M control lines
           MemWrite_in : in STD_LOGIC;
           MemRead_in : in STD_LOGIC;
           Jump_in : in STD_LOGIC;
           MemWrite_out : out STD_LOGIC;
           MemRead_out : out STD_LOGIC;
           Jump_out : out STD_LOGIC;
           
           --EX control lines
           RegDst_in : in STD_LOGIC;
           ALUOp_in : in STD_LOGIC_VECTOR (1 downto 0);
           ALUSrc_in : in STD_LOGIC;
           RegDst_out : out STD_LOGIC;
           ALUOp_out : out STD_LOGIC_VECTOR (1 downto 0);
           ALUSrc_out : out STD_LOGIC;
           
           --datapath lines
           PC4_in: in std_logic_vector(31 downto 0);
           A1_in: in std_logic_vector(31 downto 0);
           A2_in: in std_logic_vector(31 downto 0);
           signext_in: in std_logic_vector(31 downto 0);
           rt_in: in std_logic_vector(4 downto 0);
           rd_in: in std_logic_vector(4 downto 0);
           
           PC4_out: out std_logic_vector(31 downto 0);
           A1_out: out std_logic_vector(31 downto 0);
           A2_out: out std_logic_vector(31 downto 0);
           signext_out: out std_logic_vector(31 downto 0);
           rt_out: out std_logic_vector(4 downto 0);
           rd_out: out std_logic_vector(4 downto 0)
           );
end ID_EX_Reg;

architecture Behavioral of ID_EX_Reg is

begin

process(clk)
begin

    if reset = '1' then
        
        RegWrite_out <= '0';
        MemtoReg_out <= '0';
        
        MemWrite_out<='0';
        MemRead_out<='0';
        Jump_out<='0';
        
        RegDst_out<='0';
        ALUOp_out<= "00";
        ALUSrc_out<= '0';
        
        PC4_out<= x"00000000";
        A1_out<= x"00000000";
        A2_out<= x"00000000";
        signext_out<= x"00000000";
        rt_out<= "00000";
        rd_out<="00000";
        
        elsif rising_edge(clk) then
            RegWrite_out <= RegWrite_in;
            MemtoReg_out <= MemtoReg_in;
            
            MemWrite_out<=MemWrite_in;
            MemRead_out<=MemRead_in;
            Jump_out<=Jump_in;
            
            RegDst_out<=RegDst_in;
            ALUOp_out<= ALUOp_in;
            ALUSrc_out<= ALUSrc_in;
            
            PC4_out<= PC4_in;
            A1_out<= A1_in;
            A2_out<= A2_in;
            signext_out<= signext_in;
            rt_out<= rt_in;
            rd_out<=rd_in;
end if;          
end process;


end Behavioral;
