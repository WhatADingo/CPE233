.EQU time_INSIDE_FOR_COUNT    = 0x5E
.EQU time_MIDDLE_FOR_COUNT    = 0xFF
.EQU time_OUTSIDE_FOR_COUNT   = 0xFF

;assumes 7 seg decoder is on port 81, buttons on FF, and leds on 80
.EQU led_port = 0x40
.EQU seg_port = 0x81
.EQU BUTTONS   = 0XFF

.EQU BIT0 = 0X01
.EQU BIT1 = 0X02
.EQU BIT2 = 0X04
.EQU BIT3 = 0X08
.EQU BIT4 = 0X10
.EQU BIT5 = 0X20
.EQU BIT6 = 0X40
.EQU BIT7 = 0X80

.CSEG
.ORG 0x01

MOV R30, 0x01
OUT R30, seg_port

Test1: ;-------------------------------------------------------------------------------------
	MOV		R20,	0x00
	MOV 	R10, 	0x00
	MOV 	R11, 	0x01
	MOV 	R1, 	0x0F
	MOV 	R2, 	0xAA

	MOV 	R3, R1
	AND 	R3, R2
	CMP 	R3, 0x0A
	BRNE 	endtest11
	OR 	R20,  BIT0
	endtest11: OUT 	R20, LED_PORT

	CALL pause
	
	MOV 	R4, R1
	OR 		R4, R2
	CMP 	R4, 0XAF
	BRNE 	endtest12
	OR 	R20, BIT1
	endtest12: OUT 	R20, LED_PORT

	CALL pause

	MOV 	R5, R1
	EXOR 	R5, R2
	CMP 	R5, 0XA5
	BRNE 	endtest13
	OR 	R20,  BIT2
	endtest13: OUT 	R20, LED_PORT
	
	CALL pause
	
	MOV 	R6, R1
	CMP	R10, R11
	LSL 	R6
	CMP 	R6, 0X1F
	BRNE 	endtest14
	OR 	R20,  BIT3
	endtest14: OUT 	R20, LED_PORT

	CALL pause

	MOV 	R7, R1
	CMP	R10, R11
	LSR 	R7
	CMP 	R7, 0X87
	BRNE 	endtest15
	OR 	R20,  BIT4
	endtest15: OUT 	R20, LED_PORT

	CALL pause
	
	OR	R20, 0xE0
	OUT 	R20, LED_PORT

CALL nextTest

Test2: ;-------------------------------------------------------------------------------------

	Mov  R31,0x00

	Mov  R10,0x35
	AND  R10,0xDB
	CMP  R10, 0x11
	BRNE endtest21
	OR   R31,0x01
	endtest21: OUT  R31,LED_PORT

	CALL pause
	
	Mov  R10,0x55
	OR   R10,0xAA
	CMP  R10,0xFF
	BRNE endtest22
	OR   R31,0x02
	endtest22: OUT  R31,LED_PORT ;pass OR
	
	Call pause

	Mov  R10,0xAB
	EXOR  R10,0x54
	CMP  R10,0xFF
	BRNE endtest23
	OR   R31,0x04
	endtest23: OUT  R31,LED_PORT ;pass XOR
	
	Call pause
	
	Mov  R10,0x7F
	ROL  R10
	CMP  R10,0xFE
	BRNE endtest24
	OR   R31,0x08
	endtest24: OUT  R31,LED_PORT ;pass ROL

	Call pause
	
	Mov  R10,0xFE
	ROR  R10
	CMP  R10,0x7F
	BRNE endtest25
	OR   R31,0x10
	endtest25: OUT  R31,LED_PORT ;pass ROR

	Call pause

	Mov  R10,0xBE
	ASR  R10
	CMP  R10,0xDF
	BRNE endtest26
	OR   R31,0xE0
	endtest26: OUT  R31,LED_PORT ;pass ASR

CALL nextTest

