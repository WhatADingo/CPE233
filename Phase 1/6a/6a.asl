

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


(0001)                       032  || .EQU SWITCHPORT = 0x20			;Input Ports
(0002)                       255  || .EQU BUTTON_PORT = 0xFF			;
(0003)                       064  || .EQU LED_PORT = 0x40			;Output Ports
(0004)                       129  || .EQU SEV_SEG_Cathodes = 0x81		;
(0005)                       130  || .EQU SEV_SEG_Anodes = 0x82		;
(0006)                       191  || .EQU Top_Counter = 0xBF			;
(0007)                       255  || .EQU Mid_Counter = 0xFF			;
(0008)                       255  || .EQU Lower_Counter = 0xFF		;
(0009)                       001  || .EQU test1_mask = 0x01			;
(0010)                       002  || .EQU test2_mask = 0x02			;
(0011)                       004  || .EQU test3_mask = 0x04			;
(0012)                       008  || .EQU test4_mask = 0x08			;
(0013)                       016  || .EQU test5_mask = 0x10			;
(0014)                       032  || .EQU test6_mask = 0x20			;
(0015)                       064  || .EQU test7_mask = 0x40			;
(0016)                       128  || .EQU test8_mask = 0x80			;
(0017)                            || .DSEG
(0018)                       000  || .ORG		0X00
(0019)                            || .CSEG
(0020)                       064  || .ORG		0X40			;
(0021)                            || 		
(0022)  CS-0x040  0x36480         || 		MOV  R4,0x80		;Add test1 Overflow
(0023)  CS-0x041  0x284DB         || 		ADD  R4,0xDB
(0024)  CS-0x042  0x3045B         || 		CMP  R4,0x5B
(0025)  CS-0x043  0x0822A         || 		BREQ if_stuff1
(0026)                            || 
(0027)  CS-0x044  0x08230         || 		BRN  end_if1		;else
(0028)                            || 
(0029)  CS-0x045  0x23F01  0x045  || if_stuff1:	OR   R31,test1_mask
(0030)                            || 
(0031)  CS-0x046  0x35F40  0x046  || end_if1:	OUT  R31,LED_PORT
(0032)  CS-0x047  0x361BF         || 		MOV  R1,Top_Counter
(0033)  CS-0x048  0x2C101  0x048  || Top_loop1:	SUB  R1,0x01
(0034)                            || 		
(0035)  CS-0x049  0x362FF         || 		MOV  R2,Mid_Counter
(0036)  CS-0x04A  0x2C201  0x04A  || Mid_loop1:	SUB  R2,0x01
(0037)                            || 
(0038)  CS-0x04B  0x363FF         || 		MOV  R3,Lower_Counter	
(0039)  CS-0x04C  0x2C301  0x04C  || Lower_loop1:	SUB  R3,0x01
(0040)  CS-0x04D  0x08263         || 		BRNE Lower_loop1
(0041)                            || 
(0042)  CS-0x04E  0x22200         || 		OR   R2,0x00
(0043)  CS-0x04F  0x08253         || 		BRNE Mid_loop1	
(0044)                            || 
(0045)  CS-0x050  0x22100         || 		OR   R1,0x00
(0046)  CS-0x051  0x08243         || 		BRNE Top_loop1	
(0047)                            || 
(0048)  CS-0x052  0x3665D         || 		MOV  R6,0x5D		;Add test2
(0049)  CS-0x053  0x28669         || 		ADD  R6,0x69
(0050)  CS-0x054  0x306C6         || 		CMP  R6,0xC6
(0051)  CS-0x055  0x082BA         || 		BREQ if_stuff2
(0052)                            || 
(0053)  CS-0x056  0x082C0         || 		BRN  end_if2		;else
(0054)                            || 
(0055)  CS-0x057  0x23F02  0x057  || if_stuff2:	OR   R31,test2_mask
(0056)                            || 
(0057)  CS-0x058  0x35F40  0x058  || end_if2:	OUT  R31,LED_PORT
(0058)  CS-0x059  0x361BF         || 		MOV  R1,Top_Counter
(0059)  CS-0x05A  0x2C101  0x05A  || Top_loop2:	SUB  R1,0x01
(0060)                            || 		
(0061)  CS-0x05B  0x362FF         || 		MOV  R2,Mid_Counter
(0062)  CS-0x05C  0x2C201  0x05C  || Mid_loop2:	SUB  R2,0x01
(0063)                            || 
(0064)  CS-0x05D  0x363FF         || 		MOV  R3,Lower_Counter	
(0065)  CS-0x05E  0x2C301  0x05E  || Lower_loop2:	SUB  R3,0x01
(0066)  CS-0x05F  0x082F3         || 		BRNE Lower_loop2
(0067)                            || 
(0068)  CS-0x060  0x22200         || 		OR   R2,0x00
(0069)  CS-0x061  0x082E3         || 		BRNE Mid_loop2
(0070)                            || 
(0071)  CS-0x062  0x22100         || 		OR   R1,0x00
(0072)  CS-0x063  0x082D3         || 		BRNE Top_loop2		
(0073)                            || 
(0074)  CS-0x064  0x36801         || 		MOV  R8,0x01		;Sub test3 Underflow
(0075)  CS-0x065  0x2C803         || 		SUB  R8,0x03
(0076)  CS-0x066  0x308FE         || 		CMP  R8,0xFE
(0077)  CS-0x067  0x0834A         || 		BREQ if_stuff3
(0078)                            || 
(0079)  CS-0x068  0x08350         || 		BRN  end_if3		;else
(0080)                            || 
(0081)  CS-0x069  0x23F04  0x069  || if_stuff3:	OR   R31,test3_mask
(0082)                            || 
(0083)  CS-0x06A  0x35F40  0x06A  || end_if3:	OUT  R31,LED_PORT
(0084)  CS-0x06B  0x361BF         || 		MOV  R1,Top_Counter
(0085)  CS-0x06C  0x2C101  0x06C  || Top_loop3:	SUB  R1,0x01
(0086)                            || 		
(0087)  CS-0x06D  0x362FF         || 		MOV  R2,Mid_Counter
(0088)  CS-0x06E  0x2C201  0x06E  || Mid_loop3:	SUB  R2,0x01
(0089)                            || 
(0090)  CS-0x06F  0x363FF         || 		MOV  R3,Lower_Counter	
(0091)  CS-0x070  0x2C301  0x070  || Lower_loop3:	SUB  R3,0x01
(0092)  CS-0x071  0x08383         || 		BRNE Lower_loop3
(0093)                            || 
(0094)  CS-0x072  0x22200         || 		OR   R2,0x00
(0095)  CS-0x073  0x08373         || 		BRNE Mid_loop3	
(0096)                            || 
(0097)  CS-0x074  0x22100         || 		OR   R1,0x00
(0098)  CS-0x075  0x08363         || 		BRNE Top_loop3	
(0099)                            || 
(0100)  CS-0x076  0x36AE5         || 		MOV  R10,0xE5		;Sub test4
(0101)  CS-0x077  0x2CA96         || 		SUB  R10,0x96
(0102)  CS-0x078  0x30A4F         || 		CMP  R10,0x4F
(0103)  CS-0x079  0x083DA         || 		BREQ if_stuff4
(0104)                            || 
(0105)  CS-0x07A  0x083E0         || 		BRN  end_if4		;else
(0106)                            || 
(0107)  CS-0x07B  0x23F08  0x07B  || if_stuff4:	OR   R31,test4_mask
(0108)                            || 
(0109)  CS-0x07C  0x35F40  0x07C  || end_if4:	OUT  R31,LED_PORT
(0110)  CS-0x07D  0x361BF         || 		MOV  R1,Top_Counter
(0111)  CS-0x07E  0x2C101  0x07E  || Top_loop4:	SUB  R1,0x01
(0112)                            || 		
(0113)  CS-0x07F  0x362FF         || 		MOV  R2,Mid_Counter
(0114)  CS-0x080  0x2C201  0x080  || Mid_loop4:	SUB  R2,0x01
(0115)                            || 
(0116)  CS-0x081  0x363FF         || 		MOV  R3,Lower_Counter	
(0117)  CS-0x082  0x2C301  0x082  || Lower_loop4:	SUB  R3,0x01
(0118)  CS-0x083  0x08413         || 		BRNE Lower_loop4
(0119)                            || 
(0120)  CS-0x084  0x22200         || 		OR   R2,0x00
(0121)  CS-0x085  0x08403         || 		BRNE Mid_loop4	
(0122)                            || 
(0123)  CS-0x086  0x22100         || 		OR   R1,0x00
(0124)  CS-0x087  0x083F3         || 		BRNE Top_loop4	
(0125)                            || 
(0126)  CS-0x088  0x36C48         || 		MOV  R12,0x48		;AddC test5 C high
(0127)  CS-0x089  0x18001         || 		SEC  
(0128)  CS-0x08A  0x2AC67         || 		ADDC R12,0x67
(0129)  CS-0x08B  0x30CB0         || 		CMP  R12,0xB0
(0130)  CS-0x08C  0x08472         || 		BREQ if_stuff5
(0131)                            || 
(0132)  CS-0x08D  0x08478         || 		BRN  end_if5		;else
(0133)                            || 
(0134)  CS-0x08E  0x23F10  0x08E  || if_stuff5:	OR   R31,test5_mask
(0135)                            || 
(0136)  CS-0x08F  0x35F40  0x08F  || end_if5:	OUT  R31,LED_PORT
(0137)  CS-0x090  0x361BF         || 		MOV  R1,Top_Counter
(0138)  CS-0x091  0x2C101  0x091  || Top_loop5:	SUB  R1,0x01
(0139)                            || 		
(0140)  CS-0x092  0x362FF         || 		MOV  R2,Mid_Counter
(0141)  CS-0x093  0x2C201  0x093  || Mid_loop5:	SUB  R2,0x01
(0142)                            || 
(0143)  CS-0x094  0x363FF         || 		MOV  R3,Lower_Counter	
(0144)  CS-0x095  0x2C301  0x095  || Lower_loop5:	SUB  R3,0x01
(0145)  CS-0x096  0x084AB         || 		BRNE Lower_loop5
(0146)                            || 
(0147)  CS-0x097  0x22200         || 		OR   R2,0x00
(0148)  CS-0x098  0x0849B         || 		BRNE Mid_loop5	
(0149)                            || 
(0150)  CS-0x099  0x22100         || 		OR   R1,0x00
(0151)  CS-0x09A  0x0848B         || 		BRNE Top_loop5
(0152)                            || 
(0153)  CS-0x09B  0x36E48         || 		MOV  R14,0x48		;AddC test6 C low
(0154)  CS-0x09C  0x18000         || 		CLC  
(0155)  CS-0x09D  0x2AE67         || 		ADDC R14,0x67
(0156)  CS-0x09E  0x30EAF         || 		CMP  R14,0xAF
(0157)  CS-0x09F  0x0850A         || 		BREQ if_stuff6
(0158)                            || 
(0159)  CS-0x0A0  0x08510         || 		BRN  end_if6		;else
(0160)                            || 
(0161)  CS-0x0A1  0x23F20  0x0A1  || if_stuff6:	OR   R31,test6_mask
(0162)                            || 
(0163)  CS-0x0A2  0x35F40  0x0A2  || end_if6:	OUT  R31,LED_PORT
(0164)  CS-0x0A3  0x361BF         || 		MOV  R1,Top_Counter
(0165)  CS-0x0A4  0x2C101  0x0A4  || Top_loop6:	SUB  R1,0x01
(0166)                            || 		
(0167)  CS-0x0A5  0x362FF         || 		MOV  R2,Mid_Counter
(0168)  CS-0x0A6  0x2C201  0x0A6  || Mid_loop6:	SUB  R2,0x01
(0169)                            || 
(0170)  CS-0x0A7  0x363FF         || 		MOV  R3,Lower_Counter	
(0171)  CS-0x0A8  0x2C301  0x0A8  || Lower_loop6:	SUB  R3,0x01
(0172)  CS-0x0A9  0x08543         || 		BRNE Lower_loop6
(0173)                            || 
(0174)  CS-0x0AA  0x22200         || 		OR   R2,0x00
(0175)  CS-0x0AB  0x08533         || 		BRNE Mid_loop6	
(0176)                            || 
(0177)  CS-0x0AC  0x22100         || 		OR   R1,0x00
(0178)  CS-0x0AD  0x08523         || 		BRNE Top_loop6
(0179)                            || 
(0180)  CS-0x0AE  0x37080         || 		MOV  R16,0x80		;SubC test7 C high
(0181)  CS-0x0AF  0x18001         || 		SEC  
(0182)  CS-0x0B0  0x2F000         || 		SUBC R16,0x00
(0183)  CS-0x0B1  0x3107F         || 		CMP  R16,0x7F
(0184)  CS-0x0B2  0x085A2         || 		BREQ if_stuff7
(0185)                            || 
(0186)  CS-0x0B3  0x085A8         || 		BRN  end_if7		;else
(0187)                            || 
(0188)  CS-0x0B4  0x23F40  0x0B4  || if_stuff7:	OR   R31,test7_mask
(0189)                            || 
(0190)  CS-0x0B5  0x35F40  0x0B5  || end_if7:	OUT  R31,LED_PORT
(0191)  CS-0x0B6  0x361BF         || 		MOV  R1,Top_Counter
(0192)  CS-0x0B7  0x2C101  0x0B7  || Top_loop7:	SUB  R1,0x01
(0193)                            || 		
(0194)  CS-0x0B8  0x362FF         || 		MOV  R2,Mid_Counter
(0195)  CS-0x0B9  0x2C201  0x0B9  || Mid_loop7:	SUB  R2,0x01
(0196)                            || 
(0197)  CS-0x0BA  0x363FF         || 		MOV  R3,Lower_Counter	
(0198)  CS-0x0BB  0x2C301  0x0BB  || Lower_loop7:	SUB  R3,0x01
(0199)  CS-0x0BC  0x085DB         || 		BRNE Lower_loop7
(0200)                            || 
(0201)  CS-0x0BD  0x22200         || 		OR   R2,0x00
(0202)  CS-0x0BE  0x085CB         || 		BRNE Mid_loop7	
(0203)                            || 
(0204)  CS-0x0BF  0x22100         || 		OR   R1,0x00
(0205)  CS-0x0C0  0x085BB         || 		BRNE Top_loop7
(0206)                            || 
(0207)  CS-0x0C1  0x37280         || 		MOV  R18,0x80		;SubC test8 C low
(0208)  CS-0x0C2  0x18000         || 		CLC  
(0209)  CS-0x0C3  0x2F201         || 		SUBC R18,0x01
(0210)  CS-0x0C4  0x3127F         || 		CMP  R18,0x7F
(0211)  CS-0x0C5  0x0863A         || 		BREQ if_stuff8
(0212)                            || 
(0213)  CS-0x0C6  0x08640         || 		BRN  end_if8		;else
(0214)                            || 
(0215)  CS-0x0C7  0x23F80  0x0C7  || if_stuff8:	OR   R31,test8_mask
(0216)                            || 
(0217)  CS-0x0C8  0x35F40  0x0C8  || end_if8:	OUT  R31,LED_PORT
(0218)  CS-0x0C9  0x361BF         || 		MOV  R1,Top_Counter
(0219)  CS-0x0CA  0x2C101  0x0CA  || Top_loop8:	SUB  R1,0x01
(0220)                            || 		
(0221)  CS-0x0CB  0x362FF         || 		MOV  R2,Mid_Counter
(0222)  CS-0x0CC  0x2C201  0x0CC  || Mid_loop8:	SUB  R2,0x01
(0223)                            || 
(0224)  CS-0x0CD  0x363FF         || 		MOV  R3,Lower_Counter	
(0225)  CS-0x0CE  0x2C301  0x0CE  || Lower_loop8:	SUB  R3,0x01
(0226)  CS-0x0CF  0x08673         || 		BRNE Lower_loop8
(0227)                            || 
(0228)  CS-0x0D0  0x22200         || 		OR   R2,0x00
(0229)  CS-0x0D1  0x08663         || 		BRNE Mid_loop8	
(0230)                            || 
(0231)  CS-0x0D2  0x22100         || 		OR   R1,0x00
(0232)  CS-0x0D3  0x08653         || 		BRNE Top_loop8
(0233)                            || 
(0234)                            || 





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
END_IF1        0x046   (0031)  ||  0027 
END_IF2        0x058   (0057)  ||  0053 
END_IF3        0x06A   (0083)  ||  0079 
END_IF4        0x07C   (0109)  ||  0105 
END_IF5        0x08F   (0136)  ||  0132 
END_IF6        0x0A2   (0163)  ||  0159 
END_IF7        0x0B5   (0190)  ||  0186 
END_IF8        0x0C8   (0217)  ||  0213 
IF_STUFF1      0x045   (0029)  ||  0025 
IF_STUFF2      0x057   (0055)  ||  0051 
IF_STUFF3      0x069   (0081)  ||  0077 
IF_STUFF4      0x07B   (0107)  ||  0103 
IF_STUFF5      0x08E   (0134)  ||  0130 
IF_STUFF6      0x0A1   (0161)  ||  0157 
IF_STUFF7      0x0B4   (0188)  ||  0184 
IF_STUFF8      0x0C7   (0215)  ||  0211 
LOWER_LOOP1    0x04C   (0039)  ||  0040 
LOWER_LOOP2    0x05E   (0065)  ||  0066 
LOWER_LOOP3    0x070   (0091)  ||  0092 
LOWER_LOOP4    0x082   (0117)  ||  0118 
LOWER_LOOP5    0x095   (0144)  ||  0145 
LOWER_LOOP6    0x0A8   (0171)  ||  0172 
LOWER_LOOP7    0x0BB   (0198)  ||  0199 
LOWER_LOOP8    0x0CE   (0225)  ||  0226 
MID_LOOP1      0x04A   (0036)  ||  0043 
MID_LOOP2      0x05C   (0062)  ||  0069 
MID_LOOP3      0x06E   (0088)  ||  0095 
MID_LOOP4      0x080   (0114)  ||  0121 
MID_LOOP5      0x093   (0141)  ||  0148 
MID_LOOP6      0x0A6   (0168)  ||  0175 
MID_LOOP7      0x0B9   (0195)  ||  0202 
MID_LOOP8      0x0CC   (0222)  ||  0229 
TOP_LOOP1      0x048   (0033)  ||  0046 
TOP_LOOP2      0x05A   (0059)  ||  0072 
TOP_LOOP3      0x06C   (0085)  ||  0098 
TOP_LOOP4      0x07E   (0111)  ||  0124 
TOP_LOOP5      0x091   (0138)  ||  0151 
TOP_LOOP6      0x0A4   (0165)  ||  0178 
TOP_LOOP7      0x0B7   (0192)  ||  0205 
TOP_LOOP8      0x0CA   (0219)  ||  0232 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BUTTON_PORT    0x0FF   (0002)  ||  
LED_PORT       0x040   (0003)  ||  0031 0057 0083 0109 0136 0163 0190 0217 
LOWER_COUNTER  0x0FF   (0008)  ||  0038 0064 0090 0116 0143 0170 0197 0224 
MID_COUNTER    0x0FF   (0007)  ||  0035 0061 0087 0113 0140 0167 0194 0221 
SEV_SEG_ANODES 0x082   (0005)  ||  
SEV_SEG_CATHODES 0x081   (0004)  ||  
SWITCHPORT     0x020   (0001)  ||  
TEST1_MASK     0x001   (0009)  ||  0029 
TEST2_MASK     0x002   (0010)  ||  0055 
TEST3_MASK     0x004   (0011)  ||  0081 
TEST4_MASK     0x008   (0012)  ||  0107 
TEST5_MASK     0x010   (0013)  ||  0134 
TEST6_MASK     0x020   (0014)  ||  0161 
TEST7_MASK     0x040   (0015)  ||  0188 
TEST8_MASK     0x080   (0016)  ||  0215 
TOP_COUNTER    0x0BF   (0006)  ||  0032 0058 0084 0110 0137 0164 0191 0218 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
