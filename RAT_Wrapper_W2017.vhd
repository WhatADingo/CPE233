----------------------------------------------------------------------------------
-- Company:  RAT Technologies (a subdivision of Cal Poly CENG)
-- Engineer:  Various RAT rats
--
-- Create Date:    02/03/2017
-- Module Name:    RAT_wrapper - Behavioral
-- Target Devices:  Basys3
-- Description: Wrapper for RAT CPU. This model provides a template to interfaces
--    the RAT CPU to the Basys3 development board.
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAT_wrapper is
    Port ( LEDS     : out   STD_LOGIC_VECTOR (7 downto 0);
           SWITCHES : in    STD_LOGIC_VECTOR (7 downto 0);
           RST      : in    STD_LOGIC;
           CLK      : in    STD_LOGIC;
           ANODES   : out   std_logic_vector (3 downto 0);
           CATHODES : out   std_logic_vector (7 downto 0);
           interrupt: in   std_logic);
end RAT_wrapper;

architecture Behavioral of RAT_wrapper is

   -- INPUT PORT IDS -------------------------------------------------------------
   -- Right now, the only possible inputs are the switches
   -- In future labs you can add more port IDs, and you'll have
   -- to add constants here for the mux below
   CONSTANT SWITCHES_ID : STD_LOGIC_VECTOR (7 downto 0) := X"20";
   -------------------------------------------------------------------------------
   
   -------------------------------------------------------------------------------
   -- OUTPUT PORT IDS ------------------------------------------------------------
   -- In future labs you can add more port IDs
   CONSTANT LEDS_ID       : STD_LOGIC_VECTOR (7 downto 0) := X"40";
   CONSTANT SSEG_ID       : STD_LOGIC_VECTOR (7 downto 0) := X"81";
   -------------------------------------------------------------------------------

   -- Declare RAT_CPU ------------------------------------------------------------
   component RAT_MCU
       Port ( IN_PORT  : in  STD_LOGIC_VECTOR (7 downto 0);
              OUT_PORT : out STD_LOGIC_VECTOR (7 downto 0);
              PORT_ID  : out STD_LOGIC_VECTOR (7 downto 0);
              IO_STRB  : out STD_LOGIC;
              RESET    : in  STD_LOGIC;
              INT   : in  STD_LOGIC;
              CLK      : in  STD_LOGIC);
   end component RAT_MCU;
   -------------------------------------------------------------------------------
   
   -- SSEG Display ---------------------------------------------------------------
   component sseg_dec is
       Port (     ALU_VAL : in std_logic_vector(7 downto 0); 
                  CLK : in std_logic;
                  DISP_EN : out std_logic_vector(3 downto 0);
                  SEGMENTS : out std_logic_vector(7 downto 0));
   end component sseg_dec;
   -----------------------------------------------------------------------------
   
   -- db_1shot ---------------------------------------------------------------
   component db_1shot_FSM is
       Port ( A    : in STD_LOGIC;
              CLK  : in STD_LOGIC;
              A_DB : out STD_LOGIC);
   end component db_1shot_FSM;
   
   -- Signals for connecting RAT_CPU to RAT_wrapper -------------------------------
   signal s_input_port  : std_logic_vector (7 downto 0);
   signal s_output_port : std_logic_vector (7 downto 0);
   signal s_port_id     : std_logic_vector (7 downto 0);
   signal s_load        : std_logic;
   signal s_clk_sig     : std_logic := '0';
   signal s_interrupt   : std_logic;
   
   -- Register definitions for output devices ------------------------------------
   -- add signals for any added outputs
   signal r_LEDS        : std_logic_vector (7 downto 0);
   signal r_SSEG        : std_logic_vector (7 downto 0);
   -------------------------------------------------------------------------------

begin
 
   -- Clock Divider Process ------------------------------------------------------
   clkdiv: process(CLK)
    begin
        if RISING_EDGE(CLK) then
            s_clk_sig <= NOT s_clk_sig;
        end if;
    end process clkdiv;
   -------------------------------------------------------------------------------
   
   
   -- Instantiate RAT_CPU --------------------------------------------------------
   CPU: RAT_MCU
   port map(  IN_PORT  => s_input_port,
              OUT_PORT => s_output_port,
              PORT_ID  => s_port_id,
              RESET    => RST,
              IO_STRB  => s_load,
              INT      => s_interrupt,
              CLK      => s_clk_sig);
   -------------------------------------------------------------------------------
   
    --sseg display ---------------------------------------------------------------
   display: sseg_dec
   port map( ALU_VAL => r_SSEG,
             CLK => s_clk_sig,
             DISP_EN => ANODES,
             SEGMENTS => CATHODES);
   -------------------------------------------------------------------------------
   
   --debounce_1shot ---------------------------------------------------------------
   debounce: db_1shot_fsm
   port map ( A => interrupt,
              CLK => s_clk_sig,
              A_DB => s_interrupt);
   -- MUX for selecting what input to read ---------------------------------------
   -- add conditions and connections for any added PORT IDs
   -------------------------------------------------------------------------------
   inputs: process(s_port_id, SWITCHES)
   begin
      if (s_port_id = SWITCHES_ID) then
         s_input_port <= SWITCHES;
      else
         s_input_port <= x"00";
      end if;
      
   end process inputs;
   -------------------------------------------------------------------------------


   -------------------------------------------------------------------------------
   -- MUX for updating output registers ------------------------------------------
   -- Register updates depend on rising clock edge and asserted load signal
   -- add conditions and connections for any added PORT IDs
   -------------------------------------------------------------------------------
   outputs: process(CLK)
   begin
      if (rising_edge(CLK)) then
         if (s_load = '1') then
           
            -- the register definition for the LEDS
            if (s_port_id = LEDS_ID) then
               r_LEDS <= s_output_port;
            -- the register definition for the SSEG display    
            elsif (s_port_id = SSEG_ID) then
               r_SSEG <= s_output_port;
            end if;
           
         end if;
      end if;
   end process outputs;
   -------------------------------------------------------------------------------

   -- Register Interface Assignments ---------------------------------------------
   -- add all outputs that you added to this design
   LEDS <= r_LEDS;
   
   

end Behavioral;
