library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SimulationMCU is

end SimulationMCU;

architecture Behavioral of SimulationMCU is
    component RAT_MCU is
        Port ( IN_PORT : in STD_LOGIC_VECTOR (7 downto 0);
               RESET : in STD_LOGIC;
               INT : in STD_LOGIC;
               CLK : in STD_LOGIC;
               OUT_PORT : out STD_LOGIC_VECTOR (7 downto 0);
               PORT_ID : out STD_LOGIC_VECTOR (7 downto 0);
               IO_STRB : out STD_LOGIC);
    end component RAT_MCU;
    
    signal IN_PORT : STD_LOGIC_VECTOR(7 downto 0);-- := (others => '0');
    signal RESET : STD_LOGIC := '0';
    signal INT : STD_LOGIC := '0';
    signal OUT_PORT : STD_LOGIC_VECTOR(7 downto 0);
    signal PORT_ID : STD_LOGIC_VECTOR(7 downto 0);
    signal IO_STRB : STD_LOGIC;
    signal CLK : std_logic := '0';
    constant CLK_period: time := 10 ns;

begin

    uut: RAT_MCU Port Map(
        CLK => CLK,
        IN_PORT => IN_PORT,
        RESET => RESET,
        INT => INT,
        OUT_PORT => OUT_PORT,
        PORT_ID => PORT_ID,
        IO_STRB => IO_STRB);
        
    CLK_process : process
        begin
        wait for CLK_period/2;
        CLK <= not CLK;
    end process;
    
    sim_proc: process
    begin
--        INT <= '0';
--        IN_PORT <= "00100000";
        RESET <= '0';
        INT <= '1';
        IN_PORT <= "11010110";
        wait for 20 ns;
--        wait for 20 ns;
--        IN_PORT <= "01010101";
--        wait for 20 ns;
--        IN_PORT <= "01010100";
--        wait;
    end process;
end Behavioral;
