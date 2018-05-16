

List FileKey 
----------------------------------------------------------------------
C1      C2      C3      C4    || C5
--------------------------------------------------------------
C1:  Address (decimal) of instruction in source file. 
C2:  Segment (code or data) and address (in code or data segment) 
       of inforation associated with current linte. Note that not all
       source lines will contain information in this field.  
C3:  Opcode bits (this field only appears for valid instructions.
C4:  Data field; lists data for labels and assorted directives. 
C5:  Raw line from source code.
----------------------------------------------------------------------


(0001)                            || ;-------------------------------------------------------------------- 
(0002)                            || ;- Programmers: Scott Leonard & Errol Leon
(0003)                            || ;- Date: 02-27-2011
(0004)                            || ;- Version: 1
(0005)                            || ;- Test Case: 7
(0006)                            || ;- 
(0007)                            || ;- TEST 1:	ADD
(0008)                            || ;- TEST 2:	ADDC
(0009)                            || ;- TEST 3:	SUB
(0010)                            || ;- TEST 4:	SUBC
(0011)                            || ;- 
(0012)                            || ;- LED output set to R15.
(0013)                            || ;- Tests will run then LED will continuously output results
(0014)                            || ;-------------------------------------------------------------------- 
(0015)                            || 
(0016)                            || ;--------------------------------------------------------------------
(0017)                            || ;- Port Constants
(0018)                            || ;--------------------------------------------------------------------
(0019)                       032  || .EQU SWITCH_PORT = 0x20         ; port for switches ----- INPUT
(0020)                       064  || .EQU LED_PORT = 0x40             ; port for LED output --- OUTOUT
(0021)                       255  || .EQU BTN_PORT = 0xFF             ; port for button input - INPUT
(0022)                            || ;-------------------------------------------------------------------- 
(0023)                            || 
(0024)                            || ;--------------------------------------------------------------------
(0025)                            || ;- Bit Constants
(0026)                            || ;--------------------------------------------------------------------
(0027)                       001  || .EQU B0_MASK = 0x01              ; mask all but bit0
(0028)                       002  || .EQU B1_MASK = 0x02              ; mask all but bit1
(0029)                       004  || .EQU B2_MASK = 0x04              ; mask all but bit2
(0030)                       008  || .EQU B3_MASK = 0x08              ; mask all but bit3
(0031)                       016  || .EQU B4_MASK = 0x10              ; mask all but bit4
(0032)                       032  || .EQU B5_MASK = 0x20              ; mask all but bit5
(0033)                       064  || .EQU B6_MASK = 0x40              ; mask all but bit6
(0034)                       128  || .EQU B7_MASK = 0x80              ; mask all but bit7
(0035)                       170  || .EQU INSIDE_FOR_COUNT = 0xAA	 ; Loop delays, ~0.5
(0036)                       170  || .EQU MIDDLE_FOR_COUNT = 0xAA	 ; second delay for
(0037)                       170  || .EQU OUTSIDE_FOR_COUNT = 0xAA	 ; each LED. 0xAA default
(0038)                            || ;--------------------------------------------------------------------    
(0039)                            || 
(0040)                            || ;--------------------------------------------------------------------
(0041)                            || ;- Memory Designation Constants
(0042)                            || ;--------------------------------------------------------------------
(0043)                            || .DSEG
(0044)                       000  || .ORG     0x00
(0045)  DS-0x000             001  || DATA:   .DB 1
(0046)                            || ;--------------------------------------------------------------------
(0047)                            || 
(0048)                            || ;--------------------------------------------------------------------
(0049)                            || ;- Begin Code Space
(0050)                            || ;--------------------------------------------------------------------
(0051)                            || .CSEG
(0052)                       023  || .ORG         0x17                            
(0053)                            || 
-------------------------------------------------------------------------------------------
-STUP-  CS-0x000  0x36001  0x001  ||              MOV     r0,0x01     ; write dseg data to reg
-STUP-  CS-0x001  0x3A000  0x000  ||              LD      r0,0x00     ; place reg data in mem 
-STUP-  CS-0x002  0x080B8  0x100  ||              BRN     0x17        ; jump to start of .cseg in program mem 
-------------------------------------------------------------------------------------------
(0054)  CS-0x017  0x36F00  0x017  || start:			 MOV R15,0x00     ;LED Register
(0055)                            || 
(0056)                            || ;-TEST-0-ADD--------------------------------------------------------
(0057)                            || 
(0058)  CS-0x018  0x36A05  0x018  || test0:		 	 MOV R10,0x05 
(0059)  CS-0x019  0x36B04         || 			 MOV R11,0x04
(0060)  CS-0x01A  0x02A58         || 			 ADD R10,R11	 ;5+4=9
(0061)  CS-0x01B  0x36C09         || 			 MOV R12,0x09
(0062)  CS-0x01C  0x04C50         || 			 CMP R12,R10
(0063)  CS-0x01D  0x080FA         || 			 BREQ test0_pass
(0064)  CS-0x01E  0x08108         || 			 BRN  test0_fail
(0065)                            || 			 			 
(0066)  CS-0x01F  0x22F01  0x01F  || test0_pass:  		 OR R15,B0_MASK
(0067)  CS-0x020  0x08110         || 			 BRN  delay0
(0068)                            || 
(0069)  CS-0x021  0x08110  0x021  || test0_fail:  		 BRN  delay0
(0070)                            || 
(0071)                            || 
(0072)  CS-0x022  0x374AA  0x022  || delay0:		MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
(0073)  CS-0x023  0x2D401  0x023  || OUTSIDE_FOR0: 	SUB     R20, 0x01
(0074)                            || 
(0075)  CS-0x024  0x375AA         || 		MOV     R21, MIDDLE_FOR_COUNT
(0076)  CS-0x025  0x2D501  0x025  || MIDDLE_FOR0:  	SUB     R21, 0x01
(0077)                            ||              
(0078)  CS-0x026  0x376AA         || 		MOV     R22, INSIDE_FOR_COUNT
(0079)  CS-0x027  0x2D601  0x027  || INSIDE_FOR0:  	SUB     R22, 0x01
(0080)  CS-0x028  0x0813B         || 		BRNE    INSIDE_FOR0
(0081)  CS-0x029  0x23500         || 		OR      R21, 0x00
(0082)  CS-0x02A  0x0812B         || 		BRNE    MIDDLE_FOR0
(0083)  CS-0x02B  0x23400         || 		OR      R20, 0x00
(0084)  CS-0x02C  0x0811B         || 		BRNE    OUTSIDE_FOR0
(0085)  CS-0x02D  0x08170         || 		BRN	test1			;Branch to next test
(0086)                            || ;--------------------------------------------------------------------
(0087)                            || 
(0088)                            || 
(0089)                            || 
(0090)                            || 
(0091)                            || ;-TEST-1-ADDC--------------------------------------------------------
(0092)                            || 
(0093)  CS-0x02E  0x34F40  0x02E  || test1:		 	 OUT R15,LED_PORT    ;Output current results
(0094)  CS-0x02F  0x18001         || 			 SEC		     ;set carry to 1
(0095)  CS-0x030  0x36A05         || 			 MOV R10,0x05 
(0096)  CS-0x031  0x36B04         || 			 MOV R11,0x04
(0097)  CS-0x032  0x02A59         || 			 ADDC R10,R11        ;5+4+1=10
(0098)  CS-0x033  0x36C0A         || 			 MOV R12,0x0A
(0099)  CS-0x034  0x04C50         || 			 CMP R12,R10
(0100)  CS-0x035  0x081BA         || 			 BREQ test1_pass
(0101)  CS-0x036  0x081C8         || 			 BRN  test1_fail
(0102)                            || 			 
(0103)  CS-0x037  0x22F02  0x037  || test1_pass:  		 OR   R15,B1_MASK
(0104)  CS-0x038  0x081D0         || 			 BRN  delay1
(0105)                            || 
(0106)  CS-0x039  0x081D0  0x039  || test1_fail:  		 BRN  delay1
(0107)                            || 
(0108)                            || 
(0109)  CS-0x03A  0x374AA  0x03A  || delay1:		MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
(0110)  CS-0x03B  0x2D401  0x03B  || OUTSIDE_FOR1: 	SUB     R20, 0x01
(0111)                            || 
(0112)  CS-0x03C  0x375AA         || 		MOV     R21, MIDDLE_FOR_COUNT
(0113)  CS-0x03D  0x2D501  0x03D  || MIDDLE_FOR1:  	SUB     R21, 0x01
(0114)                            ||              
(0115)  CS-0x03E  0x376AA         || 		MOV     R22, INSIDE_FOR_COUNT
(0116)  CS-0x03F  0x2D601  0x03F  || INSIDE_FOR1:  	SUB     R22, 0x01
(0117)  CS-0x040  0x081FB         || 		BRNE    INSIDE_FOR1
(0118)  CS-0x041  0x23500         || 		OR      R21, 0x00
(0119)  CS-0x042  0x081EB         || 		BRNE    MIDDLE_FOR1
(0120)  CS-0x043  0x23400         || 		OR      R20, 0x00
(0121)  CS-0x044  0x081DB         || 		BRNE    OUTSIDE_FOR1
(0122)  CS-0x045  0x08230         || 		BRN	test2			;Branch to next test
(0123)                            || ;--------------------------------------------------------------------
(0124)                            || 
(0125)                            || 
(0126)                            || 
(0127)                            || 
(0128)                            || ;-TEST-2-SUB---------------------------------------------------------
(0129)                            || 
(0130)  CS-0x046  0x34F40  0x046  || test2:		 	 OUT R15,LED_PORT    ;Output current results
(0131)  CS-0x047  0x36A05         || 			 MOV R10,0x05
(0132)  CS-0x048  0x36B04         || 			 MOV R11,0x04
(0133)  CS-0x049  0x02A5A         || 			 SUB R10,R11         ;5-4=1
(0134)  CS-0x04A  0x36C01         || 			 MOV R12,0x01
(0135)  CS-0x04B  0x04C50         || 			 CMP R12,R10
(0136)  CS-0x04C  0x08272         || 			 BREQ test2_pass
(0137)  CS-0x04D  0x08280         || 			 BRN  test2_fail		 
(0138)                            || 			 
(0139)  CS-0x04E  0x22F04  0x04E  || test2_pass:  		 OR   R15,B2_MASK
(0140)  CS-0x04F  0x08288         || 			 BRN  delay2
(0141)                            || 
(0142)  CS-0x050  0x08288  0x050  || test2_fail:  		 BRN  delay2
(0143)                            || 
(0144)                            || 
(0145)  CS-0x051  0x374AA  0x051  || delay2:		MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
(0146)  CS-0x052  0x2D401  0x052  || OUTSIDE_FOR2: 	SUB     R20, 0x01
(0147)                            || 
(0148)  CS-0x053  0x375AA         || 		MOV     R21, MIDDLE_FOR_COUNT
(0149)  CS-0x054  0x2D501  0x054  || MIDDLE_FOR2:  	SUB     R21, 0x01
(0150)                            ||              
(0151)  CS-0x055  0x376AA         || 		MOV     R22, INSIDE_FOR_COUNT
(0152)  CS-0x056  0x2D601  0x056  || INSIDE_FOR2:  	SUB     R22, 0x01
(0153)  CS-0x057  0x082B3         || 		BRNE    INSIDE_FOR2
(0154)  CS-0x058  0x23500         || 		OR      R21, 0x00
(0155)  CS-0x059  0x082A3         || 		BRNE    MIDDLE_FOR2
(0156)  CS-0x05A  0x23400         || 		OR      R20, 0x00
(0157)  CS-0x05B  0x08293         || 		BRNE    OUTSIDE_FOR2
(0158)  CS-0x05C  0x082E8         || 		BRN	test3			;Branch to next test
(0159)                            || ;--------------------------------------------------------------------
(0160)                            || 
(0161)                            || 
(0162)                            || 
(0163)                            || 
(0164)                            || ;-TEST-3-SUBC--------------------------------------------------------
(0165)                            || 
(0166)                            || 
(0167)  CS-0x05D  0x34F40  0x05D  || test3:		 	 OUT R15,LED_PORT    ;Output current results
(0168)  CS-0x05E  0x18001         || 			 SEC		     ;set carry to 1
(0169)  CS-0x05F  0x36A05         || 			 MOV R10,0x05
(0170)  CS-0x060  0x36B02         || 			 MOV R11,0x02
(0171)  CS-0x061  0x02A5B         || 			 SUBC R10,R11        ;5-2-1 = 2
(0172)  CS-0x062  0x36C02         || 			 MOV R12,0x02
(0173)  CS-0x063  0x04C50         || 			 CMP R12,R10
(0174)  CS-0x064  0x08332         || 			 BREQ test3_pass
(0175)  CS-0x065  0x08360         || 			 BRN  test3_fail
(0176)                            || 
(0177)  CS-0x066  0x22F08  0x066  || test3_pass:  		 OR R15,B3_MASK   ;turn on remaining LED's
(0178)  CS-0x067  0x22F10         || 			 OR R15,B4_MASK
(0179)  CS-0x068  0x22F20         || 			 OR R15,B5_MASK
(0180)  CS-0x069  0x22F40         || 			 OR R15,B6_MASK
(0181)  CS-0x06A  0x22F80         || 			 OR R15,B7_MASK
(0182)  CS-0x06B  0x08368         || 			 BRN  delay3
(0183)                            || 
(0184)  CS-0x06C  0x08368  0x06C  || test3_fail:  		 BRN  delay3
(0185)                            || 
(0186)                            || 
(0187)  CS-0x06D  0x374AA  0x06D  || delay3:		MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
(0188)  CS-0x06E  0x2D401  0x06E  || OUTSIDE_FOR3: 	SUB     R20, 0x01
(0189)                            || 
(0190)  CS-0x06F  0x375AA         || 		MOV     R21, MIDDLE_FOR_COUNT
(0191)  CS-0x070  0x2D501  0x070  || MIDDLE_FOR3:  	SUB     R21, 0x01
(0192)                            ||              
(0193)  CS-0x071  0x376AA         || 		MOV     R22, INSIDE_FOR_COUNT
(0194)  CS-0x072  0x2D601  0x072  || INSIDE_FOR3:  	SUB     R22, 0x01
(0195)  CS-0x073  0x08393         || 		BRNE    INSIDE_FOR3
(0196)  CS-0x074  0x23500         || 		OR      R21, 0x00
(0197)  CS-0x075  0x08383         || 		BRNE    MIDDLE_FOR3
(0198)  CS-0x076  0x23400         || 		OR      R20, 0x00
(0199)  CS-0x077  0x08373         || 		BRNE    OUTSIDE_FOR3
(0200)  CS-0x078  0x083C8         || 		BRN	finish			;Branch to next test
(0201)                            || ;--------------------------------------------------------------------
(0202)                            || 
(0203)                            || 
(0204)                            || ;-Finish--------------------------------------------------------
(0205)                            || 
(0206)  CS-0x079  0x34F40  0x079  || finish:			 OUT R15,LED_PORT
(0207)  CS-0x07A  0x083C8         || 			 BRN finish
(0208)                            || ;--------------------------------------------------------------------
(0209)                            || 
(0210)                            || 
(0211)                            || 





Symbol Table Key 
----------------------------------------------------------------------
C1             C2     C3      ||  C4+
-------------  ----   ----        -------
C1:  name of symbol
C2:  the value of symbol 
C3:  source code line number where symbol defined
C4+: source code line number of where symbol is referenced 
----------------------------------------------------------------------


-- Labels
------------------------------------------------------------ 
DELAY0         0x022   (0072)  ||  0067 0069 
DELAY1         0x03A   (0109)  ||  0104 0106 
DELAY2         0x051   (0145)  ||  0140 0142 
DELAY3         0x06D   (0187)  ||  0182 0184 
FINISH         0x079   (0206)  ||  0200 0207 
INSIDE_FOR0    0x027   (0079)  ||  0080 
INSIDE_FOR1    0x03F   (0116)  ||  0117 
INSIDE_FOR2    0x056   (0152)  ||  0153 
INSIDE_FOR3    0x072   (0194)  ||  0195 
MIDDLE_FOR0    0x025   (0076)  ||  0082 
MIDDLE_FOR1    0x03D   (0113)  ||  0119 
MIDDLE_FOR2    0x054   (0149)  ||  0155 
MIDDLE_FOR3    0x070   (0191)  ||  0197 
OUTSIDE_FOR0   0x023   (0073)  ||  0084 
OUTSIDE_FOR1   0x03B   (0110)  ||  0121 
OUTSIDE_FOR2   0x052   (0146)  ||  0157 
OUTSIDE_FOR3   0x06E   (0188)  ||  0199 
START          0x017   (0054)  ||  
TEST0          0x018   (0058)  ||  
TEST0_FAIL     0x021   (0069)  ||  0064 
TEST0_PASS     0x01F   (0066)  ||  0063 
TEST1          0x02E   (0093)  ||  0085 
TEST1_FAIL     0x039   (0106)  ||  0101 
TEST1_PASS     0x037   (0103)  ||  0100 
TEST2          0x046   (0130)  ||  0122 
TEST2_FAIL     0x050   (0142)  ||  0137 
TEST2_PASS     0x04E   (0139)  ||  0136 
TEST3          0x05D   (0167)  ||  0158 
TEST3_FAIL     0x06C   (0184)  ||  0175 
TEST3_PASS     0x066   (0177)  ||  0174 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
B0_MASK        0x001   (0027)  ||  0066 
B1_MASK        0x002   (0028)  ||  0103 
B2_MASK        0x004   (0029)  ||  0139 
B3_MASK        0x008   (0030)  ||  0177 
B4_MASK        0x010   (0031)  ||  0178 
B5_MASK        0x020   (0032)  ||  0179 
B6_MASK        0x040   (0033)  ||  0180 
B7_MASK        0x080   (0034)  ||  0181 
BTN_PORT       0x0FF   (0021)  ||  
INSIDE_FOR_COUNT 0x0AA   (0035)  ||  0078 0115 0151 0193 
LED_PORT       0x040   (0020)  ||  0093 0130 0167 0206 
MIDDLE_FOR_COUNT 0x0AA   (0036)  ||  0075 0112 0148 0190 
OUTSIDE_FOR_COUNT 0x0AA   (0037)  ||  0072 0109 0145 0187 
SWITCH_PORT    0x020   (0019)  ||  


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
DATA           0x001   (0045)  ||  
