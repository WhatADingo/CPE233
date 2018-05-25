library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FLAGS is
    Port ( c : in STD_LOGIC;
           z : in STD_LOGIC;
           cset : in STD_LOGIC;
           cclr : in STD_LOGIC;
           zclr : in STD_LOGIC;
           cld : in STD_LOGIC;
           zld : in STD_LOGIC;
           flgsel : in STD_LOGIC; -- FLG_LD_SEL
           shadld : in STD_LOGIC;
           cflag : out STD_LOGIC;
           zflag : out STD_LOGIC;
           clk : in STD_LOGIC);
end FLAGS;

architecture Behavioral of FLAGS is

component reg is
    Port ( load : in STD_LOGIC;
           set : in STD_LOGIC;
           clear : in STD_LOGIC;
           d_in : in STD_LOGIC;
           d_out : out STD_LOGIC;
           clk : in STD_LOGIC);
end component;

signal c_in : std_logic;
signal z_in : std_logic;
signal shad_c_in : std_logic;
signal shad_z_in : std_logic;
signal shad_c_out : std_logic;
signal shad_z_out : std_logic;

begin

cflag <= shad_c_in;
zflag <= shad_z_in;

c_reg:      reg port map(
            load => cld,
            set => cset,
            clear => cclr,
            d_in => c_in,
            d_out => cflag,
            clk => clk);
            
z_reg:      reg port map(
            load => zld,
            d_in => z_in,
            set => '0',
            clear => '0',
            d_out => zflag,
            clk => clk);
            
c_shad_reg: reg port map(
            load => shadld,
            set => '0',
            clear => '0',
            d_in => shad_c_in,
            d_out => shad_c_out,
            clk => clk);
            
z_shad_reg: reg port map(
            load => shadld,
            set => '0',
            clear => zclr,
            d_in => shad_z_in,
            d_out => shad_z_out,
            clk => clk);

mux: process(flgsel, c, z, shad_c_out, shad_z_out)
begin

if(flgsel = '0') then
    c_in <= c;
    z_in <= z;
else
    c_in <= shad_c_out;
    z_in <= shad_z_out;
end if;
    
end process;

end Behavioral;
