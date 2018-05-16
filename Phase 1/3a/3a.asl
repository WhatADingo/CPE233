

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


(0001)                            || ;- Programmers: Abesh Mubaraki and Vince Jison
(0002)                            || ;- Date: 26 Feb 2011
(0003)                            || ;- Version: 1a
(0004)                            || ;--------------------------------------------------------------------
(0005)                            || ;-######## Case #3 - BRN, BREQ, BRNE, BRCS, BRCC, CLC, SEC ########-;
(0006)                            || ;--------------------------------------------------------------------
(0007)                            || ;-
(0008)                            || ;- Version 1a update: TABs were removed and replaced with spaces
(0009)                            || ;-
(0010)                            || ;-
(0011)                            || ;- This test case switches on the LEDs on the Nexys2 from right to
(0012)                            || ;- left (LD0 to LD7) for each successful test.
(0013)                            || ;- There is about half a second delay in between each test.
(0014)                            || ;- The correspondence between the test and LEDs is as follows:
(0015)                            || ;- 	BRN	LD0
(0016)                            || ;- 	BREQ	LD1
(0017)                            || ;- 	BRNE	LD2
(0018)                            || ;- 	BRCS	LD3
(0019)                            || ;- 	BRCC	LD4
(0020)                            || ;- 	CLC	LD5
(0021)                            || ;- 	SEC	LD6 and LD7
(0022)                            || ;-
(0023)                            || ;- Some other operations that are used in this test case are
(0024)                            || ;- 	ADD	SUB	EXOR	LSR	MOV	OUT	OR
(0025)                            || ;-
(0026)                            || ;- LEDs must turn on from 0 to 7 to indicate a successful test.
(0027)                            || ;-
(0028)                            || ;--------------------------------------------------------------------
(0029)                            || 
(0030)                            || ;--------------------------------------------------------------------
(0031)                            || ;- Port Constants
(0032)                            || ;--------------------------------------------------------------------
(0033)                       032  || .EQU SWITCH_PORT = 0x20       ; port for switches ----- INPUT
(0034)                       064  || .EQU LED_PORT    = 0x40         ; port for LED output --- OUTOUT
(0035)                       255  || .EQU BTN_PORT    = 0xFF         ; port for button input - INPUT
(0036)                            || ;--------------------------------------------------------------------
(0037)                            || 
(0038)                            || ;--------------------------------------------------------------------
(0039)                            || ;- Misc Constants
(0040)                            || ;--------------------------------------------------------------------
(0041)                            || 
(0042)                       001  || .EQU B0_MASK = 0x01             ; mask all but bit0
(0043)                       002  || .EQU B1_MASK = 0x02             ; mask all but bit1
(0044)                       004  || .EQU B2_MASK = 0x04             ; mask all but bit2
(0045)                       008  || .EQU B3_MASK = 0x08             ; mask all but bit3
(0046)                       016  || .EQU B4_MASK = 0x10             ; mask all but bit4
(0047)                       032  || .EQU B5_MASK = 0x20             ; mask all but bit5
(0048)                       064  || .EQU B6_MASK = 0x40             ; mask all but bit6
(0049)                       128  || .EQU B7_MASK = 0x80             ; mask all but bit7
(0050)                            ||  
(0051)                       255  || .EQU INSIDE_FOR_COUNT  = 0xFF   ; These three contestants set the
(0052)                       255  || .EQU MIDDLE_FOR_COUNT  = 0xFF   ; amount of delay between each test.
(0053)                       096  || .EQU OUTSIDE_FOR_COUNT = 0x60   ; Current time delay is about 503 mS.
(0054)                            || ;- 	Setting the last constant to FF will give a 1.3 sec delay.
(0055)                            || 
(0056)                            || ;--------------------------------------------------------------------
(0057)                            || 
(0058)                            || ;--------------------------------------------------------------------
(0059)                            || 
(0060)                            || .DSEG
(0061)                       000  || .ORG   0x00
(0062)                            || 
(0063)                            || ;--------------------------------------------------------------------
(0064)                            || 
(0065)                            || ;--------------------------------------------------------------------
(0066)                            || 
(0067)                            || .CSEG
(0068)                       064  || .ORG   0x40
(0069)                            || 
(0070)                            || 
(0071)  CS-0x040  0x36A00  0x040  || Main:         MOV R10, 0x00             ; R10 used to outputs to LEDs
(0072)  CS-0x041  0x36B00         ||               MOV R11, 0x00             ;
(0073)  CS-0x042  0x08650         ||               BRN 0xCA                  ;
(0074)  CS-0x043  0x28B00  0x043  || Zero_Down:    ADD R11, 0x00             ; Zero flag set
(0075)  CS-0x044  0x08392         ||               BREQ Check_One            ;
(0076)  CS-0x045  0x28B01  0x045  || One_Down:     ADD R11, 0x01             ; Zero flag cleared
(0077)  CS-0x046  0x08403         ||               BRNE Check_Two            ;
(0078)  CS-0x047  0x28BFF  0x047  || Two_Down:     ADD R11, 0xFF             ; Carry flag set
(0079)  CS-0x048  0x0A470         ||               BRCS Check_Three          ;
(0080)  CS-0x049  0x36B00  0x049  || Three_Down:   MOV R11, 0x00             ;
(0081)  CS-0x04A  0x28B01         ||               ADD R11, 0x01             ; Carry flag cleared
(0082)  CS-0x04B  0x0A4E1         ||               BRCC Check_Four           ;
(0083)  CS-0x04C  0x28BFF  0x04C  || Four_Down:    ADD R11, 0xFF             ; Carry flag set & R1 = 0x00
(0084)  CS-0x04D  0x18000         ||               CLC                       ; Carry flag cleared
(0085)  CS-0x04E  0x10B01         ||               LSR R11                   ; Moving the C value in
(0086)  CS-0x04F  0x10B01         ||               LSR R11                   ; 	proper location to
(0087)  CS-0x050  0x10B01         ||               LSR R11                   ; 	test it.
(0088)  CS-0x051  0x24B20         ||               EXOR R11, B5_MASK         ;
(0089)  CS-0x052  0x00A5A         ||               EXOR R10, R11             ; Entering the test result
(0090)  CS-0x053  0x34A40         ||               OUT R10, LED_PORT         ; 	to R10
(0091)                            || 
(0092)                            || ; Delay ----------------------------------------------------------------
(0093)  CS-0x054  0x36160         ||               MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0094)  CS-0x055  0x2C101  0x055  || outside_one:  SUB R1, 0x01
(0095)  CS-0x056  0x362FF         ||               MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
(0096)  CS-0x057  0x2C201  0x057  || middle_one:   SUB R2, 0x01
(0097)  CS-0x058  0x363FF         ||               MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0098)  CS-0x059  0x2C301  0x059  || inside_one:   SUB R3, 0x01
(0099)  CS-0x05A  0x082CB         ||               BRNE inside_one
(0100)  CS-0x05B  0x22200         ||               OR R2, 0x00           ;load flags for middle for counter
(0101)  CS-0x05C  0x082BB         ||               BRNE middle_one
(0102)  CS-0x05D  0x22100         ||               OR R1, 0x00           ;load flags for outsde for counter value
(0103)  CS-0x05E  0x082AB         ||               BRNE outside_one
(0104)                            || 
(0105)  CS-0x05F  0x36B00  0x05F  || Five_down:    MOV R11, 0x00             ;
(0106)  CS-0x060  0x18001         ||               SEC                       ;
(0107)  CS-0x061  0x10B01         ||               LSR R11                   ;
(0108)  CS-0x062  0x00A5A         ||               EXOR R10, R11             ;
(0109)  CS-0x063  0x10B01         ||               LSR R11                   ;
(0110)  CS-0x064  0x00A5A         ||               EXOR R10, R11             ;
(0111)  CS-0x065  0x34A40         ||               OUT R10, LED_PORT         ;
(0112)                            || 
(0113)                            || ; Delay ----------------------------------------------------------------
(0114)  CS-0x066  0x36160         ||               MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0115)  CS-0x067  0x2C101  0x067  || outside_two:  SUB R1, 0x01
(0116)  CS-0x068  0x362FF         ||               MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
(0117)  CS-0x069  0x2C201  0x069  || middle_two:   SUB R2, 0x01
(0118)  CS-0x06A  0x363FF         ||               MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0119)  CS-0x06B  0x2C301  0x06B  || inside_two:   SUB R3, 0x01
(0120)  CS-0x06C  0x0835B         ||               BRNE inside_two
(0121)  CS-0x06D  0x22200         ||               OR R2, 0x00           ;load flags for middle for counter
(0122)  CS-0x06E  0x0834B         ||               BRNE middle_two
(0123)  CS-0x06F  0x22100         ||               OR R1, 0x00           ;load flags for outsde for counter value
(0124)  CS-0x070  0x0833B         ||               BRNE outside_two
(0125)                            || 
(0126)  CS-0x071  0x08200  0x071  || Six_down:     Brn Main                  ;
(0127)                            ||                                         ;
(0128)                            ||                                         ;<-Code dies when it crosses
(0129)                            ||                                         ;	this border
(0130)                            ||                                         ;
(0131)                            ||                                         ; Step aside Janet Napolitano
(0132)                            || ;--------------------------------------------------------------------
(0133)                            || 
(0134)  CS-0x072  0x22A02  0x072  || Check_One:    OR R10, B1_MASK
(0135)  CS-0x073  0x34A40         ||               OUT R10, LED_PORT
(0136)                            || 
(0137)                            || ; Delay ----------------------------------------------------------------
(0138)  CS-0x074  0x36160         ||               MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0139)  CS-0x075  0x2C101  0x075  || outside_tre:  SUB R1, 0x01
(0140)  CS-0x076  0x362FF         ||               MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
(0141)  CS-0x077  0x2C201  0x077  || middle_tre:   SUB R2, 0x01
(0142)  CS-0x078  0x363FF         ||               MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0143)  CS-0x079  0x2C301  0x079  || inside_tre:   SUB R3, 0x01
(0144)  CS-0x07A  0x083CB         ||               BRNE inside_tre
(0145)  CS-0x07B  0x22200         ||               OR R2, 0x00           ;load flags for middle for counter
(0146)  CS-0x07C  0x083BB         ||               BRNE middle_tre
(0147)  CS-0x07D  0x22100         ||               OR R1, 0x00           ;load flags for outsde for counter value
(0148)  CS-0x07E  0x083AB         ||               BRNE outside_tre
(0149)                            || 
(0150)  CS-0x07F  0x08228         ||               BRN One_Down
(0151)                            ||                 
(0152)  CS-0x080  0x22A04  0x080  || Check_Two:    OR R10, B2_MASK
(0153)  CS-0x081  0x34A40         ||               OUT R10, LED_PORT
(0154)                            || 
(0155)                            || ; Delay ----------------------------------------------------------------
(0156)  CS-0x082  0x36160         ||               MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0157)  CS-0x083  0x2C101  0x083  || outside_for:  SUB R1, 0x01
(0158)  CS-0x084  0x362FF         ||               MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
(0159)  CS-0x085  0x2C201  0x085  || middle_for:   SUB R2, 0x01
(0160)  CS-0x086  0x363FF         ||               MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0161)  CS-0x087  0x2C301  0x087  || inside_for:   SUB R3, 0x01
(0162)  CS-0x088  0x0843B         ||               BRNE inside_for
(0163)  CS-0x089  0x22200         ||               OR R2, 0x00           ;load flags for middle for counter
(0164)  CS-0x08A  0x0842B         ||               BRNE middle_for
(0165)  CS-0x08B  0x22100         ||               OR R1, 0x00           ;load flags for outsde for counter value
(0166)  CS-0x08C  0x0841B         ||               BRNE outside_for
(0167)                            || 
(0168)  CS-0x08D  0x08238         ||               BRN Two_Down
(0169)                            ||               
(0170)  CS-0x08E  0x22A08  0x08E  || Check_Three:  OR R10, B3_MASK
(0171)  CS-0x08F  0x34A40         ||               OUT R10, LED_PORT
(0172)                            || 
(0173)                            || ; Delay ----------------------------------------------------------------
(0174)  CS-0x090  0x36160         ||               MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0175)  CS-0x091  0x2C101  0x091  || outside_fiv:  SUB R1, 0x01
(0176)  CS-0x092  0x362FF         ||               MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
(0177)  CS-0x093  0x2C201  0x093  || middle_fiv:   SUB R2, 0x01
(0178)  CS-0x094  0x363FF         ||               MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0179)  CS-0x095  0x2C301  0x095  || inside_fiv:   SUB R3, 0x01
(0180)  CS-0x096  0x084AB         ||               BRNE inside_fiv
(0181)  CS-0x097  0x22200         ||               OR R2, 0x00           ;load flags for middle for counter
(0182)  CS-0x098  0x0849B         ||               BRNE middle_fiv
(0183)  CS-0x099  0x22100         ||               OR R1, 0x00           ;load flags for outsde for counter value
(0184)  CS-0x09A  0x0848B         ||               BRNE outside_fiv
(0185)                            || 
(0186)  CS-0x09B  0x08248         ||               BRN Three_Down
(0187)                            || 
(0188)  CS-0x09C  0x22A10  0x09C  || Check_Four:   OR R10, B4_MASK
(0189)  CS-0x09D  0x34A40         ||               OUT R10, LED_PORT
(0190)                            || 
(0191)                            || ; Delay ----------------------------------------------------------------
(0192)  CS-0x09E  0x36160         ||               MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0193)  CS-0x09F  0x2C101  0x09F  || outside_six:  SUB R1, 0x01
(0194)  CS-0x0A0  0x362FF         ||               MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
(0195)  CS-0x0A1  0x2C201  0x0A1  || middle_six:   SUB R2, 0x01
(0196)  CS-0x0A2  0x363FF         ||               MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0197)  CS-0x0A3  0x2C301  0x0A3  || inside_six:   SUB R3, 0x01
(0198)  CS-0x0A4  0x0851B         ||               BRNE inside_six
(0199)  CS-0x0A5  0x22200         ||               OR R2, 0x00           ;load flags for middle for counter
(0200)  CS-0x0A6  0x0850B         ||               BRNE middle_six
(0201)  CS-0x0A7  0x22100         ||               OR R1, 0x00           ;load flags for outsde for counter value
(0202)  CS-0x0A8  0x084FB         ||               BRNE outside_six
(0203)                            || 
(0204)  CS-0x0A9  0x08260         ||               BRN Four_Down
(0205)                            || 
(0206)                            || ;--------------------------------------------------------------------
(0207)                            || .CSEG
(0208)                       202  || .ORG   0xCA
(0209)                            || 
(0210)  CS-0x0CA  0x22A01  0x0CA  || Check_Zero:   OR R10, B0_MASK
(0211)  CS-0x0CB  0x34A40         ||               OUT R10, LED_PORT
(0212)                            || 
(0213)                            || ; Delay ----------------------------------------------------------------
(0214)  CS-0x0CC  0x36160         ||               MOV R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0215)  CS-0x0CD  0x2C101  0x0CD  || outside_sev:  SUB R1, 0x01
(0216)  CS-0x0CE  0x362FF         ||               MOV R2, MIDDLE_FOR_COUNT	 ;set middle for loop count
(0217)  CS-0x0CF  0x2C201  0x0CF  || middle_sev:   SUB R2, 0x01
(0218)  CS-0x0D0  0x363FF         ||               MOV R3, INSIDE_FOR_COUNT   ;set inside for loop count
(0219)  CS-0x0D1  0x2C301  0x0D1  || inside_sev:   SUB R3, 0x01
(0220)  CS-0x0D2  0x0868B         ||               BRNE inside_sev
(0221)  CS-0x0D3  0x22200         ||               OR R2, 0x00           ;load flags for middle for counter
(0222)  CS-0x0D4  0x0867B         ||               BRNE middle_sev
(0223)  CS-0x0D5  0x22100         ||               OR R1, 0x00           ;load flags for outsde for counter value
(0224)  CS-0x0D6  0x0866B         ||               BRNE outside_sev
(0225)                            || 
(0226)  CS-0x0D7  0x08218         ||               BRN Zero_down;
(0227)                            ||               
(0228)                            || 
(0229)                            || 
(0230)                            || 





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
CHECK_FOUR     0x09C   (0188)  ||  0082 
CHECK_ONE      0x072   (0134)  ||  0075 
CHECK_THREE    0x08E   (0170)  ||  0079 
CHECK_TWO      0x080   (0152)  ||  0077 
CHECK_ZERO     0x0CA   (0210)  ||  
FIVE_DOWN      0x05F   (0105)  ||  
FOUR_DOWN      0x04C   (0083)  ||  0204 
INSIDE_FIV     0x095   (0179)  ||  0180 
INSIDE_FOR     0x087   (0161)  ||  0162 
INSIDE_ONE     0x059   (0098)  ||  0099 
INSIDE_SEV     0x0D1   (0219)  ||  0220 
INSIDE_SIX     0x0A3   (0197)  ||  0198 
INSIDE_TRE     0x079   (0143)  ||  0144 
INSIDE_TWO     0x06B   (0119)  ||  0120 
MAIN           0x040   (0071)  ||  0126 
MIDDLE_FIV     0x093   (0177)  ||  0182 
MIDDLE_FOR     0x085   (0159)  ||  0164 
MIDDLE_ONE     0x057   (0096)  ||  0101 
MIDDLE_SEV     0x0CF   (0217)  ||  0222 
MIDDLE_SIX     0x0A1   (0195)  ||  0200 
MIDDLE_TRE     0x077   (0141)  ||  0146 
MIDDLE_TWO     0x069   (0117)  ||  0122 
ONE_DOWN       0x045   (0076)  ||  0150 
OUTSIDE_FIV    0x091   (0175)  ||  0184 
OUTSIDE_FOR    0x083   (0157)  ||  0166 
OUTSIDE_ONE    0x055   (0094)  ||  0103 
OUTSIDE_SEV    0x0CD   (0215)  ||  0224 
OUTSIDE_SIX    0x09F   (0193)  ||  0202 
OUTSIDE_TRE    0x075   (0139)  ||  0148 
OUTSIDE_TWO    0x067   (0115)  ||  0124 
SIX_DOWN       0x071   (0126)  ||  
THREE_DOWN     0x049   (0080)  ||  0186 
TWO_DOWN       0x047   (0078)  ||  0168 
ZERO_DOWN      0x043   (0074)  ||  0226 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
B0_MASK        0x001   (0042)  ||  0210 
B1_MASK        0x002   (0043)  ||  0134 
B2_MASK        0x004   (0044)  ||  0152 
B3_MASK        0x008   (0045)  ||  0170 
B4_MASK        0x010   (0046)  ||  0188 
B5_MASK        0x020   (0047)  ||  0088 
B6_MASK        0x040   (0048)  ||  
B7_MASK        0x080   (0049)  ||  
BTN_PORT       0x0FF   (0035)  ||  
INSIDE_FOR_COUNT 0x0FF   (0051)  ||  0097 0118 0142 0160 0178 0196 0218 
LED_PORT       0x040   (0034)  ||  0090 0111 0135 0153 0171 0189 0211 
MIDDLE_FOR_COUNT 0x0FF   (0052)  ||  0095 0116 0140 0158 0176 0194 0216 
OUTSIDE_FOR_COUNT 0x060   (0053)  ||  0093 0114 0138 0156 0174 0192 0214 
SWITCH_PORT    0x020   (0033)  ||  


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
