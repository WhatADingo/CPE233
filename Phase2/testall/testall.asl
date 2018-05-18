

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
(0005)                            || ;assumes 7 seg decoder is on port 81, buttons on FF, and leds on 80
(0006)                       064  || .EQU led_port = 0x40
(0007)                       129  || .EQU seg_port = 0x81
(0008)                       255  || .EQU BUTTONS   = 0XFF
(0009)                            || 
(0010)                       001  || .EQU BIT0 = 0X01
(0011)                       002  || .EQU BIT1 = 0X02
(0012)                       004  || .EQU BIT2 = 0X04
(0013)                       008  || .EQU BIT3 = 0X08
(0014)                       016  || .EQU BIT4 = 0X10
(0015)                       032  || .EQU BIT5 = 0X20
(0016)                       064  || .EQU BIT6 = 0X40
(0017)                       128  || .EQU BIT7 = 0X80
(0018)                            || 
(0019)                            || .CSEG
(0020)                       001  || .ORG 0x01
(0021)                            || 
(0022)  CS-0x001  0x37E01         || MOV R30, 0x01
(0023)  CS-0x002  0x35E81         || OUT R30, seg_port
(0024)                            || 
(0025)                     0x003  || Test1: ;-------------------------------------------------------------------------------------
(0026)  CS-0x003  0x37400         || 	MOV		R20,	0x00
(0027)  CS-0x004  0x36A00         || 	MOV 	R10, 	0x00
(0028)  CS-0x005  0x36B01         || 	MOV 	R11, 	0x01
(0029)  CS-0x006  0x3610F         || 	MOV 	R1, 	0x0F
(0030)  CS-0x007  0x362AA         || 	MOV 	R2, 	0xAA
(0031)                            || 
(0032)  CS-0x008  0x04309         || 	MOV 	R3, R1
(0033)  CS-0x009  0x00310         || 	AND 	R3, R2
(0034)  CS-0x00A  0x3030A         || 	CMP 	R3, 0x0A
(0035)  CS-0x00B  0x0806B         || 	BRNE 	endtest11
(0036)  CS-0x00C  0x23401         || 	OR 	R20,  BIT0
(0037)  CS-0x00D  0x35440  0x00D  || 	endtest11: OUT 	R20, LED_PORT
(0038)                            || 
(0039)  CS-0x00E  0x08BA1         || 	CALL pause
(0040)                            || 	
(0041)  CS-0x00F  0x04409         || 	MOV 	R4, R1
(0042)  CS-0x010  0x00411         || 	OR 		R4, R2
(0043)  CS-0x011  0x304AF         || 	CMP 	R4, 0XAF
(0044)  CS-0x012  0x080A3         || 	BRNE 	endtest12
(0045)  CS-0x013  0x23402         || 	OR 	R20, BIT1
(0046)  CS-0x014  0x35440  0x014  || 	endtest12: OUT 	R20, LED_PORT
(0047)                            || 
(0048)  CS-0x015  0x08BA1         || 	CALL pause
(0049)                            || 
(0050)  CS-0x016  0x04509         || 	MOV 	R5, R1
(0051)  CS-0x017  0x00512         || 	EXOR 	R5, R2
(0052)  CS-0x018  0x305A5         || 	CMP 	R5, 0XA5
(0053)  CS-0x019  0x080DB         || 	BRNE 	endtest13
(0054)  CS-0x01A  0x23404         || 	OR 	R20,  BIT2
(0055)  CS-0x01B  0x35440  0x01B  || 	endtest13: OUT 	R20, LED_PORT
(0056)                            || 	
(0057)  CS-0x01C  0x08BA1         || 	CALL pause
(0058)                            || 	
(0059)  CS-0x01D  0x04609         || 	MOV 	R6, R1
(0060)  CS-0x01E  0x04A58         || 	CMP	R10, R11
(0061)  CS-0x01F  0x10600         || 	LSL 	R6
(0062)  CS-0x020  0x3061F         || 	CMP 	R6, 0X1F
(0063)  CS-0x021  0x0811B         || 	BRNE 	endtest14
(0064)  CS-0x022  0x23408         || 	OR 	R20,  BIT3
(0065)  CS-0x023  0x35440  0x023  || 	endtest14: OUT 	R20, LED_PORT
(0066)                            || 
(0067)  CS-0x024  0x08BA1         || 	CALL pause
(0068)                            || 
(0069)  CS-0x025  0x04709         || 	MOV 	R7, R1
(0070)  CS-0x026  0x04A58         || 	CMP	R10, R11
(0071)  CS-0x027  0x10701         || 	LSR 	R7
(0072)  CS-0x028  0x30787         || 	CMP 	R7, 0X87
(0073)  CS-0x029  0x0815B         || 	BRNE 	endtest15
(0074)  CS-0x02A  0x23410         || 	OR 	R20,  BIT4
(0075)  CS-0x02B  0x35440  0x02B  || 	endtest15: OUT 	R20, LED_PORT
(0076)                            || 
(0077)  CS-0x02C  0x08BA1         || 	CALL pause
(0078)                            || 	
(0079)  CS-0x02D  0x234E0         || 	OR	R20, 0xE0
(0080)  CS-0x02E  0x35440         || 	OUT 	R20, LED_PORT
(0081)                            || 
(0082)  CS-0x02F  0x08C01         || CALL nextTest
(0083)                            || 
(0084)                     0x030  || Test2: ;-------------------------------------------------------------------------------------
(0085)                            || 
(0086)  CS-0x030  0x37F00         || 	Mov  R31,0x00
(0087)                            || 
(0088)  CS-0x031  0x36A35         || 	Mov  R10,0x35
(0089)  CS-0x032  0x20ADB         || 	AND  R10,0xDB
(0090)  CS-0x033  0x30A11         || 	CMP  R10, 0x11
(0091)  CS-0x034  0x081B3         || 	BRNE endtest21
(0092)  CS-0x035  0x23F01         || 	OR   R31,0x01
(0093)  CS-0x036  0x35F40  0x036  || 	endtest21: OUT  R31,LED_PORT
(0094)                            || 
(0095)  CS-0x037  0x08BA1         || 	CALL pause
(0096)                            || 	
(0097)  CS-0x038  0x36A55         || 	Mov  R10,0x55
(0098)  CS-0x039  0x22AAA         || 	OR   R10,0xAA
(0099)  CS-0x03A  0x30AFF         || 	CMP  R10,0xFF
(0100)  CS-0x03B  0x081EB         || 	BRNE endtest22
(0101)  CS-0x03C  0x23F02         || 	OR   R31,0x02
(0102)  CS-0x03D  0x35F40  0x03D  || 	endtest22: OUT  R31,LED_PORT ;pass OR
(0103)                            || 	
(0104)  CS-0x03E  0x08BA1         || 	Call pause
(0105)                            || 
(0106)  CS-0x03F  0x36AAB         || 	Mov  R10,0xAB
(0107)  CS-0x040  0x24A54         || 	EXOR  R10,0x54
(0108)  CS-0x041  0x30AFF         || 	CMP  R10,0xFF
(0109)  CS-0x042  0x08223         || 	BRNE endtest23
(0110)  CS-0x043  0x23F04         || 	OR   R31,0x04
(0111)  CS-0x044  0x35F40  0x044  || 	endtest23: OUT  R31,LED_PORT ;pass XOR
(0112)                            || 	
(0113)  CS-0x045  0x08BA1         || 	Call pause
(0114)                            || 	
(0115)  CS-0x046  0x36A7F         || 	Mov  R10,0x7F
(0116)  CS-0x047  0x10A02         || 	ROL  R10
(0117)  CS-0x048  0x30AFE         || 	CMP  R10,0xFE
(0118)  CS-0x049  0x0825B         || 	BRNE endtest24
(0119)  CS-0x04A  0x23F08         || 	OR   R31,0x08
(0120)  CS-0x04B  0x35F40  0x04B  || 	endtest24: OUT  R31,LED_PORT ;pass ROL
(0121)                            || 
(0122)  CS-0x04C  0x08BA1         || 	Call pause
(0123)                            || 	
(0124)  CS-0x04D  0x36AFE         || 	Mov  R10,0xFE
(0125)  CS-0x04E  0x10A03         || 	ROR  R10
(0126)  CS-0x04F  0x30A7F         || 	CMP  R10,0x7F
(0127)  CS-0x050  0x08293         || 	BRNE endtest25
(0128)  CS-0x051  0x23F10         || 	OR   R31,0x10
(0129)  CS-0x052  0x35F40  0x052  || 	endtest25: OUT  R31,LED_PORT ;pass ROR
(0130)                            || 
(0131)  CS-0x053  0x08BA1         || 	Call pause
(0132)                            || 
(0133)  CS-0x054  0x36ABE         || 	Mov  R10,0xBE
(0134)  CS-0x055  0x12A00         || 	ASR  R10
(0135)  CS-0x056  0x30ADF         || 	CMP  R10,0xDF
(0136)  CS-0x057  0x082CB         || 	BRNE endtest26
(0137)  CS-0x058  0x23FE0         || 	OR   R31,0xE0
(0138)  CS-0x059  0x35F40  0x059  || 	endtest26: OUT  R31,LED_PORT ;pass ASR
(0139)                            || 
(0140)  CS-0x05A  0x08C01         || CALL nextTest
(0141)                            || 
(0142)                     0x05B  || Test3: ;--------------------------------------------------------------------------------------
(0143)  CS-0x05B  0x36100         || 	MOV R1, 0X00
(0144)                            || 
(0145)  CS-0x05C  0x28101  0x05C  || 	test31: ADD R1, 0X01
(0146)  CS-0x05D  0x08BA1         || 	CALL pause
(0147)  CS-0x05E  0x36477         || 	MOV R4, 0X77
(0148)  CS-0x05F  0x30477         || 	CMP R4, 0X77
(0149)  CS-0x060  0x0831A         || 	BREQ test32
(0150)  CS-0x061  0x2C101         || 	SUB R1, 0X01
(0151)  CS-0x062  0x08318         || 	BRN test32
(0152)                            || 
(0153)  CS-0x063  0x34140  0x063  || 	test32: OUT R1, led_port
(0154)  CS-0x064  0x28102         || 	ADD R1, 0X02
(0155)  CS-0x065  0x08BA1         || 	CALL pause
(0156)  CS-0x066  0x30466         || 	CMP R4, 0X66
(0157)  CS-0x067  0x08353         || 	BRNE test33
(0158)  CS-0x068  0x2C102         || 	SUB R1, 0X02
(0159)  CS-0x069  0x08350         || 	BRN test33
(0160)                            || 
(0161)  CS-0x06A  0x34140  0x06A  || 	test33: OUT R1, led_port
(0162)  CS-0x06B  0x28104         || 	ADD R1, 0X04
(0163)  CS-0x06C  0x08BA1         || 	CALL pause
(0164)  CS-0x06D  0x08380         || 	BRN test34
(0165)  CS-0x06E  0x2C104         || 	SUB R1, 0X04
(0166)  CS-0x06F  0x08380         || 	BRN test34
(0167)                            || 
(0168)  CS-0x070  0x34140  0x070  || 	test34: OUT R1, led_port
(0169)  CS-0x071  0x28108         || 	ADD R1, 0X08
(0170)  CS-0x072  0x08BA1         || 	CALL pause
(0171)  CS-0x073  0x364FF         || 	MOV R4, 0XFF
(0172)  CS-0x074  0x28455         || 	ADD R4, 0X55
(0173)  CS-0x075  0x0A3C0         || 	BRCS test35
(0174)  CS-0x076  0x2C108         || 	SUB R1, 0X08
(0175)  CS-0x077  0x083C0         || 	BRN test35
(0176)                            || 
(0177)  CS-0x078  0x34140  0x078  || 	test35: OUT R1, led_port
(0178)  CS-0x079  0x28110         || 	ADD R1, 0X10
(0179)  CS-0x07A  0x08BA1         || 	CALL pause
(0180)  CS-0x07B  0x36477         || 	MOV R4, 0X77
(0181)  CS-0x07C  0x28411         || 	ADD R4, 0X11
(0182)  CS-0x07D  0x0A401         || 	BRCC test36
(0183)  CS-0x07E  0x2C110         || 	SUB R1, 0X10
(0184)  CS-0x07F  0x08400         || 	BRN test36
(0185)                            || 
(0186)  CS-0x080  0x34140  0x080  || 	test36: OUT R1, led_port
(0187)  CS-0x081  0x28120         || 	ADD R1, 0X20
(0188)  CS-0x082  0x08BA1         || 	CALL pause
(0189)  CS-0x083  0x284FF         || 	ADD R4, 0XFF
(0190)  CS-0x084  0x18000         || 	CLC
(0191)  CS-0x085  0x0A441         || 	BRCC test37
(0192)  CS-0x086  0x2C120         || 	SUB R1, 0X20
(0193)  CS-0x087  0x08440         || 	BRN test37
(0194)                            || 	
(0195)  CS-0x088  0x34140  0x088  || 	test37: OUT R1, led_port
(0196)  CS-0x089  0x28140         || 	ADD R1, 0X40
(0197)  CS-0x08A  0x08BA1         || 	CALL pause
(0198)  CS-0x08B  0x2C411         || 	SUB R4, 0X11
(0199)  CS-0x08C  0x18001         || 	SEC
(0200)  CS-0x08D  0x0A480         || 	BRCS final3
(0201)  CS-0x08E  0x2C140         || 	SUB R1, 0X40
(0202)  CS-0x08F  0x08480         || 	BRN final3
(0203)                            || 
(0204)                     0x090  || 	final3: 
(0205)  CS-0x090  0x28180         || 	ADD R1, 0X80
(0206)  CS-0x091  0x34140         || 	OUT R1, led_port
(0207)                            || 
(0208)  CS-0x092  0x08C01         || CALL nextTest	
(0209)                            || 
(0210)                     0x093  || Test4: 	;-------------------------------------------------------------------------------------
(0211)  CS-0x093  0x37F00         || 	MOV R31, 0x00
(0212)  CS-0x094  0x35F40         || 	OUT R31, led_port
(0213)                            || 	
(0214)  CS-0x095  0x36050         || 	MOV R0, 0x50
(0215)  CS-0x096  0x12001         || 	PUSH R0
(0216)  CS-0x097  0x381FF         || 	LD R1, 0xFF
(0217)  CS-0x098  0x30150         || 	CMP R1, 0x50
(0218)  CS-0x099  0x084DB         || 	BRNE endtest41
(0219)  CS-0x09A  0x23F01         || 	OR R31, 0x01
(0220)  CS-0x09B  0x35F40  0x09B  || 	endtest41: OUT R31, led_port
(0221)                            || 
(0222)  CS-0x09C  0x08BA1         || 	CALL pause
(0223)                            || 
(0224)  CS-0x09D  0x361D1         || 	MOV R1, 0xD1
(0225)  CS-0x09E  0x14100         || 	WSP R1
(0226)  CS-0x09F  0x36011         || 	MOV R0, 0x11
(0227)  CS-0x0A0  0x12001         || 	PUSH R0
(0228)  CS-0x0A1  0x381D0         || 	LD R1, 0xD0
(0229)  CS-0x0A2  0x30111         || 	CMP R1, 0x11
(0230)  CS-0x0A3  0x0852B         || 	BRNE endtest42
(0231)  CS-0x0A4  0x23F02         || 	OR R31, 0x02
(0232)  CS-0x0A5  0x35F40  0x0A5  || 	endtest42: OUT R31, led_port
(0233)                            || 
(0234)  CS-0x0A6  0x08BA1         || 	CALL pause
(0235)                            || 
(0236)  CS-0x0A7  0x361FF         || 	MOV R1, 0xFF
(0237)  CS-0x0A8  0x14100         || 	WSP R1
(0238)  CS-0x0A9  0x36022         || 	MOV R0, 0x22
(0239)  CS-0x0AA  0x3A0FF         || 	ST R0, 0xFF
(0240)  CS-0x0AB  0x12102         || 	POP R1
(0241)  CS-0x0AC  0x30122         || 	CMP R1, 0x22
(0242)  CS-0x0AD  0x0857B         || 	BRNE endtest43
(0243)  CS-0x0AE  0x23F04         || 	OR R31, 0x04
(0244)  CS-0x0AF  0x35F40  0x0AF  || 	endtest43: OUT R31, led_port
(0245)                            || 
(0246)  CS-0x0B0  0x08BA1         || 	CALL pause
(0247)                            || 
(0248)  CS-0x0B1  0x36100         || 	MOV R1, 0x00
(0249)  CS-0x0B2  0x14100         || 	WSP R1
(0250)  CS-0x0B3  0x36042         || 	MOV R0, 0x42
(0251)  CS-0x0B4  0x12001         || 	PUSH R0
(0252)  CS-0x0B5  0x12102         || 	POP R1
(0253)  CS-0x0B6  0x30142         || 	CMP R1, 0x42
(0254)  CS-0x0B7  0x085CB         || 	BRNE endtest44
(0255)  CS-0x0B8  0x23F08         || 	OR R31, 0x08
(0256)  CS-0x0B9  0x35F40  0x0B9  || 	endtest44: OUT R31, led_port
(0257)                            || 
(0258)  CS-0x0BA  0x08BA1         || 	CALL pause
(0259)                            || 
(0260)  CS-0x0BB  0x36011         || 	MOV R0, 0x11
(0261)  CS-0x0BC  0x12001         || 	PUSH R0
(0262)  CS-0x0BD  0x36022         || 	MOV R0, 0x22
(0263)  CS-0x0BE  0x12001         || 	PUSH R0
(0264)  CS-0x0BF  0x36033         || 	MOV R0, 0x33
(0265)  CS-0x0C0  0x12001         || 	PUSH R0
(0266)  CS-0x0C1  0x36044         || 	MOV R0, 0x44
(0267)  CS-0x0C2  0x12001         || 	PUSH R0
(0268)  CS-0x0C3  0x36055         || 	MOV R0, 0x55
(0269)  CS-0x0C4  0x12001         || 	PUSH R0
(0270)  CS-0x0C5  0x12102         || 	POP R1
(0271)  CS-0x0C6  0x30155         || 	CMP R1, 0x55
(0272)  CS-0x0C7  0x086AB         || 	BRNE endtest45
(0273)  CS-0x0C8  0x12102         || 	POP R1
(0274)  CS-0x0C9  0x30144         || 	CMP R1, 0x44
(0275)  CS-0x0CA  0x086AB         || 	BRNE endtest45
(0276)  CS-0x0CB  0x12102         || 	POP R1
(0277)  CS-0x0CC  0x30133         || 	CMP R1, 0x33
(0278)  CS-0x0CD  0x086AB         || 	BRNE endtest45
(0279)  CS-0x0CE  0x12102         || 	POP R1
(0280)  CS-0x0CF  0x30122         || 	CMP R1, 0x22
(0281)  CS-0x0D0  0x086AB         || 	BRNE endtest45
(0282)  CS-0x0D1  0x12102         || 	POP R1
(0283)  CS-0x0D2  0x30111         || 	CMP R1, 0x11
(0284)  CS-0x0D3  0x086AB         || 	BRNE endtest45
(0285)  CS-0x0D4  0x23F10         || 	OR R31, 0x10
(0286)  CS-0x0D5  0x35F40  0x0D5  || 	endtest45: OUT R31, led_port
(0287)                            || 
(0288)  CS-0x0D6  0x08BA1         || 	CALL pause
(0289)                            || 
(0290)  CS-0x0D7  0x08B01         || 	CALL test6Func
(0291)  CS-0x0D8  0x30177         || 	CMP R1, 0x77
(0292)  CS-0x0D9  0x086DB         || 	BRNE endtest46
(0293)  CS-0x0DA  0x23F20         || 	OR R31, 0x20
(0294)  CS-0x0DB  0x35F40  0x0DB  || 	endtest46: OUT R31, led_port
(0295)                            || 	
(0296)  CS-0x0DC  0x08BA1         || 	CALL pause
(0297)                            || 	
(0298)  CS-0x0DD  0x08B11         || 	CALL test7Func
(0299)  CS-0x0DE  0x30188         || 	CMP R1, 0x88
(0300)  CS-0x0DF  0x0870B         || 	BRNE endtest47
(0301)  CS-0x0E0  0x23F40         || 	OR R31, 0x40
(0302)  CS-0x0E1  0x35F40  0x0E1  || 	endtest47: OUT R31, led_port
(0303)                            || 
(0304)  CS-0x0E2  0x08BA1         || 	CALL pause
(0305)                            || 
(0306)  CS-0x0E3  0x08B39         || 	CALL test8Func
(0307)  CS-0x0E4  0x30059         || 	CMP R0, 0x59
(0308)  CS-0x0E5  0x0873B         || 	BRNE endtest48
(0309)  CS-0x0E6  0x23F80         || 	OR R31, 0x80
(0310)  CS-0x0E7  0x35F40  0x0E7  || 	endtest48: OUT R31, led_port
(0311)                            || 
(0312)  CS-0x0E8  0x08C01         || 	CALL nextTest
(0313)                            || 
(0314)                     0x0E9  || Test5: ;------------------------------------------------------------------------------------------
(0315)  CS-0x0E9  0x37400         || 	MOV R20, 0x00
(0316)                            || 
(0317)  CS-0x0EA  0x36A01         || 	MOV R10, 0x01
(0318)  CS-0x0EB  0x30A01         || 	CMP R10, 0x01
(0319)  CS-0x0EC  0x08773         || 	BRNE endtest51
(0320)  CS-0x0ED  0x23401         || 	OR R20, 0x01
(0321)  CS-0x0EE  0x35440  0x0EE  || 	endtest51: OUT R20, LED_PORT
(0322)                            || 
(0323)  CS-0x0EF  0x08BA1         || 	CALL pause
(0324)                            || 
(0325)  CS-0x0F0  0x04B51         || 	MOV R11, R10
(0326)  CS-0x0F1  0x30B01         || 	CMP R11, 0x01
(0327)  CS-0x0F2  0x087A3         || 	BRNE endtest52
(0328)  CS-0x0F3  0x23402         || 	OR R20, 0x02
(0329)  CS-0x0F4  0x35440  0x0F4  || 	endtest52: OUT R20, LED_PORT
(0330)                            || 
(0331)  CS-0x0F5  0x08BA1         || 	CALL pause
(0332)                            || 
(0333)  CS-0x0F6  0x04A5B         || 	ST R10, (R11)		
(0334)  CS-0x0F7  0x04C5A         || 	LD R12, (R11)
(0335)  CS-0x0F8  0x30C01         || 	CMP R12, 0x01
(0336)  CS-0x0F9  0x087DB         || 	BRNE endtest53
(0337)  CS-0x0FA  0x23404         || 	OR R20, 0x04
(0338)  CS-0x0FB  0x35440  0x0FB  || 	endtest53: OUT R20, LED_PORT
(0339)                            || 
(0340)  CS-0x0FC  0x08BA1         || 	CALL pause
(0341)                            || 	
(0342)  CS-0x0FD  0x3AA02         || 	ST R10, 0x02
(0343)  CS-0x0FE  0x37502         || 	MOV R21, 0x02
(0344)  CS-0x0FF  0x04DAA         || 	LD R13, (R21)
(0345)  CS-0x100  0x30D01         || 	CMP R13, 0x01
(0346)  CS-0x101  0x0881B         || 	BRNE endtest54
(0347)  CS-0x102  0x23408         || 	OR R20, 0x08
(0348)  CS-0x103  0x35440  0x103  || 	endtest54: OUT R20, LED_PORT
(0349)                            || 
(0350)  CS-0x104  0x08BA1         || 	CALL pause
(0351)                            || 
(0352)  CS-0x105  0x37603         || 	MOV R22, 0x03
(0353)  CS-0x106  0x04AB3         || 	ST R10, (R22)		
(0354)  CS-0x107  0x38E03         || 	LD R14, 0x03		
(0355)  CS-0x108  0x30E01         || 	CMP R14, 0x01
(0356)  CS-0x109  0x0885B         || 	BRNE endtest55
(0357)  CS-0x10A  0x23410         || 	OR R20, 0x10
(0358)  CS-0x10B  0x35440  0x10B  || 	endtest55: OUT R20, LED_PORT
(0359)                            || 
(0360)  CS-0x10C  0x08BA1         || 	CALL pause
(0361)                            || 
(0362)  CS-0x10D  0x3AA04         || 	ST R10, 0x04
(0363)  CS-0x10E  0x38F04         || 	LD R15, 0x04		
(0364)  CS-0x10F  0x30C01         || 	CMP R12, 0x01
(0365)  CS-0x110  0x08893         || 	BRNE endtest56
(0366)  CS-0x111  0x234E0         || 	OR R20, 0xE0
(0367)  CS-0x112  0x35440  0x112  || 	endtest56: OUT R20, LED_PORT
(0368)                            || 
(0369)  CS-0x113  0x08C01         || CALL nextTest
(0370)                            || 
(0371)                     0x114  || Test6: ;-----------------------------------------------------------------------------------------
(0372)  CS-0x114  0x36100         || 	MOV R1,0x00      ; register 1 is used to hold the status of the operations completed
(0373)  CS-0x115  0x36400         || 	MOV R4,0x00      ; register 4 is used to hold the bit locator/updater
(0374)  CS-0x116  0x22401         || 	OR  R4,0x01
(0375)  CS-0x117  0x36201         || 	MOV R2,0x01
(0376)  CS-0x118  0x28202         || 	ADD R2,0x02
(0377)  CS-0x119  0x30203         || 	CMP R2,0x03
(0378)  CS-0x11A  0x088E3         || 	BRNE endtest61         ; if correct, go to correct section
(0379)  CS-0x11B  0x00121         || 	OR R1,R4         ; update the status bit -- this lights up led 1 only
(0380)  CS-0x11C  0x34140  0x11C  || 	endtest61: OUT  R1, led_port
(0381)                            || 	
(0382)  CS-0x11D  0x08BA1         || 	CALL pause
(0383)                            || 
(0384)  CS-0x11E  0x22402         || 	OR   R4,0x02     ; change the bit updater value so that the next bit will be updated
(0385)  CS-0x11F  0x18001         || 	SEC              ; set carry to 1
(0386)  CS-0x120  0x2A203         || 	ADDC R2,0x03
(0387)  CS-0x121  0x30207         || 	CMP  R2,0x07
(0388)  CS-0x122  0x08923         || 	BRNE endtest62
(0389)  CS-0x123  0x00121         || 	OR R1, R4
(0390)  CS-0x124  0x34140  0x124  || 	endtest62: OUT R1, led_port
(0391)                            || 	
(0392)  CS-0x125  0x08BA1         || 	CALL pause
(0393)                            || 
(0394)  CS-0x126  0x22404         || 	OR  R4,0x04
(0395)  CS-0x127  0x2C202         || 	SUB R2,0x02
(0396)  CS-0x128  0x30205         || 	CMP R2,0x05
(0397)  CS-0x129  0x0895B         || 	BRNE endtest63
(0398)  CS-0x12A  0x00121         || 	OR R1, R4
(0399)  CS-0x12B  0x34140  0x12B  || 	endtest63: OUT R1, led_port
(0400)                            || 
(0401)  CS-0x12C  0x08BA1         || 	CALL pause
(0402)                            || 
(0403)  CS-0x12D  0x22408         || 	OR  R4,0x08
(0404)  CS-0x12E  0x18001         || 	SEC
(0405)  CS-0x12F  0x2E203         || 	SUBC R2,0x03
(0406)  CS-0x130  0x30201         || 	CMP  R2,0x01
(0407)  CS-0x131  0x089A3         || 	BRNE endtest64
(0408)  CS-0x132  0x00121         || 	OR R1, R4
(0409)  CS-0x133  0x221F0         || 	OR R1, 0xF0
(0410)  CS-0x134  0x34140  0x134  || 	endtest64: OUT R1, led_port
(0411)                            || 
(0412)  CS-0x135  0x08C01         || CALL nextTest
(0413)                            || 
(0414)                     0x136  || Test7: ;----------------------------------------------------------------------------------------
(0415)  CS-0x136  0x36A05         || 	MOV R10,0x05 
(0416)  CS-0x137  0x36B04         || 	MOV R11,0x04
(0417)  CS-0x138  0x02A58         || 	ADD R10,R11	 ;5+4=9
(0418)  CS-0x139  0x36C09         || 	MOV R12,0x09
(0419)  CS-0x13A  0x04C50         || 	CMP R12,R10
(0420)  CS-0x13B  0x089EB         || 	BRNE endtest71
(0421)  CS-0x13C  0x22F01         || 	OR R15, BIT0
(0422)  CS-0x13D  0x34F40  0x13D  || 	endtest71: OUT R15, led_port
(0423)                            || 
(0424)  CS-0x13E  0x08BA1         || 	CALL pause
(0425)                            || 
(0426)  CS-0x13F  0x18001         || 	SEC		     ;set carry to 1
(0427)  CS-0x140  0x36A05         || 	MOV R10,0x05 
(0428)  CS-0x141  0x36B04         || 	MOV R11,0x04
(0429)  CS-0x142  0x02A59         || 	ADDC R10,R11        ;5+4+1=10
(0430)  CS-0x143  0x36C0A         || 	MOV R12,0x0A
(0431)  CS-0x144  0x04C50         || 	CMP R12,R10
(0432)  CS-0x145  0x08A3B         || 	BRNE endtest72
(0433)  CS-0x146  0x22F02         || 	OR R15, BIT1
(0434)  CS-0x147  0x34F40  0x147  || 	endtest72: OUT R15, led_port
(0435)                            || 	
(0436)  CS-0x148  0x08BA1         || 	CALL pause
(0437)                            || 	
(0438)  CS-0x149  0x36A05         || 	MOV R10,0x05
(0439)  CS-0x14A  0x36B04         || 	MOV R11,0x04
(0440)  CS-0x14B  0x02A5A         || 	SUB R10,R11         ;5-4=1
(0441)  CS-0x14C  0x36C01         || 	MOV R12,0x01
(0442)  CS-0x14D  0x04C50         || 	CMP R12,R10
(0443)  CS-0x14E  0x08A83         || 	BRNE endtest73
(0444)  CS-0x14F  0x22F04         || 	OR R15, BIT2
(0445)  CS-0x150  0x34F40  0x150  || 	endtest73: OUT R15, led_port
(0446)                            || 
(0447)  CS-0x151  0x08BA1         || 	CALL pause
(0448)                            || 	
(0449)  CS-0x152  0x18001         || 	SEC
(0450)  CS-0x153  0x36A05         || 	MOV R10,0x05
(0451)  CS-0x154  0x36B02         || 	MOV R11,0x02
(0452)  CS-0x155  0x02A5B         || 	SUBC R10,R11        ;5-2-1 = 2
(0453)  CS-0x156  0x36C02         || 	MOV R12,0x02
(0454)  CS-0x157  0x04C50         || 	CMP R12,R10
(0455)  CS-0x158  0x08AF3         || 	BRNE endtest74
(0456)  CS-0x159  0x22F08         || 	OR R15, BIT3
(0457)  CS-0x15A  0x22F10         || 	OR R15, BIT4
(0458)  CS-0x15B  0x22F20         || 	OR R15, BIT5
(0459)  CS-0x15C  0x22F40         || 	OR R15, BIT6
(0460)  CS-0x15D  0x22F80         || 	OR R15, BIT7
(0461)  CS-0x15E  0x34F40  0x15E  || 	endtest74: OUT R15, led_port
(0462)                            || 
(0463)                            || ;--------- wait indefinitely ------------------------------------------------------------
(0464)  CS-0x15F  0x08AF8  0x15F  || end: BRN end 
(0465)                            || 
(0466)                            || ;----------------functions -------------------------------------------------------------------
(0467)  CS-0x160  0x36177  0x160  || test6Func: MOV R1, 0x77
(0468)  CS-0x161  0x18002         || 	   RET
(0469)                            || 
(0470)  CS-0x162  0x36130  0x162  || test7Func: MOV R1, 0x30
(0471)  CS-0x163  0x08B29         || 	   CALL test7Func2
(0472)  CS-0x164  0x18002         || 		   RET
(0473)                            || 
(0474)  CS-0x165  0x36188  0x165  || test7Func2: MOV R1, 0x88
(0475)  CS-0x166  0x18002         || 		RET
(0476)                            || 
(0477)  CS-0x167  0x36001  0x167  || test8Func: MOV R0, 0x01
(0478)  CS-0x168  0x36101         || 	   MOV R1, 0x01
(0479)  CS-0x169  0x3630A         || 	   MOV R3, 0x0A
(0480)  CS-0x16A  0x08B61         || 	   CALL test8Func2
(0481)  CS-0x16B  0x18002         || 	   RET
(0482)                            || 
(0483)  CS-0x16C  0x02008  0x16C  || test8Func2: ADD R0,R1
(0484)  CS-0x16D  0x04409         || 		MOV R4, R1
(0485)  CS-0x16E  0x04101         || 		MOV R1, R0
(0486)  CS-0x16F  0x04021         || 		MOV R0, R4
(0487)  CS-0x170  0x2C301         || 		SUB R3, 0x01
(0488)  CS-0x171  0x08B9A         || 		BREQ endtest8Func2
(0489)  CS-0x172  0x08B61         || 		CALL test8Func2
(0490)  CS-0x173  0x18002  0x173  || endtest8Func2: RET
(0491)                            || 
(0492)                            ||  
(0493)  CS-0x174  0x37DFF  0x174  || pause:	     MOV     R29, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0494)  CS-0x175  0x2DD01  0x175  || outside_for: SUB     R29, 0x01
(0495)                            || 
(0496)  CS-0x176  0x37CFF         || 			 MOV     R28, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0497)  CS-0x177  0x2DC01  0x177  || middle_for: SUB     R28, 0x01
(0498)                            || 			 
(0499)  CS-0x178  0x37B5E         || 			 MOV     R27, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0500)  CS-0x179  0x2DB01  0x179  || inside_for: SUB     R27, 0x01
(0501)  CS-0x17A  0x08BCB         || 			 BRNE    inside_for
(0502)                            || 			 
(0503)  CS-0x17B  0x23C00         || 			 OR      R28, 0x00               ;load flags for middle for counter
(0504)  CS-0x17C  0x08BBB         || 			 BRNE    middle_for
(0505)                            || 			 
(0506)  CS-0x17D  0x23D00         || 			 OR      R29, 0x00               ;load flags for outsde for counter value
(0507)  CS-0x17E  0x08BAB         || 			 BRNE    outside_for
(0508)  CS-0x17F  0x18002         || 			 RET
(0509)                            || 
(0510)                     0x180  || nextTest:
(0511)  CS-0x180  0x08BA1         || 	CALL pause
(0512)  CS-0x181  0x08BA1         || 	CALL pause
(0513)                            || 
(0514)  CS-0x182  0x37F00         || 	MOV R31, 0x00
(0515)  CS-0x183  0x35F40         || 	OUT R31, led_port
(0516)                            || 
(0517)  CS-0x184  0x29E01         || 	ADD R30, 0x01
(0518)  CS-0x185  0x35E81         || 	OUT R30, seg_port
(0519)                            || 
(0520)  CS-0x186  0x08BA1         || 	CALL pause
(0521)  CS-0x187  0x18002         || RET
(0522)                            || 
(0523)                            || 
(0524)                            || 
(0525)                            || 





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
END            0x15F   (0464)  ||  0464 
ENDTEST11      0x00D   (0037)  ||  0035 
ENDTEST12      0x014   (0046)  ||  0044 
ENDTEST13      0x01B   (0055)  ||  0053 
ENDTEST14      0x023   (0065)  ||  0063 
ENDTEST15      0x02B   (0075)  ||  0073 
ENDTEST21      0x036   (0093)  ||  0091 
ENDTEST22      0x03D   (0102)  ||  0100 
ENDTEST23      0x044   (0111)  ||  0109 
ENDTEST24      0x04B   (0120)  ||  0118 
ENDTEST25      0x052   (0129)  ||  0127 
ENDTEST26      0x059   (0138)  ||  0136 
ENDTEST41      0x09B   (0220)  ||  0218 
ENDTEST42      0x0A5   (0232)  ||  0230 
ENDTEST43      0x0AF   (0244)  ||  0242 
ENDTEST44      0x0B9   (0256)  ||  0254 
ENDTEST45      0x0D5   (0286)  ||  0272 0275 0278 0281 0284 
ENDTEST46      0x0DB   (0294)  ||  0292 
ENDTEST47      0x0E1   (0302)  ||  0300 
ENDTEST48      0x0E7   (0310)  ||  0308 
ENDTEST51      0x0EE   (0321)  ||  0319 
ENDTEST52      0x0F4   (0329)  ||  0327 
ENDTEST53      0x0FB   (0338)  ||  0336 
ENDTEST54      0x103   (0348)  ||  0346 
ENDTEST55      0x10B   (0358)  ||  0356 
ENDTEST56      0x112   (0367)  ||  0365 
ENDTEST61      0x11C   (0380)  ||  0378 
ENDTEST62      0x124   (0390)  ||  0388 
ENDTEST63      0x12B   (0399)  ||  0397 
ENDTEST64      0x134   (0410)  ||  0407 
ENDTEST71      0x13D   (0422)  ||  0420 
ENDTEST72      0x147   (0434)  ||  0432 
ENDTEST73      0x150   (0445)  ||  0443 
ENDTEST74      0x15E   (0461)  ||  0455 
ENDTEST8FUNC2  0x173   (0490)  ||  0488 
FINAL3         0x090   (0204)  ||  0200 0202 
INSIDE_FOR     0x179   (0500)  ||  0501 
MIDDLE_FOR     0x177   (0497)  ||  0504 
NEXTTEST       0x180   (0510)  ||  0082 0140 0208 0312 0369 0412 
OUTSIDE_FOR    0x175   (0494)  ||  0507 
PAUSE          0x174   (0493)  ||  0039 0048 0057 0067 0077 0095 0104 0113 0122 0131 
                               ||  0146 0155 0163 0170 0179 0188 0197 0222 0234 0246 
                               ||  0258 0288 0296 0304 0323 0331 0340 0350 0360 0382 
                               ||  0392 0401 0424 0436 0447 0511 0512 0520 
