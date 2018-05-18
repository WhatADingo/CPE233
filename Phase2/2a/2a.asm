;--------------------------------------------------------------------
;- Port and Memory Constants
---------------------------------------------------------------------
.EQU SWITCH_PORT = 0x20         ; port for switch input  --- INPUT
.EQU LED_PORT = 0x40            ; port for LED output    --- OUTPUT
.EQU INSIDE_FOR_COUNT	= 0xFF	;  
.EQU MIDDLE_FOR_COUNT	= 0xFF	; 
.EQU OUTSIDE_FOR_COUNT	= 0x40	;
.EQU BITMASK01		= 0x01
.EQU BITMASK02		= 0x02
.EQU BITMASK04		= 0x04
.EQU BITMASK08		= 0x08
.EQU BITMASK10		= 0x10
.EQU BITMASK20		= 0x20
.EQU BITMASK40		= 0x40
.EQU BITMASK80		= 0x80
.EQU CMPTEST1		= 0xAA
.EQU CMPTEST2		= 0xA0
.EQU CMPTEST3		= 0xAA
.EQU CMPTEST4		= 0xAF
.EQU CMPTEST5		= 0x55
.EQU CMPTEST6		= 0xFF
.EQU CMPTEST7		= 0xAA
.EQU CMPTEST8		= 0x0F
.DSEG
.ORG	0x00
;--------------------------------------------------------------------
.CSEG
.ORG	0x10

MAIN:		MOV	R0, 0x00
		OUT	R0, LED_PORT
		CALL	PAUSE
		


IMMANDTEST:	MOV	R10, 0xAA
		MOV	R11, 0xA0
		AND	R10, R11
		CMP	R10, CMPTEST2
		CALL	PASS1
		CALL	PAUSE

IMMORTEST:	MOV	R10, 0xA0
		OR	R10, 0x0F
		CMP	R10, CMPTEST4
		CALL	PASS2
		CALL	PAUSE

IMMEXORTEST:	MOV	R10, 0xF0
		EXOR	R10, 0x0F
		CMP	R10, CMPTEST6
		CALL	PASS3
		CALL	PAUSE

IMMRTEST:	MOV	R10, 0xAA
		ROL	R10
		ROR	R10
		CMP	R10, CMPTEST7
		CALL	PASS4
		CALL	PAUSE

IMMATEST:	MOV	R10,0xF0
		ASR	R10
		ASR	R10
		ASR	R10
		ASR	R10
		CMP	R10, CMPTEST8
		CALL	PASS5
		CALL	PAUSE
		BRN 	MAIN
		
Pause:		MOV 	R1, OUTSIDE_FOR_COUNT	;set outside for loop count
outside_for: 	SUB     R1, 0x01
		MOV     R2, MIDDLE_FOR_COUNT	;set middle for loop count
middle_for:	SUB     R2, 0x01
		MOV     R3, INSIDE_FOR_COUNT	;set inside for loop count
inside_for:	SUB     R3, 0x01
		BRNE    inside_for
		OR      R2, 0x00		;load flags for middle for counter
		BRNE    middle_for
		OR      R1, 0x00		;load flags for outsde for counter value
		BRNE    outside_for
		RET	

PASS1:		ADD	R0, BITMASK01
		OUT	R0, LED_PORT
		RET
PASS2:		ADD	R0, BITMASK02
		OUT	R0, LED_PORT
		RET
PASS3:		ADD	R0, BITMASK04
		OUT	R0, LED_PORT
		RET
PASS4:		ADD	R0, BITMASK08
		OUT	R0, LED_PORT
		RET
PASS5:		ADD	R0, 0xF0
		OUT	R0, LED_PORT
		RET

;