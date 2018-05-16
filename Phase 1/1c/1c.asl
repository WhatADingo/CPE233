

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
(0002)                            || ;- Programmers: Trevor Dalke and Josh Korven
(0003)                            || ;- Date: 02-26-2011
(0004)                            || ;- Version: 1
(0005)                            || ;-
(0006)                            || ;-
(0007)                            || ;- testAND:	Tests AND(reg/reg)         lights up leftmost LED
(0008)                            || ;- testOR:      Tests OR(reg/reg)          lights up second LED
(0009)                            || ;- testEXOR:	Tests EXOR(reg/reg)        lights up third LED
(0010)                            || ;- testLSL:	Tests LSL(reg)             lights up fourth LED
(0011)                            || ;- testLSR:	Tests LSR(reg)             lights up last 4 LED's
(0012)                            || ;- 
(0013)                            || ;- A successful test results in an LED lighting up. The first test
(0014)                            || ;- lights up the leftmost LED. Each sequential test lights up the
(0015)                            || ;- next LED to the right. A failed test results in that particular
(0016)                            || ;- LED not lighting up, but the next cases are still tested. The
(0017)                            || ;- final test lights up the remaining LED's. There is about a half
(0018)                            || ;- second delay between each test so that each LED can be seen being
(0019)                            || ;- lit up individually.
(0020)                            || ;--------------------------------------------------------------------
(0021)                            || 
(0022)                            || ;---------------------Constant Declarations------------
(0023)                       186  || .EQU INSIDE_FOR_COUNT    = 0xBA
(0024)                       186  || .EQU MIDDLE_FOR_COUNT    = 0xBA
(0025)                       186  || .EQU OUTSIDE_FOR_COUNT   = 0xBA
(0026)                            || 
(0027)                       170  || .EQU VALUE1              = 0xAA
(0028)                       197  || .EQU VALUE2              = 0xC5
(0029)                            || 
(0030)                       064  || .EQU LED_PORT            = 0x40
(0031)                            || ;--------------------------------------------------------------------
(0032)                            || 
(0033)                            || .DSEG
(0034)                       000  || .ORG         0x00  
(0035)                            || .CSEG
(0036)                       064  || .ORG         0x40
(0037)                            || 
(0038)                            || ;------------------------------Begin-----------------------------    
(0039)                            || 
(0040)  CS-0x040  0x36600         || MOV R6, 0x00
(0041)  CS-0x041  0x34640         || OUT R6, LED_PORT
(0042)                     0x042  || testAND:
(0043)                            || ;----------------------------Hold-----------------------------------
(0044)  CS-0x042  0x361BA         ||               MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0045)  CS-0x043  0x2C101  0x043  || outside_for0: SUB     R1, 0x01
(0046)                            || 
(0047)  CS-0x044  0x362BA         ||              MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
(0048)  CS-0x045  0x2C201  0x045  || middle_for0:  SUB     R2, 0x01
(0049)                            ||              
(0050)  CS-0x046  0x363BA         ||              MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0051)  CS-0x047  0x2C301  0x047  || inside_for0:  SUB     R3, 0x01
(0052)  CS-0x048  0x0823B         ||              BRNE    inside_for0
(0053)                            ||              
(0054)  CS-0x049  0x22200         ||              OR      R2, 0x00               ;load flags for middle for counter
(0055)  CS-0x04A  0x0822B         ||              BRNE    middle_for0
(0056)                            ||              
(0057)  CS-0x04B  0x22100         ||              OR      R1, 0x00               ;load flags for outside for counter value
(0058)  CS-0x04C  0x0821B         ||              BRNE    outside_for0
(0059)                            || ;---------------------------End Hold---------------------------------
(0060)  CS-0x04D  0x364AA         || 			 MOV R4, VALUE1
(0061)  CS-0x04E  0x365C5         || 			 MOV R5, VALUE2
(0062)  CS-0x04F  0x00428         || 			 AND R4, R5
(0063)  CS-0x050  0x30480         || 			 CMP R4, 0x80 
(0064)  CS-0x051  0x08492         || 			 BREQ outputAND;
(0065)                            || 
(0066)                     0x052  || testOR:
(0067)                            || ;----------------------------Hold-----------------------------------
(0068)  CS-0x052  0x361BA         ||               MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0069)  CS-0x053  0x2C101  0x053  || outside_for1: SUB     R1, 0x01
(0070)                            || 
(0071)  CS-0x054  0x362BA         ||              MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
(0072)  CS-0x055  0x2C201  0x055  || middle_for1:  SUB     R2, 0x01
(0073)                            ||              
(0074)  CS-0x056  0x363BA         ||              MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0075)  CS-0x057  0x2C301  0x057  || inside_for1:  SUB     R3, 0x01
(0076)  CS-0x058  0x082BB         ||              BRNE    inside_for1
(0077)                            ||              
(0078)  CS-0x059  0x22200         ||              OR      R2, 0x00               ;load flags for middle for counter
(0079)  CS-0x05A  0x082AB         ||              BRNE    middle_for1
(0080)                            ||              
(0081)  CS-0x05B  0x22100         ||              OR      R1, 0x00               ;load flags for outside for counter value
(0082)  CS-0x05C  0x0829B         ||             BRNE    outside_for1
(0083)                            || ;---------------------------End Hold---------------------------------
(0084)  CS-0x05D  0x364AA         || 			 MOV R4, VALUE1
(0085)  CS-0x05E  0x365C5         || 			 MOV R5, VALUE2
(0086)  CS-0x05F  0x00429         || 			 OR R4, R5
(0087)  CS-0x060  0x304EF         ||                          CMP R4, 0xEF
(0088)  CS-0x061  0x084AA         || 			 BREQ outputOR;
(0089)                            || 
(0090)                     0x062  || testEXOR:		
(0091)                            || ;----------------------------Hold-----------------------------------
(0092)  CS-0x062  0x361BA         ||              MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0093)  CS-0x063  0x2C101  0x063  || outside_for2: SUB     R1, 0x01
(0094)                            || 
(0095)  CS-0x064  0x362BA         ||             MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
(0096)  CS-0x065  0x2C201  0x065  || middle_for2:  SUB     R2, 0x01
(0097)                            ||              
(0098)  CS-0x066  0x363BA         ||              MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0099)  CS-0x067  0x2C301  0x067  || inside_for2:  SUB     R3, 0x01
(0100)  CS-0x068  0x0833B         ||              BRNE    inside_for2
(0101)                            ||              
(0102)  CS-0x069  0x22200         ||              OR      R2, 0x00               ;load flags for middle for counter
(0103)  CS-0x06A  0x0832B         ||              BRNE    middle_for2
(0104)                            ||              
(0105)  CS-0x06B  0x22100         ||              OR      R1, 0x00               ;load flags for outside for counter value
(0106)  CS-0x06C  0x0831B         ||              BRNE    outside_for2
(0107)                            || ;---------------------------End Hold---------------------------------	 
(0108)  CS-0x06D  0x364AA         || 			 MOV R4, VALUE1
(0109)  CS-0x06E  0x365C5         || 			 MOV R5, VALUE2
(0110)                            || 
(0111)  CS-0x06F  0x0042A         || 			 EXOR R4, R5
(0112)  CS-0x070  0x3046F         ||                          CMP R4, 0x6F
(0113)  CS-0x071  0x084C2         || 			 BREQ outputEXOR;
(0114)                            || 
(0115)                     0x072  || testLSL:		
(0116)                            || ;----------------------------Hold-----------------------------------
(0117)  CS-0x072  0x361BA         ||              MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0118)  CS-0x073  0x2C101  0x073  || outside_for3: SUB     R1, 0x01
(0119)                            || 
(0120)  CS-0x074  0x362BA         ||              MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
(0121)  CS-0x075  0x2C201  0x075  || middle_for3:  SUB     R2, 0x01
(0122)                            ||              
(0123)  CS-0x076  0x363BA         ||              MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0124)  CS-0x077  0x2C301  0x077  || inside_for3:  SUB     R3, 0x01
(0125)  CS-0x078  0x083BB         ||              BRNE    inside_for3
(0126)                            ||              
(0127)  CS-0x079  0x22200         ||              OR      R2, 0x00               ;load flags for middle for counter
(0128)  CS-0x07A  0x083AB         ||              BRNE    middle_for3
(0129)                            ||              
(0130)  CS-0x07B  0x22100         ||              OR      R1, 0x00               ;load flags for outside for counter value
(0131)  CS-0x07C  0x0839B         ||              BRNE    outside_for3
(0132)                            || ;---------------------------End Hold---------------------------------	 
(0133)  CS-0x07D  0x364AA         || 			 MOV R4, VALUE1
(0134)  CS-0x07E  0x365C5         || 			 MOV R5, VALUE2
(0135)  CS-0x07F  0x10400         || 			 LSL R4
(0136)  CS-0x080  0x30454         || 			 CMP R4, 0x54
(0137)  CS-0x081  0x084DA         || 			 BREQ outputLSL;
(0138)                     0x082  || testLSR:	
(0139)                            || ;----------------------------Hold-----------------------------------
(0140)  CS-0x082  0x361BA         ||              MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0141)  CS-0x083  0x2C101  0x083  || outside_for4: SUB     R1, 0x01
(0142)                            || 
(0143)  CS-0x084  0x362BA         ||              MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
(0144)  CS-0x085  0x2C201  0x085  || middle_for4:  SUB     R2, 0x01
(0145)                            ||              
(0146)  CS-0x086  0x363BA         ||              MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0147)  CS-0x087  0x2C301  0x087  || inside_for4:  SUB     R3, 0x01
(0148)  CS-0x088  0x0843B         ||              BRNE    inside_for4
(0149)                            ||              
(0150)  CS-0x089  0x22200         ||              OR      R2, 0x00               ;load flags for middle for counter
(0151)  CS-0x08A  0x0842B         ||              BRNE    middle_for4
(0152)                            ||              
(0153)  CS-0x08B  0x22100         ||              OR      R1, 0x00               ;load flags for outside for counter value
(0154)  CS-0x08C  0x0841B         ||              BRNE    outside_for4
(0155)                            || ;---------------------------End Hold---------------------------------		 
(0156)  CS-0x08D  0x364AA         || 			 MOV R4, VALUE1
(0157)  CS-0x08E  0x365C5         || 			 MOV R5, VALUE2
(0158)  CS-0x08F  0x10401         || 			 LSR R4
(0159)  CS-0x090  0x30455         || 			 CMP R4, 0x55
(0160)  CS-0x091  0x084F2         || 			 BREQ outputLSR;
(0161)                            || ;----------------------Successful Test Outputs-----------------------
(0162)                     0x092  || outputAND:             
(0163)  CS-0x092  0x22680         || OR R6, 0x80	 
(0164)  CS-0x093  0x34640         || OUT R6, LED_PORT
(0165)  CS-0x094  0x08290         || BRN testOR;
(0166)                            || 
(0167)                     0x095  || outputOR:		 
(0168)  CS-0x095  0x22640         || OR R6, 0x40
(0169)  CS-0x096  0x34640         || OUT R6, LED_PORT
(0170)  CS-0x097  0x08310         || BRN testEXOR;
(0171)                            || 
(0172)                     0x098  || outputEXOR:		 
(0173)  CS-0x098  0x22620         || OR R6, 0x20
(0174)  CS-0x099  0x34640         || OUT R6, LED_PORT
(0175)  CS-0x09A  0x08390         || BRN testLSL;
(0176)                            || 
(0177)                     0x09B  || outputLSL:
(0178)  CS-0x09B  0x22610         || OR R6, 0x10
(0179)  CS-0x09C  0x34640         || OUT R6, LED_PORT
(0180)  CS-0x09D  0x08410         || BRN testLSR;
(0181)                            || 
(0182)                     0x09E  || outputLSR:		 
(0183)  CS-0x09E  0x2260F         || OR R6, 0x0F
(0184)  CS-0x09F  0x34640         || OUT R6, LED_PORT
(0185)                            || 
(0186)                            || ;-------------------------Hold LED's Indefinitely----------------------------------
(0187)                     0x0A0  || endlessloop:
(0188)  CS-0x0A0  0x306FF         || CMP R6, 0XFF
(0189)  CS-0x0A1  0x08500         || BRN endlessloop;
(0190)                            || 
(0191)                            || 
(0192)                            || 





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
ENDLESSLOOP    0x0A0   (0187)  ||  0189 
INSIDE_FOR0    0x047   (0051)  ||  0052 
INSIDE_FOR1    0x057   (0075)  ||  0076 
INSIDE_FOR2    0x067   (0099)  ||  0100 
INSIDE_FOR3    0x077   (0124)  ||  0125 
INSIDE_FOR4    0x087   (0147)  ||  0148 
MIDDLE_FOR0    0x045   (0048)  ||  0055 
MIDDLE_FOR1    0x055   (0072)  ||  0079 
MIDDLE_FOR2    0x065   (0096)  ||  0103 
MIDDLE_FOR3    0x075   (0121)  ||  0128 
MIDDLE_FOR4    0x085   (0144)  ||  0151 
OUTPUTAND      0x092   (0162)  ||  0064 
OUTPUTEXOR     0x098   (0172)  ||  0113 
OUTPUTLSL      0x09B   (0177)  ||  0137 
OUTPUTLSR      0x09E   (0182)  ||  0160 
OUTPUTOR       0x095   (0167)  ||  0088 
OUTSIDE_FOR0   0x043   (0045)  ||  0058 
OUTSIDE_FOR1   0x053   (0069)  ||  0082 
OUTSIDE_FOR2   0x063   (0093)  ||  0106 
OUTSIDE_FOR3   0x073   (0118)  ||  0131 
OUTSIDE_FOR4   0x083   (0141)  ||  0154 
TESTAND        0x042   (0042)  ||  
TESTEXOR       0x062   (0090)  ||  0170 
TESTLSL        0x072   (0115)  ||  0175 
TESTLSR        0x082   (0138)  ||  0180 
TESTOR         0x052   (0066)  ||  0165 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INSIDE_FOR_COUNT 0x0BA   (0023)  ||  0050 0074 0098 0123 0146 
LED_PORT       0x040   (0030)  ||  0041 0164 0169 0174 0179 0184 
MIDDLE_FOR_COUNT 0x0BA   (0024)  ||  0047 0071 0095 0120 0143 
OUTSIDE_FOR_COUNT 0x0BA   (0025)  ||  0044 0068 0092 0117 0140 
VALUE1         0x0AA   (0027)  ||  0060 0084 0108 0133 0156 
VALUE2         0x0C5   (0028)  ||  0061 0085 0109 0134 0157 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
