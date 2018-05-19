

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


(0001)                            || ; --  AUTHOR:     DOUG BRANDT & JAMES GILSTRAP
(0002)                            || ; --  DATE:       FEB 24, 2011
(0003)                            || ; --  CLASS:      CPE 233
(0004)                            || ; --  INSTRUCTOR: GERFEN
(0005)                            || ; -- 
(0006)                            || ; --  PURPOSE:    THIS PROGRAM WAS BUILT TO TEST SEVERAL DIFFERENT INSTRUCTIONS OF THE RAT PROCESSOR
(0007)                            || ; --              THE TEST CASE NUMBER FOR THIS PROGRAM IS #6 (THIS INCLUDES ADD(REG,IMM), ADDC(REG,IMM), SUB(REG,IMM), SUBC(REG,IMM))
(0008)                            || ; --              THE PROGRAM PERFORMS THE OPERATION, CHECKS THAT THE OPERATION PERFORMED CORRECTLY, AND THEN UPDATES THE OUTPUT(LED) VALUES
(0009)                            || 
(0010)                            || 
(0011)                            || ; INPUT AND OUTPUT PORTS
(0012)                            || ; -----------------------------
(0013)                       032  || .EQU SWITCHES = 0x20
(0014)                       255  || .EQU BUTTONS = 0xFF
(0015)                       064  || .EQU LEDS = 0x40
(0016)                            || ; -----------------------------
(0017)                            || 
(0018)                            || ; CONSTANTS
(0019)                       190  || .EQU INSIDE_FOR_COUNT    = 0xBE
(0020)                       190  || .EQU MIDDLE_FOR_COUNT    = 0xBE
(0021)                       190  || .EQU OUTSIDE_FOR_COUNT   = 0xBE
(0022)                            || ;--------------------------------
(0023)                            || 
(0024)                            || ; DATA SEG
(0025)                            || ; -----------------------------
(0026)                            || .DSEG
(0027)                       000  || .ORG 0x00
(0028)                            || ; -----------------------------
(0029)                            || 
(0030)                            || ; CODE SEG
(0031)                            || ; -----------------------------
(0032)                            || .CSEG
(0033)                       016  || .ORG 0x10
(0034)                            || ; -----------------------------
(0035)                            || 
(0036)                     0x010  || MAIN:
(0037)  CS-0x010  0x36100         ||        MOV R1,0x00      ; register 1 is used to hold the status of the operations completed
(0038)  CS-0x011  0x36400         ||        MOV R4,0x00      ; register 4 is used to hold the bit locator/updater
(0039)  CS-0x012  0x08401         ||        CALL waste_time
(0040)  CS-0x013  0x22401         ||        OR  R4,0x01
(0041)  CS-0x014  0x36201         ||        MOV R2,0x01
(0042)  CS-0x015  0x28202         ||        ADD R2,0x02
(0043)  CS-0x016  0x30203         ||        CMP R2,0x03
(0044)  CS-0x017  0x080CA         ||        BREQ IF2         ; if correct, go to correct section
(0045)  CS-0x018  0x080E0         ||        BRN END_IF2      ; else continue past it
(0046)                            || 
(0047)                     0x019  || IF2:
(0048)  CS-0x019  0x00121         ||        OR R1,R4         ; update the status bit -- this lights up led 1 only
(0049)  CS-0x01A  0x34140         ||        OUT  R1,LEDS
(0050)  CS-0x01B  0x080E0         ||        BRN END_IF2
(0051)                            || 
(0052)                     0x01C  || END_IF2:
(0053)  CS-0x01C  0x08401         ||        CALL waste_time
(0054)  CS-0x01D  0x22402         ||        OR   R4,0x02     ; change the bit updater value so that the next bit will be updated
(0055)  CS-0x01E  0x18001         ||        SEC              ; set carry to 1
(0056)  CS-0x01F  0x2A203         ||        ADDC R2,0x03
(0057)  CS-0x020  0x30207         ||        CMP  R2,0x07
(0058)  CS-0x021  0x0811A         ||        BREQ IF3         ; if correct, go to the correct section
(0059)  CS-0x022  0x08130         ||        BRN END_IF3      ; else continue past it
(0060)                            || 
(0061)                     0x023  || IF3:                    ; THE PROCESS CONTINUES IN A SIMILAR WAY FOR THE REMAINDER OF THE FUNCTIONS BEING TESTED
(0062)  CS-0x023  0x00121         ||        OR R1,R4
(0063)  CS-0x024  0x34140         ||        OUT R1,LEDS
(0064)  CS-0x025  0x08130         ||        BRN END_IF3
(0065)                            || 
(0066)                     0x026  || END_IF3:
(0067)  CS-0x026  0x08401         ||        CALL waste_time
(0068)  CS-0x027  0x22404         ||        OR  R4,0x04
(0069)  CS-0x028  0x2C202         ||        SUB R2,0x02
(0070)  CS-0x029  0x30205         ||        CMP R2,0x05
(0071)  CS-0x02A  0x08162         ||        BREQ IF4
(0072)  CS-0x02B  0x08178         ||        BRN END_IF4
(0073)                            || 
(0074)                     0x02C  || IF4:
(0075)  CS-0x02C  0x00121         ||        OR R1,R4
(0076)  CS-0x02D  0x34140         ||        OUT R1,LEDS
(0077)  CS-0x02E  0x08178         ||        BRN END_IF4
(0078)                            || 
(0079)                     0x02F  || END_IF4:
(0080)  CS-0x02F  0x08401         ||        CALL waste_time
(0081)  CS-0x030  0x22408         ||        OR  R4,0x08
(0082)  CS-0x031  0x18001         ||        SEC
(0083)  CS-0x032  0x2E203         ||        SUBC R2,0x03
(0084)  CS-0x033  0x30201         ||        CMP  R2,0x01
(0085)  CS-0x034  0x081B2         ||        BREQ IF5
(0086)  CS-0x035  0x081D0         ||        BRN END_IF5
(0087)                            || 
(0088)                     0x036  || IF5:
(0089)  CS-0x036  0x00121         ||        OR R1,R4
(0090)  CS-0x037  0x221F0         ||        OR R1,0xF0
(0091)  CS-0x038  0x34140         ||        OUT R1,LEDS
(0092)  CS-0x039  0x081D0         ||        BRN END_IF5
(0093)                            || 
(0094)                     0x03A  || END_IF5:
(0095)  CS-0x03A  0x34140         ||        OUT R1,LEDS
(0096)  CS-0x03B  0x08460         ||        BRN END
(0097)                            || 
(0098)                            || 
(0099)                            || 
(0100)                            || .CSEG
(0101)                       128  || .ORG         0x80
(0102)                            || 
(0103)                     0x080  || waste_time:
(0104)  CS-0x080  0x365BE         ||              MOV     R5,OUTSIDE_FOR_COUNT  ;set outside for loop count
(0105)                     0x081  || outside_for:
(0106)  CS-0x081  0x2C501         ||              SUB     R5,0x01
(0107)  CS-0x082  0x366BE         ||              MOV     R6,MIDDLE_FOR_COUNT   ;set middle for loop count
(0108)                     0x083  || middle_for:
(0109)  CS-0x083  0x2C601         ||              SUB     R6,0x01
(0110)  CS-0x084  0x367BE         ||              MOV     R7,INSIDE_FOR_COUNT   ;set inside for loop count
(0111)                     0x085  || inside_for:
(0112)  CS-0x085  0x2C701         ||              SUB     R7,0x01
(0113)  CS-0x086  0x0842B         ||              BRNE    inside_for
(0114)                            || 
(0115)  CS-0x087  0x22600         ||              OR      R6,0x00               ;load flags for middle for counter
(0116)  CS-0x088  0x0841B         ||              BRNE    middle_for
(0117)                            || 
(0118)  CS-0x089  0x22500         ||              OR      R5,0x00               ;load flags for outsde for counter value
(0119)  CS-0x08A  0x0840B         ||              BRNE    outside_for
(0120)  CS-0x08B  0x18002         ||              RET
(0121)                            || 
(0122)                     0x08C  || END:
(0123)  CS-0x08C  0x04109         ||        MOV R1,R1
(0124)  CS-0x08D  0x08460         ||        BRN END





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
END            0x08C   (0122)  ||  0096 0124 
END_IF2        0x01C   (0052)  ||  0045 0050 
END_IF3        0x026   (0066)  ||  0059 0064 
END_IF4        0x02F   (0079)  ||  0072 0077 
END_IF5        0x03A   (0094)  ||  0086 0092 
IF2            0x019   (0047)  ||  0044 
IF3            0x023   (0061)  ||  0058 
IF4            0x02C   (0074)  ||  0071 
IF5            0x036   (0088)  ||  0085 
INSIDE_FOR     0x085   (0111)  ||  0113 
MAIN           0x010   (0036)  ||  
MIDDLE_FOR     0x083   (0108)  ||  0116 
OUTSIDE_FOR    0x081   (0105)  ||  0119 
WASTE_TIME     0x080   (0103)  ||  0039 0053 0067 0080 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BUTTONS        0x0FF   (0014)  ||  
INSIDE_FOR_COUNT 0x0BE   (0019)  ||  0110 
LEDS           0x040   (0015)  ||  0049 0063 0076 0091 0095 
MIDDLE_FOR_COUNT 0x0BE   (0020)  ||  0107 
OUTSIDE_FOR_COUNT 0x0BE   (0021)  ||  0104 
SWITCHES       0x020   (0013)  ||  


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
