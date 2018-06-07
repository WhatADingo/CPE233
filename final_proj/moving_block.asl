

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
(0044)                     0x012  || main:   
(0045)  CS-0x012  0x08211         || 		CALL	move_block
(0046)                            || 	
(0047)  CS-0x013  0x08090         ||         BRN    main                    ; continuous loop 
(0048)                            || 
(0049)                            || ;--------------------------------------------------------------------
(0050)                            || 
(0051)                            || ;--------------------------------------------------------------------
(0052)                            || ;-  Subroutine: draw_horizontal_line
(0053)                            || ;-
(0054)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0055)                            || ;-
(0056)                            || ;-  Parameters:
(0057)                            || ;-   r8  = starting x-coordinate
(0058)                            || ;-   r7  = y-coordinate
(0059)                            || ;-   r9  = ending x-coordinate
(0060)                            || ;-   r6  = color used for line
(0061)                            || ;-
(0062)                            || ;- Tweaked registers: r8,r9
(0063)                            || ;--------------------------------------------------------------------
(0064)                            || 
(0065)                     0x014  || draw_horizontal_line:
(0066)  CS-0x014  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0067)                            || 
(0068)                     0x015  || draw_horiz1:
(0069)  CS-0x015  0x08151         ||         CALL   draw_dot         ; 
(0070)  CS-0x016  0x28801         ||         ADD    r8,0x01
(0071)  CS-0x017  0x04848         ||         CMP    r8,r9
(0072)  CS-0x018  0x080AB         ||         BRNE   draw_horiz1
(0073)  CS-0x019  0x18002         ||         RET
(0074)                            || 
(0075)                            || ;--------------------------------------------------------------------
(0076)                            || 
(0077)                            || ;---------------------------------------------------------------------
(0078)                            || ;-  Subroutine: draw_vertical_line
(0079)                            || ;-
(0080)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0081)                            || ;-
(0082)                            || ;-  Parameters:
(0083)                            || ;-   r8  = x-coordinate
(0084)                            || ;-   r7  = starting y-coordinate
(0085)                            || ;-   r9  = ending y-coordinate
(0086)                            || ;-   r6  = color used for line
(0087)                            || ;- 
(0088)                            || ;- Tweaked registers: r7,r9
(0089)                            || ;--------------------------------------------------------------------
(0090)                            || 
(0091)                     0x01A  || draw_vertical_line:
(0092)  CS-0x01A  0x28901         ||          ADD    r9,0x01
(0093)                            || 
(0094)                     0x01B  || draw_vert1:          
(0095)  CS-0x01B  0x08151         ||          CALL   draw_dot
(0096)  CS-0x01C  0x28701         ||          ADD    r7,0x01
(0097)  CS-0x01D  0x04748         ||          CMP    r7,R9
(0098)  CS-0x01E  0x080DB         ||          BRNE   draw_vert1
(0099)  CS-0x01F  0x18002         ||          RET
(0100)                            || 
(0101)                            || ;--------------------------------------------------------------------
(0102)                            || 
(0103)                            || ;---------------------------------------------------------------------
(0104)                            || ;-  Subroutine: draw_background
(0105)                            || ;-
(0106)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0107)                            || ;-  draw_horizontal_line subroutine. 
(0108)                            || ;- 
(0109)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0110)                            || ;----------------------------------------------------------------------
(0111)                            || 
(0112)                     0x020  || draw_background: 
(0113)  CS-0x020  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0114)  CS-0x021  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0115)  CS-0x022  0x04769  0x022  || start:   MOV   r7,r13                   ; load current row count 
(0116)  CS-0x023  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0117)  CS-0x024  0x36927         ||          MOV   r9,0x27 
(0118)                            || 
(0119)  CS-0x025  0x080A1         ||          CALL  draw_horizontal_line
(0120)  CS-0x026  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0121)  CS-0x027  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0122)  CS-0x028  0x08113         ||          BRNE  start                    ; branch to draw more rows
(0123)  CS-0x029  0x18002         ||          RET
(0124)                            || 
(0125)                            || ;---------------------------------------------------------------------
(0126)                            || 
(0127)                            ||  
(0128)                            || ;---------------------------------------------------------------------
(0129)                            || ;- Subrountine: draw_dot
(0130)                            || ;- 
(0131)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0132)                            || ;- 
(0133)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0134)                            || ;- 
(0135)                            || ;- Tweaked registers: r4,r5
(0136)                            || ;---------------------------------------------------------------------
(0137)                            || 
(0138)                     0x02A  || draw_dot: 
(0139)  CS-0x02A  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0140)  CS-0x02B  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0141)                            || 
(0142)  CS-0x02C  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0143)  CS-0x02D  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0144)  CS-0x02E  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0145)  CS-0x02F  0x0A1B0         ||            BRCS  dd_add40
(0146)                            || 
(0147)  CS-0x030  0x10401  0x030  || t1:        LSR   r4
(0148)  CS-0x031  0x0A1C8         ||            BRCS  dd_add80
(0149)                            || 
(0150)  CS-0x032  0x34591  0x032  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0151)  CS-0x033  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0152)  CS-0x034  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0153)  CS-0x035  0x18002         ||            RET
(0154)                            || 
(0155)  CS-0x036  0x22540  0x036  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0156)  CS-0x037  0x18000         ||            CLC                  ; freshen bit
(0157)  CS-0x038  0x08180         ||            BRN   t1             
(0158)                            || 
(0159)  CS-0x039  0x22580  0x039  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0160)  CS-0x03A  0x08190         ||            BRN   dd_out
(0161)                            || ; --------------------------------------------------------------------
(0162)                            || 
(0163)  CS-0x03B  0x366F8  0x03B  || draw_block: MOV r6,M_YELLOW
(0164)                            || 
(0165)  CS-0x03C  0x36A01         || 			MOV r10,0x01
(0166)  CS-0x03D  0x04751         || 			MOV r7, r10
(0167)  CS-0x03E  0x36B00         || 			MOV r11,0x00
(0168)  CS-0x03F  0x04859         || 			MOV r8, r11
(0169)  CS-0x040  0x08151         || 			CALL draw_dot
(0170)  CS-0x041  0x18002         || 			RET
(0171)                            || 
(0172)  CS-0x042  0x32F9A  0x042  || move_block: IN r15,button
(0173)                            || 
(0174)  CS-0x043  0x12F00         || 			ASR r15
(0175)  CS-0x044  0x0A2A8         || 			BRCS move_right
(0176)                     0x045  || 			move_right_end:
(0177)  CS-0x045  0x12F00         || 			ASR r15
(0178)  CS-0x046  0x0A2F0         || 			BRCS move_left
(0179)                     0x047  || 			move_left_end:
(0180)  CS-0x047  0x12F00         || 			ASR r15
(0181)  CS-0x048  0x0A338         || 			BRCS move_up
(0182)                     0x049  || 			move_up_end:
(0183)  CS-0x049  0x12F00         || 			ASR r15
(0184)  CS-0x04A  0x0A380         || 			BRCS move_down
(0185)                     0x04B  || 			move_down_end:
(0186)                            || 
(0187)  CS-0x04B  0x370AA         || 			MOV r16, For_Count
(0188)  CS-0x04C  0x2D001  0x04C  || 	delay0:		SUB r16, 0x01
(0189)  CS-0x04D  0x371AA         || 				MOV r17, For_Count
(0190)  CS-0x04E  0x2D101  0x04E  || 		delay1: 	SUB r17, 0x01
(0191)  CS-0x04F  0x372AA         || 					MOV r18, For_Count
(0192)  CS-0x050  0x2D201  0x050  || 			delay2: 	SUB r18, 0x01
(0193)  CS-0x051  0x08283         || 						BRNE delay2
(0194)  CS-0x052  0x08273         || 					BRNE delay1
(0195)  CS-0x053  0x08263         || 				BRNE delay0
(0196)                            || 
(0197)  CS-0x054  0x18002         || 			RET
(0198)                            || 
(0199)                     0x055  || move_right:
(0200)                            || 		
(0201)                            || 		;maze boundary check
(0202)  CS-0x055  0x30826         || 		CMP	   r8, 0x26
(0203)  CS-0x056  0x0822A         || 		BREQ	move_right_end
(0204)                            || 		
(0205)  CS-0x057  0x083C9         || 		CALL	draw_at_prev_loc
(0206)                            || 
(0207)                            || 		;draw pixel at new location
(0208)  CS-0x058  0x28B01         || 		ADD	   r11, 0x01
(0209)  CS-0x059  0x04751         || 		MOV    r7, r10
(0210)  CS-0x05A  0x04859         || 		MOV    r8, r11
(0211)  CS-0x05B  0x366F8         || 		MOV    r6, M_YELLOW
(0212)  CS-0x05C  0x08151         || 		CALL   draw_dot
(0213)                            || 
(0214)  CS-0x05D  0x08228         || 		BRN move_right_end
(0215)                            || 
(0216)                     0x05E  || move_left:
(0217)                            || 		
(0218)                            || 		;maze boundary check
(0219)  CS-0x05E  0x30801         || 		CMP	   r8, 0x01
(0220)  CS-0x05F  0x0823A         || 		BREQ	move_left_end
(0221)                            || 		
(0222)  CS-0x060  0x083C9         || 		CALL	draw_at_prev_loc
(0223)                            || 
(0224)                            || 		;draw pixel at new location
(0225)  CS-0x061  0x2CB01         || 		SUB	   r11, 0x01
(0226)  CS-0x062  0x04751         || 		MOV    r7, r10
(0227)  CS-0x063  0x04859         || 		MOV    r8, r11
(0228)  CS-0x064  0x366F8         || 		MOV    r6, M_YELLOW
(0229)  CS-0x065  0x08151         || 		CALL   draw_dot
(0230)                            || 
(0231)  CS-0x066  0x08238         || 		BRN move_left_end
(0232)                            || 
(0233)                     0x067  || move_up:
(0234)                            || 		
(0235)                            || 		;maze boundary check
(0236)  CS-0x067  0x30701         || 		CMP	   r7, 0x01
(0237)  CS-0x068  0x0824A         || 		BREQ	move_up_end
(0238)                            || 		
(0239)  CS-0x069  0x083C9         || 		CALL	draw_at_prev_loc
(0240)                            || 
(0241)                            || 		;draw pixel at new location
(0242)  CS-0x06A  0x28A01         || 		ADD	   r10, 0x01
(0243)  CS-0x06B  0x04751         || 		MOV    r7, r10
(0244)  CS-0x06C  0x04859         || 		MOV    r8, r11
(0245)  CS-0x06D  0x366F8         || 		MOV    r6, M_YELLOW
(0246)  CS-0x06E  0x08151         || 		CALL   draw_dot
(0247)                            || 
(0248)  CS-0x06F  0x08248         || 		BRN move_up_end
(0249)                            || 
(0250)                     0x070  || move_down:
(0251)                            || 		
(0252)                            || 		;maze boundary check
(0253)  CS-0x070  0x3071B         || 		CMP	   r7, 0x1b
(0254)  CS-0x071  0x0825A         || 		BREQ	move_down_end
(0255)                            || 		
(0256)  CS-0x072  0x083C9         || 		CALL	draw_at_prev_loc
(0257)                            || 
(0258)                            || 		;draw pixel at new location
(0259)  CS-0x073  0x2CA01         || 		SUB	   r10, 0x01
(0260)  CS-0x074  0x04751         || 		MOV    r7, r10
(0261)  CS-0x075  0x04859         || 		MOV    r8, r11
(0262)  CS-0x076  0x366F8         ||         MOV    r6, M_YELLOW
(0263)  CS-0x077  0x08151         || 		CALL   draw_dot
(0264)                            || 
(0265)  CS-0x078  0x08258         || 		BRN move_down_end
(0266)                            || 
(0267)                     0x079  || draw_at_prev_loc:
(0268)  CS-0x079  0x04751         || 		MOV    r7, r10
(0269)  CS-0x07A  0x04859         || 		MOV    r8, r11
(0270)  CS-0x07B  0x366FF         || 		MOV    r6, BG_COLOR
(0271)  CS-0x07C  0x08151         || 		CALL   draw_dot
(0272)  CS-0x07D  0x18002         || 		RET





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
DD_ADD40       0x036   (0155)  ||  0145 
DD_ADD80       0x039   (0159)  ||  0148 
DD_OUT         0x032   (0150)  ||  0160 
DELAY0         0x04C   (0188)  ||  0195 
DELAY1         0x04E   (0190)  ||  0194 
DELAY2         0x050   (0192)  ||  0193 
DRAW_AT_PREV_LOC 0x079   (0267)  ||  0205 0222 0239 0256 
DRAW_BACKGROUND 0x020   (0112)  ||  0026 
DRAW_BLOCK     0x03B   (0163)  ||  0042 
DRAW_DOT       0x02A   (0138)  ||  0069 0095 0169 0212 0229 0246 0263 0271 
DRAW_HORIZ1    0x015   (0068)  ||  0072 
DRAW_HORIZONTAL_LINE 0x014   (0065)  ||  0119 
DRAW_VERT1     0x01B   (0094)  ||  0098 
DRAW_VERTICAL_LINE 0x01A   (0091)  ||  
INIT           0x010   (0025)  ||  
MAIN           0x012   (0044)  ||  0047 
MOVE_BLOCK     0x042   (0172)  ||  0045 
MOVE_DOWN      0x070   (0250)  ||  0184 
MOVE_DOWN_END  0x04B   (0185)  ||  0254 0265 
MOVE_LEFT      0x05E   (0216)  ||  0178 
MOVE_LEFT_END  0x047   (0179)  ||  0220 0231 
MOVE_RIGHT     0x055   (0199)  ||  0175 
MOVE_RIGHT_END 0x045   (0176)  ||  0203 0214 
MOVE_UP        0x067   (0233)  ||  0181 
MOVE_UP_END    0x049   (0182)  ||  0237 0248 
START          0x022   (0115)  ||  0122 
T1             0x030   (0147)  ||  0157 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0010)  ||  0113 0270 
BUTTON         0x09A   (0018)  ||  0172 
FOR_COUNT      0x0AA   (0019)  ||  0187 0189 0191 
LEDS           0x040   (0008)  ||  
M_BLACK        0x000   (0015)  ||  
M_BLUE         0x013   (0014)  ||  
M_BROWN        0x090   (0016)  ||  
M_RED          0x0E0   (0013)  ||  
M_YELLOW       0x0F8   (0012)  ||  0163 0211 0228 0245 0262 
SSEG           0x081   (0007)  ||  
VGA_COLOR      0x092   (0006)  ||  0152 
VGA_HADD       0x090   (0004)  ||  0151 
VGA_LADD       0x091   (0005)  ||  0150 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
