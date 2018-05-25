library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity RAT_MCU is
    Port ( IN_PORT : in STD_LOGIC_VECTOR (7 downto 0);
           RESET : in STD_LOGIC;
           INT : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUT_PORT : out STD_LOGIC_VECTOR (7 downto 0);
           PORT_ID : out STD_LOGIC_VECTOR (7 downto 0);
           IO_STRB : out STD_LOGIC);
end RAT_MCU;

architecture Behavioral of RAT_MCU is

component control_unit is
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
           flg_z_clr : out STD_LOGIC;
           flg_c_ld : out STD_LOGIC;
           flg_z_ld : out STD_LOGIC;
           flg_ld_sel : out STD_LOGIC;
           flg_shad_ld : out STD_LOGIC;
           rst : out STD_LOGIC;
           io_strb : out STD_LOGIC);
end component;

component PC_MAIN is
    Port ( PC_LD : in STD_LOGIC;
           PC_INC : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           PC_COUNT : out STD_LOGIC_VECTOR (9 downto 0);
           FROM_IMMED : in STD_LOGIC_VECTOR (9 downto 0);
           FROM_STACK : in STD_LOGIC_VECTOR (9 downto 0);
           PC_MUX_SEL : in STD_LOGIC_VECTOR (1 downto 0));
end component;

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

component prog_rom is
   port (     ADDRESS : in std_logic_vector(9 downto 0); 
          INSTRUCTION : out std_logic_vector(17 downto 0); 
                  CLK : in std_logic);  
end component;

component reg_file is
    Port ( RF_WR_DATA : in STD_LOGIC_VECTOR (7 downto 0);
           ADRX : in STD_LOGIC_VECTOR (4 downto 0);
           ADRY : in STD_LOGIC_VECTOR (4 downto 0);
           RF_WR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DX_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           DY_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           SEL : in STD_LOGIC_VECTOR (3 downto 0);
           SUM : out STD_LOGIC_VECTOR (7 downto 0);
           C_FLAG : out STD_LOGIC;
           Z_FLAG : out STD_LOGIC;
           C_IN : in STD_LOGIC);
end component;

