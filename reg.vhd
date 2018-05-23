library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
    Port ( load : in STD_LOGIC;
           set : in STD_LOGIC;
           clear : in STD_LOGIC;
           d_in : in STD_LOGIC;
           d_out : out STD_LOGIC;
           clk : in STD_LOGIC);
end reg;

architecture Behavioral of reg is

begin

proc: process(load, set, clear, d_in, clk)
begin

if(rising_edge(clk)) then
    if(clear = '1') then
        d_out <= '0';
    elsif(set = '1') then
        d_out <= '1';
    elsif(load = '1') then
        d_out <= d_in;
    end if;
end if;

end process;

end Behavioral;
