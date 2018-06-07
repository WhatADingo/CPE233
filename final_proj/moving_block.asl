

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
(0012)                       224  || .EQU M_YELLOW		= 0xE0	;0xF8
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
(0026)  CS-0x010  0x08151         ||          CALL   draw_background         ; draw using default color
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
(0042)  CS-0x011  0x08229         || 		CALL	draw_block
(0043)                            || 
(0044)  CS-0x012  0x36F11         || 		MOV		r15,0x11
(0045)  CS-0x013  0x34F40         || 		OUT		r15,LEDS
(0046)                            || 
(0047)                            || 		;maze boundary check
(0048)  CS-0x014  0x30826         || 		CMP	   r8, 0x26
(0049)  CS-0x015  0x08282         || 		BREQ	move_right_end
(0050)                            || 		
(0051)  CS-0x016  0x083F1         || 		CALL	draw_at_prev_loc
(0052)                            || 
(0053)                            || 		;draw pixel at new location
(0054)  CS-0x017  0x28B01         || 		ADD	   r11, 0x01
(0055)  CS-0x018  0x04751         || 		MOV    r7, r10
(0056)  CS-0x019  0x04859         || 		MOV    r8, r11
(0057)  CS-0x01A  0x366E0         || 		MOV    r6, M_YELLOW
(0058)  CS-0x01B  0x081A1         || 		CALL   draw_dot
(0059)                            || 
(0060)  CS-0x01C  0x08261  0x01C  || main:   CALL	move_block
(0061)                            || 	
(0062)  CS-0x01D  0x080E0         ||         BRN    main                    ; continuous loop 
(0063)                            || 
(0064)                            || ;--------------------------------------------------------------------
(0065)                            || 
(0066)                            || ;--------------------------------------------------------------------
(0067)                            || ;-  Subroutine: draw_horizontal_line
(0068)                            || ;-
(0069)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0070)                            || ;-
(0071)                            || ;-  Parameters:
(0072)                            || ;-   r8  = starting x-coordinate
(0073)                            || ;-   r7  = y-coordinate
(0074)                            || ;-   r9  = ending x-coordinate
(0075)                            || ;-   r6  = color used for line
(0076)                            || ;-
(0077)                            || ;- Tweaked registers: r8,r9
(0078)                            || ;--------------------------------------------------------------------
(0079)                            || 
(0080)                     0x01E  || draw_horizontal_line:
(0081)  CS-0x01E  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0082)                            || 
(0083)                     0x01F  || draw_horiz1:
(0084)  CS-0x01F  0x081A1         ||         CALL   draw_dot         ; 
(0085)  CS-0x020  0x28801         ||         ADD    r8,0x01
(0086)  CS-0x021  0x04848         ||         CMP    r8,r9
(0087)  CS-0x022  0x080FB         ||         BRNE   draw_horiz1
(0088)  CS-0x023  0x18002         ||         RET
(0089)                            || 
(0090)                            || ;--------------------------------------------------------------------
(0091)                            || 
(0092)                            || ;---------------------------------------------------------------------
(0093)                            || ;-  Subroutine: draw_vertical_line
(0094)                            || ;-
(0095)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0096)                            || ;-
(0097)                            || ;-  Parameters:
(0098)                            || ;-   r8  = x-coordinate
(0099)                            || ;-   r7  = starting y-coordinate
(0100)                            || ;-   r9  = ending y-coordinate
(0101)                            || ;-   r6  = color used for line
(0102)                            || ;- 
(0103)                            || ;- Tweaked registers: r7,r9
(0104)                            || ;--------------------------------------------------------------------
(0105)                            || 
(0106)                     0x024  || draw_vertical_line:
(0107)  CS-0x024  0x28901         ||          ADD    r9,0x01
(0108)                            || 
(0109)                     0x025  || draw_vert1:          
(0110)  CS-0x025  0x081A1         ||          CALL   draw_dot
(0111)  CS-0x026  0x28701         ||          ADD    r7,0x01
(0112)  CS-0x027  0x04748         ||          CMP    r7,R9
(0113)  CS-0x028  0x0812B         ||          BRNE   draw_vert1
(0114)  CS-0x029  0x18002         ||          RET
(0115)                            || 
(0116)                            || ;--------------------------------------------------------------------
(0117)                            || 
(0118)                            || ;---------------------------------------------------------------------
(0119)                            || ;-  Subroutine: draw_background
(0120)                            || ;-
(0121)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0122)                            || ;-  draw_horizontal_line subroutine. 
(0123)                            || ;- 
(0124)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0125)                            || ;----------------------------------------------------------------------
(0126)                            || 
(0127)                     0x02A  || draw_background: 
(0128)  CS-0x02A  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0129)  CS-0x02B  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0130)  CS-0x02C  0x04769  0x02C  || start:   MOV   r7,r13                   ; load current row count 
(0131)  CS-0x02D  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0132)  CS-0x02E  0x36927         ||          MOV   r9,0x27 
(0133)                            || 
(0134)  CS-0x02F  0x080F1         ||          CALL  draw_horizontal_line
(0135)  CS-0x030  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0136)  CS-0x031  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0137)  CS-0x032  0x08163         ||          BRNE  start                    ; branch to draw more rows
(0138)  CS-0x033  0x18002         ||          RET
(0139)                            || 
(0140)                            || ;---------------------------------------------------------------------
(0141)                            || 
(0142)                            ||  
(0143)                            || ;---------------------------------------------------------------------
(0144)                            || ;- Subrountine: draw_dot
(0145)                            || ;- 
(0146)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0147)                            || ;- 
(0148)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0149)                            || ;- 
(0150)                            || ;- Tweaked registers: r4,r5
(0151)                            || ;---------------------------------------------------------------------
(0152)                            || 
(0153)                     0x034  || draw_dot: 
(0154)  CS-0x034  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0155)  CS-0x035  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0156)                            || 
(0157)  CS-0x036  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0158)  CS-0x037  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0159)  CS-0x038  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0160)  CS-0x039  0x0A200         ||            BRCS  dd_add40
(0161)                            || 
(0162)  CS-0x03A  0x10401  0x03A  || t1:        LSR   r4
(0163)  CS-0x03B  0x0A218         ||            BRCS  dd_add80
(0164)                            || 
(0165)  CS-0x03C  0x34591  0x03C  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0166)  CS-0x03D  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0167)  CS-0x03E  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0168)  CS-0x03F  0x18002         ||            RET
(0169)                            || 
(0170)  CS-0x040  0x22540  0x040  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0171)  CS-0x041  0x18000         ||            CLC                  ; freshen bit
(0172)  CS-0x042  0x081D0         ||            BRN   t1             
(0173)                            || 
(0174)  CS-0x043  0x22580  0x043  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0175)  CS-0x044  0x081E0         ||            BRN   dd_out
(0176)                            || ; --------------------------------------------------------------------
(0177)                            || 
(0178)  CS-0x045  0x366E0  0x045  || draw_block: MOV r6,M_YELLOW
(0179)                            || 
(0180)  CS-0x046  0x36A01         || 			MOV r10,0x01
(0181)  CS-0x047  0x04751         || 			MOV r7, r10
(0182)  CS-0x048  0x36B00         || 			MOV r11,0x00
(0183)  CS-0x049  0x04859         || 			MOV r8, r11
(0184)  CS-0x04A  0x081A1         || 			CALL draw_dot
(0185)  CS-0x04B  0x18002         || 			RET
(0186)                            || 
(0187)  CS-0x04C  0x32F9A  0x04C  || move_block: IN r15,button
(0188)  CS-0x04D  0x34F40         || 			OUT r15, LEDS
(0189)                            || 
(0190)  CS-0x04E  0x10F01         || 			LSR r15
(0191)  CS-0x04F  0x0A2E8         || 			BRCS move_right
(0192)                     0x050  || 			move_right_end:
(0193)  CS-0x050  0x10F01         || 			LSR r15
(0194)  CS-0x051  0x0A330         || 			BRCS move_left
(0195)                     0x052  || 			move_left_end:
(0196)  CS-0x052  0x10F01         || 			LSR r15
(0197)  CS-0x053  0x0A370         || 			BRCS move_up
(0198)                     0x054  || 			move_up_end:
(0199)  CS-0x054  0x10F01         || 			LSR r15
(0200)  CS-0x055  0x0A3B0         || 			BRCS move_down
(0201)                     0x056  || 			move_down_end:
(0202)                            || 
(0203)  CS-0x056  0x370AA         || 			MOV r16, For_Count
(0204)  CS-0x057  0x2D001  0x057  || 	delay0:		SUB r16, 0x01
(0205)  CS-0x058  0x371AA         || 				MOV r17, For_Count
(0206)  CS-0x059  0x2D101  0x059  || 		delay1: 	SUB r17, 0x01
(0207)  CS-0x05A  0x082CB         || 					BRNE delay1
(0208)  CS-0x05B  0x082BB         || 				BRNE delay0
(0209)                            || 
(0210)  CS-0x05C  0x18002         || 			RET
(0211)                            || 
(0212)                     0x05D  || move_right:
(0213)                            || 		
(0214)                            || 		;maze boundary check
(0215)  CS-0x05D  0x30826         || 		CMP	   r8, 0x26
(0216)  CS-0x05E  0x08282         || 		BREQ	move_right_end
(0217)                            || 		
(0218)                            || 		OUT		0xFF, LEDS
            syntax error

