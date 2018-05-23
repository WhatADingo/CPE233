----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2016 11:19:14 AM
-- Design Name: 
-- Module Name: debounce_one_shot_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce_one_shot_TB is
--  Port ( );
end debounce_one_shot_TB;

architecture Behavioral of debounce_one_shot_TB is

   component db_1shot_FSM is
       Port ( A    : in STD_LOGIC;
              CLK  : in STD_LOGIC;
              A_DB : out STD_LOGIC);
   end component;

   
    signal A_tb          : std_logic := '0';
    signal CLK_tb        : std_logic := '0';
    signal A_DB_tb       : std_logic := '0';
   
    constant clk_period : time := 20ns;
    
begin
    
    uut: db_1shot_FSM
    port map (  A     => A_tb,
                CLK   => CLK_tb,
                A_DB  => A_DB_tb);               
                
    clk_proc : process
    begin
        CLK_tb <= '0';
        wait for clk_period/2;
        CLK_tb <= '1';
        wait for clk_period/2;   
    end process;
    

    stim_proc: process
    begin
        A_tb <= '0';
        wait for 30ns;
        A_tb <= '1';
        wait for 30ns;
        A_tb <= '0';
        wait for 30ns;
        A_tb <= '1';
        wait for 30ns;
        
        wait for 2us;
        
        A_tb <= '0';
        wait for 30ns;
        A_tb <= '1';
        wait for 30ns;
        A_tb <= '0';
        wait for 30ns;
        A_tb <= '1';
        wait for 30ns;      
        A_tb <= '0';
        wait for 30ns;           

        wait;
        
    end process;
    
    end Behavioral;
