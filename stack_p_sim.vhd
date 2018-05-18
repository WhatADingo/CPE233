library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stack_p_sim is

end stack_p_sim;

architecture Behavioral of stack_p_sim is
    component SP is
    Port (RST: in STD_LOGIC;
             CLK: in STD_LOGIC;
                SP_LD: in STD_LOGIC;
                SP_INCR: in STD_LOGIC;
                SP_DECR: in STD_LOGIC;
                DATA: in STD_LOGIC_VECTOR (7 downto 0);
               DATA_OUT: out STD_LOGIC_VECTOR (7 downto 0));
    end component SP;
    
    signal DATA : STD_LOGIC_VECTOR(7 downto 0);
    signal RST : STD_LOGIC := '0';
    signal SP_LD : STD_LOGIC;
    signal SP_INCR: STD_LOGIC;
    signal SP_DECR: STD_LOGIC;
    signal DATA_OUT : STD_LOGIC_VECTOR(7 downto 0);
    signal CLK : std_logic := '0';
    constant CLK_period: time := 10 ns;

begin

    uut: SP Port Map(
        CLK => CLK,
        DATA => DATA,
        RST => RST,
        SP_LD => SP_LD,
        SP_INCR => SP_INCR,
        SP_DECR => SP_DECR,
        DATA_OUT => DATA_OUT);
        
    CLK_process : process
        begin
        wait for CLK_period/2;
        CLK <= not CLK;
    end process;
    
    sim_proc: process
    begin
        RST <= '0';
        SP_LD <= '1';
        DATA <= "00000001";
        wait for 15 ns;
        SP_LD <= '0';
        SP_INCR <= '1';
        wait for 15 ns;

        
    end process;
end Behavioral;
