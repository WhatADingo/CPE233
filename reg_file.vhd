library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_file is
    Port ( RF_WR_DATA : in STD_LOGIC_VECTOR (7 downto 0);
           ADRX : in STD_LOGIC_VECTOR (4 downto 0);
           ADRY : in STD_LOGIC_VECTOR (4 downto 0);
           RF_WR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DX_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           DY_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end reg_file;

architecture Behavioral of reg_file is

type memory is Array(0 to 31) of STD_LOGIC_VECTOR(7 downto 0);
signal ram : memory := (others => (others => '0'));

begin

write: process(CLK, RF_WR, ADRX, RF_WR_DATA, ram)
begin
    if(rising_edge(CLK)) then
        if (RF_WR = '1') then
            ram(to_integer(unsigned(ADRX))) <= RF_WR_DATA;
        end if;
    end if;
end process;

DX_OUT <= ram(to_integer(unsigned(ADRX)));
DY_OUT <= ram(to_integer(unsigned(ADRY)));

end Behavioral;
