library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_MAIN is
    Port ( PC_LD : in STD_LOGIC;
           PC_INC : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PC_COUNT : out STD_LOGIC_VECTOR (9 downto 0);
           FROM_IMMED : in STD_LOGIC_VECTOR (9 downto 0);
           FROM_STACK : in STD_LOGIC_VECTOR (9 downto 0);
           PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0));
end PC_MAIN;

architecture Behavioral of PC_MAIN is

component PC is
    Port ( D_IN : in STD_LOGIC_VECTOR (9 downto 0);
           PC_LD : in STD_LOGIC;
           PC_INC : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PC_COUNT : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component PC_MUX is
    Port ( FROM_IMMED : in STD_LOGIC_VECTOR (9 downto 0);
           FROM_STACK : in STD_LOGIC_VECTOR (9 downto 0);
           PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0);
           D_IN : out STD_LOGIC_VECTOR (9 downto 0));
end component;

signal data : STD_LOGIC_VECTOR (9 downto 0);

begin

pcee:     PC port map(
            D_IN => data,
            PC_LD => PC_LD,
            PC_INC => PC_INC,
            RST => RST,
            CLK => CLK,
            PC_COUNT => PC_COUNT);
            
mux: PC_MUX port map(
            FROM_IMMED => FROM_IMMED,
            FROM_STACK => FROM_STACK,
            PC_MUX_SEL => PC_MUX_SEL,
            D_IN => data);
            
end Behavioral;
