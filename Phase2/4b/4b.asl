

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


(0001)                       094  || .EQU time_INSIDE_FOR_COUNT    = 0x5E
(0002)                       255  || .EQU time_MIDDLE_FOR_COUNT    = 0xFF
(0003)                       255  || .EQU time_OUTSIDE_FOR_COUNT   = 0xFF
(0004)                            || 
(0005)                       064  || .EQU led_port = 0x40
(0006)                            || 
(0007)                            || .CSEG
(0008)                       064  || .ORG 0x40
(0009)                            || 
(0010)                            || ;This tests PUSH, POP, WSP, CALL, RET
(0011)                            || ;This assumes MOV, LD, ST, CMP, OUT, SUB, BRNE, BREQ, OR, ADD all work
(0012)                            || 
(0013)                            || ;requires simulator 0.52 or greater to simulate test case 8
(0014)                            || 
(0015)  CS-0x040  0x37F00  0x040  || Main: 	MOV R31, 0x00
(0016)  CS-0x041  0x35F40         || 	OUT R31, led_port
(0017)                            || 	
(0018)                            || 	;--------- test 1 ---------------------------------------------------------------
(0019)                            || 	;this tests only the push command by pushing a value and then loading directly.
(0020)                            || 	;it does not initialize the stack pointer to test stack pointer initialization
(0021)                            || 	;--------------------------------------------------------------------------------
(0022)  CS-0x042  0x36050         || 	MOV R0, 0x50
(0023)  CS-0x043  0x12001         || 	PUSH R0
(0024)  CS-0x044  0x381FF         || 	LD R1, 0xFF
(0025)  CS-0x045  0x30150         || 	CMP R1, 0x50
(0026)  CS-0x046  0x08243         || 	BRNE endtest1
(0027)  CS-0x047  0x23F01         || 	OR R31, 0x01
(0028)                            || 	
(0029)  CS-0x048  0x35F40  0x048  || 	endtest1: OUT R31, led_port
(0030)                            || 
(0031)                            || 	;--------------------- Pause 1/2 second ----------------------------------------       
(0032)  CS-0x049  0x361FF         || 		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0033)  CS-0x04A  0x2C101  0x04A  || 	outside_for1: SUB     R1, 0x01
(0034)                            || 
(0035)  CS-0x04B  0x362FF         || 		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0036)  CS-0x04C  0x2C201  0x04C  || 	middle_for1:  SUB     R2, 0x01
(0037)                            || 		     
(0038)  CS-0x04D  0x3635E         || 		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0039)  CS-0x04E  0x2C301  0x04E  || 	inside_for1:  SUB     R3, 0x01
(0040)  CS-0x04F  0x08273         || 		     BRNE    inside_for1
(0041)                            || 		     
(0042)  CS-0x050  0x22200         || 		     OR      R2, 0x00               ;load flags for middle for counter
(0043)  CS-0x051  0x08263         || 		     BRNE    middle_for1
(0044)                            || 		     
(0045)  CS-0x052  0x22100         || 		     OR      R1, 0x00               ;load flags for outsde for counter value
(0046)  CS-0x053  0x08253         || 		     BRNE    outside_for1
(0047)                            || 	;------------------------------- end Pause -----------------------------------------------
(0048)                            || 	 
(0049)                            || 	;--------- test 2 ---------------------------------------------------------------
(0050)                            || 	;this tests the push command by pushing a value and then loading directly.
(0051)                            || 	;this tests the wsp command by changing the stack to point at a random location in the memory
(0052)                            || 	;--------------------------------------------------------------------------------
(0053)  CS-0x054  0x361D1         || 	MOV R1, 0xD1
(0054)  CS-0x055  0x14100         || 	WSP R1
(0055)  CS-0x056  0x36011         || 	MOV R0, 0x11
(0056)  CS-0x057  0x12001         || 	PUSH R0
(0057)  CS-0x058  0x381D0         || 	LD R1, 0xD0
(0058)  CS-0x059  0x30111         || 	CMP R1, 0x11
(0059)  CS-0x05A  0x082E3         || 	BRNE endtest2
(0060)  CS-0x05B  0x23F02         || 	OR R31, 0x02
(0061)                            || 	
(0062)  CS-0x05C  0x35F40  0x05C  || 	endtest2: OUT R31, led_port
(0063)                            || 
(0064)                            || 	;--------------------- Pause 1/2 second ----------------------------------------       
(0065)  CS-0x05D  0x361FF         || 		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0066)  CS-0x05E  0x2C101  0x05E  || 	outside_for2: SUB     R1, 0x01
(0067)                            || 
(0068)  CS-0x05F  0x362FF         || 		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0069)  CS-0x060  0x2C201  0x060  || 	middle_for2:  SUB     R2, 0x01
(0070)                            || 	     
(0071)  CS-0x061  0x3635E         || 		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0072)  CS-0x062  0x2C301  0x062  || 	inside_for2:  SUB     R3, 0x01
(0073)  CS-0x063  0x08313         || 		     BRNE    inside_for2
(0074)                            || 		     
(0075)  CS-0x064  0x22200         || 		     OR      R2, 0x00               ;load flags for middle for counter
(0076)  CS-0x065  0x08303         || 		     BRNE    middle_for2
(0077)                            || 		     
(0078)  CS-0x066  0x22100         || 		     OR      R1, 0x00               ;load flags for outsde for counter value
(0079)  CS-0x067  0x082F3         || 		     BRNE    outside_for2
(0080)                            || 	;------------------------------- end Pause -----------------------------------------------
(0081)                            || 
(0082)                            || 	;--------- test 3 ---------------------------------------------------------------
(0083)                            || 	;this tests only the pop command by storing a variable directly and then popping it
(0084)                            || 	;--------------------------------------------------------------------------------
(0085)  CS-0x068  0x361FF         || 	MOV R1, 0xFF
(0086)  CS-0x069  0x14100         || 	WSP R1
(0087)  CS-0x06A  0x36022         || 	MOV R0, 0x22
(0088)  CS-0x06B  0x3A0FF         || 	ST R0, 0xFF
(0089)  CS-0x06C  0x12102         || 	POP R1
(0090)  CS-0x06D  0x30122         || 	CMP R1, 0x22
(0091)  CS-0x06E  0x08383         || 	BRNE endtest3
(0092)  CS-0x06F  0x23F04         || 	OR R31, 0x04
(0093)                            || 	
(0094)  CS-0x070  0x35F40  0x070  || 	endtest3: OUT R31, led_port
(0095)                            || 
(0096)                            || 	;--------------------- Pause 1/2 second ----------------------------------------       
(0097)  CS-0x071  0x361FF         || 		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0098)  CS-0x072  0x2C101  0x072  || 	outside_for3: SUB     R1, 0x01
(0099)                            || 
(0100)  CS-0x073  0x362FF         || 		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0101)  CS-0x074  0x2C201  0x074  || 	middle_for3:  SUB     R2, 0x01
(0102)                            || 		     
(0103)  CS-0x075  0x3635E         || 		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0104)  CS-0x076  0x2C301  0x076  || 	inside_for3:  SUB     R3, 0x01
(0105)  CS-0x077  0x083B3         || 		     BRNE    inside_for3
(0106)                            || 	     
(0107)  CS-0x078  0x22200         || 		     OR      R2, 0x00               ;load flags for middle for counter
(0108)  CS-0x079  0x083A3         || 		     BRNE    middle_for3
(0109)                            || 		     
(0110)  CS-0x07A  0x22100         || 		     OR      R1, 0x00               ;load flags for outsde for counter value
(0111)  CS-0x07B  0x08393         || 		     BRNE    outside_for3
(0112)                            || 	;------------------------------- end Pause -----------------------------------------------
(0113)                            || 
(0114)                            || 	;--------- test 4 ---------------------------------------------------------------
(0115)                            || 	;this tests both the push and pop commands
(0116)                            || 	;--------------------------------------------------------------------------------
(0117)  CS-0x07C  0x36100         || 	MOV R1, 0x00
(0118)  CS-0x07D  0x14100         || 	WSP R1
(0119)  CS-0x07E  0x36042         || 	MOV R0, 0x42
(0120)  CS-0x07F  0x12001         || 	PUSH R0
(0121)  CS-0x080  0x12102         || 	POP R1
(0122)  CS-0x081  0x30142         || 	CMP R1, 0x42
(0123)  CS-0x082  0x08423         || 	BRNE endtest4
(0124)  CS-0x083  0x23F08         || 	OR R31, 0x08
(0125)                            || 
(0126)  CS-0x084  0x35F40  0x084  || 	endtest4: OUT R31, led_port
(0127)                            || 
(0128)                            || 	;--------------------- Pause 1/2 second ----------------------------------------       
(0129)  CS-0x085  0x361FF         || 		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0130)  CS-0x086  0x2C101  0x086  || 	outside_for4: SUB     R1, 0x01
(0131)                            || 
(0132)  CS-0x087  0x362FF         || 		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0133)  CS-0x088  0x2C201  0x088  || 	middle_for4:  SUB     R2, 0x01
(0134)                            || 	     
(0135)  CS-0x089  0x3635E         || 		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0136)  CS-0x08A  0x2C301  0x08A  || 	inside_for4:  SUB     R3, 0x01
(0137)  CS-0x08B  0x08453         || 		     BRNE    inside_for4
(0138)                            || 		     
(0139)  CS-0x08C  0x22200         || 		     OR      R2, 0x00               ;load flags for middle for counter
(0140)  CS-0x08D  0x08443         || 		     BRNE    middle_for4
(0141)                            || 		     
(0142)  CS-0x08E  0x22100         || 		     OR      R1, 0x00               ;load flags for outsde for counter value
(0143)  CS-0x08F  0x08433         || 		     BRNE    outside_for4
(0144)                            || 	;------------------------------- end Pause -----------------------------------------------	
(0145)                            || 
(0146)                            || 	;--------- test 5 ---------------------------------------------------------------
(0147)                            || 	;this tests multiple pushes with multiple pops
(0148)                            || 	;--------------------------------------------------------------------------------
(0149)  CS-0x090  0x36011         || 	MOV R0, 0x11
(0150)  CS-0x091  0x12001         || 	PUSH R0
(0151)  CS-0x092  0x36022         || 	MOV R0, 0x22
(0152)  CS-0x093  0x12001         || 	PUSH R0
(0153)  CS-0x094  0x36033         || 	MOV R0, 0x33
(0154)  CS-0x095  0x12001         || 	PUSH R0
(0155)  CS-0x096  0x36044         || 	MOV R0, 0x44
(0156)  CS-0x097  0x12001         || 	PUSH R0
(0157)  CS-0x098  0x36055         || 	MOV R0, 0x55
(0158)  CS-0x099  0x12001         || 	PUSH R0
(0159)                            || 
(0160)  CS-0x09A  0x12102         || 	POP R1
(0161)  CS-0x09B  0x30155         || 	CMP R1, 0x55
(0162)  CS-0x09C  0x08553         || 	BRNE endtest5
(0163)  CS-0x09D  0x12102         || 	POP R1
(0164)  CS-0x09E  0x30144         || 	CMP R1, 0x44
(0165)  CS-0x09F  0x08553         || 	BRNE endtest5
(0166)  CS-0x0A0  0x12102         || 	POP R1
(0167)  CS-0x0A1  0x30133         || 	CMP R1, 0x33
(0168)  CS-0x0A2  0x08553         || 	BRNE endtest5
(0169)  CS-0x0A3  0x12102         || 	POP R1
(0170)  CS-0x0A4  0x30122         || 	CMP R1, 0x22
(0171)  CS-0x0A5  0x08553         || 	BRNE endtest5
(0172)  CS-0x0A6  0x12102         || 	POP R1
(0173)  CS-0x0A7  0x30111         || 	CMP R1, 0x11
(0174)  CS-0x0A8  0x08553         || 	BRNE endtest5
(0175)                            || 	
(0176)  CS-0x0A9  0x23F10         || 	OR R31, 0x10
(0177)                            || 	
(0178)  CS-0x0AA  0x35F40  0x0AA  || 	endtest5: OUT R31, led_port
(0179)                            || 
(0180)                            || 	;--------------------- Pause 1/2 second ----------------------------------------       
(0181)  CS-0x0AB  0x361FF         || 		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0182)  CS-0x0AC  0x2C101  0x0AC  || 	outside_for5: SUB     R1, 0x01
(0183)                            || 
(0184)  CS-0x0AD  0x362FF         || 		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0185)  CS-0x0AE  0x2C201  0x0AE  || 	middle_for5:  SUB     R2, 0x01
(0186)                            || 		     
(0187)  CS-0x0AF  0x3635E         || 		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0188)  CS-0x0B0  0x2C301  0x0B0  || 	inside_for5:  SUB     R3, 0x01
(0189)  CS-0x0B1  0x08583         || 		     BRNE    inside_for5
(0190)                            || 		     
(0191)  CS-0x0B2  0x22200         || 		     OR      R2, 0x00               ;load flags for middle for counter
(0192)  CS-0x0B3  0x08573         || 		     BRNE    middle_for5
(0193)                            || 		     
(0194)  CS-0x0B4  0x22100         || 		     OR      R1, 0x00               ;load flags for outsde for counter value
(0195)  CS-0x0B5  0x08563         || 		     BRNE    outside_for5
(0196)                            || 	;------------------------------- end Pause -----------------------------------------------
(0197)                            || 
(0198)                            || 	;--------- test 6 ---------------------------------------------------------------
(0199)                            || 	;this tests a simple function call (call/ret)
(0200)                            || 	;see bottom for all functions
(0201)                            || 	;--------------------------------------------------------------------------------
(0202)  CS-0x0B6  0x086E1         || 	CALL test6Func
(0203)  CS-0x0B7  0x30177         || 	CMP R1, 0x77
(0204)  CS-0x0B8  0x085D3         || 	BRNE endtest6
(0205)  CS-0x0B9  0x23F20         || 	OR R31, 0x20
(0206)                            || 	
(0207)  CS-0x0BA  0x35F40  0x0BA  || 	endtest6: OUT R31, led_port
(0208)                            || 
(0209)                            || 	;--------------------- Pause 1/2 second ----------------------------------------       
(0210)  CS-0x0BB  0x361FF         || 		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0211)  CS-0x0BC  0x2C101  0x0BC  || 	outside_for6: SUB     R1, 0x01
(0212)                            || 
(0213)  CS-0x0BD  0x362FF         || 		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0214)  CS-0x0BE  0x2C201  0x0BE  || 	middle_for6:  SUB     R2, 0x01
(0215)                            || 		     
(0216)  CS-0x0BF  0x3635E         || 		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0217)  CS-0x0C0  0x2C301  0x0C0  || 	inside_for6:  SUB     R3, 0x01
(0218)  CS-0x0C1  0x08603         || 		     BRNE    inside_for6
(0219)                            || 	     
(0220)  CS-0x0C2  0x22200         || 		     OR      R2, 0x00               ;load flags for middle for counter
(0221)  CS-0x0C3  0x085F3         || 		     BRNE    middle_for6
(0222)                            || 	     
(0223)  CS-0x0C4  0x22100         || 		     OR      R1, 0x00               ;load flags for outsde for counter value
(0224)  CS-0x0C5  0x085E3         || 		     BRNE    outside_for6
(0225)                            || 	;------------------------------- end Pause -----------------------------------------------
(0226)                            || 	
(0227)                            || 	;--------- test 7 ---------------------------------------------------------------
(0228)                            || 	;this tests a function which calls another function
(0229)                            || 	;--------------------------------------------------------------------------------
(0230)  CS-0x0C6  0x086F1         || 	CALL test7Func
(0231)  CS-0x0C7  0x30188         || 	CMP R1, 0x88
(0232)  CS-0x0C8  0x08653         || 	BRNE endtest7
(0233)  CS-0x0C9  0x23F40         || 	OR R31, 0x40
(0234)                            || 	
(0235)  CS-0x0CA  0x35F40  0x0CA  || 	endtest7: OUT R31, led_port
(0236)                            || 
(0237)                            || 	;--------------------- Pause 1/2 second ----------------------------------------       
(0238)  CS-0x0CB  0x361FF         || 		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0239)  CS-0x0CC  0x2C101  0x0CC  || 	outside_for7: SUB     R1, 0x01
(0240)                            || 
(0241)  CS-0x0CD  0x362FF         || 		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0242)  CS-0x0CE  0x2C201  0x0CE  || 	middle_for7:  SUB     R2, 0x01
(0243)                            || 		     
(0244)  CS-0x0CF  0x3635E         || 		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0245)  CS-0x0D0  0x2C301  0x0D0  || 	inside_for7:  SUB     R3, 0x01
(0246)  CS-0x0D1  0x08683         || 		     BRNE    inside_for7
(0247)                            || 		     
(0248)  CS-0x0D2  0x22200         || 		     OR      R2, 0x00               ;load flags for middle for counter
(0249)  CS-0x0D3  0x08673         || 		     BRNE    middle_for7
(0250)                            || 		     
(0251)  CS-0x0D4  0x22100         || 		     OR      R1, 0x00               ;load flags for outsde for counter value
(0252)  CS-0x0D5  0x08663         || 		     BRNE    outside_for7
(0253)                            || 	;------------------------------- end Pause -----------------------------------------------
(0254)                            || 
(0255)                            || 	;--------- test 8 ---------------------------------------------------------------
(0256)                            || 	;this tests recursive functions by computing the 10th fibonacci number.
(0257)                            || 	;--------------------------------------------------------------------------------
(0258)  CS-0x0D6  0x08719         || 	CALL test8Func
(0259)  CS-0x0D7  0x30059         || 	CMP R0, 0x59
(0260)  CS-0x0D8  0x086D3         || 	BRNE endtest8
(0261)  CS-0x0D9  0x23F80         || 	OR R31, 0x80
(0262)                            || 	
(0263)  CS-0x0DA  0x35F40  0x0DA  || 	endtest8: OUT R31, led_port
(0264)                            || 
(0265)                            || 	;--------- wait indefinitely ------------------------------------------------------------
(0266)  CS-0x0DB  0x086D8  0x0DB  || 	end: BRN end 
(0267)                            || 
(0268)                            || 	;----------------functions -------------------------------------------------------------------
(0269)  CS-0x0DC  0x36177  0x0DC  || 	test6Func: MOV R1, 0x77
(0270)  CS-0x0DD  0x18002         || 		   RET
(0271)                            || 	
(0272)  CS-0x0DE  0x36130  0x0DE  || 	test7Func: MOV R1, 0x30
(0273)  CS-0x0DF  0x08709         || 		   CALL test7Func2
(0274)  CS-0x0E0  0x18002         || 	           RET
(0275)                            || 	
(0276)  CS-0x0E1  0x36188  0x0E1  || 	test7Func2: MOV R1, 0x88
(0277)  CS-0x0E2  0x18002         || 		    RET
(0278)                            || 	
(0279)  CS-0x0E3  0x36001  0x0E3  || 	test8Func: MOV R0, 0x01
(0280)  CS-0x0E4  0x36101         || 		   MOV R1, 0x01
(0281)  CS-0x0E5  0x3630A         || 		   MOV R3, 0x0A
(0282)  CS-0x0E6  0x08741         || 		   CALL test8Func2
(0283)  CS-0x0E7  0x18002         || 		   RET
(0284)                            || 
(0285)  CS-0x0E8  0x02008  0x0E8  || 	test8Func2: ADD R0,R1
(0286)  CS-0x0E9  0x04409         || 		    MOV R4, R1
(0287)  CS-0x0EA  0x04101         || 		    MOV R1, R0
(0288)  CS-0x0EB  0x04021         || 		    MOV R0, R4
(0289)  CS-0x0EC  0x2C301         || 		    SUB R3, 0x01
(0290)  CS-0x0ED  0x0877A         || 		    BREQ endtest8Func2
(0291)  CS-0x0EE  0x08741         || 		    CALL test8Func2
(0292)  CS-0x0EF  0x18002  0x0EF  || 	endtest8Func2: RET
(0293)                            || 
(0294)                            || 
(0295)                            || 
(0296)                            || 
(0297)                            || 
(0298)                            || 
(0299)                            || 





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
END            0x0DB   (0266)  ||  0266 
ENDTEST1       0x048   (0029)  ||  0026 
ENDTEST2       0x05C   (0062)  ||  0059 
ENDTEST3       0x070   (0094)  ||  0091 
ENDTEST4       0x084   (0126)  ||  0123 
ENDTEST5       0x0AA   (0178)  ||  0162 0165 0168 0171 0174 
ENDTEST6       0x0BA   (0207)  ||  0204 
ENDTEST7       0x0CA   (0235)  ||  0232 
ENDTEST8       0x0DA   (0263)  ||  0260 
ENDTEST8FUNC2  0x0EF   (0292)  ||  0290 
INSIDE_FOR1    0x04E   (0039)  ||  0040 
INSIDE_FOR2    0x062   (0072)  ||  0073 
INSIDE_FOR3    0x076   (0104)  ||  0105 
INSIDE_FOR4    0x08A   (0136)  ||  0137 
INSIDE_FOR5    0x0B0   (0188)  ||  0189 
INSIDE_FOR6    0x0C0   (0217)  ||  0218 
INSIDE_FOR7    0x0D0   (0245)  ||  0246 
MAIN           0x040   (0015)  ||  
MIDDLE_FOR1    0x04C   (0036)  ||  0043 
MIDDLE_FOR2    0x060   (0069)  ||  0076 
MIDDLE_FOR3    0x074   (0101)  ||  0108 
MIDDLE_FOR4    0x088   (0133)  ||  0140 
MIDDLE_FOR5    0x0AE   (0185)  ||  0192 
MIDDLE_FOR6    0x0BE   (0214)  ||  0221 
MIDDLE_FOR7    0x0CE   (0242)  ||  0249 
OUTSIDE_FOR1   0x04A   (0033)  ||  0046 
OUTSIDE_FOR2   0x05E   (0066)  ||  0079 
OUTSIDE_FOR3   0x072   (0098)  ||  0111 
OUTSIDE_FOR4   0x086   (0130)  ||  0143 
OUTSIDE_FOR5   0x0AC   (0182)  ||  0195 
OUTSIDE_FOR6   0x0BC   (0211)  ||  0224 
OUTSIDE_FOR7   0x0CC   (0239)  ||  0252 
TEST6FUNC      0x0DC   (0269)  ||  0202 
TEST7FUNC      0x0DE   (0272)  ||  0230 
TEST7FUNC2     0x0E1   (0276)  ||  0273 
TEST8FUNC      0x0E3   (0279)  ||  0258 
TEST8FUNC2     0x0E8   (0285)  ||  0282 0291 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
LED_PORT       0x040   (0005)  ||  0016 0029 0062 0094 0126 0178 0207 0235 0263 
TIME_INSIDE_FOR_COUNT 0x05E   (0001)  ||  0038 0071 0103 0135 0187 0216 0244 
TIME_MIDDLE_FOR_COUNT 0x0FF   (0002)  ||  0035 0068 0100 0132 0184 0213 0241 
TIME_OUTSIDE_FOR_COUNT 0x0FF   (0003)  ||  0032 0065 0097 0129 0181 0210 0238 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
