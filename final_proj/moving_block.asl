

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


(0001)                            || .CSEG
(0002)                       016  || .ORG 0x10
(0003)                            || 
(0004)                       144  || .EQU VGA_HADD = 0x90
(0005)                       145  || .EQU VGA_LADD = 0x91
(0006)                       146  || .EQU VGA_COLOR = 0x92
(0007)                       129  || .EQU SSEG = 0x81
(0008)                       064  || .EQU LEDS = 0x40
(0009)                            || 
(0010)                       255  || .EQU BG_COLOR       = 0xFF             ; Background:  white
(0011)                            || 
(0012)                       248  || .EQU M_YELLOW		= 0xF8
(0013)                       224  || .EQU M_RED			= 0xE0
(0014)                       019  || .EQU M_BLUE			= 0x13
(0015)                       000  || .EQU M_BLACK		= 0x00
(0016)                       144  || .EQU M_BROWN		= 0x90
(0017)                            || 
(0018)                       154  || .EQU button         = 0x9A
(0019)                       170  || .EQU For_Count		= 0xAA
(0020)                            || 
(0021)                            || ;r6 is used for color
(0022)                            || ;r7 is used for Y
(0023)                            || ;r8 is used for X
(0024)                            || ;---------------------------------------------------------------------
(0025)                     0x010  || init:
(0026)  CS-0x010  0x08101         ||          CALL   draw_background         ; draw using default color
(0027)                            ||          ;MOV    r7, 0x0F                ; generic Y coordinate
(0028)                            ||          ;MOV    r8, 0x14                ; generic X coordinate
(0029)                            ||          ;MOV    r6, 0xE0                ; color
(0030)                            ||          ;CALL   draw_dot                ; draw red pixel
(0031)                            ||          ;MOV    r8,0x01                 ; starting x coordinate
(0032)                            ||          ;MOV    r7,0x12                 ; start y coordinate
(0033)                            ||          ;MOV    r9,0x26                 ; ending x coordinate
(0034)                            ||          ;CALL   draw_horizontal_line
(0035)                            || 
(0036)                            ||          ;MOV    r8,0x08                 ; starting x coordinate
(0037)                            ||          ;MOV    r7,0x04                 ; start y coordinate
(0038)                            ||          ;MOV    r9,0x17                 ; ending x coordinate
(0039)                            ||          ;CALL   draw_vertical_line
(0040)                            ||   
(0041)                            || 		;CALL	draw_maze
(0042)  CS-0x011  0x081D9         || 		CALL	draw_block
(0043)                            || 
(0044)  CS-0x012  0x08211  0x012  || main:   CALL	move_block
(0045)                            || 	
(0046)  CS-0x013  0x08090         ||         BRN    main                    ; continuous loop 
(0047)                            || 
(0048)                            || ;--------------------------------------------------------------------
(0049)                            || 
(0050)                            || ;--------------------------------------------------------------------
(0051)                            || ;-  Subroutine: draw_horizontal_line
(0052)                            || ;-
(0053)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0054)                            || ;-
(0055)                            || ;-  Parameters:
(0056)                            || ;-   r8  = starting x-coordinate
(0057)                            || ;-   r7  = y-coordinate
(0058)                            || ;-   r9  = ending x-coordinate
(0059)                            || ;-   r6  = color used for line
(0060)                            || ;-
(0061)                            || ;- Tweaked registers: r8,r9
(0062)                            || ;--------------------------------------------------------------------
(0063)                            || 
(0064)                     0x014  || draw_horizontal_line:
(0065)  CS-0x014  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0066)                            || 
(0067)                     0x015  || draw_horiz1:
(0068)  CS-0x015  0x08151         ||         CALL   draw_dot         ; 
(0069)  CS-0x016  0x28801         ||         ADD    r8,0x01
(0070)  CS-0x017  0x04848         ||         CMP    r8,r9
(0071)  CS-0x018  0x080AB         ||         BRNE   draw_horiz1
(0072)  CS-0x019  0x18002         ||         RET
(0073)                            || 
(0074)                            || ;--------------------------------------------------------------------
(0075)                            || 
(0076)                            || ;---------------------------------------------------------------------
(0077)                            || ;-  Subroutine: draw_vertical_line
(0078)                            || ;-
(0079)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0080)                            || ;-
(0081)                            || ;-  Parameters:
(0082)                            || ;-   r8  = x-coordinate
(0083)                            || ;-   r7  = starting y-coordinate
(0084)                            || ;-   r9  = ending y-coordinate
(0085)                            || ;-   r6  = color used for line
(0086)                            || ;- 
(0087)                            || ;- Tweaked registers: r7,r9
(0088)                            || ;--------------------------------------------------------------------
(0089)                            || 
(0090)                     0x01A  || draw_vertical_line:
(0091)  CS-0x01A  0x28901         ||          ADD    r9,0x01
(0092)                            || 
(0093)                     0x01B  || draw_vert1:          
(0094)  CS-0x01B  0x08151         ||          CALL   draw_dot
(0095)  CS-0x01C  0x28701         ||          ADD    r7,0x01
(0096)  CS-0x01D  0x04748         ||          CMP    r7,R9
(0097)  CS-0x01E  0x080DB         ||          BRNE   draw_vert1
(0098)  CS-0x01F  0x18002         ||          RET
(0099)                            || 
(0100)                            || ;--------------------------------------------------------------------
(0101)                            || 
(0102)                            || ;---------------------------------------------------------------------
(0103)                            || ;-  Subroutine: draw_background
(0104)                            || ;-
(0105)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0106)                            || ;-  draw_horizontal_line subroutine. 
(0107)                            || ;- 
(0108)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0109)                            || ;----------------------------------------------------------------------
(0110)                            || 
(0111)                     0x020  || draw_background: 
(0112)  CS-0x020  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0113)  CS-0x021  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0114)  CS-0x022  0x04769  0x022  || start:   MOV   r7,r13                   ; load current row count 
(0115)  CS-0x023  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0116)  CS-0x024  0x36927         ||          MOV   r9,0x27 
(0117)                            || 
(0118)  CS-0x025  0x080A1         ||          CALL  draw_horizontal_line
(0119)  CS-0x026  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0120)  CS-0x027  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0121)  CS-0x028  0x08113         ||          BRNE  start                    ; branch to draw more rows
(0122)  CS-0x029  0x18002         ||          RET
(0123)                            || 
(0124)                            || ;---------------------------------------------------------------------
(0125)                            || 
(0126)                            ||  
(0127)                            || ;---------------------------------------------------------------------
(0128)                            || ;- Subrountine: draw_dot
(0129)                            || ;- 
(0130)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0131)                            || ;- 
(0132)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0133)                            || ;- 
(0134)                            || ;- Tweaked registers: r4,r5
(0135)                            || ;---------------------------------------------------------------------
(0136)                            || 
(0137)                     0x02A  || draw_dot: 
(0138)  CS-0x02A  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0139)  CS-0x02B  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0140)                            || 
(0141)  CS-0x02C  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0142)  CS-0x02D  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0143)  CS-0x02E  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0144)  CS-0x02F  0x0A1B0         ||            BRCS  dd_add40
(0145)                            || 
(0146)  CS-0x030  0x10401  0x030  || t1:        LSR   r4
(0147)  CS-0x031  0x0A1C8         ||            BRCS  dd_add80
(0148)                            || 
(0149)  CS-0x032  0x34591  0x032  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0150)  CS-0x033  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0151)  CS-0x034  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0152)  CS-0x035  0x18002         ||            RET
(0153)                            || 
(0154)  CS-0x036  0x22540  0x036  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0155)  CS-0x037  0x18000         ||            CLC                  ; freshen bit
(0156)  CS-0x038  0x08180         ||            BRN   t1             
(0157)                            || 
(0158)  CS-0x039  0x22580  0x039  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0159)  CS-0x03A  0x08190         ||            BRN   dd_out
(0160)                            || ; --------------------------------------------------------------------
(0161)                            || 
(0162)  CS-0x03B  0x366F8  0x03B  || draw_block: MOV r6,M_YELLOW
(0163)                            || 
(0164)  CS-0x03C  0x36A01         || 			MOV r10,0x01
(0165)  CS-0x03D  0x04751         || 			MOV r7, r10
(0166)  CS-0x03E  0x36B01         || 			MOV r11,0x01
(0167)  CS-0x03F  0x04859         || 			MOV r8, r11
(0168)  CS-0x040  0x08151         || 			CALL draw_dot
(0169)  CS-0x041  0x18002         || 			RET
(0170)                            || 
(0171)  CS-0x042  0x32F9A  0x042  || move_block: IN r15,button
(0172)                            || 	;		MOV r16,For_Count
(0173)                            || 	;TimeDelay:	SUB r16,0x01
(0174)                            || 	;			BRNE TimeDelay
(0175)  CS-0x043  0x12F00         || 			ASR r15
(0176)  CS-0x044  0x0A260         || 			BRCS move_right
(0177)  CS-0x045  0x12F00         || 			ASR r15
(0178)  CS-0x046  0x0A2B8         || 			BRCS move_left
(0179)  CS-0x047  0x12F00         || 			ASR r15
(0180)  CS-0x048  0x0A310         || 			BRCS move_up
(0181)  CS-0x049  0x12F00         || 			ASR r15
(0182)  CS-0x04A  0x0A368         || 			BRCS move_down
(0183)                            || 
(0184)  CS-0x04B  0x18002         || 			RET
(0185)                            || 
(0186)                     0x04C  || move_right:
(0187)                            || 		
(0188)                            || 		;maze boundary check
(0189)  CS-0x04C  0x30826         || 		CMP	   r8, 0x26
(0190)                            || 		BREQ	RET
            syntax error

