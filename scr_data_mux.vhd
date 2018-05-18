
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity scr_data_mux is
  Port ( scr_data_sel: in std_logic;
         reg_data: in std_logic_vector (7 downto 0);
         pc_count: in std_logic_vector (9 downto 0);
         scr_d_out: out std_logic_vector (9 downto 0)
         );
end scr_data_mux;

architecture Behavioral of scr_data_mux is

begin
scr_data: process(scr_data_sel, reg_data, pc_count) --scr_data_sel mux
begin
    case scr_data_sel is
    when '0' =>
        scr_d_out <= "00" & reg_data;
    when others =>
        scr_d_out <= pc_count;
    end case;
end process;

end Behavioral;
