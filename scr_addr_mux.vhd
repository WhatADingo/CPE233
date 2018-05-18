
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity scr_addr_mux is
    Port ( scr_addr_sel : in STD_LOGIC_VECTOR (1 downto 0);
           reg_data : in std_logic_vector (7 downto 0);
           instruction: in STD_LOGIC_VECTOR (7 downto 0);
           sp_data: in std_logic_vector (7 downto 0);
           scr_addr: out std_logic_vector (7 downto 0)
           );
end scr_addr_mux;

architecture Behavioral of scr_addr_mux is

begin

proc : process (scr_addr_sel, reg_data, instruction, sp_data)
begin
    case scr_addr_sel is
    when "00" =>
        scr_addr <= reg_data;
    when "01" =>
        scr_addr <= instruction;
    when "10" =>
        scr_addr <= sp_data;
    when others =>
        scr_addr <= sp_data - 1;
    end case;
end process;

end Behavioral;