(0191)                            || 		
(0192)                            || 		;draw pixel at new location
(0193)  CS-0x04D  0x28B01         || 		ADD	   r11, 0x01
(0194)  CS-0x04E  0x04751         || 		MOV    r7, r10
(0195)  CS-0x04F  0x04859         || 		MOV    r8, r11
(0196)  CS-0x050  0x366F8         || 		MOV    r6, M_YELLOW
(0197)  CS-0x051  0x08151         || 		CALL   draw_dot
(0198)                            || 
(0199)                            || 		;draw background at previous location
(0200)  CS-0x052  0x04751         || 		MOV    r7, r10
(0201)  CS-0x053  0x04859         || 		MOV    r8, r11
(0202)  CS-0x054  0x366FF         || 		MOV    r6, BG_COLOR
(0203)  CS-0x055  0x08151         || 		CALL   draw_dot
(0204)                            || 
(0205)  CS-0x056  0x18002         || 		RET
(0206)                            || 
(0207)                     0x057  || move_left:
(0208)                            || 		
(0209)                            || 		;maze boundary check
(0210)  CS-0x057  0x30801         || 		CMP	   r8, 0x01
(0211)                            || 		BREQ	RET
            syntax error

(0212)                            || 		
(0213)                            || 		;draw pixel at new location
(0214)  CS-0x058  0x2CB01         || 		SUB	   r11, 0x01
(0215)  CS-0x059  0x04751         || 		MOV    r7, r10
(0216)  CS-0x05A  0x04859         || 		MOV    r8, r11
(0217)  CS-0x05B  0x366F8         || 		MOV    r6, M_YELLOW
(0218)  CS-0x05C  0x08151         || 		CALL   draw_dot
(0219)                            || 
(0220)                            || 		;draw background at previous location
(0221)  CS-0x05D  0x04751         || 		MOV    r7, r10
(0222)  CS-0x05E  0x04859         || 		MOV    r8, r11
(0223)  CS-0x05F  0x366FF         || 		MOV    r6, BG_COLOR
(0224)  CS-0x060  0x08151         || 		CALL   draw_dot
(0225)                            || 		
(0226)  CS-0x061  0x18002         || 		RET
(0227)                            || 
(0228)                     0x062  || move_up:
(0229)                            || 		
(0230)                            || 		;maze boundary check
(0231)  CS-0x062  0x30701         || 		CMP	   r7, 0x01
(0232)                            || 		BREQ	RET
            syntax error