component scratch_ram is
    Port ( DATA_IN : in STD_LOGIC_VECTOR (9 downto 0);
           SCR_ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           SCR_WE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DATA_OUT : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component reg_mux is
    Port ( rf_wr_sel: in std_logic_vector (1 downto 0);
           ALU_res : in STD_LOGIC_VECTOR (7 downto 0);
           scr_data: in std_logic_vector (7 downto 0);
           sp_data: in std_logic_vector (7 downto 0);
           in_port: in std_logic_vector (7 downto 0);
           d_out: out std_logic_vector (7 downto 0)
           );
end component reg_mux;

component FLAGS is
    Port ( c : in STD_LOGIC;
           z : in STD_LOGIC;
           cset : in STD_LOGIC;
           i_set: in std_logic;
           i_clr: in std_logic;
           cclr : in STD_LOGIC;
           zclr : in STD_LOGIC;
           cld : in STD_LOGIC;
           zld : in STD_LOGIC;
           flgsel : in STD_LOGIC;
           shadld : in STD_LOGIC;
           cflag : out STD_LOGIC;
           zflag : out STD_LOGIC;
           iflag : out std_logic;
           clk : in STD_LOGIC);
end component;

component reg is
    Port ( load : in STD_LOGIC;
           set : in STD_LOGIC;
           clear : in STD_LOGIC;
           d_in : in STD_LOGIC;
           d_out : out STD_LOGIC;
           clk : in STD_LOGIC);
end component;

component SP is
    Port (RST: in STD_LOGIC;
         CLK: in STD_LOGIC;
            SP_LD: in STD_LOGIC;
            SP_INCR: in STD_LOGIC;
            SP_DECR: in STD_LOGIC;
            DATA: in STD_LOGIC_VECTOR (7 downto 0);
           DATA_OUT: out STD_LOGIC_VECTOR (7 downto 0));
end component SP;

component scr_addr_mux is
    Port ( scr_addr_sel : in STD_LOGIC_VECTOR (1 downto 0);
           reg_data : in std_logic_vector (7 downto 0);
           instruction: in STD_LOGIC_VECTOR (7 downto 0);
           sp_data: in std_logic_vector (7 downto 0);
           scr_addr: out std_logic_vector (7 downto 0)
           );
end component scr_addr_mux;

component scr_data_mux is
  Port ( scr_data_sel: in std_logic;
         reg_data: in std_logic_vector (7 downto 0);
         pc_count: in std_logic_vector (9 downto 0);
         scr_d_out: out std_logic_vector (9 downto 0)
         );
end component scr_data_mux;

signal PC_COUNT : std_logic_vector(9 downto 0);
signal ir : std_logic_vector(17 downto 0);

signal RF_WR_DATA : std_logic_vector(7 downto 0);
signal DX_OUT : std_logic_vector(7 downto 0);
signal DY_OUT : std_logic_vector(7 downto 0);
signal ALU_OPY : std_logic_vector(7 downto 0);

signal C : std_logic;
signal Z : std_logic;
--signal C_IN : std_logic;

signal RESULT : std_logic_vector(7 downto 0);

signal DATA_IN : std_logic_vector(9 downto 0);
signal DATA_OUT : std_logic_vector(9 downto 0);
signal SCR_ADDR : std_logic_vector(7 downto 0);

signal SP_OUT: std_logic_vector(7 downto 0);

signal RST : std_logic;

signal I_OUT : std_logic;
signal pre_int : std_logic;

--Control unit outputs
signal I_SET : std_logic;
signal I_CLR : std_logic;

signal PC_LD : std_logic;
signal PC_INC : std_logic;
signal PC_MUX_SEL : std_logic_vector(1 downto 0);

signal ALU_SEL : std_logic_vector(3 downto 0);
signal ALU_OPY_SEL : std_logic;

signal RF_WR : std_logic;
signal RF_WR_SEL : std_logic_vector(1 downto 0);

signal SP_LD : std_logic;
signal SP_INCR : std_logic;
signal SP_DECR : std_logic;

signal SCR_ADDR_SEL : std_logic_vector(1 downto 0);
signal SCR_DATA_SEL : std_logic;
signal SCR_WE : std_logic;

signal FLG_C_SET : std_logic;
signal FLG_C_CLR : std_logic;
signal FLG_Z_CLR : std_logic;
signal FLG_C_LD : std_logic;
signal FLG_Z_LD : std_logic;
signal FLG_LD_SEL : std_logic;
signal FLG_SHAD_LD : std_logic;
signal Z_FLAG : std_logic;
signal c_to_cin : std_logic;

begin


control: control_unit port map(
            c_flag => c_to_cin,
            z_flag => Z_flag,
            int => pre_int,
            reset => reset,
            ophigh => ir(17 downto 13),
            oplow => ir(1 downto 0),
            clk => clk,
            i_set => i_set,
            i_clr => i_clr,
            pc_ld => pc_ld,
            pc_inc => pc_inc,
            pc_mux_sel => pc_mux_sel,
            alu_opy_sel => alu_opy_sel,
            alu_sel => alu_sel,
            rf_wr => rf_wr,
            rf_wr_sel => rf_wr_sel,
            sp_ld => sp_ld,
            sp_incr => sp_incr,
            sp_decr => sp_decr,
            scr_we => scr_we,
            scr_addr_sel => scr_addr_sel,
            scr_data_sel => scr_data_sel,
            flg_c_set => flg_c_set,
            flg_c_clr => flg_c_clr,
            flg_Z_clr => flg_z_clr,
            flg_c_ld => flg_c_ld,
            flg_z_ld => flg_z_ld,
            flg_ld_sel => flg_ld_sel,
            flg_shad_ld => flg_shad_ld,
            rst => rst,
            io_strb => io_strb);
            
piece:  PC_MAIN port map(
            PC_LD => PC_LD,
            PC_INC => PC_INC,
            RST => RST,
            CLK => CLK,
            PC_COUNT => PC_COUNT,
            FROM_IMMED => ir(12 downto 3),
            FROM_STACK => DATA_OUT,
            PC_MUX_SEL => PC_MUX_SEL);

prog:   prog_rom port map(
            ADDRESS => PC_COUNT,
            INSTRUCTION => ir,
            CLK => CLK);
            
reg_mem:    reg_file port map(
            RF_WR_DATA => RF_WR_DATA,
            ADRX => ir(12 downto 8),
            ADRY => ir(7 downto 3),
            RF_WR => RF_WR,
            CLK => CLK,
            DX_OUT => DX_OUT,
            DY_OUT => DY_OUT);
            
reg_mult:    reg_mux port map(
            rf_wr_sel => rf_wr_sel,
            ALU_res => RESULT,
            scr_data => DATA_OUT(7 downto 0),
            sp_data => sp_out,
            in_port => IN_PORT,
            d_out => RF_WR_DATA);

al_you:   ALU port map(
            A=> DX_OUT,
            B => ALU_OPY,
            SUM => RESULT,
            SEL => ALU_SEL,
            C_FLAG => C,
            Z_FLAG => Z,
            C_IN => c_to_cin);
            
stack_p:    SP port map(
            SP_LD => SP_LD,
            RST => RST,
            sp_incr => sp_incr,
            sp_decr => sp_decr,
            CLK => CLK,
            DATA => DX_OUT,
            DATA_OUT => sp_out );
            
scratch:   scratch_ram port map(
            DATA_IN => DATA_IN,
            SCR_ADDR => SCR_ADDR,
            SCR_WE => SCR_WE,
            CLK => CLK,
            DATA_OUT => DATA_OUT);

scr_mux:   scr_addr_mux port map(
            scr_addr_sel => scr_addr_sel,
            reg_data => DY_OUT,
            instruction => ir (7 downto 0),
            sp_data => sp_out,
            scr_addr => SCR_ADDR);
            
scr_d_mux: scr_data_mux port map(
            scr_data_sel => scr_data_sel,
            reg_data => DX_OUT,
            pc_count  => PC_COUNT,
            scr_d_out => DATA_IN);
            
flg:       FLAGS port map(
            c => C,
            z => Z,
            i_set => i_set,
            i_clr => i_clr,
            cset => FLG_C_SET,
            cclr => FLG_C_CLR,
            zclr => FLG_Z_CLR,
            cld => FLG_C_LD,
            zld => FLG_Z_LD,
            flgsel => FLG_LD_SEL,
            shadld => FLG_SHAD_LD,
            cflag => c_to_cin,
            zflag => Z_flag,
            iflag => i_out,
            clk => CLK);
            
--i_reg: reg port map(
--            load => '0',
--            set => i_set,
--            clear => i_clr,
--            d_in => '0',
--            d_out => i_out,
--            clk => clk);
            
alu_b: process(ALU_OPY, ALU_OPY_SEL, DY_OUT, ir)
begin
    if(ALU_OPY_SEL = '1') then
        ALU_OPY <= ir(7 downto 0);
    else
        ALU_OPY <= DY_OUT;
    end if;
end process;

pre_int <= i_out and INT;
PORT_ID <= ir(7 downto 0);
OUT_PORT <= DX_OUT;

end Behavioral;
