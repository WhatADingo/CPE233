

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


(0001)                            || ;- Test Info: ----------------------------------------------------------|
(0002)                            || ;- Programmers: Kevin Brewer and Kyle Patterson                       	|
(0003)                            || ;- Date: 02-27-2011						      	|
(0004)                            || ;- Version: 1							      	|
(0005)                            || ;-----------------------------------------------------------------------|
(0006)                            || ;- Test Cases:							      	|
(0007)                            || ;-								      	|
(0008)                            || ;- Test1:   Tests AND(reg/reg)         lights up LED0 (rightmost LED) 	|
(0009)                            || ;- Test2:   Tests OR(reg/reg)          lights up LED1		      	|
(0010)                            || ;- Test3:   Tests EXOR(reg/reg)        lights up LED2		      	|
(0011)                            || ;- Test4:   Tests LSL(reg)             lights up LED3		      	|
(0012)                            || ;- Test5:   Tests LSR(reg)             lights up LED4 through LED7    	|
(0013)                            || ;-----------------------------------------------------------------------|
(0014)                            || ;- Results:							      	|
(0015)                            || ;-									|
(0016)                            || ;- Each successful test results in an LED lighting up. A failed test	|
(0017)                            || ;- results in an unlit LED. The LEDs light up in sequential order 	|
(0018)                            || ;- starting with LED0 for the first test through LED7 for the last 	|
(0019)                            || ;- test.  If all tests pass all eight LEDs on the board should be lit.	|
(0020)                            || ;- There will be a half second delay between each test.			|
(0021)                            || ;-----------------------------------------------------------------------|
(0022)                            || ;- Registers of Interest:						|
(0023)                            || ;-									|
(0024)                            || ;- R1, R2, and R3:  Used in loops that causes half second delay		|
(0025)                            || ;- R10 and R11:	    Used for testing AND, OR, EXOR, LSL, and LSR	|
(0026)                            || ;- R31:		    Used with LEDs to show which tests passed		|
(0027)                            || ;-----------------------------------------------------------------------|
(0028)                            || 
(0029)                            || 
(0030)                            || ;- Port Constants: -----------------------------------------------------|
(0031)                       064  || .EQU LED_PORT = 0x40	; switch and button ports not needed for tests	|
(0032)                            || ;-----------------------------------------------------------------------|
(0033)                            || 
(0034)                            || ;- Looping Constants: --------------------------------------------------|
(0035)                       186  || .EQU INSIDE_FOR_COUNT    = 0xBA ;
(0036)                       186  || .EQU MIDDLE_FOR_COUNT    = 0xBA ;
(0037)                       186  || .EQU OUTSIDE_FOR_COUNT   = 0xBA ;
(0038)                            || ;-----------------------------------------------------------------------|
(0039)                            || 
(0040)                            || .DSEG
(0041)                       000  || .ORG         0x00  
(0042)                            || .CSEG
(0043)                       064  || .ORG         0x40
(0044)                            || 
(0045)                            || 
(0046)                            ||    
(0047)  CS-0x040  0x37F00  0x040  || main_loop:	MOV	R31, 0x00	; Initialize LEDs to all unlit
(0048)                            || 
(0049)  CS-0x041  0x36AD6  0x041  || Test1:	 	MOV 	R10, 0xD6	; 11010110
(0050)  CS-0x042  0x36B55         || 		MOV 	R11, 0x55	; 01010101
(0051)  CS-0x043  0x00A58         || 		AND 	R10, R11	; 01010100 = 0x54
(0052)  CS-0x044  0x30A54         || 		CMP 	R10, 0x54 	; If AND works, Z = 1
(0053)  CS-0x045  0x0829B         || 		BRNE 	Test2;		; If Z = 1, no branch
(0054)  CS-0x046  0x23F01         || 		OR 	R31, 0x01
(0055)  CS-0x047  0x35F40         || 		OUT 	R31, LED_PORT	; LED0 lit
(0056)                            || 
(0057)                            || 
(0058)                            || ;-HOLD-DELAY-1-----------------------------------------------------------
(0059)  CS-0x048  0x361BA         || 		MOV     R1, OUTSIDE_FOR_COUNT
(0060)  CS-0x049  0x2C101  0x049  || OUTSIDE_FOR1: 	SUB     R1, 0x01
(0061)                            ||  
(0062)  CS-0x04A  0x362BA         || 		MOV     R2, MIDDLE_FOR_COUNT
(0063)  CS-0x04B  0x2C201  0x04B  || MIDDLE_FOR1:  	SUB     R2, 0x01
(0064)                            ||              
(0065)  CS-0x04C  0x363BA         || 		MOV     R3, INSIDE_FOR_COUNT
(0066)  CS-0x04D  0x2C301  0x04D  || INSIDE_FOR1:  	SUB     R3, 0x01
(0067)  CS-0x04E  0x0826B         || 		BRNE    INSIDE_FOR1
(0068)                            || 
(0069)  CS-0x04F  0x22200         || 		OR      R2, 0x00
(0070)  CS-0x050  0x0825B         || 		BRNE    MIDDLE_FOR1
(0071)                            || 
(0072)  CS-0x051  0x22100         || 		OR      R1, 0x00
(0073)  CS-0x052  0x0824B         || 		BRNE    OUTSIDE_FOR1
(0074)                            || ;-END-HOLD---------------------------------------------------------------
(0075)                            || 
(0076)                            || 
(0077)  CS-0x053  0x36AD6  0x053  || Test2:		MOV 	R10, 0xD6	; 11010110
(0078)  CS-0x054  0x36B55         || 		MOV 	R11, 0x55	; 01010101
(0079)  CS-0x055  0x00A59         || 		OR 	R10, R11	; 11010111 = 0xD7
(0080)  CS-0x056  0x30AD7         ||                 CMP 	R10, 0xD7	; If OR works, Z = 1
(0081)  CS-0x057  0x0832B         || 		BRNE 	Test3;		; If Z = 1, no branch
(0082)  CS-0x058  0x23F02         || 		OR	R31, 0x02
(0083)  CS-0x059  0x35F40         || 		OUT	R31, LED_PORT	; LED1 lit
(0084)                            || 
(0085)                            || 
(0086)                            || ;-HOLD-DELAY-2-----------------------------------------------------------
(0087)  CS-0x05A  0x361BA         || 		MOV     R1, OUTSIDE_FOR_COUNT
(0088)  CS-0x05B  0x2C101  0x05B  || OUTSIDE_FOR2: 	SUB     R1, 0x01
(0089)                            ||  
(0090)  CS-0x05C  0x362BA         || 		MOV     R2, MIDDLE_FOR_COUNT
(0091)  CS-0x05D  0x2C201  0x05D  || MIDDLE_FOR2:  	SUB     R2, 0x01
(0092)                            ||              
(0093)  CS-0x05E  0x363BA         || 		MOV     R3, INSIDE_FOR_COUNT
(0094)  CS-0x05F  0x2C301  0x05F  || INSIDE_FOR2:  	SUB     R3, 0x01
(0095)  CS-0x060  0x082FB         || 		BRNE    INSIDE_FOR2
(0096)                            || 
(0097)  CS-0x061  0x22200         || 		OR      R2, 0x00
(0098)  CS-0x062  0x082EB         || 		BRNE    MIDDLE_FOR2
(0099)                            || 
(0100)  CS-0x063  0x22100         || 		OR      R1, 0x00
(0101)  CS-0x064  0x082DB         || 		BRNE    OUTSIDE_FOR2
(0102)                            || ;-END-HOLD---------------------------------------------------------------
(0103)                            || 
(0104)                            || 
(0105)  CS-0x065  0x36AD6  0x065  || Test3:		MOV 	R10, 0xD6	; 11010110
(0106)  CS-0x066  0x36B55         || 		MOV 	R11, 0x55	; 01010101
(0107)  CS-0x067  0x00A5A         || 		EXOR 	R10, R11	; 10000011 = 0x83
(0108)  CS-0x068  0x30A83         ||                 CMP 	R10, 0x83	; If OR works, Z = 1
(0109)  CS-0x069  0x083BB         || 		BRNE 	Test4;		; If Z = 1, no branch
(0110)  CS-0x06A  0x23F04         || 		OR	R31, 0x04
(0111)  CS-0x06B  0x35F40         || 		OUT	R31, LED_PORT	; LED3 lit
(0112)                            || 
(0113)                            || 
(0114)                            || ;-HOLD-DELAY-3-----------------------------------------------------------
(0115)  CS-0x06C  0x361BA         || 		MOV     R1, OUTSIDE_FOR_COUNT
(0116)  CS-0x06D  0x2C101  0x06D  || OUTSIDE_FOR3: 	SUB     R1, 0x01
(0117)                            ||  
(0118)  CS-0x06E  0x362BA         || 		MOV     R2, MIDDLE_FOR_COUNT
(0119)  CS-0x06F  0x2C201  0x06F  || MIDDLE_FOR3:  	SUB     R2, 0x01
(0120)                            ||              
(0121)  CS-0x070  0x363BA         || 		MOV     R3, INSIDE_FOR_COUNT
(0122)  CS-0x071  0x2C301  0x071  || INSIDE_FOR3:  	SUB     R3, 0x01
(0123)  CS-0x072  0x0838B         || 		BRNE    INSIDE_FOR3
(0124)                            || 
(0125)  CS-0x073  0x22200         || 		OR      R2, 0x00
(0126)  CS-0x074  0x0837B         || 		BRNE    MIDDLE_FOR3
(0127)                            || 
(0128)  CS-0x075  0x22100         || 		OR      R1, 0x00
(0129)  CS-0x076  0x0836B         || 		BRNE    OUTSIDE_FOR3
(0130)                            || ;-END-HOLD---------------------------------------------------------------
(0131)                            || 
(0132)                            || 
(0133)  CS-0x077  0x36AD6  0x077  || Test4:		MOV 	R10, 0xD6	; 11010110 - Also no R11 needed
(0134)  CS-0x078  0x18001         || 		SEC			; Set C = 1
(0135)  CS-0x079  0x10A00         || 		LSL 	R10		; 10101101 = 0xAD
(0136)  CS-0x07A  0x30AAD         ||                 CMP 	R10, 0xAD	; If OR works, Z = 1
(0137)  CS-0x07B  0x0844B         || 		BRNE 	Test5;		; If Z = 1, no branch
(0138)  CS-0x07C  0x23F08         || 		OR	R31, 0x08
(0139)  CS-0x07D  0x35F40         || 		OUT	R31, LED_PORT	; LED1 lit
(0140)                            || 
(0141)                            || 
(0142)                            || ;-HOLD-DELAY-4-----------------------------------------------------------
(0143)  CS-0x07E  0x361BA         || 		MOV     R1, OUTSIDE_FOR_COUNT
(0144)  CS-0x07F  0x2C101  0x07F  || OUTSIDE_FOR4: 	SUB     R1, 0x01
(0145)                            ||  
(0146)  CS-0x080  0x362BA         || 		MOV     R2, MIDDLE_FOR_COUNT
(0147)  CS-0x081  0x2C201  0x081  || MIDDLE_FOR4:  	SUB     R2, 0x01
(0148)                            ||              
(0149)  CS-0x082  0x363BA         || 		MOV     R3, INSIDE_FOR_COUNT
(0150)  CS-0x083  0x2C301  0x083  || INSIDE_FOR4:  	SUB     R3, 0x01
(0151)  CS-0x084  0x0841B         || 		BRNE    INSIDE_FOR4
(0152)                            || 
(0153)  CS-0x085  0x22200         || 		OR      R2, 0x00
(0154)  CS-0x086  0x0840B         || 		BRNE    MIDDLE_FOR4
(0155)                            || 
(0156)  CS-0x087  0x22100         || 		OR      R1, 0x00
(0157)  CS-0x088  0x083FB         || 		BRNE    OUTSIDE_FOR4
(0158)                            || ;-END-HOLD---------------------------------------------------------------
(0159)                            || 
(0160)                            || 
(0161)  CS-0x089  0x36AD6  0x089  || Test5:		MOV 	R10, 0xD6	; 11010110 - Also no R11 needed
(0162)  CS-0x08A  0x18001         || 		SEC			; Set C = 1
(0163)  CS-0x08B  0x10A01         || 		LSR 	R10		; 11101011 = 0xEB
(0164)  CS-0x08C  0x30AEB         ||                 CMP 	R10, 0xEB	; If OR works, Z = 1
(0165)  CS-0x08D  0x084DB         || 		BRNE 	DONE;		; If Z = 1, no branch
(0166)  CS-0x08E  0x23FF0         || 		OR	R31, 0xF0
(0167)  CS-0x08F  0x35F40         || 		OUT	R31, LED_PORT	; LED7-LED4 lit
(0168)                            || 
(0169)                            || 
(0170)                            || ;-HOLD-DELAY-5-----------------------------------------------------------
(0171)  CS-0x090  0x361BA         || 		MOV     R1, OUTSIDE_FOR_COUNT
(0172)  CS-0x091  0x2C101  0x091  || OUTSIDE_FOR5: 	SUB     R1, 0x01
(0173)                            ||  
(0174)  CS-0x092  0x362BA         || 		MOV     R2, MIDDLE_FOR_COUNT
(0175)  CS-0x093  0x2C201  0x093  || MIDDLE_FOR5:  	SUB     R2, 0x01
(0176)                            ||              
(0177)  CS-0x094  0x363BA         || 		MOV     R3, INSIDE_FOR_COUNT
(0178)  CS-0x095  0x2C301  0x095  || INSIDE_FOR5:  	SUB     R3, 0x01
(0179)  CS-0x096  0x084AB         || 		BRNE    INSIDE_FOR5
(0180)                            || 
(0181)  CS-0x097  0x22200         || 		OR      R2, 0x00
(0182)  CS-0x098  0x0849B         || 		BRNE    MIDDLE_FOR5
(0183)                            || 
(0184)  CS-0x099  0x22100         || 		OR      R1, 0x00
(0185)  CS-0x09A  0x0848B         || 		BRNE    OUTSIDE_FOR5
(0186)                            || ;-END-HOLD---------------------------------------------------------------
(0187)                            || 
(0188)                            || 
(0189)  CS-0x09B  0x35F40  0x09B  || DONE:		OUT R31, LED_PORT
(0190)  CS-0x09C  0x084D8         || 		BRN DONE
(0191)                            || ;
BRN DONE





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
DONE           0x09B   (0189)  ||  0165 0190 
INSIDE_FOR1    0x04D   (0066)  ||  0067 
INSIDE_FOR2    0x05F   (0094)  ||  0095 
INSIDE_FOR3    0x071   (0122)  ||  0123 
INSIDE_FOR4    0x083   (0150)  ||  0151 
INSIDE_FOR5    0x095   (0178)  ||  0179 
MAIN_LOOP      0x040   (0047)  ||  
MIDDLE_FOR1    0x04B   (0063)  ||  0070 
MIDDLE_FOR2    0x05D   (0091)  ||  0098 
MIDDLE_FOR3    0x06F   (0119)  ||  0126 
MIDDLE_FOR4    0x081   (0147)  ||  0154 
MIDDLE_FOR5    0x093   (0175)  ||  0182 
OUTSIDE_FOR1   0x049   (0060)  ||  0073 
OUTSIDE_FOR2   0x05B   (0088)  ||  0101 
OUTSIDE_FOR3   0x06D   (0116)  ||  0129 
OUTSIDE_FOR4   0x07F   (0144)  ||  0157 
OUTSIDE_FOR5   0x091   (0172)  ||  0185 
TEST1          0x041   (0049)  ||  
TEST2          0x053   (0077)  ||  0053 
TEST3          0x065   (0105)  ||  0081 
TEST4          0x077   (0133)  ||  0109 
TEST5          0x089   (0161)  ||  0137 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INSIDE_FOR_COUNT 0x0BA   (0035)  ||  0065 0093 0121 0149 0177 
LED_PORT       0x040   (0031)  ||  0055 0083 0111 0139 0167 0189 
MIDDLE_FOR_COUNT 0x0BA   (0036)  ||  0062 0090 0118 0146 0174 
OUTSIDE_FOR_COUNT 0x0BA   (0037)  ||  0059 0087 0115 0143 0171 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