TEST1          0x003   (0025)  ||  
TEST2          0x030   (0084)  ||  
TEST3          0x05B   (0142)  ||  
TEST31         0x05C   (0145)  ||  
TEST32         0x063   (0153)  ||  0149 0151 
TEST33         0x06A   (0161)  ||  0157 0159 
TEST34         0x070   (0168)  ||  0164 0166 
TEST35         0x078   (0177)  ||  0173 0175 
TEST36         0x080   (0186)  ||  0182 0184 
TEST37         0x088   (0195)  ||  0191 0193 
TEST4          0x093   (0210)  ||  
TEST5          0x0E9   (0314)  ||  
TEST6          0x114   (0371)  ||  
TEST6FUNC      0x160   (0467)  ||  0290 
TEST7          0x136   (0414)  ||  
TEST7FUNC      0x162   (0470)  ||  0298 
TEST7FUNC2     0x165   (0474)  ||  0471 
TEST8FUNC      0x167   (0477)  ||  0306 
TEST8FUNC2     0x16C   (0483)  ||  0480 0489 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BIT0           0x001   (0010)  ||  0036 0421 
BIT1           0x002   (0011)  ||  0045 0433 
BIT2           0x004   (0012)  ||  0054 0444 
BIT3           0x008   (0013)  ||  0064 0456 
BIT4           0x010   (0014)  ||  0074 0457 
BIT5           0x020   (0015)  ||  0458 
BIT6           0x040   (0016)  ||  0459 
BIT7           0x080   (0017)  ||  0460 
BUTTONS        0x0FF   (0008)  ||  
LED_PORT       0x040   (0006)  ||  0037 0046 0055 0065 0075 0080 0093 0102 0111 0120 
                               ||  0129 0138 0153 0161 0168 0177 0186 0195 0206 0212 
                               ||  0220 0232 0244 0256 0286 0294 0302 0310 0321 0329 
                               ||  0338 0348 0358 0367 0380 0390 0399 0410 0422 0434 
                               ||  0445 0461 0515 
SEG_PORT       0x081   (0007)  ||  0023 0518 
TIME_INSIDE_FOR_COUNT 0x05E   (0001)  ||  0499 
TIME_MIDDLE_FOR_COUNT 0x0FF   (0002)  ||  0496 
TIME_OUTSIDE_FOR_COUNT 0x0FF   (0003)  ||  0493 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
