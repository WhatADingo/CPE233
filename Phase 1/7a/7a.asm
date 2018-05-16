;-------------------------------------------------------------------- 
;- Programmers: Scott Leonard & Errol Leon
;- Date: 02-27-2011
;- Version: 1
;- Test Case: 7
;- 
;- TEST 1:	ADD
;- TEST 2:	ADDC
;- TEST 3:	SUB
;- TEST 4:	SUBC
;- 
;- LED output set to R15.
;- Tests will run then LED will continuously output results
;-------------------------------------------------------------------- 

;--------------------------------------------------------------------
;- Port Constants
;--------------------------------------------------------------------
.EQU SWITCH_PORT = 0x20         ; port for switches ----- INPUT
.EQU LED_PORT = 0x40             ; port for LED output --- OUTOUT
.EQU BTN_PORT = 0xFF             ; port for button input - INPUT
;-------------------------------------------------------------------- 

;--------------------------------------------------------------------
;- Bit Constants
;--------------------------------------------------------------------
.EQU B0_MASK = 0x01              ; mask all but bit0
.EQU B1_MASK = 0x02              ; mask all but bit1
.EQU B2_MASK = 0x04              ; mask all but bit2
.EQU B3_MASK = 0x08              ; mask all but bit3
.EQU B4_MASK = 0x10              ; mask all but bit4
.EQU B5_MASK = 0x20              ; mask all but bit5
.EQU B6_MASK = 0x40              ; mask all but bit6
.EQU B7_MASK = 0x80              ; mask all but bit7
.EQU INSIDE_FOR_COUNT = 0xAA	 ; Loop delays, ~0.5
.EQU MIDDLE_FOR_COUNT = 0xAA	 ; second delay for
.EQU OUTSIDE_FOR_COUNT = 0xAA	 ; each LED. 0xAA default
;--------------------------------------------------------------------    

;--------------------------------------------------------------------
;- Memory Designation Constants
;--------------------------------------------------------------------
.DSEG
.ORG     0x00
DATA:   .DB 1
;--------------------------------------------------------------------

;--------------------------------------------------------------------
;- Begin Code Space
;--------------------------------------------------------------------
.CSEG
.ORG         0x17                            

start:			 MOV R15,0x00     ;LED Register

;-TEST-0-ADD--------------------------------------------------------

test0:		 	 MOV R10,0x05 
			 MOV R11,0x04
			 ADD R10,R11	 ;5+4=9
			 MOV R12,0x09
			 CMP R12,R10
			 BREQ test0_pass
			 BRN  test0_fail
			 			 
test0_pass:  		 OR R15,B0_MASK
			 BRN  delay0

test0_fail:  		 BRN  delay0


delay0:		MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
OUTSIDE_FOR0: 	SUB     R20, 0x01

		MOV     R21, MIDDLE_FOR_COUNT
MIDDLE_FOR0:  	SUB     R21, 0x01
             
		MOV     R22, INSIDE_FOR_COUNT
INSIDE_FOR0:  	SUB     R22, 0x01
		BRNE    INSIDE_FOR0
		OR      R21, 0x00
		BRNE    MIDDLE_FOR0
		OR      R20, 0x00
		BRNE    OUTSIDE_FOR0
		BRN	test1			;Branch to next test
;--------------------------------------------------------------------




;-TEST-1-ADDC--------------------------------------------------------

test1:		 	 OUT R15,LED_PORT    ;Output current results
			 SEC		     ;set carry to 1
			 MOV R10,0x05 
			 MOV R11,0x04
			 ADDC R10,R11        ;5+4+1=10
			 MOV R12,0x0A
			 CMP R12,R10
			 BREQ test1_pass
			 BRN  test1_fail
			 
test1_pass:  		 OR   R15,B1_MASK
			 BRN  delay1

test1_fail:  		 BRN  delay1


delay1:		MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
OUTSIDE_FOR1: 	SUB     R20, 0x01

		MOV     R21, MIDDLE_FOR_COUNT
MIDDLE_FOR1:  	SUB     R21, 0x01
             
		MOV     R22, INSIDE_FOR_COUNT
INSIDE_FOR1:  	SUB     R22, 0x01
		BRNE    INSIDE_FOR1
		OR      R21, 0x00
		BRNE    MIDDLE_FOR1
		OR      R20, 0x00
		BRNE    OUTSIDE_FOR1
		BRN	test2			;Branch to next test
;--------------------------------------------------------------------




;-TEST-2-SUB---------------------------------------------------------

test2:		 	 OUT R15,LED_PORT    ;Output current results
			 MOV R10,0x05
			 MOV R11,0x04
			 SUB R10,R11         ;5-4=1
			 MOV R12,0x01
			 CMP R12,R10
			 BREQ test2_pass
			 BRN  test2_fail		 
			 
test2_pass:  		 OR   R15,B2_MASK
			 BRN  delay2

test2_fail:  		 BRN  delay2


delay2:		MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
OUTSIDE_FOR2: 	SUB     R20, 0x01

		MOV     R21, MIDDLE_FOR_COUNT
MIDDLE_FOR2:  	SUB     R21, 0x01
             
		MOV     R22, INSIDE_FOR_COUNT
INSIDE_FOR2:  	SUB     R22, 0x01
		BRNE    INSIDE_FOR2
		OR      R21, 0x00
		BRNE    MIDDLE_FOR2
		OR      R20, 0x00
		BRNE    OUTSIDE_FOR2
		BRN	test3			;Branch to next test
;--------------------------------------------------------------------




;-TEST-3-SUBC--------------------------------------------------------


test3:		 	 OUT R15,LED_PORT    ;Output current results
			 SEC		     ;set carry to 1
			 MOV R10,0x05
			 MOV R11,0x02
			 SUBC R10,R11        ;5-2-1 = 2
			 MOV R12,0x02
			 CMP R12,R10
			 BREQ test3_pass
			 BRN  test3_fail

test3_pass:  		 OR R15,B3_MASK   ;turn on remaining LED's
			 OR R15,B4_MASK
			 OR R15,B5_MASK
			 OR R15,B6_MASK
			 OR R15,B7_MASK
			 BRN  delay3

test3_fail:  		 BRN  delay3


delay3:		MOV     R20, OUTSIDE_FOR_COUNT    ;Start delay
OUTSIDE_FOR3: 	SUB     R20, 0x01

		MOV     R21, MIDDLE_FOR_COUNT
MIDDLE_FOR3:  	SUB     R21, 0x01
             
		MOV     R22, INSIDE_FOR_COUNT
INSIDE_FOR3:  	SUB     R22, 0x01
		BRNE    INSIDE_FOR3
		OR      R21, 0x00
		BRNE    MIDDLE_FOR3
		OR      R20, 0x00
		BRNE    OUTSIDE_FOR3
		BRN	finish			;Branch to next test
;--------------------------------------------------------------------


;-Finish--------------------------------------------------------

finish:			 OUT R15,LED_PORT
			 BRN finish
;--------------------------------------------------------------------



