library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           SEL : in STD_LOGIC_VECTOR (3 downto 0);
           SUM : out STD_LOGIC_VECTOR (7 downto 0);
           C_FLAG : out STD_LOGIC;
           Z_FLAG : out STD_LOGIC;
           C_IN : in STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

--extended signals to 9 bits for carry
signal aex : STD_LOGIC_VECTOR (8 downto 0);
signal bex : STD_LOGIC_VECTOR (8 downto 0);

--intermediate signals for processes
signal S : STD_LOGIC_VECTOR (8 downto 0);
signal C : STD_LOGIC;
signal Z : STD_LOGIC;

begin

aex <= '0' & A;
bex <= '0' & B;

choose: process(SEL, aex, bex, C_IN)
variable rex : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
begin
case SEL is
    when "0000" => rex := aex + bex; --add
    when "0001" => rex := aex + bex + C_IN; --addc
    when "0010" => rex := aex - bex; --sub
    when "0011" => rex := (aex - bex) - C_IN; --subc
    when "0100" => rex := aex - bex; --cmp
    when "0101" => rex := aex and bex; --and
    when "0110" => rex := aex or bex; --or
    when "0111" => rex := aex xor bex; --exor
    when "1000" => rex := aex and bex; --test
    when "1001" => rex := aex(7 downto 0) & C_IN; --lsl
    when "1010" => rex := C_IN & aex(7 downto 1) & aex(0); --lsr
    when "1011" => rex := '0' & aex(6 downto 0) & aex(7); --rol
    when "1100" => rex := '0' & aex(0) & aex(7 downto 1); -- ror
    when "1101" => rex := '0' & aex(7) & aex(7 downto 1); --asr
    when "1110" => rex := bex; --mov
    when others => rex := (others => '0');
end case;
if (rex(7 downto 0) = x"00") then
    z <= '1';
else
    z <= '0';
end if;
C <= rex(8);
SUM <= rex(7 downto 0);
end process choose;


    

--zflag: process(SEL, rex)
--begin
--if(SEL (3 downto 1) /= "111" ) then
--    if (rex(7 downto 0) = x"00") then
--        Z <= '1';
--    else
--        Z <= '0';
--    end if;
--else Z <= '0';
--end if;
--end process zflag;

--cflag: process(SEL, rex, aex)
--begin
--if(SEL < "0101") then
--    C <= rex(8);
--elsif(SEL > "0100" and SEL < "1001") then
--    C <= '0';
--elsif(SEL = "1001" or SEL = "1011") then
--    C <= aex(7);
--elsif(SEL = "1010" or SEL = "1100" or SEL = "1101") then
--    C <= aex(0);
--else C <= '0';
--end if;
--end process cflag;

--misc: process(SEL, rex, aex)
--begin
--if(SEL /= "0100" and SEL /= "1000") then
--    SUM <= rex(7 downto 0);
--else
--    SUM <= aex(7 downto 0);
--end if;
--end process misc;

--SUM <= S(7 downto 0);
C_FLAG <= C;
Z_FLAG <= Z;

end Behavioral;
