----------------------------------------------------------------------------------
-- Engineer: Kia Rahbar, David Chau, Silas Wong
-- Create Date: 05/11/2018 04:12:26 PM 
-- Description: Stack Pointer
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SP is
    Port (RST: in STD_LOGIC;
             CLK: in STD_LOGIC;
                SP_LD: in STD_LOGIC;
                SP_INCR: in STD_LOGIC;
                SP_DECR: in STD_LOGIC;
                DATA: in STD_LOGIC_VECTOR (7 downto 0);
               DATA_OUT: out STD_LOGIC_VECTOR (7 downto 0));
end SP;

architecture Behavioral of SP is

signal SP_Sig : std_logic_vector(7 downto 0) := "00000000";

begin

Main: process(CLK,RST,SP_LD,SP_INCR,SP_DECR,DATA)
begin
if (rising_edge(CLK)) then
    if (RST = '1') then
        SP_Sig <= (others => '0');
    elsif (SP_LD = '1') then
        SP_Sig <= DATA;
    elsif (SP_INCR = '1') then
        SP_Sig <= SP_Sig + "00000001";
    elsif (SP_DECR = '1') then
        SP_Sig <= SP_Sig - "00000001";
    end if;
end if;
end process;

DATA_OUT <= SP_Sig;

end Behavioral;