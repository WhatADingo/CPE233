

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


(0001)                            || ;Programmers: Frames
(0002)                            || ;Version: 1b
(0003)                            || ;2/26/11
(0004)                            || ;
(0005)                            || ;Test Case #4
(0006)                            || ;
(0007)                            || ;Tests PUSH, POP, WSP, Call, and RET
(0008)                            || ;**Assumes that MOV, BRN, OR, OUT, LD, ST, CMP, BREQ, SUB, BRNE all work
(0009)                            || ;
(0010)                            || ;Updates_v1a:
(0011)                            || ;**Loops program
(0012)                            || ;**Added more tests to be thorough
(0013)                            || ;**Added a few NOTES
(0014)                            || ;**Now call test has a nested call in it
(0015)                            || ;
(0016)                            || ;Updates_v1b
(0017)                            || ;**NO TABS!!!!!!!!!
(0018)                            || 
(0019)                       064  || .EQU LED_PORT = 0x40 ;LED port id and
(0020)                       001  || .EQU FIRST_LED = 0x01 ;all constants that 
(0021)                       002  || .EQU SECOND_LED = 0x02 ;will turn on specific
(0022)                       004  || .EQU THIRD_LED = 0x04 ;leds
(0023)                       248  || .EQU ALL_LED = 0xF8
(0024)                            || 
(0025)                       001  || .EQU OUTSIDE_FOR_COUNT = 0x01 ;For loop constants
(0026)                       001  || .EQU MIDDLE_FOR_COUNT = 0x01 
(0027)                       001  || .EQU INSIDE_FOR_COUNT = 0x01 
(0028)                            || 
(0029)                            || 
(0030)                            || .CSEG
(0031)                       064  || .ORG 0x40
(0032)                            || 
(0033)                     0x040  || MAIN: 
(0034)  CS-0x040  0x36034         || MOV R0, 0x34 ;Move in constant values 
(0035)  CS-0x041  0x361A3         || MOV R1, 0xA3 ;that will be used for the
(0036)  CS-0x042  0x3625D         || MOV R2, 0x5D ;tests.
(0037)  CS-0x043  0x37F00         || MOV R31, 0x00 
(0038)  CS-0x044  0x08288         || BRN TEST_PUSH;
(0039)                            || 
(0040)                            || ;--Turn on first LED
(0041)                     0x045  || FIRST_LED_ON: 
(0042)  CS-0x045  0x23F01         || OR R31,FIRST_LED ;Turn the first led on
(0043)  CS-0x046  0x35F40         || OUT R31, LED_PORT ;output it to the out port
(0044)  CS-0x047  0x08400         || BRN PAUSE; ;branch to the pause
(0045)                            || 
(0046)                            || ;--Turn on second LED
(0047)                     0x048  || SECOND_LED_ON:	
(0048)  CS-0x048  0x23F02         || OR R31, SECOND_LED ;Turn the second led on
(0049)  CS-0x049  0x35F40         || OUT R31, LED_PORT ;output it to the out port
(0050)  CS-0x04A  0x08400         || BRN PAUSE; ;branch pause
(0051)                            || 
(0052)                            || ;--Turn on third LED
(0053)                     0x04B  || THIRD_LED_ON:	
(0054)  CS-0x04B  0x23F04         || OR R31, THIRD_LED ;Turn the third led on
(0055)  CS-0x04C  0x35F40         || OUT R31, LED_PORT ;output it to the out port
(0056)  CS-0x04D  0x08400         || BRN PAUSE; ;branch to pause
(0057)                            || 
(0058)                            || ;--Turn on rest of LEDs
(0059)                     0x04E  || ALL_LED_ON:	
(0060)  CS-0x04E  0x23FF8         || OR R31, ALL_LED	;Turn all the rest of the leds on
(0061)  CS-0x04F  0x35F40         || OUT R31, LED_PORT ;output them to the outport
(0062)  CS-0x050  0x08400         || BRN PAUSE; ;branch to end
(0063)                            || 
(0064)                            || ;--Test PUSH
(0065)                     0x051  || TEST_PUSH:	
(0066)  CS-0x051  0x12101         || PUSH R1 ;Test push by pushing a value	
(0067)  CS-0x052  0x383FF         || LD R3, 0xFF ;onto the stack, then loading it
(0068)  CS-0x053  0x04308         || CMP R3, R1 ;and comparing to expected value
(0069)  CS-0x054  0x082F3         || BRNE TEST_POP; ;branch if equal to turn the first led on
(0070)  CS-0x055  0x12101         || PUSH R1 ;Test multiple pushes
(0071)  CS-0x056  0x04F09         || MOV R15, R1
(0072)  CS-0x057  0x12F01         || PUSH R15
(0073)  CS-0x058  0x390FD         || LD R16, 0xFD
(0074)  CS-0x059  0x391FE         || LD R17, 0xFE
(0075)  CS-0x05A  0x05078         || CMP R16, R15
(0076)  CS-0x05B  0x082F3         || BRNE TEST_POP;
(0077)                            || 
(0078)  CS-0x05C  0x05108         || CMP R17, R1
(0079)  CS-0x05D  0x0822A         || BREQ FIRST_LED_ON;
(0080)                            || 
(0081)                            || ;--Test POP
(0082)                     0x05E  || TEST_POP:
(0083)  CS-0x05E  0x12402         || POP R4 ;Test pop by popping the recently pushed
(0084)  CS-0x05F  0x04408         || CMP R4, R1 ;value, then compare with expected
(0085)  CS-0x060  0x0833B         || BRNE TEST_WSP; ;branch if equal to turn on the second led
(0086)                            || 		
(0087)  CS-0x061  0x13202         || POP R18 ;Test multiple pops
(0088)  CS-0x062  0x13302         || POP R19	;NOTE: if failed pushed test then will fail
(0089)  CS-0x063  0x05208         || CMP R18, R1 ;  multiple pop tests becuase no values
(0090)  CS-0x064  0x0833B         || BRNE TEST_WSP; ;pushed onto the stack
(0091)                            || 
(0092)  CS-0x065  0x05308         || CMP R19, R1
(0093)  CS-0x066  0x08242         || BREQ SECOND_LED_ON;
(0094)                            || 
(0095)                            || ;--Test WSP
(0096)                     0x067  || TEST_WSP:
(0097)  CS-0x067  0x14200         || WSP R2	;Write the stack pointer, then
(0098)  CS-0x068  0x12101         || PUSH R1	;store value at location
(0099)  CS-0x069  0x12502         || POP R5 ;pop from the location
(0100)  CS-0x06A  0x04508         || CMP R5,R1 ;compare to expected value
(0101)  CS-0x06B  0x083B3         || BRNE TEST_CALL; ;branch if equal to turn on third led
(0102)                            || 
(0103)  CS-0x06C  0x14200         || WSP R2 ;Test WSP but in different ways than
(0104)  CS-0x06D  0x12101         || PUSH R1	;popping and pushing values
(0105)  CS-0x06E  0x3975C         || LD R23, 0x5C
(0106)  CS-0x06F  0x05708         || CMP R23, R1
(0107)  CS-0x070  0x083B3         || BRNE TEST_CALL;	;NOTE: if push and pop don't work
(0108)                            || 		;      then wsp will fail because
(0109)  CS-0x071  0x14000         || WSP R0          ;      it uses push and pop
(0110)  CS-0x072  0x04103         || ST R1,(R0)
(0111)  CS-0x073  0x13802         || POP R24
(0112)  CS-0x074  0x05808         || CMP R24, R1
(0113)  CS-0x075  0x0825A         || BREQ THIRD_LED_ON;
(0114)                            || 
(0115)                            || 				
(0116)                            || ;--Test CALL
(0117)                     0x076  || TEST_CALL:
(0118)  CS-0x076  0x083C9         || CALL TEST_RT; ;Test call by calling a subroutine
(0119)  CS-0x077  0x04608         || CMP R6,R1 ;compare if subroutine was actually called
(0120)  CS-0x078  0x08272         || BREQ ALL_LED_ON; ;branch if equal to light the rest of the leds
(0121)                            || 
(0122)                            || ;--Test RT
(0123)                     0x079  || TEST_RT:
(0124)  CS-0x079  0x04609         || MOV R6,R1 ;Mov a value into R6
(0125)  CS-0x07A  0x083F1         || CALL TEST_RT2; ;call nested subroutine
(0126)  CS-0x07B  0x04708         || CMP R7,R1 ;compare if subroutine was called
(0127)  CS-0x07C  0x0848B         || BRNE END; ;branch to end if not equal
(0128)  CS-0x07D  0x18002         || RET ;return to where called from
(0129)                            || 
(0130)                     0x07E  || TEST_RT2:
(0131)  CS-0x07E  0x04709         || MOV R7,R1; Mov a value into R7
(0132)  CS-0x07F  0x18002         || RET ;return to where called from
(0133)                            || 		
(0134)                            || ;--Pause for 1/2 second
(0135)                     0x080  || PAUSE: 
(0136)  CS-0x080  0x37401         || MOV R20, OUTSIDE_FOR_COUNT  ;set outside for loop count
(0137)                     0x081  || OUTSIDE_FOR:
(0138)  CS-0x081  0x2D401         || SUB R20, 0x01
(0139)                            || 
(0140)  CS-0x082  0x37501         || MOV R21, MIDDLE_FOR_COUNT   ;set middle for loop count
(0141)                     0x083  || MIDDLE_FOR:
(0142)  CS-0x083  0x2D501         || SUB R21, 0x01
(0143)                            ||              
(0144)  CS-0x084  0x37601         || MOV R22, INSIDE_FOR_COUNT  	;set inside for loop count
(0145)                     0x085  || INSIDE_FOR:
(0146)  CS-0x085  0x2D601         || SUB R22, 0x01
(0147)  CS-0x086  0x0842B         || BRNE INSIDE_FOR;
(0148)                            ||              
(0149)  CS-0x087  0x23500         || OR R21, 0x00 ;load flags for middle for counter
(0150)  CS-0x088  0x0841B         || BRNE MIDDLE_FOR;	
(0151)                            ||             
(0152)  CS-0x089  0x23400         || OR R20, 0x00 ;load flags for outsde for counter value
(0153)  CS-0x08A  0x0840B         || BRNE OUTSIDE_FOR;
(0154)                            || 
(0155)  CS-0x08B  0x31F01         || CMP R31, 0x01 ;if first led is on
(0156)  CS-0x08C  0x082F2         || BREQ TEST_POP; ;then brach next test
(0157)                            || 
(0158)  CS-0x08D  0x31F03         || CMP R31, 0x03 ;if second led is on
(0159)  CS-0x08E  0x0833A         || BREQ TEST_WSP; ;then brach to next test
(0160)                            || 	
(0161)  CS-0x08F  0x31F07         || CMP R31, 0x07 ;if third led is on
(0162)  CS-0x090  0x083B2         || BREQ TEST_CALL; ;then branch to next test
(0163)                            || 
(0164)                     0x091  || END:		
(0165)  CS-0x091  0x08200         || BRN MAIN; ;END
(0166)                            || 
(0167)                            || 
(0168)                            || 
(0169)                            || 





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
ALL_LED_ON     0x04E   (0059)  ||  0120 
END            0x091   (0164)  ||  0127 
FIRST_LED_ON   0x045   (0041)  ||  0079 
INSIDE_FOR     0x085   (0145)  ||  0147 
MAIN           0x040   (0033)  ||  0165 
MIDDLE_FOR     0x083   (0141)  ||  0150 
OUTSIDE_FOR    0x081   (0137)  ||  0153 
PAUSE          0x080   (0135)  ||  0044 0050 0056 0062 
SECOND_LED_ON  0x048   (0047)  ||  0093 
TEST_CALL      0x076   (0117)  ||  0101 0107 0162 
TEST_POP       0x05E   (0082)  ||  0069 0076 0156 
TEST_PUSH      0x051   (0065)  ||  0038 
TEST_RT        0x079   (0123)  ||  0118 
TEST_RT2       0x07E   (0130)  ||  0125 
TEST_WSP       0x067   (0096)  ||  0085 0090 0159 
THIRD_LED_ON   0x04B   (0053)  ||  0113 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
ALL_LED        0x0F8   (0023)  ||  0060 
FIRST_LED      0x001   (0020)  ||  0042 
INSIDE_FOR_COUNT 0x001   (0027)  ||  0144 
LED_PORT       0x040   (0019)  ||  0043 0049 0055 0061 
MIDDLE_FOR_COUNT 0x001   (0026)  ||  0140 
OUTSIDE_FOR_COUNT 0x001   (0025)  ||  0136 
SECOND_LED     0x002   (0021)  ||  0048 
THIRD_LED      0x004   (0022)  ||  0054 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
