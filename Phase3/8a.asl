

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


(0001)                            || ; **************************************************************************************
(0002)                            || ; Updated on 2-23-2017
(0003)                            || ; This program tests the SEI, CLI, RETIE, and RETID instructions and uses OUT, MOV, 
(0004)                            || ; ADD, SUB, AND, OR, CMP, BRN, and BRNE.
(0005)                            || ;
(0006)                            || ; How you initiate the inturrupt is up to the user.
(0007)                            || ; 
(0008)                            || ; LED7 is used to indicate of interrupts are enabled.  The program cycles between
(0009)                            || ; interrupts being enabled and not, with LED7 flashing on and off.  
(0010)                            || ;
(0011)                            || ; Normal program operation is to watch LED7, generate interrupts when LED7 is
(0012)                            || ; illuminated, and see those interrupts counted on the 7 Segment Display. Once the   
(0013)                            || ; 20th interrupt (interrupt 0x14) is received, LD1 will come on to signify finished 
(0014)                            || ; counting. Interrupts will also be disabled to prevent further counting.
(0015)                            || ; **************************************************************************************
(0016)                            || 
(0017)                            || 
(0018)                            || .DSEG
(0019)                       000  || .ORG 0x00
(0020)                            || 
(0021)                       255  || .equ loop_count = 0xFF     ; extend the loop count
(0022)                       064  || .equ led_port   = 0x40
(0023)                       129  || .equ ssg_port	= 0x81
(0024)                            || 
(0025)                            || .CSEG
(0026)                       016  || .ORG 0x10
(0027)  CS-0x010  0x36100         ||             MOV  R1, 0x00   	;R1 is used to count interrupts and drive the SSG
(0028)  CS-0x011  0x36200         ||             MOV  R2, 0x00   	;Set flag to allow interrupts to be enabled
(0029)  CS-0x012  0x34181         ||             OUT  R1, ssg_port   ;Initialize Sev Seg to 0
(0030)                            || 
(0031)  CS-0x013  0x1A000  0x013  || MAIN:       SEI
(0032)  CS-0x014  0x36380         || 	        MOV  R3, 0x80           ;illuminate LD7 when interrupts on
(0033)  CS-0x015  0x34340         || 	        OUT  R3, led_port
(0034)  CS-0x016  0x36BFF         || 	        MOV  R11, loop_count    ;set outside for loop count
(0035)  CS-0x017  0x08100         || 	        BRN  FOR1
(0036)                            || 	        
(0037)  CS-0x018  0x302FF  0x018  || BACK1:      CMP  R2, 0xFF            ;check flag if done counting interrupts
(0038)  CS-0x019  0x0822A         ||             BREQ DONE
(0039)  CS-0x01A  0x1A001         ||             CLI                                       
(0040)  CS-0x01B  0x2037F         ||             AND  R3,  0x7F          ;extinguish LD7 when interrupts disabled
(0041)  CS-0x01C  0x34340         || 	        OUT  R3,  led_port
(0042)  CS-0x01D  0x36BFF         || 	        MOV  R11, loop_count    ;set outside for loop count
(0043)  CS-0x01E  0x08188         ||             BRN  FOR2
(0044)  CS-0x01F  0x08098         ||             BRN  MAIN               ;should never be needed
(0045)                            || 
(0046)                     0x020  || FOR1:
(0047)  CS-0x020  0x2CB01  0x020  || out_for1:   SUB  R11, 0x01
(0048)  CS-0x021  0x36CFF         ||             MOV  R12, loop_count   ;set middle for loop count
(0049)                            || 
(0050)  CS-0x022  0x2CC01  0x022  || mid_for1:   SUB  R12, 0x01
(0051)  CS-0x023  0x36DFF         ||             MOV  R13, loop_count   ;set inside for loop count
(0052)                            || 
(0053)  CS-0x024  0x2CD01  0x024  || in_for1:    SUB  R13, 0x01
(0054)  CS-0x025  0x37FFF         ||             MOV  R31, 0xFF          ;empty instructions to slow things down
(0055)  CS-0x026  0x37FFF         || 	        MOV  R31, 0xFF          ;when interrupts are enabled to allow
(0056)  CS-0x027  0x37FFF         ||             MOV  R31, 0xFF          ;button presses
(0057)  CS-0x028  0x37FFF         ||             MOV  R31, 0xFF
(0058)  CS-0x029  0x37FFF         ||             MOV  R31, 0xFF
(0059)  CS-0x02A  0x37FFF         ||             MOV  R31, 0xFF
(0060)  CS-0x02B  0x08123         ||             BRNE in_for1
(0061)                            ||              
(0062)  CS-0x02C  0x22C00         ||             OR   R12, 0x00         ;load flags for middle for counter
(0063)  CS-0x02D  0x08113         ||             BRNE mid_for1
(0064)                            ||              
(0065)  CS-0x02E  0x22B00         ||             OR   R11, 0x00         ;load flags for outsde for counter value
(0066)  CS-0x02F  0x08103         ||             BRNE out_for1
(0067)  CS-0x030  0x080C0         ||             BRN  BACK1
(0068)                            || 
(0069)                     0x031  || FOR2:
(0070)  CS-0x031  0x2CB01  0x031  || out_for2:   SUB  R11, 0x01
(0071)  CS-0x032  0x36CFF         ||             MOV  R12, loop_count ;set middle for loop count
(0072)                            || 
(0073)  CS-0x033  0x2CC01  0x033  || mid_for2:   SUB  R12, 0x01
(0074)  CS-0x034  0x36DFF         ||             MOV  R13, loop_count ;set inside for loop count
(0075)                            || 
(0076)  CS-0x035  0x2CD01  0x035  || in_for2:    SUB  R13, 0x01
(0077)  CS-0x036  0x081AB         ||             BRNE in_for2
(0078)                            ||              
(0079)  CS-0x037  0x22C00         ||             OR   R12, 0x00       ;load flags for middle for counter
(0080)  CS-0x038  0x0819B         ||             BRNE mid_for2
(0081)                            ||              
(0082)  CS-0x039  0x22B00         ||             OR   R11, 0x00       ;load flags for outsde for counter value
(0083)  CS-0x03A  0x0818B         ||             BRNE out_for2
(0084)  CS-0x03B  0x08098         ||             BRN  MAIN
(0085)                            || 
(0086)  CS-0x03C  0x28101  0x03C  || ISR:        ADD  R1, 0x01           ;count interrupts and update SSG
(0087)  CS-0x03D  0x34181         ||             OUT  R1, ssg_port         
(0088)  CS-0x03E  0x30114         ||             CMP  R1, 0x14           ;After 20 presses disable interrupts
(0089)  CS-0x03F  0x0820A         ||             BREQ DISABLE_INTS       ;and finish up
(0090)  CS-0x040  0x1A003         || 	        RETIE
(0091)                            || 
(0092)                     0x041  || DISABLE_INTS:
(0093)  CS-0x041  0x36301         ||             MOV  R3, 0x01           ;illuminate LD1 indicating done
(0094)  CS-0x042  0x34340         ||             OUT  R3, led_port
(0095)  CS-0x043  0x362FF         ||             MOV  R2, 0xFF           ;set flag to indicate done 
(0096)  CS-0x044  0x1A002         ||             RETID                   ;return without enabling interrupts
(0097)                            || 
(0098)  CS-0x045  0x08228  0x045  || DONE:       BRN  DONE               ;ALL DONE, NO MORE INTERRUPTS!
(0099)                            || 
(0100)                            || .CSEG
(0101)                       1023  || .ORG 0x3FF  ;interrupt vector
(0102)  CS-0x3FF  0x081E0  0x3FF  || VECTOR:     BRN ISR





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
BACK1          0x018   (0037)  ||  0067 
DISABLE_INTS   0x041   (0092)  ||  0089 
DONE           0x045   (0098)  ||  0038 0098 
FOR1           0x020   (0046)  ||  0035 
FOR2           0x031   (0069)  ||  0043 
IN_FOR1        0x024   (0053)  ||  0060 
IN_FOR2        0x035   (0076)  ||  0077 
ISR            0x03C   (0086)  ||  0102 
MAIN           0x013   (0031)  ||  0044 0084 
MID_FOR1       0x022   (0050)  ||  0063 
MID_FOR2       0x033   (0073)  ||  0080 
OUT_FOR1       0x020   (0047)  ||  0066 
OUT_FOR2       0x031   (0070)  ||  0083 
VECTOR         0x3FF   (0102)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
LED_PORT       0x040   (0022)  ||  0033 0041 0094 
LOOP_COUNT     0x0FF   (0021)  ||  0034 0042 0048 0051 0071 0074 
SSG_PORT       0x081   (0023)  ||  0029 0087 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
