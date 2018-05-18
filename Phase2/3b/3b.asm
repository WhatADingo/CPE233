.EQU LOOP_COUNT	= 0xFF
.EQU LOOP_COUNT_IN = 0X5E
;---------------------------------------------
;- Port Constants
;--------------------------------------------------------------------
.EQU LED_PORT    = 0x40         ; port for LED output --- OUTOUT
;--------------------------------------------------------------------
.CSEG
.ORG	0X40




;Test of the first branch, LD7		

main:		MOV R1, 0X00
		ADD R1, 0X01
		BRN pause1
		SUB R1, 0X01

		


pause1:		OUT R1, LED_PORT
		MOV R9, LOOP_COUNT
outLoop1:	MOV R10, LOOP_COUNT
		SUB R9, 0X01
midLoop1:	MOV R11, LOOP_COUNT_IN
		SUB R10, 0X01
inLoop1:	SUB R11, 0X01
		BRNE inLoop1
		OR R10, 0X00
		BRNE midLoop1
		OR R9, 0X00
		BRNE outLoop1

;Second Test for Branch if EQ LD6

test2:		ADD R1, 0X02
		MOV R4, 0X77
		CMP R4, 0X77
		BREQ pause2
		SUB R1, 0X02

pause2:		OUT R1, LED_PORT
		MOV R9, LOOP_COUNT
outLoop2:	MOV R10, LOOP_COUNT
		SUB R9, 0X01
midLoop2:	MOV R11, LOOP_COUNT_IN
		SUB R10, 0X01
inLoop2:	SUB R11, 0X01
		BRNE inLoop2
		OR R10, 0X00
		BRNE midLoop2
		OR R9, 0X00
		BRNE outLoop2
		

;Third Test for Branch if Not EQ LD5
		
		ADD R1, 0X04
		MOV R4, 0X77
		CMP R4, 0X66
		BRNE pause3
		SUB R1, 0X04

pause3:		OUT R1, LED_PORT
		MOV R9, LOOP_COUNT
outLoop3:	MOV R10, LOOP_COUNT
		SUB R9, 0X01
midLoop3:	MOV R11, LOOP_COUNT_IN
		SUB R10, 0X01
inLoop3:	SUB R11, 0X01
		BRNE inLoop3
		OR R10, 0X00
		BRNE midLoop3
		OR R9, 0X00
		BRNE outLoop3

;Fourth Test for Direct Branch LD4

		ADD R1, 0X08
		BRN pause4
		SUB R1, 0X08
		
pause4:		OUT R1, LED_PORT
		MOV R9, LOOP_COUNT
outLoop4:	MOV R10, LOOP_COUNT
		SUB R9, 0X01
midLoop4:	MOV R11, LOOP_COUNT_IN
		SUB R10, 0X01
inLoop4:	SUB R11, 0X01
		BRNE inLoop4
		OR R10, 0X00
		BRNE midLoop4
		OR R9, 0X00
		BRNE outLoop4

;Fifth Test for Branch if Carry Set LD3

		ADD R1, 0X10
		MOV R4, 0XFF
		ADD R4, 0X55
		BRCS pause5
		SUB R1, 0X10

pause5:		OUT R1, LED_PORT
		MOV R9, LOOP_COUNT
outLoop5:	MOV R10, LOOP_COUNT
		SUB R9, 0X01
midLoop5:	MOV R11, LOOP_COUNT_IN
		SUB R10, 0X01
inLoop5:	SUB R11, 0X01
		BRNE inLoop5
		OR R10, 0X00
		BRNE midLoop5
		OR R9, 0X00
		BRNE outLoop5

;Sixth Test for Branch if Carry Cleared LD2
		
		ADD R1, 0X20
		MOV R4, 0X77
		ADD R4, 0X11
		BRCC pause6
		SUB R1, 0X20

pause6:		OUT R1, LED_PORT
		MOV R9, LOOP_COUNT
outLoop6:	MOV R10, LOOP_COUNT
		SUB R9, 0X01
midLoop6:	MOV R11, LOOP_COUNT_IN
		SUB R10, 0X01
inLoop6:	SUB R11, 0X01
		BRNE inLoop6
		OR R10, 0X00
		BRNE midLoop6
		OR R9, 0X00
		BRNE outLoop6

;Seventh Test for CLEAR CARRY

		ADD R1, 0X40
		MOV R4, 0XFF
		ADD R4, 0XFF
		CLC
		BRCC pause7
		SUB R1, 0X40

pause7:		OUT R1, LED_PORT
		MOV R9, LOOP_COUNT
outLoop7:	MOV R10, LOOP_COUNT
		SUB R9, 0X01
midLoop7:	MOV R11, LOOP_COUNT_IN
		SUB R10, 0X01
inLoop7:	SUB R11, 0X01
		BRNE inLoop7
		OR R10, 0X00
		BRNE midLoop7
		OR R9, 0X00
		BRNE outLoop7

;Eigth and final test for SET CARRY
		
		ADD R1, 0X80
		MOV R4, 0XFF
		SUB R4, 0X11
		SEC
		BRCS pause8
		SUB R1, 0X80
		BRN pause8

pause8:		OUT R1, LED_PORT
		MOV R9, LOOP_COUNT
outLoop8:	MOV R10, LOOP_COUNT
		SUB R9, 0X01
midLoop8:	MOV R11, LOOP_COUNT_IN
		SUB R10, 0X01
inLoop8:	SUB R11, 0X01
		BRNE inLoop8
		OR R10, 0X00
		BRNE midLoop8
		OR R9, 0X00
		BRNE outLoop8





final:
		OUT R1, LED_PORT
		BRN final








