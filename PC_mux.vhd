library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_MUX is
    Port ( FROM_IMMED : in STD_LOGIC_VECTOR (9 downto 0);
           FROM_STACK : in STD_LOGIC_VECTOR (9 downto 0);
           PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0);
           D_IN : out STD_LOGIC_VECTOR (9 downto 0));
end PC_MUX;

architecture Behavioral of PC_MUX is

begin

proc : process (PC_MUX_SEL, FROM_IMMED, FROM_STACK)
begin
    case PC_MUX_SEL is
        when "00" =>
            D_IN <= FROM_IMMED;
        when "01" =>
            D_IN <= FROM_STACK;
        when "10" =>
            D_IN <= (others => '1');
        when others =>
            D_IN <= (others => '0');
    end case;
end process;

end Behavioral;