(0233)                            || 		
(0234)                            || 		;draw pixel at new location
(0235)  CS-0x063  0x28A01         || 		ADD	   r10, 0x01
(0236)  CS-0x064  0x04751         || 		MOV    r7, r10
(0237)  CS-0x065  0x04859         || 		MOV    r8, r11
(0238)  CS-0x066  0x366F8         || 		MOV    r6, M_YELLOW
(0239)  CS-0x067  0x08151         || 		CALL   draw_dot
(0240)                            || 
(0241)                            || 		;draw background at previous location
(0242)  CS-0x068  0x04751         || 		MOV    r7, r10
(0243)  CS-0x069  0x04859         || 		MOV    r8, r11
(0244)  CS-0x06A  0x366FF         || 		MOV    r6, BG_COLOR
(0245)  CS-0x06B  0x08151         || 		CALL   draw_dot
(0246)                            || 		
(0247)  CS-0x06C  0x18002         || 		RET
(0248)                            || 
(0249)                     0x06D  || move_down:
(0250)                            || 		
(0251)                            || 		;maze boundary check
(0252)  CS-0x06D  0x3071B         || 		CMP	   r7, 0x1b
(0253)                            || 		BREQ	RET
            syntax error

(0254)                            || 		
(0255)                            || 		;draw pixel at new location
(0256)  CS-0x06E  0x2CA01         || 		SUB	   r10, 0x01
(0257)  CS-0x06F  0x04751         || 		MOV    r7, r10
(0258)  CS-0x070  0x04859         || 		MOV    r8, r11
(0259)  CS-0x071  0x366F8         ||         MOV    r6, M_YELLOW
(0260)  CS-0x072  0x08151         || 		CALL   draw_dot
(0261)                            || 
(0262)                            || 		;draw background at previous location
(0263)  CS-0x073  0x04751         || 		MOV    r7, r10
(0264)  CS-0x074  0x04859         || 		MOV    r8, r11
(0265)  CS-0x075  0x366FF         || 		MOV    r6, BG_COLOR
(0266)  CS-0x076  0x08151         || 		CALL   draw_dot
(0267)                            || 		
(0268)  CS-0x077  0x18002         || 		RET





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
DD_ADD40       0x036   (0154)  ||  0144 
DD_ADD80       0x039   (0158)  ||  0147 
DD_OUT         0x032   (0149)  ||  0159 
DRAW_BACKGROUND 0x020   (0111)  ||  0026 
DRAW_BLOCK     0x03B   (0162)  ||  0042 
DRAW_DOT       0x02A   (0137)  ||  0068 0094 0168 0197 0203 0218 0224 0239 0245 0260 
                               ||  0266 