Test3: ;--------------------------------------------------------------------------------------
	MOV R1, 0X00

	test31: ADD R1, 0X01
	CALL pause
	MOV R4, 0X77
	CMP R4, 0X77
	BREQ test32
	SUB R1, 0X01
	BRN test32

	test32: OUT R1, led_port
	ADD R1, 0X02
	CALL pause
	CMP R4, 0X66
	BRNE test33
	SUB R1, 0X02
	BRN test33

	test33: OUT R1, led_port
	ADD R1, 0X04
	CALL pause
	BRN test34
	SUB R1, 0X04
	BRN test34

	test34: OUT R1, led_port
	ADD R1, 0X08
	CALL pause
	MOV R4, 0XFF
	ADD R4, 0X55
	BRCS test35
	SUB R1, 0X08
	BRN test35

	test35: OUT R1, led_port
	ADD R1, 0X10
	CALL pause
	MOV R4, 0X77
	ADD R4, 0X11
	BRCC test36
	SUB R1, 0X10
	BRN test36

	test36: OUT R1, led_port
	ADD R1, 0X20
	CALL pause
	ADD R4, 0XFF
	CLC
	BRCC test37
	SUB R1, 0X20
	BRN test37
	
	test37: OUT R1, led_port
	ADD R1, 0X40
	CALL pause
	SUB R4, 0X11
	SEC
	BRCS final3
	SUB R1, 0X40
	BRN final3

	final3: 
	ADD R1, 0X80
	OUT R1, led_port

CALL nextTest	

Test4: 	;-------------------------------------------------------------------------------------
	MOV R31, 0x00
	OUT R31, led_port
	
	MOV R0, 0x50
	PUSH R0
	LD R1, 0xFF
	CMP R1, 0x50
	BRNE endtest41
	OR R31, 0x01
	endtest41: OUT R31, led_port

	CALL pause

	MOV R1, 0xD1
	WSP R1
	MOV R0, 0x11
	PUSH R0
	LD R1, 0xD0
	CMP R1, 0x11
	BRNE endtest42
	OR R31, 0x02
	endtest42: OUT R31, led_port

	CALL pause

	MOV R1, 0xFF
	WSP R1
	MOV R0, 0x22
	ST R0, 0xFF
	POP R1
	CMP R1, 0x22
	BRNE endtest43
	OR R31, 0x04
	endtest43: OUT R31, led_port

	CALL pause

	MOV R1, 0x00
	WSP R1
	MOV R0, 0x42
	PUSH R0
	POP R1
	CMP R1, 0x42
	BRNE endtest44
	OR R31, 0x08
	endtest44: OUT R31, led_port

	CALL pause

	MOV R0, 0x11
	PUSH R0
	MOV R0, 0x22
	PUSH R0
	MOV R0, 0x33
	PUSH R0
	MOV R0, 0x44
	PUSH R0
	MOV R0, 0x55
	PUSH R0
	POP R1
	CMP R1, 0x55
	BRNE endtest45
	POP R1
	CMP R1, 0x44
	BRNE endtest45
	POP R1
	CMP R1, 0x33
	BRNE endtest45
	POP R1
	CMP R1, 0x22
	BRNE endtest45
	POP R1
	CMP R1, 0x11
	BRNE endtest45
	OR R31, 0x10
	endtest45: OUT R31, led_port

	CALL pause

	CALL test6Func
	CMP R1, 0x77
	BRNE endtest46
	OR R31, 0x20
	endtest46: OUT R31, led_port
	
	CALL pause
	
	CALL test7Func
	CMP R1, 0x88
	BRNE endtest47
	OR R31, 0x40
	endtest47: OUT R31, led_port

	CALL pause

	CALL test8Func
	CMP R0, 0x59
	BRNE endtest48
	OR R31, 0x80
	endtest48: OUT R31, led_port

	CALL nextTest

Test5: ;------------------------------------------------------------------------------------------
	MOV R20, 0x00

	MOV R10, 0x01
	CMP R10, 0x01
	BRNE endtest51
	OR R20, 0x01
	endtest51: OUT R20, LED_PORT

	CALL pause

	MOV R11, R10
	CMP R11, 0x01
	BRNE endtest52
	OR R20, 0x02
	endtest52: OUT R20, LED_PORT

	CALL pause

	ST R10, (R11)		
	LD R12, (R11)
	CMP R12, 0x01
	BRNE endtest53
	OR R20, 0x04
	endtest53: OUT R20, LED_PORT

	CALL pause
	
	ST R10, 0x02
	MOV R21, 0x02
	LD R13, (R21)
	CMP R13, 0x01
	BRNE endtest54
	OR R20, 0x08
	endtest54: OUT R20, LED_PORT

	CALL pause

	MOV R22, 0x03
	ST R10, (R22)		
	LD R14, 0x03		
	CMP R14, 0x01
	BRNE endtest55
	OR R20, 0x10
	endtest55: OUT R20, LED_PORT

	CALL pause

	ST R10, 0x04
	LD R15, 0x04		
	CMP R12, 0x01
	BRNE endtest56
	OR R20, 0xE0
	endtest56: OUT R20, LED_PORT