(0219)  CS-0x05F  0x083F1         || 		CALL	draw_at_prev_loc
(0220)                            || 
(0221)                            || 		;draw pixel at new location
(0222)  CS-0x060  0x28B01         || 		ADD	   r11, 0x01
(0223)  CS-0x061  0x04751         || 		MOV    r7, r10
(0224)  CS-0x062  0x04859         || 		MOV    r8, r11
(0225)  CS-0x063  0x366E0         || 		MOV    r6, M_YELLOW
(0226)  CS-0x064  0x081A1         || 		CALL   draw_dot
(0227)                            || 
(0228)  CS-0x065  0x08280         || 		BRN move_right_end
(0229)                            || 
(0230)                     0x066  || move_left:
(0231)                            || 		
(0232)                            || 		;maze boundary check
(0233)  CS-0x066  0x30801         || 		CMP	   r8, 0x01
(0234)  CS-0x067  0x08292         || 		BREQ	move_left_end
(0235)                            || 
(0236)                            || 		OUT		0xFF, LEDS
            syntax error

(0237)                            || 		
(0238)                            || 		;CALL	draw_at_prev_loc
(0239)                            || 
(0240)                            || 		;draw pixel at new location
(0241)  CS-0x068  0x2CB01         || 		SUB	   r11, 0x01
(0242)  CS-0x069  0x04751         || 		MOV    r7, r10
(0243)  CS-0x06A  0x04859         || 		MOV    r8, r11
(0244)  CS-0x06B  0x366E0         || 		MOV    r6, M_YELLOW
(0245)  CS-0x06C  0x081A1         || 		CALL   draw_dot
(0246)                            || 
(0247)  CS-0x06D  0x08290         || 		BRN move_left_end
(0248)                            || 
(0249)                     0x06E  || move_up:
(0250)                            || 		
(0251)                            || 		;maze boundary check
(0252)  CS-0x06E  0x30701         || 		CMP	   r7, 0x01
(0253)  CS-0x06F  0x082A2         || 		BREQ	move_up_end
(0254)                            || 		
(0255)                            || 		OUT		0xFF, LEDS
            syntax error

