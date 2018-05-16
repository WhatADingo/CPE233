;------------------------------------------------------------------------------------------------------
.EQU LED_PORT		=   	0X40		;port for LED outputs
.EQU SWITCH_PORT	=   	0X20		;port for switch inputs
;------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------
; - Other Constants
;------------------------------------------------------------------------------------------------------
.EQU BIT_0_MASK = 0X01
.EQU BIT_1_MASK = 0X02
.EQU BIT_2_MASK = 0X04
.EQU BIT_3_MASK = 0X08
.EQU BIT_4_MASK = 0X10
.EQU BIT_5_MASK = 0X20
.EQU BIT_6_MASK = 0X40
.EQU BIT_7_MASK = 0X80

.EQU INSIDE_FOR_COUNT    = 0x01
.EQU MIDDLE_FOR_COUNT    = 0x01
.EQU OUTSIDE_FOR_COUNT   = 0x01

;------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------
; - Memory Designation Constants
;------------------------------------------------------------------------------------------------------
;- .DESG
;- .ORG	0x00
;------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------
;- Main Program - FIVE DIFFERENT TEST CASES
;------------------------------------------------------------------------------------------------------

.CSEG
.ORG		0x40

INIT:		MOV 	R20,	0x00	;output register
			MOV 	R10, 	0x00	;used to set carry flag
			MOV 	R11, 	0x01	;used to set carry flag
			MOV 	R1, 	0x0F	;used for logic operations
			MOV 	R2, 	0xAA	;used for logic operations

;---------------------------------------------------------------
timedelay0:    	MOV     R17, OUTSIDE_FOR_COUNT  
outside_for0: 	SUB     R17, 0x01

             	MOV     R18, MIDDLE_FOR_COUNT   
middle_for0:  	SUB     R18, 0x01
             
             	MOV     R19, INSIDE_FOR_COUNT   
inside_for0:  	SUB     R19, 0x01
             	BRNE    inside_for0
             
             	OR      R18, 0x00              
             	BRNE    middle_for0
             
             	OR      R17, 0x00               
             	BRNE    outside_for0

;---------------------------------------------------------------
ANDTest: 		MOV 	R3, R1
			AND 	R3, R2
			CMP 	R3, 0x0A
			BRNE 	timedelay1

			OR 	R20,  BIT_0_MASK
			OUT 	R20, LED_PORT


timedelay1:    	MOV     R17, OUTSIDE_FOR_COUNT  
outside_for1: 	SUB     R17, 0x01

             	MOV     R18, MIDDLE_FOR_COUNT   
middle_for1:  	SUB     R18, 0x01
             
             	MOV     R19, INSIDE_FOR_COUNT   
inside_for1:  	SUB     R19, 0x01
             	BRNE    inside_for1
             
             	OR      R18, 0x00              
             	BRNE    middle_for1
             
             	OR      R17, 0x00               
             	BRNE    outside_for1

;---------------------------------------------------------------
ORTest:			MOV 	R4, R1
			OR 	R4, R2
			CMP 	R4, 0XAF
			BRNE 	timedelay2

			OR 	R20, BIT_1_MASK
			OUT 	R20, LED_PORT

timedelay2:    	MOV     R17, OUTSIDE_FOR_COUNT  
outside_for2: 	SUB     R17, 0x01

             	MOV     R18, MIDDLE_FOR_COUNT   
middle_for2:  	SUB     R18, 0x01
             
             	MOV     R19, INSIDE_FOR_COUNT   
inside_for2:  	SUB     R19, 0x01
             	BRNE    inside_for2
             
             	OR      R18, 0x00              
             	BRNE    middle_for2
             
             	OR      R17, 0x00               
             	BRNE    outside_for2

;---------------------------------------------------------------
EXORTest:		MOV 	R5, R1
			EXOR 	R5, R2
			CMP 	R5, 0XA5
			BRNE 	timedelay3

			OR 	R20,  BIT_2_MASK
			OUT 	R20, LED_PORT

timedelay3:    	MOV     R17, OUTSIDE_FOR_COUNT  
outside_for3: 	SUB     R17, 0x01

             	MOV     R18, MIDDLE_FOR_COUNT   
middle_for3:  	SUB     R18, 0x01
             
             	MOV     R19, INSIDE_FOR_COUNT   
inside_for3:  	SUB     R19, 0x01
             	BRNE    inside_for3
             
             	OR      R18, 0x00              
             	BRNE    middle_for3
             
             	OR      R17, 0x00               
             	BRNE    outside_for3

;---------------------------------------------------------------
LSLTest:		MOV 	R6, R1
			CMP	R10, R11
			LSL 	R6
			CMP 	R6, 0X1F
			BRNE 	timedelay4

			OR 	R20,  BIT_3_MASK
			OUT 	R20, LED_PORT

timedelay4:    	MOV     R17, OUTSIDE_FOR_COUNT  
outside_for4: 	SUB     R17, 0x01

             	MOV     R18, MIDDLE_FOR_COUNT   
middle_for4:  	SUB     R18, 0x01
             
             	MOV     R19, INSIDE_FOR_COUNT   
inside_for4:  	SUB     R19, 0x01
             	BRNE    inside_for4
             
             	OR      R18, 0x00              
             	BRNE    middle_for4
             
             	OR      R17, 0x00               
             	BRNE    outside_for4

;---------------------------------------------------------------
LSRTest:		MOV 	R7, R1
			CMP	R10, R11
			LSR 	R7
			CMP 	R7, 0X87
			BRNE 	timedelay5

			OR 	R20,  BIT_4_MASK
			OUT 	R20, LED_PORT

timedelay5:    	MOV     R17, OUTSIDE_FOR_COUNT  
outside_for5: 	SUB     R17, 0x01

             	MOV     R18, MIDDLE_FOR_COUNT   
middle_for5:  	SUB     R18, 0x01
             
             	MOV     R19, INSIDE_FOR_COUNT   
inside_for5:  	SUB     R19, 0x01
             	BRNE    inside_for5
             
             	OR      R18, 0x00              
             	BRNE    middle_for5
             
             	OR      R17, 0x00               
             	BRNE    outside_for5

;---------------------------------------------------------------
LightLEDs:		OR	R20, 0xE0
				OUT R20, LED_PORT

;---------------------------------------------------------------
endless_loop:	MOV R31, 0x00
				BRN	endless_loop
