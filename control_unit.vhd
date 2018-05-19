library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port ( c_flag : in STD_LOGIC;
           z_flag : in STD_LOGIC;
           int : in STD_LOGIC;
           reset : in STD_LOGIC;
           ophigh : in STD_LOGIC_VECTOR (4 downto 0);
           oplow : in STD_LOGIC_VECTOR (1 downto 0);
           clk : in STD_LOGIC;
           i_set : out STD_LOGIC;
           i_clr : out STD_LOGIC;
           pc_ld : out STD_LOGIC;
           pc_inc : out STD_LOGIC;
           pc_mux_sel : out STD_LOGIC_VECTOR (1 downto 0);
           alu_opy_sel : out STD_LOGIC;
           alu_sel : out STD_LOGIC_VECTOR (3 downto 0);
           rf_wr : out STD_LOGIC;
           rf_wr_sel : out STD_LOGIC_VECTOR (1 downto 0);
           sp_ld : out STD_LOGIC;
           sp_incr : out STD_LOGIC;
           sp_decr : out STD_LOGIC;
           scr_we : out STD_LOGIC;
           scr_addr_sel : out STD_LOGIC_VECTOR (1 downto 0);
           scr_data_sel : out STD_LOGIC;
           flg_c_set : out STD_LOGIC;
           flg_c_clr : out STD_LOGIC;
           flg_c_ld : out STD_LOGIC;
           flg_z_ld : out STD_LOGIC;
           flg_ld_sel : out STD_LOGIC;
           flg_shad_ld : out STD_LOGIC;
           rst : out STD_LOGIC;
           io_strb : out STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is

component ff is
    Port ( d_in : in STD_LOGIC;
           d_out : out STD_LOGIC;
           clk : in STD_LOGIC;
           load : in STD_LOGIC);
end component;

signal op : STD_LOGIC_VECTOR(6 downto 0);

type state is (init, fetch, exec);
signal q, qn : state;

begin

op <= ophigh & oplow;

switch: process(clk, reset, qn)
begin
    if(reset = '1') then
        q <= init;
    elsif(rising_edge(clk)) then
        q <= qn;
    end if;
end process;


states: process(q, qn, op, c_flag, z_flag)
begin

    i_set <= '0';
    i_clr <= '0';
    pc_ld <= '0';
    pc_inc <= '0';
    pc_mux_sel <= "00";
    alu_opy_sel <= '0';
    alu_sel <= "0000";
    rf_wr <= '0';
    rf_wr_sel <= "00";
    sp_ld <= '0';
    sp_incr <= '0';
    sp_decr <= '0';
    scr_we <= '0';
    scr_addr_sel <= "00";
    scr_data_sel <= '0';
    flg_c_set <= '0';
    flg_c_clr <= '0';
    flg_c_ld <= '0';
    flg_z_ld <= '0';
    flg_ld_sel <= '0';
    flg_shad_ld <= '0';
    rst <= '0';
    io_strb <= '0';

case q is
when init =>
    rst <= '1';
    qn <= fetch;
when fetch =>
    qn <= exec;
    pc_inc <= '1';
when exec =>
    qn <= fetch;
    pc_inc <= '0';
    
    case op is
    
    --reg/reg
    --and
    when "0000000" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_sel <= "0101";
        alu_opy_sel <= '0';
        flg_z_ld <= '1';
    --or
    when "0000001" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "0110";
        flg_c_clr <= '1';
        flg_z_ld <= '1';
    --exor
    when "0000010" =>
        rf_wr <= '1';
        alu_opy_sel <= '0';
        alu_sel <= "0111";
        flg_z_ld <= '1';
    --test
    when "0000011" =>
        alu_sel <= "1000";
        alu_opy_sel <= '0';
        flg_z_ld <= '1';
    --add
    when "0000100" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "0000";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --addc
    when "0000101" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "0001";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --sub
    when "0000110" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "0010";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --subc
    when "0000111" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "0011";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --cmp
    when "0001000" =>
        alu_opy_sel <= '0';
        alu_sel <= "0100";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --mov
    when "0001001" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_sel <= "1110";
        alu_opy_sel <= '0';
     --   flg_z_ld <= '1';
   
    --ld
    when "0001010" =>
        rf_wr <= '1';
        rf_wr_sel <= "01";

    --st
    when "0001011" =>
        rf_wr <= '1';
        alu_sel <= "0011";
        --scr_data_sel <= '0';
        flg_z_ld <= '1';
    --brn
    when "0010000" =>
        pc_ld <= '1';
        pc_mux_sel <= "00";
    --breq
    when "0010010" =>
        if (z_flag = '1') then
            pc_ld <= '1';
            pc_mux_sel <= "00";
        end if ;
    --brne
    when "0010011" =>
        if (z_flag = '0') then
            pc_ld <= '1';
            pc_mux_sel <= "00";
        end if;
    --brcs
    when "0010100" =>
        if (c_flag ='1') then
            pc_ld <= '1';
            pc_mux_sel <= "00";
        end if;
    --brcc
    when "0010101" =>
        if (c_flag = '0') then
            pc_ld <= '1';
            pc_mux_sel <= "00";
        end if;
    --LSL
    when "0100000" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "1001";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --LSR
    when "0100001" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "1010";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --ROL
    when "0100010" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "1011";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --ROR
    when "0100011" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "1100";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --ASR
    when "0100100" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "1101";
        flg_c_ld <= '1';
        flg_z_ld <= '1'; 
        
    --CLC
    when "0110000" =>
        flg_c_clr <= '1';
    --SEC
    when "0110001" =>
        flg_c_set <= '1';
    
    
    --Stack Pointer    
    --call
    when "0010001" =>
        scr_data_sel <= '1';
        scr_we <= '1';    
        scr_addr_sel <= "11";
        sp_ld <= '0';
        sp_decr <= '1';
        pc_ld <= '1';
        pc_mux_sel <= "00";
    --push
    when "0100101" =>
        scr_data_sel <= '0';
        scr_we <= '1';
        scr_addr_sel <= "11";
        sp_ld <= '0';
        sp_decr <= '1';
    --pop
    when "0100110" =>
        rf_wr <= '1';
        rf_wr_sel <= "01";
        sp_incr <= '1';
        sp_ld <= '0';
        scr_addr_sel <= "10";
    --RET
    when "0110010" =>
        pc_mux_sel <= "01";
        scr_addr_sel <= "10";
        sp_incr <= '1';
        pc_ld <= '1';
    --wsp
    when "0101000" =>
        sp_ld <= '1';
        
        
    --reg-immed ---------
    --and
    when "1000000" | "1000001" | "1000010" | "1000011" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '1';
        alu_sel <= "0101";
        flg_z_ld <= '1'; 
           
    --or
    when  "1000100" | "1000101" | "1000110" | "1000111" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '1';
        alu_sel <= "0110";
        flg_z_ld <= '1';
        flg_c_clr <= '1';
    --exor
    when "1001000" | "1001001" | "1001010" | "1001011" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '1';
        alu_sel <= "0111";
        flg_z_ld <= '1';
    --test
    when "1001100" | "1001101" | "1001110" | "1001111" =>
        alu_opy_sel <= '1';
        alu_sel <= "1000";
        flg_z_ld <= '1';
    --add
    when "1010000" | "1010001" | "1010010" | "1010011" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '1';
        alu_sel <= "0000";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --addc
    when "1010100" | "1010101" | "1010110" | "1010111" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '1';
        alu_sel <= "0001";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --sub
     when "1011000" | "1011001" | "1011010" | "1011011" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '1';
        alu_sel <= "0010";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --subc
    when "1011100" | "1011101" | "1011110" | "1011111" =>
        rf_wr <= '1';
        rf_wr_sel <= "00";
        alu_opy_sel <= '1';
        alu_sel <= "0011";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
        
    --cmp
    when "1100000" | "1100001" | "1100010" | "1100011" =>
        alu_opy_sel <= '1';
        alu_sel <= "0100";
        flg_c_ld <= '1';
        flg_z_ld <= '1';
    --ld
    when "1110000" | "1110001" | "1110010" | "1110011" =>
        rf_wr <= '1';
        rf_wr_sel <= "01";
        scr_addr_sel <= "01";
    --st
    when "1110100" | "1110101" | "1110110" | "1110111" =>
        --scr_add_sel <= "01";
        scr_data_sel <= '0';
        scr_we <= '1';
        
         
    --in
    when "1100100" | "1100101" | "1100110" | "1100111" =>
        rf_wr <= '1';
        rf_wr_sel  <= "11";
    --out
    when "1101000" | "1101001" | "1101010" | "1101011" =>
        io_strb <= '1';
    --mov
    when "1101100" | "1101101" | "1101110" | "1101111" =>
        rf_wr <= '1';
        rf_wr_sel  <= "00";
        alu_opy_sel <= '1';
        alu_sel <= "1110";
    when others =>
        i_set <= '0';
        i_clr <= '0';
        pc_ld <= '0';
        pc_inc <= '0';
        pc_mux_sel <= "00";
        alu_opy_sel <= '0';
        alu_sel <= "0000";
        rf_wr <= '0';
        rf_wr_sel <= "00";
        sp_ld <= '0';
        sp_incr <= '0';
        sp_decr <= '0';
        scr_we <= '0';
        scr_addr_sel <= "00";
        scr_data_sel <= '0';
        flg_c_set <= '0';
        flg_c_clr <= '0';
        flg_c_ld <= '0';
        flg_z_ld <= '0';
        flg_ld_sel <= '0';
        flg_shad_ld <= '0';
        rst <= '0';
        io_strb <= '0';
        
    end case;
end case;

end process;

end Behavioral;