(0256)                            || 		;CALL	draw_at_prev_loc
(0257)                            || 
(0258)                            || 		;draw pixel at new location
(0259)  CS-0x070  0x2CA01         || 		SUB	   r10, 0x01
(0260)  CS-0x071  0x04751         || 		MOV    r7, r10
(0261)  CS-0x072  0x04859         || 		MOV    r8, r11
(0262)  CS-0x073  0x366E0         || 		MOV    r6, M_YELLOW
(0263)  CS-0x074  0x081A1         || 		CALL   draw_dot
(0264)                            || 
(0265)  CS-0x075  0x082A0         || 		BRN move_up_end
(0266)                            || 
(0267)                     0x076  || move_down:
(0268)                            || 		
(0269)                            || 		;maze boundary check
(0270)  CS-0x076  0x3071B         || 		CMP	   r7, 0x1b
(0271)  CS-0x077  0x082B2         || 		BREQ	move_down_end
(0272)                            || 
(0273)                            || 		OUT		0xFF, LEDS
            syntax error

(0274)                            || 		
(0275)                            || 		;CALL	draw_at_prev_loc
(0276)                            || 
(0277)                            || 		;draw pixel at new location
(0278)  CS-0x078  0x28A01         || 		ADD	   r10, 0x01
(0279)  CS-0x079  0x04751         || 		MOV    r7, r10
(0280)  CS-0x07A  0x04859         || 		MOV    r8, r11
(0281)  CS-0x07B  0x366E0         ||         MOV    r6, M_YELLOW
(0282)  CS-0x07C  0x081A1         || 		CALL   draw_dot
(0283)                            || 
(0284)  CS-0x07D  0x082B0         || 		BRN move_down_end
(0285)                            || 
(0286)                     0x07E  || draw_at_prev_loc:
(0287)  CS-0x07E  0x04751         || 		MOV    r7, r10
(0288)  CS-0x07F  0x04859         || 		MOV    r8, r11
(0289)  CS-0x080  0x366FF         || 		MOV    r6, BG_COLOR
(0290)  CS-0x081  0x081A1         || 		CALL   draw_dot
(0291)  CS-0x082  0x18002         || 		RET





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
DD_ADD40       0x040   (0170)  ||  0160 
DD_ADD80       0x043   (0174)  ||  0163 
DD_OUT         0x03C   (0165)  ||  0175 
DELAY0         0x057   (0204)  ||  0208 
DELAY1         0x059   (0206)  ||  0207 
DRAW_AT_PREV_LOC 0x07E   (0286)  ||  0051 0219 
DRAW_BACKGROUND 0x02A   (0127)  ||  0026 
DRAW_BLOCK     0x045   (0178)  ||  0042 
DRAW_DOT       0x034   (0153)  ||  0058 0084 0110 0184 0226 0245 0263 0282 0290 
DRAW_HORIZ1    0x01F   (0083)  ||  0087 
DRAW_HORIZONTAL_LINE 0x01E   (0080)  ||  0134 
DRAW_VERT1     0x025   (0109)  ||  0113 
DRAW_VERTICAL_LINE 0x024   (0106)  ||  
INIT           0x010   (0025)  ||  
MAIN           0x01C   (0060)  ||  0062 
MOVE_BLOCK     0x04C   (0187)  ||  0060 
MOVE_DOWN      0x076   (0267)  ||  0200 
MOVE_DOWN_END  0x056   (0201)  ||  0271 0284 
MOVE_LEFT      0x066   (0230)  ||  0194 
MOVE_LEFT_END  0x052   (0195)  ||  0234 0247 
MOVE_RIGHT     0x05D   (0212)  ||  0191 
MOVE_RIGHT_END 0x050   (0192)  ||  0049 0216 0228 
MOVE_UP        0x06E   (0249)  ||  0197 
MOVE_UP_END    0x054   (0198)  ||  0253 0265 
START          0x02C   (0130)  ||  0137 
T1             0x03A   (0162)  ||  0172 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0010)  ||  0128 0289 
BUTTON         0x09A   (0018)  ||  0187 
FOR_COUNT      0x0AA   (0019)  ||  0203 0205 
LEDS           0x040   (0008)  ||  0045 0188 
M_BLACK        0x000   (0015)  ||  
M_BLUE         0x013   (0014)  ||  
M_BROWN        0x090   (0016)  ||  
M_RED          0x0E0   (0013)  ||  
M_YELLOW       0x0E0   (0012)  ||  0057 0178 0225 0244 0262 0281 
SSEG           0x081   (0007)  ||  
VGA_COLOR      0x092   (0006)  ||  0167 
VGA_HADD       0x090   (0004)  ||  0166 
VGA_LADD       0x091   (0005)  ||  0165 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
