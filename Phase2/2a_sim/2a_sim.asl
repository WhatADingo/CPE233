

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


(0001)                            || ;--------------------------------------------------------------------
(0002)                            || ;- Port and Memory Constants
(0003)                            || ---------------------------------------------------------------------
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0004)                       032  || .EQU SWITCH_PORT = 0x20         ; port for switch input  --- INPUT
(0005)                       064  || .EQU LED_PORT = 0x40            ; port for LED output    --- OUTPUT
(0006)                       001  || .EQU INSIDE_FOR_COUNT	= 0x01	;  
(0007)                       001  || .EQU MIDDLE_FOR_COUNT	= 0x01	; 
(0008)                       001  || .EQU OUTSIDE_FOR_COUNT	= 0x01	;
(0009)                       001  || .EQU BITMASK01		= 0x01
(0010)                       002  || .EQU BITMASK02		= 0x02
(0011)                       004  || .EQU BITMASK04		= 0x04
(0012)                       008  || .EQU BITMASK08		= 0x08
(0013)                       016  || .EQU BITMASK10		= 0x10
(0014)                       032  || .EQU BITMASK20		= 0x20
(0015)                       064  || .EQU BITMASK40		= 0x40
(0016)                       128  || .EQU BITMASK80		= 0x80
(0017)                       170  || .EQU CMPTEST1		= 0xAA
(0018)                       160  || .EQU CMPTEST2		= 0xA0
(0019)                       170  || .EQU CMPTEST3		= 0xAA
(0020)                       175  || .EQU CMPTEST4		= 0xAF
(0021)                       085  || .EQU CMPTEST5		= 0x55
(0022)                       255  || .EQU CMPTEST6		= 0xFF
(0023)                       170  || .EQU CMPTEST7		= 0xAA
(0024)                       015  || .EQU CMPTEST8		= 0x0F
(0025)                            || .DSEG
(0026)                       000  || .ORG	0x00
(0027)                            || ;--------------------------------------------------------------------
(0028)                            || .CSEG
(0029)                       016  || .ORG	0x10
(0030)                            || 
(0031)  CS-0x010  0x36000  0x010  || MAIN:		MOV	R0, 0x00
(0032)  CS-0x011  0x34040         || 		OUT	R0, LED_PORT
(0033)  CS-0x012  0x08191         || 		CALL	PAUSE
(0034)                            || 		
(0035)                            || 
(0036)                            || 
(0037)  CS-0x013  0x36AAA  0x013  || IMMANDTEST:	MOV	R10, 0xAA
(0038)  CS-0x014  0x36BA0         || 		MOV	R11, 0xA0
(0039)  CS-0x015  0x00A58         || 		AND	R10, R11
(0040)  CS-0x016  0x30AA0         || 		CMP	R10, CMPTEST2
(0041)  CS-0x017  0x081F1         || 		CALL	PASS1
(0042)  CS-0x018  0x08191         || 		CALL	PAUSE
(0043)                            || 
(0044)  CS-0x019  0x36AA0  0x019  || IMMORTEST:	MOV	R10, 0xA0
(0045)  CS-0x01A  0x22A0F         || 		OR	R10, 0x0F
(0046)  CS-0x01B  0x30AAF         || 		CMP	R10, CMPTEST4
(0047)  CS-0x01C  0x08209         || 		CALL	PASS2
(0048)  CS-0x01D  0x08191         || 		CALL	PAUSE
(0049)                            || 
(0050)  CS-0x01E  0x36AF0  0x01E  || IMMEXORTEST:	MOV	R10, 0xF0
(0051)  CS-0x01F  0x24A0F         || 		EXOR	R10, 0x0F
(0052)  CS-0x020  0x30AFF         || 		CMP	R10, CMPTEST6
(0053)  CS-0x021  0x08221         || 		CALL	PASS3
(0054)  CS-0x022  0x08191         || 		CALL	PAUSE
(0055)                            || 
(0056)  CS-0x023  0x36AAA  0x023  || IMMRTEST:	MOV	R10, 0xAA
(0057)  CS-0x024  0x10A02         || 		ROL	R10
(0058)  CS-0x025  0x10A03         || 		ROR	R10
(0059)  CS-0x026  0x30AAA         || 		CMP	R10, CMPTEST7
(0060)  CS-0x027  0x08239         || 		CALL	PASS4
(0061)  CS-0x028  0x08191         || 		CALL	PAUSE
(0062)                            || 
(0063)  CS-0x029  0x36AF0  0x029  || IMMATEST:	MOV	R10,0xF0
(0064)  CS-0x02A  0x12A00         || 		ASR	R10
(0065)  CS-0x02B  0x12A00         || 		ASR	R10
(0066)  CS-0x02C  0x12A00         || 		ASR	R10
(0067)  CS-0x02D  0x12A00         || 		ASR	R10
(0068)  CS-0x02E  0x30A0F         || 		CMP	R10, CMPTEST8
(0069)  CS-0x02F  0x08251         || 		CALL	PASS5
(0070)  CS-0x030  0x08191         || 		CALL	PAUSE
(0071)  CS-0x031  0x08080         || 		BRN 	MAIN
(0072)                            || 		
(0073)  CS-0x032  0x36101  0x032  || Pause:		MOV 	R1, OUTSIDE_FOR_COUNT	;set outside for loop count
(0074)  CS-0x033  0x2C101  0x033  || outside_for: 	SUB     R1, 0x01
(0075)  CS-0x034  0x36201         || 		MOV     R2, MIDDLE_FOR_COUNT	;set middle for loop count
(0076)  CS-0x035  0x2C201  0x035  || middle_for:	SUB     R2, 0x01
(0077)  CS-0x036  0x36301         || 		MOV     R3, INSIDE_FOR_COUNT	;set inside for loop count
(0078)  CS-0x037  0x2C301  0x037  || inside_for:	SUB     R3, 0x01
(0079)  CS-0x038  0x081BB         || 		BRNE    inside_for
(0080)  CS-0x039  0x22200         || 		OR      R2, 0x00		;load flags for middle for counter
(0081)  CS-0x03A  0x081AB         || 		BRNE    middle_for
(0082)  CS-0x03B  0x22100         || 		OR      R1, 0x00		;load flags for outsde for counter value
(0083)  CS-0x03C  0x0819B         || 		BRNE    outside_for
(0084)  CS-0x03D  0x18002         || 		RET	
(0085)                            || 
(0086)  CS-0x03E  0x28001  0x03E  || PASS1:		ADD	R0, BITMASK01
(0087)  CS-0x03F  0x34040         || 		OUT	R0, LED_PORT
(0088)  CS-0x040  0x18002         || 		RET
(0089)  CS-0x041  0x28002  0x041  || PASS2:		ADD	R0, BITMASK02
(0090)  CS-0x042  0x34040         || 		OUT	R0, LED_PORT
(0091)  CS-0x043  0x18002         || 		RET
(0092)  CS-0x044  0x28004  0x044  || PASS3:		ADD	R0, BITMASK04
(0093)  CS-0x045  0x34040         || 		OUT	R0, LED_PORT
(0094)  CS-0x046  0x18002         || 		RET
(0095)  CS-0x047  0x28008  0x047  || PASS4:		ADD	R0, BITMASK08
(0096)  CS-0x048  0x34040         || 		OUT	R0, LED_PORT
(0097)  CS-0x049  0x18002         || 		RET
(0098)  CS-0x04A  0x280F0  0x04A  || PASS5:		ADD	R0, 0xF0
(0099)  CS-0x04B  0x34040         || 		OUT	R0, LED_PORT
(0100)  CS-0x04C  0x18002         || 		RET
(0101)                            || 
(0102)                            || ;





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
IMMANDTEST     0x013   (0037)  ||  
IMMATEST       0x029   (0063)  ||  
IMMEXORTEST    0x01E   (0050)  ||  
IMMORTEST      0x019   (0044)  ||  
IMMRTEST       0x023   (0056)  ||  
INSIDE_FOR     0x037   (0078)  ||  0079 
MAIN           0x010   (0031)  ||  0071 
MIDDLE_FOR     0x035   (0076)  ||  0081 
OUTSIDE_FOR    0x033   (0074)  ||  0083 
PASS1          0x03E   (0086)  ||  0041 
PASS2          0x041   (0089)  ||  0047 
PASS3          0x044   (0092)  ||  0053 
PASS4          0x047   (0095)  ||  0060 
PASS5          0x04A   (0098)  ||  0069 
PAUSE          0x032   (0073)  ||  0033 0042 0048 0054 0061 0070 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BITMASK01      0x001   (0009)  ||  0086 
BITMASK02      0x002   (0010)  ||  0089 
BITMASK04      0x004   (0011)  ||  0092 
BITMASK08      0x008   (0012)  ||  0095 
BITMASK10      0x010   (0013)  ||  
BITMASK20      0x020   (0014)  ||  
BITMASK40      0x040   (0015)  ||  
BITMASK80      0x080   (0016)  ||  
CMPTEST1       0x0AA   (0017)  ||  
CMPTEST2       0x0A0   (0018)  ||  0040 
CMPTEST3       0x0AA   (0019)  ||  
CMPTEST4       0x0AF   (0020)  ||  0046 
CMPTEST5       0x055   (0021)  ||  
CMPTEST6       0x0FF   (0022)  ||  0052 
CMPTEST7       0x0AA   (0023)  ||  0059 
CMPTEST8       0x00F   (0024)  ||  0068 
INSIDE_FOR_COUNT 0x001   (0006)  ||  0077 
LED_PORT       0x040   (0005)  ||  0032 0087 0090 0093 0096 0099 
MIDDLE_FOR_COUNT 0x001   (0007)  ||  0075 
OUTSIDE_FOR_COUNT 0x001   (0008)  ||  0073 
SWITCH_PORT    0x020   (0004)  ||  


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
