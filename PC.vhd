library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( D_IN : in STD_LOGIC_VECTOR (9 downto 0);
           PC_LD : in STD_LOGIC;
           PC_INC : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PC_COUNT : out STD_LOGIC_VECTOR (9 downto 0));
end PC;

architecture Behavioral of PC is

signal PC_sig : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";

begin

main : process(RST, PC_LD, PC_INC, D_IN, PC_sig, CLK)
begin
if(rising_edge(clk)) then
        if (RST = '1') then
            PC_sig <= (others => '0');
        elsif (PC_LD = '1') then
            PC_sig <= D_IN;
        elsif (PC_INC = '1') then
            PC_sig <= PC_sig + 1;
        end if;
    end if;
    
end process;

PC_COUNT <= PC_sig;

end Behavioral;
