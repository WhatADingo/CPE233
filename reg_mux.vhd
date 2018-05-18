
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_mux is
    Port ( rf_wr_sel: in std_logic_vector (1 downto 0);
           ALU_res : in STD_LOGIC_VECTOR (7 downto 0);
           scr_data: in std_logic_vector (7 downto 0);
           sp_data: in std_logic_vector (7 downto 0);
           in_port: in std_logic_vector (7 downto 0);
           d_out: out std_logic_vector (7 downto 0)
           );
end reg_mux;

architecture Behavioral of reg_mux is

begin

write: process(rf_wr_sel, ALU_res, scr_data, sp_data, in_port)
begin
    case rf_wr_sel is
        when "00" =>
            d_out <= ALU_res;
        when "01" =>
            d_out <= scr_data;
        when "10" =>
            d_out <= sp_data;
        when others =>
            d_out <= in_port;
    end case;
end process;

end Behavioral;