DRAW_HORIZ1    0x015   (0067)  ||  0071 
DRAW_HORIZONTAL_LINE 0x014   (0064)  ||  0118 
DRAW_VERT1     0x01B   (0093)  ||  0097 
DRAW_VERTICAL_LINE 0x01A   (0090)  ||  
INIT           0x010   (0025)  ||  
MAIN           0x012   (0044)  ||  0046 
MOVE_BLOCK     0x042   (0171)  ||  0044 
MOVE_DOWN      0x06D   (0249)  ||  0182 
MOVE_LEFT      0x057   (0207)  ||  0178 
MOVE_RIGHT     0x04C   (0186)  ||  0176 
MOVE_UP        0x062   (0228)  ||  0180 
START          0x022   (0114)  ||  0121 
T1             0x030   (0146)  ||  0156 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0010)  ||  0112 0202 0223 0244 0265 
BUTTON         0x09A   (0018)  ||  0171 
FOR_COUNT      0x0AA   (0019)  ||  
LEDS           0x040   (0008)  ||  
M_BLACK        0x000   (0015)  ||  
M_BLUE         0x013   (0014)  ||  
M_BROWN        0x090   (0016)  ||  
M_RED          0x0E0   (0013)  ||  
M_YELLOW       0x0F8   (0012)  ||  0162 0196 0217 0238 0259 
SSEG           0x081   (0007)  ||  
VGA_COLOR      0x092   (0006)  ||  0151 
VGA_HADD       0x090   (0004)  ||  0150 
VGA_LADD       0x091   (0005)  ||  0149 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