CALL nextTest

Test6: ;-----------------------------------------------------------------------------------------
	MOV R1,0x00      ; register 1 is used to hold the status of the operations completed
	MOV R4,0x00      ; register 4 is used to hold the bit locator/updater
	OR  R4,0x01
	MOV R2,0x01
	ADD R2,0x02
	CMP R2,0x03
	BRNE endtest61         ; if correct, go to correct section
	OR R1,R4         ; update the status bit -- this lights up led 1 only
	endtest61: OUT  R1, led_port
	
	CALL pause

	OR   R4,0x02     ; change the bit updater value so that the next bit will be updated
	SEC              ; set carry to 1
	ADDC R2,0x03
	CMP  R2,0x07
	BRNE endtest62
	OR R1, R4
	endtest62: OUT R1, led_port
	
	CALL pause

	OR  R4,0x04
	SUB R2,0x02
	CMP R2,0x05
	BRNE endtest63
	OR R1, R4
	endtest63: OUT R1, led_port

	CALL pause

	OR  R4,0x08
	SEC
	SUBC R2,0x03
	CMP  R2,0x01
	BRNE endtest64
	OR R1, R4
	OR R1, 0xF0
	endtest64: OUT R1, led_port

CALL nextTest

Test7: ;----------------------------------------------------------------------------------------
	MOV R10,0x05 
	MOV R11,0x04
	ADD R10,R11	 ;5+4=9
	MOV R12,0x09
	CMP R12,R10
	BRNE endtest71
	OR R15, BIT0
	endtest71: OUT R15, led_port

	CALL pause

	SEC		     ;set carry to 1
	MOV R10,0x05 
	MOV R11,0x04
	ADDC R10,R11        ;5+4+1=10
	MOV R12,0x0A
	CMP R12,R10
	BRNE endtest72
	OR R15, BIT1
	endtest72: OUT R15, led_port
	
	CALL pause
	
	MOV R10,0x05
	MOV R11,0x04
	SUB R10,R11         ;5-4=1
	MOV R12,0x01
	CMP R12,R10
	BRNE endtest73
	OR R15, BIT2
	endtest73: OUT R15, led_port

	CALL pause
	
	SEC
	MOV R10,0x05
	MOV R11,0x02
	SUBC R10,R11        ;5-2-1 = 2
	MOV R12,0x02
	CMP R12,R10
	BRNE endtest74
	OR R15, BIT3
	OR R15, BIT4
	OR R15, BIT5
	OR R15, BIT6
	OR R15, BIT7
	endtest74: OUT R15, led_port

;--------- wait indefinitely ------------------------------------------------------------
end: BRN end 

;----------------functions -------------------------------------------------------------------
test6Func: MOV R1, 0x77
	   RET

test7Func: MOV R1, 0x30
	   CALL test7Func2
		   RET

test7Func2: MOV R1, 0x88
		RET

test8Func: MOV R0, 0x01
	   MOV R1, 0x01
	   MOV R3, 0x0A
	   CALL test8Func2
	   RET

test8Func2: ADD R0,R1
		MOV R4, R1
		MOV R1, R0
		MOV R0, R4
		SUB R3, 0x01
		BREQ endtest8Func2
		CALL test8Func2
endtest8Func2: RET

 
pause:	     MOV     R29, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for: SUB     R29, 0x01

			 MOV     R28, time_MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for: SUB     R28, 0x01
			 
			 MOV     R27, time_INSIDE_FOR_COUNT   ;set inside for loop count
inside_for: SUB     R27, 0x01
			 BRNE    inside_for
			 
			 OR      R28, 0x00               ;load flags for middle for counter
			 BRNE    middle_for
			 
			 OR      R29, 0x00               ;load flags for outsde for counter value
			 BRNE    outside_for
			 RET

nextTest:
	CALL pause
	CALL pause

	MOV R31, 0x00
	OUT R31, led_port

	ADD R30, 0x01
	OUT R30, seg_port

	CALL pause
RET




