;------------------------------------------------
;--- Programmers: Mattics Phi, John Inlow	|
;--- Date: 2.27.11				|
;--- V.1					|
;---						|
;--- Required working instructions:		|
;--- Tests in this order:			|
;--- MOV (Reg/Imm)				|
;--- MOV (Reg/Reg)				|
;--- ST  (Reg/Reg)				|
;--- LD  (Reg/Reg)				|
;--- ST  (Reg/Imm)				|
;--- LD  (Reg/Imm)				|
;------------------------------------------------

.EQU LED_PORT	= 0x40			
.EQU INSIDE_FOR_COUNT	= 0xBA			
.EQU MIDDLE_FOR_COUNT	= 0xBA			
.EQU OUTSIDE_FOR_COUNT	= 0xBA			

.DSEG						
.ORG	0x00					

.CSEG					
.ORG	0x40				

main:		MOV	R31, 0x00


;------------------------------------------------
;--- MOV (Reg/Imm)				|
;------------------------------------------------

mov_imm:	MOV	R10, 0xFF
		CMP	R10, 0xFF
		BRNE	mov_reg
		OR	R31, 0x80
		OUT	R31, LED_PORT

;------------------------------------------------
;--- END MOV					|
;------------------------------------------------



;------------------------------------------------
;--- Delay Loop					|
;------------------------------------------------
		MOV     R1, OUTSIDE_FOR_COUNT
OUTSIDE_FOR1: 	SUB     R1, 0x01

		MOV     R2, MIDDLE_FOR_COUNT
MIDDLE_FOR1:  	SUB     R2, 0x01
             
		MOV     R3, INSIDE_FOR_COUNT
INSIDE_FOR1:  	SUB     R3, 0x01

		BRNE    INSIDE_FOR1
		OR      R2, 0x00

		BRNE    MIDDLE_FOR1
		OR      R1, 0x00

		BRNE    OUTSIDE_FOR1
;------------------------------------------------
;--- End Delay Loop				|
;------------------------------------------------



;------------------------------------------------
;--- MOV (Reg/Reg)				|
;------------------------------------------------

mov_reg:	MOV	R11, R10
		CMP	R11, 0xFF
		BRNE	st_reg
		OR	R31, 0x40
		OUT	R31, LED_PORT

;------------------------------------------------
;--- END MOV					|
;------------------------------------------------



;------------------------------------------------
;--- Delay Loop					|
;------------------------------------------------
		MOV     R1, OUTSIDE_FOR_COUNT
OUTSIDE_FOR2: 	SUB     R1, 0x01

		MOV     R2, MIDDLE_FOR_COUNT
MIDDLE_FOR2:  	SUB     R2, 0x01
             
		MOV     R3, INSIDE_FOR_COUNT
INSIDE_FOR2:  	SUB     R3, 0x01

		BRNE    INSIDE_FOR2
		OR      R2, 0x00

		BRNE    MIDDLE_FOR2
		OR      R1, 0x00

		BRNE    OUTSIDE_FOR2
;------------------------------------------------
;--- End Delay Loop				|
;------------------------------------------------



;------------------------------------------------
;--- ST (Reg/Reg)				|
;------------------------------------------------

st_reg:		MOV	R12, 0x09
		ST	R11, (R12)
		CMP	R12, 0x09
		BRNE	ld_reg
		OR	R31, 0x20
		OUT	R31, LED_PORT

;------------------------------------------------
;--- END ST					|
;------------------------------------------------



;------------------------------------------------
;--- Delay Loop					|
;------------------------------------------------
		MOV     R1, OUTSIDE_FOR_COUNT
OUTSIDE_FOR3: 	SUB     R1, 0x01

		MOV     R2, MIDDLE_FOR_COUNT
MIDDLE_FOR3:  	SUB     R2, 0x01
             
		MOV     R3, INSIDE_FOR_COUNT
INSIDE_FOR3:  	SUB     R3, 0x01

		BRNE    INSIDE_FOR3
		OR      R2, 0x00

		BRNE    MIDDLE_FOR3
		OR      R1, 0x00

		BRNE    OUTSIDE_FOR3
;------------------------------------------------
;--- End Delay Loop				|
;------------------------------------------------



;------------------------------------------------
;--- LD (Reg/Reg)				|
;------------------------------------------------

ld_reg:		LD	R13, (R12)
		CMP	R13, 0xFF
		BRNE	st_ld_imm
		OR	R31, 0x10
		OUT	R31, LED_PORT

;------------------------------------------------
;--- END LD					|
;------------------------------------------------



;------------------------------------------------
;--- Delay Loop					|
;------------------------------------------------
		MOV     R1, OUTSIDE_FOR_COUNT
OUTSIDE_FOR4: 	SUB     R1, 0x01

		MOV     R2, MIDDLE_FOR_COUNT
MIDDLE_FOR4:  	SUB     R2, 0x01
             
		MOV     R3, INSIDE_FOR_COUNT
INSIDE_FOR4:  	SUB     R3, 0x01

		BRNE    INSIDE_FOR4
		OR      R2, 0x00

		BRNE    MIDDLE_FOR4
		OR      R1, 0x00

		BRNE    OUTSIDE_FOR4
;------------------------------------------------
;--- End Delay Loop				|
;------------------------------------------------



;------------------------------------------------
;--- LD/ST (Reg/Imm)				|
;------------------------------------------------

st_ld_imm:	ST	R11, 0x10
		LD	R14, 0x10
		CMP	R14, 0xFF
		BRNE	fail
		OR	R31, 0x0F
		OUT	R31, LED_PORT

;------------------------------------------------
;--- END LD					|
;------------------------------------------------



;------------------------------------------------
;--- Delay Loop					|
;------------------------------------------------
		MOV     R1, OUTSIDE_FOR_COUNT
OUTSIDE_FOR5: 	SUB     R1, 0x01

		MOV     R2, MIDDLE_FOR_COUNT
MIDDLE_FOR5:  	SUB     R2, 0x01
             
		MOV     R3, INSIDE_FOR_COUNT
INSIDE_FOR5:  	SUB     R3, 0x01

		BRNE    INSIDE_FOR5
		OR      R2, 0x00

		BRNE    MIDDLE_FOR5
		OR      R1, 0x00

		BRNE    OUTSIDE_FOR5
;------------------------------------------------
;--- End Delay Loop				|
;------------------------------------------------


fail:		BRN	main;