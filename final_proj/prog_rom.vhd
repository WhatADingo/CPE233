-----------------------------------------------------------------------------
-- Definition of a single port ROM for RATASM defined by prog_rom.psm 
--  
-- Generated by RATASM Assembler 
--  
-- Standard IEEE libraries  
--  
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library unisim;
use unisim.vcomponents.all;
-----------------------------------------------------------------------------


entity prog_rom is 
   port (     ADDRESS : in std_logic_vector(9 downto 0); 
          INSTRUCTION : out std_logic_vector(17 downto 0); 
                  CLK : in std_logic);  
end prog_rom;



architecture low_level_definition of prog_rom is

   -----------------------------------------------------------------------------
   -- Attributes to define ROM contents during implementation synthesis. 
   -- The information is repeated in the generic map for functional simulation. 
   -----------------------------------------------------------------------------

   attribute INIT_00 : string; 
   attribute INIT_01 : string; 
   attribute INIT_02 : string; 
   attribute INIT_03 : string; 
   attribute INIT_04 : string; 
   attribute INIT_05 : string; 
   attribute INIT_06 : string; 
   attribute INIT_07 : string; 
   attribute INIT_08 : string; 
   attribute INIT_09 : string; 
   attribute INIT_0A : string; 
   attribute INIT_0B : string; 
   attribute INIT_0C : string; 
   attribute INIT_0D : string; 
   attribute INIT_0E : string; 
   attribute INIT_0F : string; 
   attribute INIT_10 : string; 
   attribute INIT_11 : string; 
   attribute INIT_12 : string; 
   attribute INIT_13 : string; 
   attribute INIT_14 : string; 
   attribute INIT_15 : string; 
   attribute INIT_16 : string; 
   attribute INIT_17 : string; 
   attribute INIT_18 : string; 
   attribute INIT_19 : string; 
   attribute INIT_1A : string; 
   attribute INIT_1B : string; 
   attribute INIT_1C : string; 
   attribute INIT_1D : string; 
   attribute INIT_1E : string; 
   attribute INIT_1F : string; 
   attribute INIT_20 : string; 
   attribute INIT_21 : string; 
   attribute INIT_22 : string; 
   attribute INIT_23 : string; 
   attribute INIT_24 : string; 
   attribute INIT_25 : string; 
   attribute INIT_26 : string; 
   attribute INIT_27 : string; 
   attribute INIT_28 : string; 
   attribute INIT_29 : string; 
   attribute INIT_2A : string; 
   attribute INIT_2B : string; 
   attribute INIT_2C : string; 
   attribute INIT_2D : string; 
   attribute INIT_2E : string; 
   attribute INIT_2F : string; 
   attribute INIT_30 : string; 
   attribute INIT_31 : string; 
   attribute INIT_32 : string; 
   attribute INIT_33 : string; 
   attribute INIT_34 : string; 
   attribute INIT_35 : string; 
   attribute INIT_36 : string; 
   attribute INIT_37 : string; 
   attribute INIT_38 : string; 
   attribute INIT_39 : string; 
   attribute INIT_3A : string; 
   attribute INIT_3B : string; 
   attribute INIT_3C : string; 
   attribute INIT_3D : string; 
   attribute INIT_3E : string; 
   attribute INIT_3F : string; 
   attribute INITP_00 : string; 
   attribute INITP_01 : string; 
   attribute INITP_02 : string; 
   attribute INITP_03 : string; 
   attribute INITP_04 : string; 
   attribute INITP_05 : string; 
   attribute INITP_06 : string; 
   attribute INITP_07 : string; 


   ----------------------------------------------------------------------
   -- Attributes to define ROM contents during implementation synthesis.
   ----------------------------------------------------------------------

   attribute INIT_00 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_01 of ram_1024_x_18 : label is "80E3484888018189890180C895A98139809B0A1B809B0B2582D1829985618139";  
   attribute INIT_02 of ram_1024_x_18 : label is "814B0D1D8D0180D96927680047696D0066FF8002811347488701818989018002";  
   attribute INIT_03 of ram_1024_x_18 : label is "81B8800025408002469244904591A2000401A1E80401041F053F454144398002";  
   attribute INIT_04 of ram_1024_x_18 : label is "800034408002269353905491A2881301A2701301131F143F5441533981C82580";  
   attribute INIT_05 of ram_1024_x_18 : label is "0F01A3E80F01A3780F012F9A8002818948596B0147516A0166F8825034808240";  
   attribute INIT_06 of ram_1024_x_18 : label is "4859800283233000833331008343D201720FD10171FFD00170FFA4C80F01A458";  
   attribute INIT_07 of ram_1024_x_18 : label is "C8014751485982E8818966F8485947518B018539464082EA0600821188014751";  
   attribute INIT_08 of ram_1024_x_18 : label is "06008211C7014859475182F8818966F848594751CB018539464082FA06008211";  
   attribute INIT_09 of ram_1024_x_18 : label is "4640831A060082118701485947518308818966F848594751CA0185394640830A";  
   attribute INIT_0A of ram_1024_x_18 : label is "8189671B6825661C8002818966FF485947518318818966F8485947518A018539";  
   attribute INIT_0B of ram_1024_x_18 : label is "691B6700682680D96926671C68008109691C6701680080D96926670068006600";  
   attribute INIT_0C of ram_1024_x_18 : label is "69046706680080D96902670268008109691C6700682780D96927671D68008109";  
   attribute INIT_0D of ram_1024_x_18 : label is "69046702680280D969046716680080D96902670E680080D969086708680080D9";  
   attribute INIT_0E of ram_1024_x_18 : label is "691867166802810969146712680281096910670C68028109690A670868028109";  
   attribute INIT_0F of ram_1024_x_18 : label is "690C67086804810969046700680480D96906671468028109691C671A68028109";  
   attribute INIT_10 of ram_1024_x_18 : label is "6906670A680480D96906670E68048109691A6718680481096914671068048109";  
   attribute INIT_11 of ram_1024_x_18 : label is "690C670A68068109690867066806810969046702680680D96906671A680480D9";  
   attribute INIT_12 of ram_1024_x_18 : label is "690A6704680680D9690C670268068109691A6716680681096914670E68068109";  
   attribute INIT_13 of ram_1024_x_18 : label is "690E670C68088109690A6706680880D969086718680680D969086712680680D9";  
   attribute INIT_14 of ram_1024_x_18 : label is "690A670C680880D9690A670668088109691C6718680881096916671268088109";  
   attribute INIT_15 of ram_1024_x_18 : label is "690C670A680A810969086706680A80D9690C6714680880D9690E6710680880D9";  
   attribute INIT_16 of ram_1024_x_18 : label is "690C670E680A80D9690E670A680A8109691A6714680A81096912670E680A8109";  
   attribute INIT_17 of ram_1024_x_18 : label is "69146712680C8109690A6704680C810969026700680C80D9690C6716680A80D9";  
   attribute INIT_18 of ram_1024_x_18 : label is "69106718680C80D9690E670C680C80D969186704680C810969186716680C8109";  
   attribute INIT_19 of ram_1024_x_18 : label is "69166710680E8109690E6708680E810969066704680E810969026700680E80D9";  
   attribute INIT_1A of ram_1024_x_18 : label is "6912670E680E80D969126708680E80D969106702680E8109691C6718680E8109";  
   attribute INIT_1B of ram_1024_x_18 : label is "69166710681081096916671068108109690C6706681080D969126716680E80D9";  
   attribute INIT_1C of ram_1024_x_18 : label is "690C67086812810969026700681280D9691E671A681080D969166712681080D9";  
   attribute INIT_1D of ram_1024_x_18 : label is "69166714681280D969146706681280D96914670268128109691A671668128109";  
   attribute INIT_1E of ram_1024_x_18 : label is "691C671A6814810969186716681481096914671268148109690E6706681480D9";  
   attribute INIT_1F of ram_1024_x_18 : label is "69186716681480D96916670E681480D9691A670A681480D96918670868148109";  
   attribute INIT_20 of ram_1024_x_18 : label is "6910670E68168109690667046816810969026700681680D969206718681480D9";  
   attribute INIT_21 of ram_1024_x_18 : label is "690C670A6818810969066702681880D9691E670C681680D9691A670268168109";  
   attribute INIT_22 of ram_1024_x_18 : label is "69266710681880D9691A670E681880D9691A6706681881096916670E68188109";  
   attribute INIT_23 of ram_1024_x_18 : label is "69166714681A8109690A6708681A810969046702681A80D9691A6712681880D9";  
   attribute INIT_24 of ram_1024_x_18 : label is "691E6702681C810969166712681C81096910670E681C8109690A6704681C8109";  
   attribute INIT_25 of ram_1024_x_18 : label is "69246714681C80D9691E6712681C80D9691E670A681C80D9691E6708681C80D9";  
   attribute INIT_26 of ram_1024_x_18 : label is "6920670E681E80D969246704681E810969086704681E810969026700681E80D9";  
   attribute INIT_27 of ram_1024_x_18 : label is "691A671868208109691467126820810969106706682080D969226716681E80D9";  
   attribute INIT_28 of ram_1024_x_18 : label is "6922671A682080D969246712682080D969226706682080D96924670268208109";  
   attribute INIT_29 of ram_1024_x_18 : label is "6924670E68228109691A671668228109690E670A6822810969086706682280D9";  
   attribute INIT_2A of ram_1024_x_18 : label is "691C6716681A80D9690C671A680A8109691C671468248109690E6702682480D9";  
   attribute INIT_2B of ram_1024_x_18 : label is "690F670E680F81896710680E8109690F670A680D661C800281896708681B80D9";  
   attribute INIT_2C of ram_1024_x_18 : label is "81096910670A681480D96915670A68138109690F670A68118189671068108109";  
   attribute INIT_2D of ram_1024_x_18 : label is "670D681A8189670C68198189670B681881096910670A681780D9691567106813";  
   attribute INIT_2E of ram_1024_x_18 : label is "0000000000000000000000000000000000000000800281096910670A681B8189";  
   attribute INIT_2F of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_30 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_31 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_32 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_33 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_34 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_35 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_36 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_37 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_38 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_39 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_3A of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_3B of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_3C of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_3D of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_3E of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INIT_3F of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INITP_00 of ram_1024_x_18 : label is "80308CC81222EEC4447433C867F11A0219FC468138F3D0890880330000000000";  
   attribute INITP_01 of ram_1024_x_18 : label is "FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFF3F4C0308CC80308CC80308CC";  
   attribute INITP_02 of ram_1024_x_18 : label is "FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC";  
   attribute INITP_03 of ram_1024_x_18 : label is "FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC";  
   attribute INITP_04 of ram_1024_x_18 : label is "FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC";  
   attribute INITP_05 of ram_1024_x_18 : label is "00000000000004FCF3CF3F3F3F3F3F3CFCF3FD3CFCFCFCFCFCFCFCFCFCFCFCFC";  
   attribute INITP_06 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  
   attribute INITP_07 of ram_1024_x_18 : label is "0000000000000000000000000000000000000000000000000000000000000000";  


