;-------------------------------------------------------------------- 
;- Programmers: Trevor Dalke and Josh Korven
;- Date: 02-26-2011
;- Version: 1
;-
;-
;- testAND:	Tests AND(reg/reg)         lights up leftmost LED
;- testOR:      Tests OR(reg/reg)          lights up second LED
;- testEXOR:	Tests EXOR(reg/reg)        lights up third LED
;- testLSL:	Tests LSL(reg)             lights up fourth LED
;- testLSR:	Tests LSR(reg)             lights up last 4 LED's
;- 
;- A successful test results in an LED lighting up. The first test
;- lights up the leftmost LED. Each sequential test lights up the
;- next LED to the right. A failed test results in that particular
;- LED not lighting up, but the next cases are still tested. The
;- final test lights up the remaining LED's. There is about a half
;- second delay between each test so that each LED can be seen being
;- lit up individually.
;--------------------------------------------------------------------

;---------------------Constant Declarations------------
.EQU INSIDE_FOR_COUNT    = 0xBA
.EQU MIDDLE_FOR_COUNT    = 0xBA
.EQU OUTSIDE_FOR_COUNT   = 0xBA

.EQU VALUE1              = 0xAA
.EQU VALUE2              = 0xC5

.EQU LED_PORT            = 0x40
;--------------------------------------------------------------------

.DSEG
.ORG         0x00  
.CSEG
.ORG         0x40

;------------------------------Begin-----------------------------    

MOV R6, 0x00
OUT R6, LED_PORT
testAND:
;----------------------------Hold-----------------------------------
              MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for0: SUB     R1, 0x01

             MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for0:  SUB     R2, 0x01
             
             MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
inside_for0:  SUB     R3, 0x01
             BRNE    inside_for0
             
             OR      R2, 0x00               ;load flags for middle for counter
             BRNE    middle_for0
             
             OR      R1, 0x00               ;load flags for outside for counter value
             BRNE    outside_for0
;---------------------------End Hold---------------------------------
			 MOV R4, VALUE1
			 MOV R5, VALUE2
			 AND R4, R5
			 CMP R4, 0x80 
			 BREQ outputAND;

testOR:
;----------------------------Hold-----------------------------------
              MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for1: SUB     R1, 0x01

             MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for1:  SUB     R2, 0x01
             
             MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
inside_for1:  SUB     R3, 0x01
             BRNE    inside_for1
             
             OR      R2, 0x00               ;load flags for middle for counter
             BRNE    middle_for1
             
             OR      R1, 0x00               ;load flags for outside for counter value
            BRNE    outside_for1
;---------------------------End Hold---------------------------------
			 MOV R4, VALUE1
			 MOV R5, VALUE2
			 OR R4, R5
                         CMP R4, 0xEF
			 BREQ outputOR;

testEXOR:		
;----------------------------Hold-----------------------------------
             MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for2: SUB     R1, 0x01

            MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for2:  SUB     R2, 0x01
             
             MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
inside_for2:  SUB     R3, 0x01
             BRNE    inside_for2
             
             OR      R2, 0x00               ;load flags for middle for counter
             BRNE    middle_for2
             
             OR      R1, 0x00               ;load flags for outside for counter value
             BRNE    outside_for2
;---------------------------End Hold---------------------------------	 
			 MOV R4, VALUE1
			 MOV R5, VALUE2

			 EXOR R4, R5
                         CMP R4, 0x6F
			 BREQ outputEXOR;

testLSL:		
;----------------------------Hold-----------------------------------
             MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for3: SUB     R1, 0x01

             MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for3:  SUB     R2, 0x01
             
             MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
inside_for3:  SUB     R3, 0x01
             BRNE    inside_for3
             
             OR      R2, 0x00               ;load flags for middle for counter
             BRNE    middle_for3
             
             OR      R1, 0x00               ;load flags for outside for counter value
             BRNE    outside_for3
;---------------------------End Hold---------------------------------	 
			 MOV R4, VALUE1
			 MOV R5, VALUE2
			 LSL R4
			 CMP R4, 0x54
			 BREQ outputLSL;
testLSR:	
;----------------------------Hold-----------------------------------
             MOV     R1, OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for4: SUB     R1, 0x01

             MOV     R2, MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for4:  SUB     R2, 0x01
             
             MOV     R3, INSIDE_FOR_COUNT   ;set inside for loop count
inside_for4:  SUB     R3, 0x01
             BRNE    inside_for4
             
             OR      R2, 0x00               ;load flags for middle for counter
             BRNE    middle_for4
             
             OR      R1, 0x00               ;load flags for outside for counter value
             BRNE    outside_for4
;---------------------------End Hold---------------------------------		 
			 MOV R4, VALUE1
			 MOV R5, VALUE2
			 LSR R4
			 CMP R4, 0x55
			 BREQ outputLSR;
;----------------------Successful Test Outputs-----------------------
outputAND:             
OR R6, 0x80	 
OUT R6, LED_PORT
BRN testOR;

outputOR:		 
OR R6, 0x40
OUT R6, LED_PORT
BRN testEXOR;

outputEXOR:		 
OR R6, 0x20
OUT R6, LED_PORT
BRN testLSL;

outputLSL:
OR R6, 0x10
OUT R6, LED_PORT
BRN testLSR;

outputLSR:		 
OR R6, 0x0F
OUT R6, LED_PORT

;-------------------------Hold LED's Indefinitely----------------------------------
endlessloop:
CMP R6, 0XFF
BRN endlessloop;



