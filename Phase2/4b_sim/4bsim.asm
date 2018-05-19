;Programmers: Frames
;Version: 1b
;2/26/11
;
;Test Case #4
;
;Tests PUSH, POP, WSP, Call, and RET
;**Assumes that MOV, BRN, OR, OUT, LD, ST, CMP, BREQ, SUB, BRNE all work
;
;Updates_v1a:
;**Loops program
;**Added more tests to be thorough
;**Added a few NOTES
;**Now call test has a nested call in it
;
;Updates_v1b
;**NO TABS!!!!!!!!!

.EQU LED_PORT = 0x40 ;LED port id and
.EQU FIRST_LED = 0x01 ;all constants that 
.EQU SECOND_LED = 0x02 ;will turn on specific
.EQU THIRD_LED = 0x04 ;leds
.EQU ALL_LED = 0xF8

.EQU OUTSIDE_FOR_COUNT = 0x01 ;For loop constants
.EQU MIDDLE_FOR_COUNT = 0x01 
.EQU INSIDE_FOR_COUNT = 0x01 


.CSEG
.ORG 0x40

MAIN: 
MOV R0, 0x34 ;Move in constant values 
MOV R1, 0xA3 ;that will be used for the
MOV R2, 0x5D ;tests.
MOV R31, 0x00 
BRN TEST_PUSH;

;--Turn on first LED
FIRST_LED_ON: 
OR R31,FIRST_LED ;Turn the first led on
OUT R31, LED_PORT ;output it to the out port
BRN PAUSE; ;branch to the pause

;--Turn on second LED
SECOND_LED_ON:	
OR R31, SECOND_LED ;Turn the second led on
OUT R31, LED_PORT ;output it to the out port
BRN PAUSE; ;branch pause

;--Turn on third LED
THIRD_LED_ON:	
OR R31, THIRD_LED ;Turn the third led on
OUT R31, LED_PORT ;output it to the out port
BRN PAUSE; ;branch to pause

;--Turn on rest of LEDs
ALL_LED_ON:	
OR R31, ALL_LED	;Turn all the rest of the leds on
OUT R31, LED_PORT ;output them to the outport
BRN PAUSE; ;branch to end

;--Test PUSH
TEST_PUSH:	
PUSH R1 ;Test push by pushing a value	
LD R3, 0xFF ;onto the stack, then loading it
CMP R3, R1 ;and comparing to expected value
BRNE TEST_POP; ;branch if equal to turn the first led on
PUSH R1 ;Test multiple pushes
MOV R15, R1
PUSH R15
LD R16, 0xFD
LD R17, 0xFE
CMP R16, R15
BRNE TEST_POP;

CMP R17, R1
BREQ FIRST_LED_ON;

;--Test POP
TEST_POP:
POP R4 ;Test pop by popping the recently pushed
CMP R4, R1 ;value, then compare with expected
BRNE TEST_WSP; ;branch if equal to turn on the second led
		
POP R18 ;Test multiple pops
POP R19	;NOTE: if failed pushed test then will fail
CMP R18, R1 ;  multiple pop tests becuase no values
BRNE TEST_WSP; ;pushed onto the stack

CMP R19, R1
BREQ SECOND_LED_ON;

;--Test WSP
TEST_WSP:
WSP R2	;Write the stack pointer, then
PUSH R1	;store value at location
POP R5 ;pop from the location
CMP R5,R1 ;compare to expected value
BRNE TEST_CALL; ;branch if equal to turn on third led

WSP R2 ;Test WSP but in different ways than
PUSH R1	;popping and pushing values
LD R23, 0x5C
CMP R23, R1
BRNE TEST_CALL;	;NOTE: if push and pop don't work
		;      then wsp will fail because
WSP R0          ;      it uses push and pop
ST R1,(R0)
POP R24
CMP R24, R1
BREQ THIRD_LED_ON;

				
;--Test CALL
TEST_CALL:
CALL TEST_RT; ;Test call by calling a subroutine
CMP R6,R1 ;compare if subroutine was actually called
BREQ ALL_LED_ON; ;branch if equal to light the rest of the leds

;--Test RT
TEST_RT:
MOV R6,R1 ;Mov a value into R6
CALL TEST_RT2; ;call nested subroutine
CMP R7,R1 ;compare if subroutine was called
BRNE END; ;branch to end if not equal
RET ;return to where called from

TEST_RT2:
MOV R7,R1; Mov a value into R7
RET ;return to where called from
		
;--Pause for 1/2 second
PAUSE: 
MOV R20, OUTSIDE_FOR_COUNT  ;set outside for loop count
OUTSIDE_FOR:
SUB R20, 0x01

MOV R21, MIDDLE_FOR_COUNT   ;set middle for loop count
MIDDLE_FOR:
SUB R21, 0x01
             
MOV R22, INSIDE_FOR_COUNT  	;set inside for loop count
INSIDE_FOR:
SUB R22, 0x01
BRNE INSIDE_FOR;
             
OR R21, 0x00 ;load flags for middle for counter
BRNE MIDDLE_FOR;	
            
OR R20, 0x00 ;load flags for outsde for counter value
BRNE OUTSIDE_FOR;

CMP R31, 0x01 ;if first led is on
BREQ TEST_POP; ;then brach next test

CMP R31, 0x03 ;if second led is on
BREQ TEST_WSP; ;then brach to next test
	
CMP R31, 0x07 ;if third led is on
BREQ TEST_CALL; ;then branch to next test

END:		
BRN MAIN; ;END