begin

   ----------------------------------------------------------------------
   --Instantiate the Xilinx primitive for a block RAM 
   --INIT values repeated to define contents for functional simulation 
   ----------------------------------------------------------------------
   ram_1024_x_18: RAMB16_S18 
   --synthesitranslate_off
   --INIT values repeated to define contents for functional simulation
   generic map ( 
          INIT_00 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_01 => X"80E3484888018189890180C895A98139809B0A1B809B0B2582D1829985618139",  
          INIT_02 => X"814B0D1D8D0180D96927680047696D0066FF8002811347488701818989018002",  
          INIT_03 => X"81B8800025408002469244904591A2000401A1E80401041F053F454144398002",  
          INIT_04 => X"800034408002269353905491A2881301A2701301131F143F5441533981C82580",  
          INIT_05 => X"0F01A3E80F01A3780F012F9A8002818948596B0147516A0166F8825034808240",  
          INIT_06 => X"4859800283233000833331008343D201720FD10171FFD00170FFA4C80F01A458",  
          INIT_07 => X"C8014751485982E8818966F8485947518B018539464082EA0600821188014751",  
          INIT_08 => X"06008211C7014859475182F8818966F848594751CB018539464082FA06008211",  
          INIT_09 => X"4640831A060082118701485947518308818966F848594751CA0185394640830A",  
          INIT_0A => X"8189671B6825661C8002818966FF485947518318818966F8485947518A018539",  
          INIT_0B => X"691B6700682680D96926671C68008109691C6701680080D96926670068006600",  
          INIT_0C => X"69046706680080D96902670268008109691C6700682780D96927671D68008109",  
          INIT_0D => X"69046702680280D969046716680080D96902670E680080D969086708680080D9",  
          INIT_0E => X"691867166802810969146712680281096910670C68028109690A670868028109",  
          INIT_0F => X"690C67086804810969046700680480D96906671468028109691C671A68028109",  
          INIT_10 => X"6906670A680480D96906670E68048109691A6718680481096914671068048109",  
          INIT_11 => X"690C670A68068109690867066806810969046702680680D96906671A680480D9",  
          INIT_12 => X"690A6704680680D9690C670268068109691A6716680681096914670E68068109",  
          INIT_13 => X"690E670C68088109690A6706680880D969086718680680D969086712680680D9",  
          INIT_14 => X"690A670C680880D9690A670668088109691C6718680881096916671268088109",  
          INIT_15 => X"690C670A680A810969086706680A80D9690C6714680880D9690E6710680880D9",  
          INIT_16 => X"690C670E680A80D9690E670A680A8109691A6714680A81096912670E680A8109",  
          INIT_17 => X"69146712680C8109690A6704680C810969026700680C80D9690C6716680A80D9",  
          INIT_18 => X"69106718680C80D9690E670C680C80D969186704680C810969186716680C8109",  
          INIT_19 => X"69166710680E8109690E6708680E810969066704680E810969026700680E80D9",  
          INIT_1A => X"6912670E680E80D969126708680E80D969106702680E8109691C6718680E8109",  
          INIT_1B => X"69166710681081096916671068108109690C6706681080D969126716680E80D9",  
          INIT_1C => X"690C67086812810969026700681280D9691E671A681080D969166712681080D9",  
          INIT_1D => X"69166714681280D969146706681280D96914670268128109691A671668128109",  
          INIT_1E => X"691C671A6814810969186716681481096914671268148109690E6706681480D9",  
          INIT_1F => X"69186716681480D96916670E681480D9691A670A681480D96918670868148109",  
          INIT_20 => X"6910670E68168109690667046816810969026700681680D969206718681480D9",  
          INIT_21 => X"690C670A6818810969066702681880D9691E670C681680D9691A670268168109",  
          INIT_22 => X"69266710681880D9691A670E681880D9691A6706681881096916670E68188109",  
          INIT_23 => X"69166714681A8109690A6708681A810969046702681A80D9691A6712681880D9",  
          INIT_24 => X"691E6702681C810969166712681C81096910670E681C8109690A6704681C8109",  
          INIT_25 => X"69246714681C80D9691E6712681C80D9691E670A681C80D9691E6708681C80D9",  
          INIT_26 => X"6920670E681E80D969246704681E810969086704681E810969026700681E80D9",  
          INIT_27 => X"691A671868208109691467126820810969106706682080D969226716681E80D9",  
          INIT_28 => X"6922671A682080D969246712682080D969226706682080D96924670268208109",  
          INIT_29 => X"6924670E68228109691A671668228109690E670A6822810969086706682280D9",  
          INIT_2A => X"691C6716681A80D9690C671A680A8109691C671468248109690E6702682480D9",  
          INIT_2B => X"690F670E680F81896710680E8109690F670A680D661C800281896708681B80D9",  
          INIT_2C => X"81096910670A681480D96915670A68138109690F670A68118189671068108109",  
          INIT_2D => X"670D681A8189670C68198189670B681881096910670A681780D9691567106813",  
          INIT_2E => X"0000000000000000000000000000000000000000800281096910670A681B8189",  
          INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INITP_00 => X"80308CC81222EEC4447433C867F11A0219FC468138F3D0890880330000000000",  
          INITP_01 => X"FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFF3F4C0308CC80308CC80308CC",  
          INITP_02 => X"FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC",  
          INITP_03 => X"FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC",  
          INITP_04 => X"FCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFC",  
          INITP_05 => X"00000000000004FCF3CF3F3F3F3F3F3CFCF3FD3CFCFCFCFCFCFCFCFCFCFCFCFC",  
          INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",  
          INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000")  


   --synthesis translate_on
   port map(  DI => "0000000000000000",
             DIP => "00",
              EN => '1',
              WE => '0',
             SSR => '0',
             CLK => clk,
            ADDR => address,
              DO => INSTRUCTION(15 downto 0),
             DOP => INSTRUCTION(17 downto 16)); 

--
end low_level_definition;
--
----------------------------------------------------------------------
-- END OF FILE prog_rom.vhd
----------------------------------------------------------------------
