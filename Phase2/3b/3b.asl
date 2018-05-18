

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


(0001)                       255  || .EQU LOOP_COUNT	= 0xFF
(0002)                       094  || .EQU LOOP_COUNT_IN = 0X5E
(0003)                            || ;---------------------------------------------
(0004)                            || ;- Port Constants
(0005)                            || ;--------------------------------------------------------------------
(0006)                       064  || .EQU LED_PORT    = 0x40         ; port for LED output --- OUTOUT
(0007)                            || ;--------------------------------------------------------------------
(0008)                            || .CSEG
(0009)                       064  || .ORG	0X40
(0010)                            || 
(0011)                            || 
(0012)                            || 
(0013)                            || 
(0014)                            || ;Test of the first branch, LD7		
(0015)                            || 
(0016)  CS-0x040  0x36100  0x040  || main:		MOV R1, 0X00
(0017)  CS-0x041  0x28101         || 		ADD R1, 0X01
(0018)  CS-0x042  0x08220         || 		BRN pause1
(0019)  CS-0x043  0x2C101         || 		SUB R1, 0X01
(0020)                            || 
(0021)                            || 		
(0022)                            || 
(0023)                            || 
(0024)  CS-0x044  0x34140  0x044  || pause1:		OUT R1, LED_PORT
(0025)  CS-0x045  0x369FF         || 		MOV R9, LOOP_COUNT
(0026)  CS-0x046  0x36AFF  0x046  || outLoop1:	MOV R10, LOOP_COUNT
(0027)  CS-0x047  0x2C901         || 		SUB R9, 0X01
(0028)  CS-0x048  0x36B5E  0x048  || midLoop1:	MOV R11, LOOP_COUNT_IN
(0029)  CS-0x049  0x2CA01         || 		SUB R10, 0X01
(0030)  CS-0x04A  0x2CB01  0x04A  || inLoop1:	SUB R11, 0X01
(0031)  CS-0x04B  0x08253         || 		BRNE inLoop1
(0032)  CS-0x04C  0x22A00         || 		OR R10, 0X00
(0033)  CS-0x04D  0x08243         || 		BRNE midLoop1
(0034)  CS-0x04E  0x22900         || 		OR R9, 0X00
(0035)  CS-0x04F  0x08233         || 		BRNE outLoop1
(0036)                            || 
(0037)                            || ;Second Test for Branch if EQ LD6
(0038)                            || 
(0039)  CS-0x050  0x28102  0x050  || test2:		ADD R1, 0X02
(0040)  CS-0x051  0x36477         || 		MOV R4, 0X77
(0041)  CS-0x052  0x30477         || 		CMP R4, 0X77
(0042)  CS-0x053  0x082AA         || 		BREQ pause2
(0043)  CS-0x054  0x2C102         || 		SUB R1, 0X02
(0044)                            || 
(0045)  CS-0x055  0x34140  0x055  || pause2:		OUT R1, LED_PORT
(0046)  CS-0x056  0x369FF         || 		MOV R9, LOOP_COUNT
(0047)  CS-0x057  0x36AFF  0x057  || outLoop2:	MOV R10, LOOP_COUNT
(0048)  CS-0x058  0x2C901         || 		SUB R9, 0X01
(0049)  CS-0x059  0x36B5E  0x059  || midLoop2:	MOV R11, LOOP_COUNT_IN
(0050)  CS-0x05A  0x2CA01         || 		SUB R10, 0X01
(0051)  CS-0x05B  0x2CB01  0x05B  || inLoop2:	SUB R11, 0X01
(0052)  CS-0x05C  0x082DB         || 		BRNE inLoop2
(0053)  CS-0x05D  0x22A00         || 		OR R10, 0X00
(0054)  CS-0x05E  0x082CB         || 		BRNE midLoop2
(0055)  CS-0x05F  0x22900         || 		OR R9, 0X00
(0056)  CS-0x060  0x082BB         || 		BRNE outLoop2
(0057)                            || 		
(0058)                            || 
(0059)                            || ;Third Test for Branch if Not EQ LD5
(0060)                            || 		
(0061)  CS-0x061  0x28104         || 		ADD R1, 0X04
(0062)  CS-0x062  0x36477         || 		MOV R4, 0X77
(0063)  CS-0x063  0x30466         || 		CMP R4, 0X66
(0064)  CS-0x064  0x08333         || 		BRNE pause3
(0065)  CS-0x065  0x2C104         || 		SUB R1, 0X04
(0066)                            || 
(0067)  CS-0x066  0x34140  0x066  || pause3:		OUT R1, LED_PORT
(0068)  CS-0x067  0x369FF         || 		MOV R9, LOOP_COUNT
(0069)  CS-0x068  0x36AFF  0x068  || outLoop3:	MOV R10, LOOP_COUNT
(0070)  CS-0x069  0x2C901         || 		SUB R9, 0X01
(0071)  CS-0x06A  0x36B5E  0x06A  || midLoop3:	MOV R11, LOOP_COUNT_IN
(0072)  CS-0x06B  0x2CA01         || 		SUB R10, 0X01
(0073)  CS-0x06C  0x2CB01  0x06C  || inLoop3:	SUB R11, 0X01
(0074)  CS-0x06D  0x08363         || 		BRNE inLoop3
(0075)  CS-0x06E  0x22A00         || 		OR R10, 0X00
(0076)  CS-0x06F  0x08353         || 		BRNE midLoop3
(0077)  CS-0x070  0x22900         || 		OR R9, 0X00
(0078)  CS-0x071  0x08343         || 		BRNE outLoop3
(0079)                            || 
(0080)                            || ;Fourth Test for Direct Branch LD4
(0081)                            || 
(0082)  CS-0x072  0x28108         || 		ADD R1, 0X08
(0083)  CS-0x073  0x083A8         || 		BRN pause4
(0084)  CS-0x074  0x2C108         || 		SUB R1, 0X08
(0085)                            || 		
(0086)  CS-0x075  0x34140  0x075  || pause4:		OUT R1, LED_PORT
(0087)  CS-0x076  0x369FF         || 		MOV R9, LOOP_COUNT
(0088)  CS-0x077  0x36AFF  0x077  || outLoop4:	MOV R10, LOOP_COUNT
(0089)  CS-0x078  0x2C901         || 		SUB R9, 0X01
(0090)  CS-0x079  0x36B5E  0x079  || midLoop4:	MOV R11, LOOP_COUNT_IN
(0091)  CS-0x07A  0x2CA01         || 		SUB R10, 0X01
(0092)  CS-0x07B  0x2CB01  0x07B  || inLoop4:	SUB R11, 0X01
(0093)  CS-0x07C  0x083DB         || 		BRNE inLoop4
(0094)  CS-0x07D  0x22A00         || 		OR R10, 0X00
(0095)  CS-0x07E  0x083CB         || 		BRNE midLoop4
(0096)  CS-0x07F  0x22900         || 		OR R9, 0X00
(0097)  CS-0x080  0x083BB         || 		BRNE outLoop4
(0098)                            || 
(0099)                            || ;Fifth Test for Branch if Carry Set LD3
(0100)                            || 
(0101)  CS-0x081  0x28110         || 		ADD R1, 0X10
(0102)  CS-0x082  0x364FF         || 		MOV R4, 0XFF
(0103)  CS-0x083  0x28455         || 		ADD R4, 0X55
(0104)  CS-0x084  0x0A430         || 		BRCS pause5
(0105)  CS-0x085  0x2C110         || 		SUB R1, 0X10
(0106)                            || 
(0107)  CS-0x086  0x34140  0x086  || pause5:		OUT R1, LED_PORT
(0108)  CS-0x087  0x369FF         || 		MOV R9, LOOP_COUNT
(0109)  CS-0x088  0x36AFF  0x088  || outLoop5:	MOV R10, LOOP_COUNT
(0110)  CS-0x089  0x2C901         || 		SUB R9, 0X01
(0111)  CS-0x08A  0x36B5E  0x08A  || midLoop5:	MOV R11, LOOP_COUNT_IN
(0112)  CS-0x08B  0x2CA01         || 		SUB R10, 0X01
(0113)  CS-0x08C  0x2CB01  0x08C  || inLoop5:	SUB R11, 0X01
(0114)  CS-0x08D  0x08463         || 		BRNE inLoop5
(0115)  CS-0x08E  0x22A00         || 		OR R10, 0X00
(0116)  CS-0x08F  0x08453         || 		BRNE midLoop5
(0117)  CS-0x090  0x22900         || 		OR R9, 0X00
(0118)  CS-0x091  0x08443         || 		BRNE outLoop5
(0119)                            || 
(0120)                            || ;Sixth Test for Branch if Carry Cleared LD2
(0121)                            || 		
(0122)  CS-0x092  0x28120         || 		ADD R1, 0X20
(0123)  CS-0x093  0x36477         || 		MOV R4, 0X77
(0124)  CS-0x094  0x28411         || 		ADD R4, 0X11
(0125)  CS-0x095  0x0A4B9         || 		BRCC pause6
(0126)  CS-0x096  0x2C120         || 		SUB R1, 0X20
(0127)                            || 
(0128)  CS-0x097  0x34140  0x097  || pause6:		OUT R1, LED_PORT
(0129)  CS-0x098  0x369FF         || 		MOV R9, LOOP_COUNT
(0130)  CS-0x099  0x36AFF  0x099  || outLoop6:	MOV R10, LOOP_COUNT
(0131)  CS-0x09A  0x2C901         || 		SUB R9, 0X01
(0132)  CS-0x09B  0x36B5E  0x09B  || midLoop6:	MOV R11, LOOP_COUNT_IN
(0133)  CS-0x09C  0x2CA01         || 		SUB R10, 0X01
(0134)  CS-0x09D  0x2CB01  0x09D  || inLoop6:	SUB R11, 0X01
(0135)  CS-0x09E  0x084EB         || 		BRNE inLoop6
(0136)  CS-0x09F  0x22A00         || 		OR R10, 0X00
(0137)  CS-0x0A0  0x084DB         || 		BRNE midLoop6
(0138)  CS-0x0A1  0x22900         || 		OR R9, 0X00
(0139)  CS-0x0A2  0x084CB         || 		BRNE outLoop6
(0140)                            || 
(0141)                            || ;Seventh Test for CLEAR CARRY
(0142)                            || 
(0143)  CS-0x0A3  0x28140         || 		ADD R1, 0X40
(0144)  CS-0x0A4  0x364FF         || 		MOV R4, 0XFF
(0145)  CS-0x0A5  0x284FF         || 		ADD R4, 0XFF
(0146)  CS-0x0A6  0x18000         || 		CLC
(0147)  CS-0x0A7  0x0A549         || 		BRCC pause7
(0148)  CS-0x0A8  0x2C140         || 		SUB R1, 0X40
(0149)                            || 
(0150)  CS-0x0A9  0x34140  0x0A9  || pause7:		OUT R1, LED_PORT
(0151)  CS-0x0AA  0x369FF         || 		MOV R9, LOOP_COUNT
(0152)  CS-0x0AB  0x36AFF  0x0AB  || outLoop7:	MOV R10, LOOP_COUNT
(0153)  CS-0x0AC  0x2C901         || 		SUB R9, 0X01
(0154)  CS-0x0AD  0x36B5E  0x0AD  || midLoop7:	MOV R11, LOOP_COUNT_IN
(0155)  CS-0x0AE  0x2CA01         || 		SUB R10, 0X01
(0156)  CS-0x0AF  0x2CB01  0x0AF  || inLoop7:	SUB R11, 0X01
(0157)  CS-0x0B0  0x0857B         || 		BRNE inLoop7
(0158)  CS-0x0B1  0x22A00         || 		OR R10, 0X00
(0159)  CS-0x0B2  0x0856B         || 		BRNE midLoop7
(0160)  CS-0x0B3  0x22900         || 		OR R9, 0X00
(0161)  CS-0x0B4  0x0855B         || 		BRNE outLoop7
(0162)                            || 
(0163)                            || ;Eigth and final test for SET CARRY
(0164)                            || 		
(0165)  CS-0x0B5  0x28180         || 		ADD R1, 0X80
(0166)  CS-0x0B6  0x364FF         || 		MOV R4, 0XFF
(0167)  CS-0x0B7  0x2C411         || 		SUB R4, 0X11
(0168)  CS-0x0B8  0x18001         || 		SEC
(0169)  CS-0x0B9  0x0A5E0         || 		BRCS pause8
(0170)  CS-0x0BA  0x2C180         || 		SUB R1, 0X80
(0171)  CS-0x0BB  0x085E0         || 		BRN pause8
(0172)                            || 
(0173)  CS-0x0BC  0x34140  0x0BC  || pause8:		OUT R1, LED_PORT
(0174)  CS-0x0BD  0x369FF         || 		MOV R9, LOOP_COUNT
(0175)  CS-0x0BE  0x36AFF  0x0BE  || outLoop8:	MOV R10, LOOP_COUNT
(0176)  CS-0x0BF  0x2C901         || 		SUB R9, 0X01
(0177)  CS-0x0C0  0x36B5E  0x0C0  || midLoop8:	MOV R11, LOOP_COUNT_IN
(0178)  CS-0x0C1  0x2CA01         || 		SUB R10, 0X01
(0179)  CS-0x0C2  0x2CB01  0x0C2  || inLoop8:	SUB R11, 0X01
(0180)  CS-0x0C3  0x08613         || 		BRNE inLoop8
(0181)  CS-0x0C4  0x22A00         || 		OR R10, 0X00
(0182)  CS-0x0C5  0x08603         || 		BRNE midLoop8
(0183)  CS-0x0C6  0x22900         || 		OR R9, 0X00
(0184)  CS-0x0C7  0x085F3         || 		BRNE outLoop8
(0185)                            || 
(0186)                            || 
(0187)                            || 
(0188)                            || 
(0189)                            || 
(0190)                     0x0C8  || final:
(0191)  CS-0x0C8  0x34140         || 		OUT R1, LED_PORT
(0192)  CS-0x0C9  0x08640         || 		BRN final
(0193)                            || 
(0194)                            || 
(0195)                            || 
(0196)                            || 
(0197)                            || 
(0198)                            || 
(0199)                            || 
(0200)                            || 





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
FINAL          0x0C8   (0190)  ||  0192 
INLOOP1        0x04A   (0030)  ||  0031 
INLOOP2        0x05B   (0051)  ||  0052 
INLOOP3        0x06C   (0073)  ||  0074 
INLOOP4        0x07B   (0092)  ||  0093 
INLOOP5        0x08C   (0113)  ||  0114 
INLOOP6        0x09D   (0134)  ||  0135 
INLOOP7        0x0AF   (0156)  ||  0157 
INLOOP8        0x0C2   (0179)  ||  0180 
MAIN           0x040   (0016)  ||  
MIDLOOP1       0x048   (0028)  ||  0033 
MIDLOOP2       0x059   (0049)  ||  0054 
MIDLOOP3       0x06A   (0071)  ||  0076 
MIDLOOP4       0x079   (0090)  ||  0095 
MIDLOOP5       0x08A   (0111)  ||  0116 
MIDLOOP6       0x09B   (0132)  ||  0137 
MIDLOOP7       0x0AD   (0154)  ||  0159 
MIDLOOP8       0x0C0   (0177)  ||  0182 
OUTLOOP1       0x046   (0026)  ||  0035 
OUTLOOP2       0x057   (0047)  ||  0056 
OUTLOOP3       0x068   (0069)  ||  0078 
OUTLOOP4       0x077   (0088)  ||  0097 
OUTLOOP5       0x088   (0109)  ||  0118 
OUTLOOP6       0x099   (0130)  ||  0139 
OUTLOOP7       0x0AB   (0152)  ||  0161 
OUTLOOP8       0x0BE   (0175)  ||  0184 
PAUSE1         0x044   (0024)  ||  0018 
PAUSE2         0x055   (0045)  ||  0042 
PAUSE3         0x066   (0067)  ||  0064 
PAUSE4         0x075   (0086)  ||  0083 
PAUSE5         0x086   (0107)  ||  0104 
PAUSE6         0x097   (0128)  ||  0125 
PAUSE7         0x0A9   (0150)  ||  0147 
PAUSE8         0x0BC   (0173)  ||  0169 0171 
TEST2          0x050   (0039)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
LED_PORT       0x040   (0006)  ||  0024 0045 0067 0086 0107 0128 0150 0173 0191 
LOOP_COUNT     0x0FF   (0001)  ||  0025 0026 0046 0047 0068 0069 0087 0088 0108 0109 
                               ||  0129 0130 0151 0152 0174 0175 
LOOP_COUNT_IN  0x05E   (0002)  ||  0028 0049 0071 0090 0111 0132 0154 0177 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
