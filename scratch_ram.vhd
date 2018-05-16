library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity scratch_ram is
    Port ( DATA_IN : in STD_LOGIC_VECTOR (9 downto 0);
           SCR_ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           SCR_WE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DATA_OUT : out STD_LOGIC_VECTOR (9 downto 0));
end scratch_ram;

architecture Behavioral of scratch_ram is

type memory is array (0 to 255) of STD_LOGIC_VECTOR (9 downto 0);
signal ram : memory := (others => (others => '0'));

begin

process(CLK, SCR_WE, DATA_IN, ram)
begin
    if rising_edge(CLK) then
        if SCR_WE = '1' then
             ram(to_integer(unsigned(SCR_ADDR))) <= DATA_IN;
        end if;
    end if;
end process;

DATA_OUT <= ram(to_integer(unsigned(SCR_ADDR)));

end Behavioral;
