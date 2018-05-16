;- Test Info: ----------------------------------------------------------|
;- Programmers: Kevin Brewer and Kyle Patterson                       	|
;- Date: 02-27-2011						      	|
;- Version: 1							      	|
;-----------------------------------------------------------------------|
;- Test Cases:							      	|
;-								      	|
;- Test1:   Tests AND(reg/reg)         lights up LED0 (rightmost LED) 	|
;- Test2:   Tests OR(reg/reg)          lights up LED1		      	|
;- Test3:   Tests EXOR(reg/reg)        lights up LED2		      	|
;- Test4:   Tests LSL(reg)             lights up LED3		      	|
;- Test5:   Tests LSR(reg)             lights up LED4 through LED7    	|
;-----------------------------------------------------------------------|
;- Results:							      	|
;-									|
;- Each successful test results in an LED lighting up. A failed test	|
;- results in an unlit LED. The LEDs light up in sequential order 	|
;- starting with LED0 for the first test through LED7 for the last 	|
;- test.  If all tests pass all eight LEDs on the board should be lit.	|
;- There will be a half second delay between each test.			|
;-----------------------------------------------------------------------|
;- Registers of Interest:						|
;-									|
;- R1, R2, and R3:  Used in loops that causes half second delay		|
;- R10 and R11:	    Used for testing AND, OR, EXOR, LSL, and LSR	|
;- R31:		    Used with LEDs to show which tests passed		|
;-----------------------------------------------------------------------|


;- Port Constants: -----------------------------------------------------|
.EQU LED_PORT = 0x40	; switch and button ports not needed for tests	|
;-----------------------------------------------------------------------|

;- Looping Constants: --------------------------------------------------|
.EQU INSIDE_FOR_COUNT    = 0xBA ;
.EQU MIDDLE_FOR_COUNT    = 0xBA ;
.EQU OUTSIDE_FOR_COUNT   = 0xBA ;
;-----------------------------------------------------------------------|

.DSEG
.ORG         0x00  
.CSEG
.ORG         0x40


   
main_loop:	MOV	R31, 0x00	; Initialize LEDs to all unlit

Test1:	 	MOV 	R10, 0xD6	; 11010110
		MOV 	R11, 0x55	; 01010101
		AND 	R10, R11	; 01010100 = 0x54
		CMP 	R10, 0x54 	; If AND works, Z = 1
		BRNE 	Test2;		; If Z = 1, no branch
		OR 	R31, 0x01
		OUT 	R31, LED_PORT	; LED0 lit


;-HOLD-DELAY-1-----------------------------------------------------------
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
;-END-HOLD---------------------------------------------------------------


Test2:		MOV 	R10, 0xD6	; 11010110
		MOV 	R11, 0x55	; 01010101
		OR 	R10, R11	; 11010111 = 0xD7
                CMP 	R10, 0xD7	; If OR works, Z = 1
		BRNE 	Test3;		; If Z = 1, no branch
		OR	R31, 0x02
		OUT	R31, LED_PORT	; LED1 lit


;-HOLD-DELAY-2-----------------------------------------------------------
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
;-END-HOLD---------------------------------------------------------------


Test3:		MOV 	R10, 0xD6	; 11010110
		MOV 	R11, 0x55	; 01010101
		EXOR 	R10, R11	; 10000011 = 0x83
                CMP 	R10, 0x83	; If OR works, Z = 1
		BRNE 	Test4;		; If Z = 1, no branch
		OR	R31, 0x04
		OUT	R31, LED_PORT	; LED3 lit


;-HOLD-DELAY-3-----------------------------------------------------------
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
;-END-HOLD---------------------------------------------------------------


Test4:		MOV 	R10, 0xD6	; 11010110 - Also no R11 needed
		SEC			; Set C = 1
		LSL 	R10		; 10101101 = 0xAD
                CMP 	R10, 0xAD	; If OR works, Z = 1
		BRNE 	Test5;		; If Z = 1, no branch
		OR	R31, 0x08
		OUT	R31, LED_PORT	; LED1 lit


;-HOLD-DELAY-4-----------------------------------------------------------
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
;-END-HOLD---------------------------------------------------------------


Test5:		MOV 	R10, 0xD6	; 11010110 - Also no R11 needed
		SEC			; Set C = 1
		LSR 	R10		; 11101011 = 0xEB
                CMP 	R10, 0xEB	; If OR works, Z = 1
		BRNE 	DONE;		; If Z = 1, no branch
		OR	R31, 0xF0
		OUT	R31, LED_PORT	; LED7-LED4 lit


;-HOLD-DELAY-5-----------------------------------------------------------
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
;-END-HOLD---------------------------------------------------------------


DONE:		OUT R31, LED_PORT
		BRN DONE
;