

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
(0007)                       147  || .EQU VGA_READ = 0x93
(0008)                       129  || .EQU SSEG = 0x81
(0009)                       064  || .EQU LEDS = 0x40
(0010)                            || 
(0011)                       255  || .EQU BG_COLOR       = 0xFF ; Background:  white
(0012)                       224  || .EQU M_YELLOW		= 0xE0 ;0xF8
(0013)                       224  || .EQU M_RED			= 0xE0
(0014)                       000  || .EQU M_BLACK		= 0x00
(0015)                       028  || .EQU M_GREEN		= 0x1C
(0016)                            || 
(0017)                       154  || .EQU button         = 0x9A
(0018)                       170  || .EQU For_Count		= 0xAA
(0019)                            || 
(0020)                            || ;r6 is used for color
(0021)                            || ;r7 is used for Y
(0022)                            || ;r8 is used for X
(0023)                            || ;r9 is used for ending coordinate
(0024)                            || ;r10 is used for block's y coordinate
(0025)                            || ;r11 is used for block's x coordinate
(0026)                            || ;r15 is used for button inputs
(0027)                            || 
(0028)                            || ;---------------------------------------------------------------------
(0029)                            || 
(0030)                            || ;---------------------------------------------------------------------
(0031)                            || ;- Main routine
(0032)                            || ;- 
(0033)                            || ;- Runs main program:
(0034)                            || ;- 		initializes background display and dot
(0035)                            || ;- 		takes in input from button to move dot
(0036)                            || ;-		continuously checks if block is at endpoint
(0037)                            || ;- 		draws win screen when player wins
(0038)                            || ;---------------------------------------------------------------------
(0039)                     0x010  || init:
(0040)  CS-0x010  0x08139         ||         CALL   draw_background		;draws everything white
(0041)  CS-0x011  0x08521         || 		CALL	draw_maze			;draws maze on background
(0042)                            || 		
(0043)  CS-0x012  0x08299         || 		CALL	draw_block			;initializes placement of block at beginning
(0044)                            || 
(0045)  CS-0x013  0x082D1  0x013  || main:   CALL	move_block			;moves based on button inputs
(0046)                            || 
(0047)                            || 		;checks to see when block reaches endpoint
(0048)  CS-0x014  0x30B25         || 		CMP		r11, 0x25
(0049)  CS-0x015  0x0809B         || 		BRNE	main
(0050)  CS-0x016  0x30A1B         || 		CMP		r10, 0x1b
(0051)  CS-0x017  0x0809B         || 		BRNE	main
(0052)                            || 
(0053)  CS-0x018  0x08139         || 		CALL	draw_background		;erases maze drawing
(0054)                            || 
(0055)                     0x019  || win_screen:
(0056)  CS-0x019  0x09569         || 		CALL	draw_win			;drawing win screen message
(0057)  CS-0x01A  0x080C8         || 		BRN		win_screen			;reset to restart game
(0058)                            || 
(0059)                            || ;--------------------------------------------------------------------
(0060)                            || 
(0061)                            || ;--------------------------------------------------------------------
(0062)                            || ;-  Subroutine: draw_horizontal_line
(0063)                            || ;-
(0064)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0065)                            || ;-
(0066)                            || ;-  Parameters:
(0067)                            || ;-   r8  = starting x-coordinate
(0068)                            || ;-   r7  = y-coordinate
(0069)                            || ;-   r9  = ending x-coordinate
(0070)                            || ;-   r6  = color used for line
(0071)                            || ;-
(0072)                            || ;- Tweaked registers: r8,r9
(0073)                            || ;--------------------------------------------------------------------
(0074)                            || 
(0075)                     0x01B  || draw_horizontal_line:
(0076)  CS-0x01B  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0077)                            || 
(0078)                     0x01C  || draw_horiz1:
(0079)  CS-0x01C  0x08189         ||         CALL   draw_dot         ; 
(0080)  CS-0x01D  0x28801         ||         ADD    r8,0x01
(0081)  CS-0x01E  0x04848         ||         CMP    r8,r9
(0082)  CS-0x01F  0x080E3         ||         BRNE   draw_horiz1
(0083)  CS-0x020  0x18002         ||         RET
(0084)                            || 
(0085)                            || ;--------------------------------------------------------------------
(0086)                            || 
(0087)                            || ;---------------------------------------------------------------------
(0088)                            || ;-  Subroutine: draw_vertical_line
(0089)                            || ;-
(0090)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0091)                            || ;-
(0092)                            || ;-  Parameters:
(0093)                            || ;-   r8  = x-coordinate
(0094)                            || ;-   r7  = starting y-coordinate
(0095)                            || ;-   r9  = ending y-coordinate
(0096)                            || ;-   r6  = color used for line
(0097)                            || ;- 
(0098)                            || ;- Tweaked registers: r7,r9
(0099)                            || ;--------------------------------------------------------------------
(0100)                            || 
(0101)                     0x021  || draw_vertical_line:
(0102)  CS-0x021  0x28901         ||          ADD    r9,0x01
(0103)                            || 
(0104)                     0x022  || draw_vert1:          
(0105)  CS-0x022  0x08189         ||          CALL   draw_dot
(0106)  CS-0x023  0x28701         ||          ADD    r7,0x01
(0107)  CS-0x024  0x04748         ||          CMP    r7,R9
(0108)  CS-0x025  0x08113         ||          BRNE   draw_vert1
(0109)  CS-0x026  0x18002         ||          RET
(0110)                            || 
(0111)                            || ;--------------------------------------------------------------------
(0112)                            || 
(0113)                            || ;---------------------------------------------------------------------
(0114)                            || ;-  Subroutine: draw_background
(0115)                            || ;-
(0116)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0117)                            || ;-  draw_horizontal_line subroutine. 
(0118)                            || ;- 
(0119)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0120)                            || ;----------------------------------------------------------------------
(0121)                            || 
(0122)                     0x027  || draw_background: 
(0123)  CS-0x027  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0124)  CS-0x028  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0125)  CS-0x029  0x04769  0x029  || start:   MOV   r7,r13                   ; load current row count 
(0126)  CS-0x02A  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0127)  CS-0x02B  0x36927         ||          MOV   r9,0x27 
(0128)                            || 
(0129)  CS-0x02C  0x080D9         ||          CALL  draw_horizontal_line
(0130)  CS-0x02D  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0131)  CS-0x02E  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0132)  CS-0x02F  0x0814B         ||          BRNE  start                    ; branch to draw more rows
(0133)                            || 
(0134)  CS-0x030  0x18002         ||          RET
(0135)                            || 
(0136)                            || ;---------------------------------------------------------------------
(0137)                            || 
(0138)                            ||  
(0139)                            || ;---------------------------------------------------------------------
(0140)                            || ;- Subrountine: draw_dot
(0141)                            || ;- 
(0142)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0143)                            || ;- 
(0144)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0145)                            || ;- 
(0146)                            || ;- Tweaked registers: r4,r5
(0147)                            || ;---------------------------------------------------------------------
(0148)                            || 
(0149)                     0x031  || draw_dot: 
(0150)  CS-0x031  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0151)  CS-0x032  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0152)                            || 
(0153)  CS-0x033  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0154)  CS-0x034  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0155)  CS-0x035  0x10401         ||            LSR   r4            ; need to get the bot 2 bits of r4 into sA
(0156)  CS-0x036  0x0A1E8         ||            BRCS  dd_add40
(0157)                            || 
(0158)  CS-0x037  0x10401  0x037  || t1:        LSR   r4
(0159)  CS-0x038  0x0A200         ||            BRCS  dd_add80
(0160)                            || 
(0161)  CS-0x039  0x34591  0x039  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0162)  CS-0x03A  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0163)  CS-0x03B  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0164)  CS-0x03C  0x18002         ||            RET
(0165)                            || 
(0166)  CS-0x03D  0x22540  0x03D  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0167)  CS-0x03E  0x18000         ||            CLC                 ; freshen bit
(0168)  CS-0x03F  0x081B8         ||            BRN   t1             
(0169)                            || 
(0170)  CS-0x040  0x22580  0x040  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0171)  CS-0x041  0x081C8         ||            BRN   dd_out
(0172)                            || ; --------------------------------------------------------------------
(0173)                            || 
(0174)                            || ;---------------------------------------------------------------------
(0175)                            || ;- Subrountine: read_dot
(0176)                            || ;- 
(0177)                            || ;- This subroutine reads the color of a dot on the display the given coordinates: 
(0178)                            || ;- 
(0179)                            || ;- (X,Y) = (r8,r7)  and stores the color into r6
(0180)                            || ;---------------------------------------------------------------------
(0181)                     0x042  || read_dot: 
(0182)  CS-0x042  0x05339         ||            MOV   r19,r7         ; copy Y coordinate
(0183)  CS-0x043  0x05441         ||            MOV   r20,r8         ; copy X coordinate
(0184)                            || 
(0185)  CS-0x044  0x2143F         ||            AND   r20,0x3F       ; make sure top 2 bits cleared
(0186)  CS-0x045  0x2131F         ||            AND   r19,0x1F       ; make sure top 3 bits cleared
(0187)  CS-0x046  0x11301         ||            LSR   r19            ; need to get the bot 2 bits of r4 into sA
(0188)  CS-0x047  0x0A270         ||            BRCS  xdd_add40
(0189)                            || 
(0190)  CS-0x048  0x11301  0x048  || xt1:       LSR   r19
(0191)  CS-0x049  0x0A288         ||            BRCS  xdd_add80
(0192)                            || 
(0193)  CS-0x04A  0x35491  0x04A  || xdd_out:   OUT   r20,VGA_LADD   ; write bot 8 address bits to register
(0194)  CS-0x04B  0x35390         ||            OUT   r19,VGA_HADD   ; write top 3 address bits to register
(0195)  CS-0x04C  0x32693         ||            IN	 r6,VGA_READ  	; takes in data
(0196)  CS-0x04D  0x18002         ||            RET
(0197)                            || 
(0198)  CS-0x04E  0x23440  0x04E  || xdd_add40: OR    r20,0x40       ; set bit if needed
(0199)  CS-0x04F  0x18000         ||            CLC                  ; freshen bit
(0200)  CS-0x050  0x08240         ||            BRN   xt1             
(0201)                            || 
(0202)  CS-0x051  0x23480  0x051  || xdd_add80:  OR    r20,0x80      ; set bit if needed
(0203)  CS-0x052  0x08250         ||            BRN   xdd_out
(0204)                            || 
(0205)                            || ; --------------------------------------------------------------------
(0206)                            || 
(0207)                            || ;---------------------------------------------------------------------
(0208)                            || ;- Subrountine: draw_block
(0209)                            || ;- 
(0210)                            || ;- This subroutine draws a dot on the display at the beginning of the program: 
(0211)                            || ;- 
(0212)                            || ;- Tweaked registers: r4, r5 (draw_dot), r10, r11 (block location)
(0213)                            || ;---------------------------------------------------------------------
(0214)  CS-0x053  0x366E0  0x053  || draw_block: MOV r6,M_YELLOW
(0215)                            || 
(0216)  CS-0x054  0x36A01         || 			MOV r10,0x01
(0217)  CS-0x055  0x04751         || 			MOV r7, r10
(0218)  CS-0x056  0x36B01         || 			MOV r11,0x01
(0219)  CS-0x057  0x04859         || 			MOV r8, r11
(0220)  CS-0x058  0x08189         || 			CALL draw_dot
(0221)  CS-0x059  0x18002         || 			RET
(0222)                            || ; --------------------------------------------------------------------
(0223)                            || 
(0224)                            || ;---------------------------------------------------------------------
(0225)                            || ;- Subrountine: move_block
(0226)                            || ;- 
(0227)                            || ;- This subroutine completes the entirity of the block moving on the screen one step in any direction
(0228)                            || ;- based on the button inputs 
(0229)                            || ;- 
(0230)                            || ;- Tweaked registers: r15 (button), r16, r17, r18 (delays)
(0231)                            || ;---------------------------------------------------------------------
(0232)  CS-0x05A  0x32F9A  0x05A  || move_block: IN r15,button			;first 4 lsb bits are port mapped to the buttons
(0233)                            || 
(0234)  CS-0x05B  0x10F01         || 			LSR r15					;lsr will shift lsb into carry
(0235)  CS-0x05C  0x10F01         || 			LSR r15
            syntax error
            syntax error

(0236)  CS-0x05D  0x10F01         || 			LSR r15
            syntax error
            syntax error

(0237)  CS-0x05E  0x10F01         || 			LSR r15
            syntax error
            syntax error

(0238)                            || 
            syntax error
            syntax error

(0239)                            || 
(0240)                            || 
(0241)                            || 			;delay for a little less than a second
(0242)                            || 			;time delayed for was estimated
(0243)  CS-0x05F  0x370FF         || 			MOV r16, 0xFF
(0244)  CS-0x060  0x2D001  0x060  || 			outside_for0: SUB r16, 0x01
(0245)  CS-0x061  0x371FF         || 						  MOV r17, 0xFF
(0246)  CS-0x062  0x2D101  0x062  || 			middle_for0:  SUB r17, 0x01
(0247)                            || 					
(0248)  CS-0x063  0x3720F         || 						  MOV r18, 0x0F
(0249)  CS-0x064  0x2D201  0x064  || 			inside_for0:  SUB r18, 0x01
(0250)  CS-0x065  0x08323         || 						  BRNE inside_for0
(0251)  CS-0x066  0x23100         || 			OR R17, 0x00
(0252)  CS-0x067  0x08313         || 			BRNE middle_for0
(0253)  CS-0x068  0x23000         || 			OR R16, 0x00
(0254)  CS-0x069  0x08303         || 			BRNE outside_for0
(0255)                            || 
(0256)                            || 
(0257)  CS-0x06A  0x18002         || 			RET
(0258)                            || 
(0259)                            || ;---------------------------------------------------------------------
(0260)                            || ;- Subrountine: move_block
(0261)                            || ;- 
(0262)                            || ;- This subroutine completes the entirity of the block moving on the screen one step in any direction
(0263)                            || ;- based on the button inputs 
(0264)                            || ;- 
(0265)                            || ;- Tweaked registers: r15 (button), r16, r17, r18 (delays)
(0266)                            || ;---------------------------------------------------------------------
(0267)                     0x06B  || move_right:
(0268)                            || 		
(0269)                            || 		;maze boundary check
(0270)  CS-0x06B  0x04859         || 		MOV		r8, r11		;set location to dot being checked
(0271)  CS-0x06C  0x04751         || 		MOV		r7, r10
(0272)  CS-0x06D  0x28801         || 		ADD		r8, 0x01
(0273)  CS-0x06E  0x08211         || 		CALL	read_dot	;r6 now has the color of the dot right of the block
(0274)  CS-0x06F  0x30600         || 		CMP	   	r6, M_BLACK
(0275)                            || 		BREQ 	RET			;if the dot right of the block is black, don't move block anywhere
            syntax error

(0276)                            || 		
(0277)  CS-0x070  0x34640         || 		OUT		r6, LEDS
(0278)                            || 
(0279)  CS-0x071  0x084F9         || 		CALL	draw_at_prev_loc 	;draw white over where dot is
(0280)                            || 
(0281)                            || 		;draw pixel at new location
(0282)  CS-0x072  0x28B01         || 		ADD	   r11, 0x01			;move dot location one to the right
(0283)  CS-0x073  0x04751         || 		MOV    r7, r10
(0284)  CS-0x074  0x04859         || 		MOV    r8, r11
(0285)  CS-0x075  0x366E0         || 		MOV    r6, M_YELLOW
(0286)  CS-0x076  0x08189         || 		CALL   draw_dot				;draw
(0287)                            || 
(0288)  CS-0x077  0x18002         || 		RET
(0289)                            || 
(0290)                            || ;---------------------------------------------------------------------
(0291)                            || ;- Subrountine: move_block
(0292)                            || ;- 
(0293)                            || ;- This subroutine completes the entirity of the block moving on the screen one step in any direction
(0294)                            || ;- based on the button inputs 
(0295)                            || ;- 
(0296)                            || ;- Tweaked registers: r15 (button), r16, r17, r18 (delays)
(0297)                            || ;---------------------------------------------------------------------
(0298)                            || 
(0299)                     0x078  || move_left:
(0300)                            || 		
(0301)                            || 		;maze boundary check
(0302)  CS-0x078  0x04859         || 		MOV		r8, r11
(0303)  CS-0x079  0x04751         || 		MOV		r7, r10
(0304)  CS-0x07A  0x2C801         || 		SUB		r8, 0x01
(0305)  CS-0x07B  0x08211         || 		CALL	read_dot
(0306)  CS-0x07C  0x30600         || 		CMP	   	r6, M_BLACK
(0307)                            || 		BREQ	RET
            syntax error

(0308)                            || 
(0309)  CS-0x07D  0x34640         || 		OUT		r6, LEDS
(0310)                            || 		
(0311)  CS-0x07E  0x084F9         || 		CALL	draw_at_prev_loc
(0312)                            || 
(0313)                            || 		;draw pixel at new location
(0314)  CS-0x07F  0x2CB01         || 		SUB	   r11, 0x01
(0315)  CS-0x080  0x04751         || 		MOV    r7, r10
(0316)  CS-0x081  0x04859         || 		MOV    r8, r11
(0317)  CS-0x082  0x366E0         || 		MOV    r6, M_YELLOW
(0318)  CS-0x083  0x08189         || 		CALL   draw_dot
(0319)                            || 
(0320)  CS-0x084  0x18002         || 		RET
(0321)                            || 
(0322)                     0x085  || move_up:
(0323)                            || 		
(0324)                            || 		;maze boundary check
(0325)  CS-0x085  0x04751         || 		MOV		r7, r10
(0326)  CS-0x086  0x04859         || 		MOV		r8, r11
(0327)  CS-0x087  0x2C701         || 		SUB		r7, 0x01
(0328)  CS-0x088  0x08211         || 		CALL	read_dot
(0329)  CS-0x089  0x30600         || 		CMP	   	r6, M_BLACK
(0330)                            || 		BREQ	RET
            syntax error

(0331)                            || 		
(0332)  CS-0x08A  0x34640         || 		OUT		r6, LEDS
(0333)                            || 
(0334)  CS-0x08B  0x084F9         || 		CALL	draw_at_prev_loc
(0335)                            || 
(0336)                            || 		;draw pixel at new location
(0337)  CS-0x08C  0x2CA01         || 		SUB	   r10, 0x01
(0338)  CS-0x08D  0x04751         || 		MOV    r7, r10
(0339)  CS-0x08E  0x04859         || 		MOV    r8, r11
(0340)  CS-0x08F  0x366E0         || 		MOV    r6, M_YELLOW
(0341)  CS-0x090  0x08189         || 		CALL   draw_dot
(0342)                            || 
(0343)  CS-0x091  0x18002         || 		RET
(0344)                            || 
(0345)                     0x092  || move_down:
(0346)                            || 		
(0347)                            || 		;maze boundary check
(0348)  CS-0x092  0x04751         || 		MOV		r7, r10
(0349)  CS-0x093  0x04859         || 		MOV		r8, r11
(0350)  CS-0x094  0x28701         || 		ADD		r7, 0x01
(0351)  CS-0x095  0x08211         || 		CALL	read_dot
(0352)  CS-0x096  0x30600         || 		CMP	   	r6, M_BLACK
(0353)                            || 		BREQ	RET
            syntax error

(0354)                            || 
(0355)  CS-0x097  0x34640         || 		OUT		r6, LEDS
(0356)                            || 		
(0357)  CS-0x098  0x084F9         || 		CALL	draw_at_prev_loc
(0358)                            || 
(0359)                            || 		;draw pixel at new location
(0360)  CS-0x099  0x28A01         || 		ADD	   r10, 0x01
(0361)  CS-0x09A  0x04751         || 		MOV    r7, r10
(0362)  CS-0x09B  0x04859         || 		MOV    r8, r11
(0363)  CS-0x09C  0x366E0         ||         MOV    r6, M_YELLOW
(0364)  CS-0x09D  0x08189         || 		CALL   draw_dot
(0365)                            || 
(0366)  CS-0x09E  0x18002         || 		RET
(0367)                            || 
(0368)                     0x09F  || draw_at_prev_loc:
(0369)  CS-0x09F  0x04751         || 		MOV    r7, r10
(0370)  CS-0x0A0  0x04859         || 		MOV    r8, r11
(0371)  CS-0x0A1  0x366FF         || 		MOV    r6, BG_COLOR
(0372)  CS-0x0A2  0x08189         || 		CALL   draw_dot
(0373)  CS-0x0A3  0x18002         || 		RET
(0374)                            || 
(0375)                     0x0A4  || draw_maze: 
(0376)                            || 
(0377)                            || 		;endpoint
(0378)  CS-0x0A4  0x3661C         || 		MOV r6,M_GREEN
(0379)                            || 
(0380)  CS-0x0A5  0x36825         || 		MOV r8,0x25  ; x coordinate
(0381)  CS-0x0A6  0x3671B         || 		MOV r7,0x1B	 ; y coordinate
(0382)  CS-0x0A7  0x08189         || 		CALL draw_dot
(0383)                            || 
(0384)                            || 
(0385)  CS-0x0A8  0x36600         || 		MOV r6,M_BLACK
(0386)                            || 
(0387)  CS-0x0A9  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0388)  CS-0x0AA  0x36700         || 		MOV r7,0x00   ; y coordinate
(0389)  CS-0x0AB  0x36926         || 		MOV r9,0x26   ; ending x coordinate
(0390)  CS-0x0AC  0x080D9         || 		CALL draw_horizontal_line
(0391)                            || 
(0392)  CS-0x0AD  0x36800         || 		MOV r8,0x00   ; x coordinate
(0393)  CS-0x0AE  0x36701         || 		MOV r7,0x01	 ; starting y coordinate
(0394)  CS-0x0AF  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0395)  CS-0x0B0  0x08109         || 		CALL draw_vertical_line
(0396)                            || 
(0397)  CS-0x0B1  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0398)  CS-0x0B2  0x3671C         || 		MOV r7,0x1C   ; y coordinate
(0399)  CS-0x0B3  0x36926         || 		MOV r9,0x26   ; ending x coordinate
(0400)  CS-0x0B4  0x080D9         || 		CALL draw_horizontal_line
(0401)                            || 
(0402)  CS-0x0B5  0x36826         || 		MOV r8,0x26   ; x coordinate
(0403)  CS-0x0B6  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0404)  CS-0x0B7  0x3691B         || 		MOV r9,0x1B	 ; ending y coordinate
(0405)  CS-0x0B8  0x08109         || 		CALL draw_vertical_line
(0406)                            || 
(0407)  CS-0x0B9  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0408)  CS-0x0BA  0x3671D         || 		MOV r7,0x1D   ; y coordinate
(0409)  CS-0x0BB  0x36927         || 		MOV r9,0x27   ; ending x coordinate
(0410)  CS-0x0BC  0x080D9         || 		CALL draw_horizontal_line
(0411)                            || 
(0412)  CS-0x0BD  0x36827         || 		MOV r8,0x27   ; x coordinate
(0413)  CS-0x0BE  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0414)  CS-0x0BF  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0415)  CS-0x0C0  0x08109         || 		CALL draw_vertical_line
(0416)                            || 
(0417)  CS-0x0C1  0x36800         || 		MOV r8,0x00  ; starting x coordinate
(0418)  CS-0x0C2  0x36702         || 		MOV r7,0x02   ; y coordinate
(0419)  CS-0x0C3  0x36902         || 		MOV r9,0x02   ; ending x coordinate
(0420)  CS-0x0C4  0x080D9         || 		CALL draw_horizontal_line
(0421)                            || 
(0422)  CS-0x0C5  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0423)  CS-0x0C6  0x36706         || 		MOV r7,0x06   ; y coordinate
(0424)  CS-0x0C7  0x36904         || 		MOV r9,0x04   ; ending x coordinate
(0425)  CS-0x0C8  0x080D9         || 		CALL draw_horizontal_line
(0426)                            || 
(0427)  CS-0x0C9  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0428)  CS-0x0CA  0x36708         || 		MOV r7,0x08   ; y coordinate
(0429)  CS-0x0CB  0x36908         || 		MOV r9,0x08   ; ending x coordinate
(0430)  CS-0x0CC  0x080D9         || 		CALL draw_horizontal_line
(0431)                            || 
(0432)  CS-0x0CD  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0433)  CS-0x0CE  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0434)  CS-0x0CF  0x36902         || 		MOV r9,0x02   ; ending x coordinate
(0435)  CS-0x0D0  0x080D9         || 		CALL draw_horizontal_line
(0436)                            || 
(0437)  CS-0x0D1  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0438)  CS-0x0D2  0x36716         || 		MOV r7,0x16   ; y coordinate
(0439)  CS-0x0D3  0x36904         || 		MOV r9,0x04   ; ending x coordinate
(0440)  CS-0x0D4  0x080D9         || 		CALL draw_horizontal_line
(0441)                            || 
(0442)  CS-0x0D5  0x36802         || 		MOV r8,0x02  ; x coordinate
(0443)  CS-0x0D6  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0444)  CS-0x0D7  0x36904         || 		MOV r9,0x04	 ; ending y coordinate
(0445)  CS-0x0D8  0x08109         || 		CALL draw_vertical_line
(0446)                            || 
(0447)  CS-0x0D9  0x36802         || 		MOV r8,0x02  ; x coordinate
(0448)  CS-0x0DA  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0449)  CS-0x0DB  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0450)  CS-0x0DC  0x08109         || 		CALL draw_vertical_line
(0451)                            || 
(0452)  CS-0x0DD  0x36802         || 		MOV r8,0x02  ; x coordinate
(0453)  CS-0x0DE  0x3670C         || 		MOV r7,0x0C	 ; starting y coordinate
(0454)  CS-0x0DF  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(0455)  CS-0x0E0  0x08109         || 		CALL draw_vertical_line
(0456)                            || 
(0457)  CS-0x0E1  0x36802         || 		MOV r8,0x02  ; x coordinate
(0458)  CS-0x0E2  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0459)  CS-0x0E3  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0460)  CS-0x0E4  0x08109         || 		CALL draw_vertical_line
(0461)                            || 
(0462)  CS-0x0E5  0x36802         || 		MOV r8,0x02  ; x coordinate
(0463)  CS-0x0E6  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0464)  CS-0x0E7  0x36918         || 		MOV r9,0x18	 ; ending y coordinate
(0465)  CS-0x0E8  0x08109         || 		CALL draw_vertical_line
(0466)                            || 
(0467)  CS-0x0E9  0x36802         || 		MOV r8,0x02  ; x coordinate
(0468)  CS-0x0EA  0x3671A         || 		MOV r7,0x1A	 ; starting y coordinate
(0469)  CS-0x0EB  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0470)  CS-0x0EC  0x08109         || 		CALL draw_vertical_line
(0471)                            || 
(0472)  CS-0x0ED  0x36802         || 		MOV r8,0x02   ; starting x coordinate
(0473)  CS-0x0EE  0x36714         || 		MOV r7,0x14   ; y coordinate
(0474)  CS-0x0EF  0x36906         || 		MOV r9,0x06   ; ending x coordinate
(0475)  CS-0x0F0  0x080D9         || 		CALL draw_horizontal_line
(0476)                            || 
(0477)  CS-0x0F1  0x36804         || 		MOV r8,0x04  ; x coordinate
(0478)  CS-0x0F2  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0479)  CS-0x0F3  0x36904         || 		MOV r9,0x04	 ; ending y coordinate
(0480)  CS-0x0F4  0x08109         || 		CALL draw_vertical_line
(0481)                            || 
(0482)  CS-0x0F5  0x36804         || 		MOV r8,0x04  ; x coordinate
(0483)  CS-0x0F6  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0484)  CS-0x0F7  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0485)  CS-0x0F8  0x08109         || 		CALL draw_vertical_line
(0486)                            || 
(0487)  CS-0x0F9  0x36804         || 		MOV r8,0x04  ; x coordinate
(0488)  CS-0x0FA  0x36710         || 		MOV r7,0x10	 ; starting y coordinate
(0489)  CS-0x0FB  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0490)  CS-0x0FC  0x08109         || 		CALL draw_vertical_line
(0491)                            || 
(0492)  CS-0x0FD  0x36804         || 		MOV r8,0x04  ; x coordinate
(0493)  CS-0x0FE  0x36718         || 		MOV r7,0x18	 ; starting y coordinate
(0494)  CS-0x0FF  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0495)  CS-0x100  0x08109         || 		CALL draw_vertical_line
(0496)                            || 
(0497)  CS-0x101  0x36804         || 		MOV r8,0x04   ; starting x coordinate
(0498)  CS-0x102  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0499)  CS-0x103  0x36906         || 		MOV r9,0x06   ; ending x coordinate
(0500)  CS-0x104  0x080D9         || 		CALL draw_horizontal_line
(0501)                            || 
(0502)  CS-0x105  0x36804         || 		MOV r8,0x04   ; starting x coordinate
(0503)  CS-0x106  0x3670A         || 		MOV r7,0x0A   ; y coordinate
(0504)  CS-0x107  0x36906         || 		MOV r9,0x06   ; ending x coordinate
(0505)  CS-0x108  0x080D9         || 		CALL draw_horizontal_line
(0506)                            || 
(0507)  CS-0x109  0x36804         || 		MOV r8,0x04   ; starting x coordinate
(0508)  CS-0x10A  0x3671A         || 		MOV r7,0x1A   ; y coordinate
(0509)  CS-0x10B  0x36906         || 		MOV r9,0x06   ; ending x coordinate
(0510)  CS-0x10C  0x080D9         || 		CALL draw_horizontal_line
(0511)                            || 
(0512)  CS-0x10D  0x36806         || 		MOV r8,0x06  ; x coordinate
(0513)  CS-0x10E  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0514)  CS-0x10F  0x36904         || 		MOV r9,0x04	 ; ending y coordinate
(0515)  CS-0x110  0x08109         || 		CALL draw_vertical_line
(0516)                            || 
(0517)  CS-0x111  0x36806         || 		MOV r8,0x06  ; x coordinate
(0518)  CS-0x112  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0519)  CS-0x113  0x36908         || 		MOV r9,0x08	 ; ending y coordinate
(0520)  CS-0x114  0x08109         || 		CALL draw_vertical_line
(0521)                            || 
(0522)  CS-0x115  0x36806         || 		MOV r8,0x06  ; x coordinate
(0523)  CS-0x116  0x3670A         || 		MOV r7,0x0A	 ; starting y coordinate
(0524)  CS-0x117  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0525)  CS-0x118  0x08109         || 		CALL draw_vertical_line
(0526)                            || 
(0527)  CS-0x119  0x36806         || 		MOV r8,0x06  ; x coordinate
(0528)  CS-0x11A  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0529)  CS-0x11B  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0530)  CS-0x11C  0x08109         || 		CALL draw_vertical_line
(0531)                            || 
(0532)  CS-0x11D  0x36806         || 		MOV r8,0x06  ; x coordinate
(0533)  CS-0x11E  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0534)  CS-0x11F  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0535)  CS-0x120  0x08109         || 		CALL draw_vertical_line
(0536)                            || 
(0537)  CS-0x121  0x36806         || 		MOV r8,0x06   ; starting x coordinate
(0538)  CS-0x122  0x36702         || 		MOV r7,0x02   ; y coordinate
(0539)  CS-0x123  0x3690C         || 		MOV r9,0x0C   ; ending x coordinate
(0540)  CS-0x124  0x080D9         || 		CALL draw_horizontal_line
(0541)                            || 
(0542)  CS-0x125  0x36806         || 		MOV r8,0x06   ; starting x coordinate
(0543)  CS-0x126  0x36704         || 		MOV r7,0x04   ; y coordinate
(0544)  CS-0x127  0x3690A         || 		MOV r9,0x0A   ; ending x coordinate
(0545)  CS-0x128  0x080D9         || 		CALL draw_horizontal_line
(0546)                            || 
(0547)  CS-0x129  0x36806         || 		MOV r8,0x06   ; starting x coordinate
(0548)  CS-0x12A  0x36712         || 		MOV r7,0x12   ; y coordinate
(0549)  CS-0x12B  0x36908         || 		MOV r9,0x08   ; ending x coordinate
(0550)  CS-0x12C  0x080D9         || 		CALL draw_horizontal_line
(0551)                            || 
(0552)  CS-0x12D  0x36806         || 		MOV r8,0x06   ; starting x coordinate
(0553)  CS-0x12E  0x36718         || 		MOV r7,0x18   ; y coordinate
(0554)  CS-0x12F  0x36908         || 		MOV r9,0x08   ; ending x coordinate
(0555)  CS-0x130  0x080D9         || 		CALL draw_horizontal_line
(0556)                            || 
(0557)  CS-0x131  0x36808         || 		MOV r8,0x08  ; x coordinate
(0558)  CS-0x132  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0559)  CS-0x133  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0560)  CS-0x134  0x08109         || 		CALL draw_vertical_line
(0561)                            || 
(0562)  CS-0x135  0x36808         || 		MOV r8,0x08  ; x coordinate
(0563)  CS-0x136  0x3670C         || 		MOV r7,0x0C	 ; starting y coordinate
(0564)  CS-0x137  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0565)  CS-0x138  0x08109         || 		CALL draw_vertical_line
(0566)                            || 
(0567)  CS-0x139  0x36808         || 		MOV r8,0x08  ; x coordinate
(0568)  CS-0x13A  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0569)  CS-0x13B  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0570)  CS-0x13C  0x08109         || 		CALL draw_vertical_line
(0571)                            || 
(0572)  CS-0x13D  0x36808         || 		MOV r8,0x08  ; x coordinate
(0573)  CS-0x13E  0x36718         || 		MOV r7,0x18	 ; starting y coordinate
(0574)  CS-0x13F  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0575)  CS-0x140  0x08109         || 		CALL draw_vertical_line
(0576)                            || 
(0577)  CS-0x141  0x36808         || 		MOV r8,0x08   ; starting x coordinate
(0578)  CS-0x142  0x36706         || 		MOV r7,0x06   ; y coordinate
(0579)  CS-0x143  0x3690A         || 		MOV r9,0x0A   ; ending x coordinate
(0580)  CS-0x144  0x080D9         || 		CALL draw_horizontal_line
(0581)                            || 
(0582)  CS-0x145  0x36808         || 		MOV r8,0x08   ; starting x coordinate
(0583)  CS-0x146  0x3670C         || 		MOV r7,0x0C   ; y coordinate
(0584)  CS-0x147  0x3690A         || 		MOV r9,0x0A   ; ending x coordinate
(0585)  CS-0x148  0x080D9         || 		CALL draw_horizontal_line
(0586)                            || 
(0587)  CS-0x149  0x36808         || 		MOV r8,0x08   ; starting x coordinate
(0588)  CS-0x14A  0x36710         || 		MOV r7,0x10   ; y coordinate
(0589)  CS-0x14B  0x3690E         || 		MOV r9,0x0E   ; ending x coordinate
(0590)  CS-0x14C  0x080D9         || 		CALL draw_horizontal_line
(0591)                            || 
(0592)  CS-0x14D  0x36808         || 		MOV r8,0x08   ; starting x coordinate
(0593)  CS-0x14E  0x36714         || 		MOV r7,0x14   ; y coordinate
(0594)  CS-0x14F  0x3690C         || 		MOV r9,0x0C   ; ending x coordinate
(0595)  CS-0x150  0x080D9         || 		CALL draw_horizontal_line
(0596)                            || 
(0597)  CS-0x151  0x3680A         || 		MOV r8,0x0A  ; x coordinate
(0598)  CS-0x152  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0599)  CS-0x153  0x36908         || 		MOV r9,0x08	 ; ending y coordinate
(0600)  CS-0x154  0x08109         || 		CALL draw_vertical_line
(0601)                            || 
(0602)  CS-0x155  0x3680A         || 		MOV r8,0x0A  ; x coordinate
(0603)  CS-0x156  0x3670A         || 		MOV r7,0x0A	 ; starting y coordinate
(0604)  CS-0x157  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0605)  CS-0x158  0x08109         || 		CALL draw_vertical_line
(0606)                            || 
(0607)  CS-0x159  0x3680A         || 		MOV r8,0x0A  ; x coordinate
(0608)  CS-0x15A  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0609)  CS-0x15B  0x36912         || 		MOV r9,0x12	 ; ending y coordinate
(0610)  CS-0x15C  0x08109         || 		CALL draw_vertical_line
(0611)                            || 
(0612)  CS-0x15D  0x3680A         || 		MOV r8,0x0A  ; x coordinate
(0613)  CS-0x15E  0x36714         || 		MOV r7,0x14	 ; starting y coordinate
(0614)  CS-0x15F  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0615)  CS-0x160  0x08109         || 		CALL draw_vertical_line
(0616)                            || 
(0617)  CS-0x161  0x3680A         || 		MOV r8,0x0A   ; starting x coordinate
(0618)  CS-0x162  0x3670A         || 		MOV r7,0x0A   ; y coordinate
(0619)  CS-0x163  0x3690E         || 		MOV r9,0x0E   ; ending x coordinate
(0620)  CS-0x164  0x080D9         || 		CALL draw_horizontal_line
(0621)                            || 
(0622)  CS-0x165  0x3680A         || 		MOV r8,0x0A   ; starting x coordinate
(0623)  CS-0x166  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0624)  CS-0x167  0x3690C         || 		MOV r9,0x0C   ; ending x coordinate
(0625)  CS-0x168  0x080D9         || 		CALL draw_horizontal_line
(0626)                            || 
(0627)  CS-0x169  0x3680A         || 		MOV r8,0x0A   ; starting x coordinate
(0628)  CS-0x16A  0x36716         || 		MOV r7,0x16   ; y coordinate
(0629)  CS-0x16B  0x3690C         || 		MOV r9,0x0C   ; ending x coordinate
(0630)  CS-0x16C  0x080D9         || 		CALL draw_horizontal_line
(0631)                            || 
(0632)  CS-0x16D  0x3680C         || 		MOV r8,0x0C  ; x coordinate
(0633)  CS-0x16E  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0634)  CS-0x16F  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0635)  CS-0x170  0x08109         || 		CALL draw_vertical_line
(0636)                            || 
(0637)  CS-0x171  0x3680C         || 		MOV r8,0x0C  ; x coordinate
(0638)  CS-0x172  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0639)  CS-0x173  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0640)  CS-0x174  0x08109         || 		CALL draw_vertical_line
(0641)                            || 
(0642)  CS-0x175  0x3680C         || 		MOV r8,0x0C  ; x coordinate
(0643)  CS-0x176  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0644)  CS-0x177  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0645)  CS-0x178  0x08109         || 		CALL draw_vertical_line
(0646)                            || 
(0647)  CS-0x179  0x3680C         || 		MOV r8,0x0C  ; x coordinate
(0648)  CS-0x17A  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0649)  CS-0x17B  0x36918         || 		MOV r9,0x18	 ; ending y coordinate
(0650)  CS-0x17C  0x08109         || 		CALL draw_vertical_line
(0651)                            || 
(0652)  CS-0x17D  0x3680C         || 		MOV r8,0x0C   ; starting x coordinate
(0653)  CS-0x17E  0x36704         || 		MOV r7,0x04   ; y coordinate
(0654)  CS-0x17F  0x36918         || 		MOV r9,0x18   ; ending x coordinate
(0655)  CS-0x180  0x080D9         || 		CALL draw_horizontal_line
(0656)                            || 
(0657)  CS-0x181  0x3680C         || 		MOV r8,0x0C   ; starting x coordinate
(0658)  CS-0x182  0x3670C         || 		MOV r7,0x0C   ; y coordinate
(0659)  CS-0x183  0x3690E         || 		MOV r9,0x0E   ; ending x coordinate
(0660)  CS-0x184  0x080D9         || 		CALL draw_horizontal_line
(0661)                            || 
(0662)  CS-0x185  0x3680C         || 		MOV r8,0x0C   ; starting x coordinate
(0663)  CS-0x186  0x36718         || 		MOV r7,0x18   ; y coordinate
(0664)  CS-0x187  0x36910         || 		MOV r9,0x10   ; ending x coordinate
(0665)  CS-0x188  0x080D9         || 		CALL draw_horizontal_line
(0666)                            || 
(0667)  CS-0x189  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0668)  CS-0x18A  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0669)  CS-0x18B  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0670)  CS-0x18C  0x08109         || 		CALL draw_vertical_line
(0671)                            || 
(0672)  CS-0x18D  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0673)  CS-0x18E  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0674)  CS-0x18F  0x36906         || 		MOV r9,0x06	 ; ending y coordinate
(0675)  CS-0x190  0x08109         || 		CALL draw_vertical_line
(0676)                            || 
(0677)  CS-0x191  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0678)  CS-0x192  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0679)  CS-0x193  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0680)  CS-0x194  0x08109         || 		CALL draw_vertical_line
(0681)                            || 
(0682)  CS-0x195  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0683)  CS-0x196  0x36710         || 		MOV r7,0x10	 ; starting y coordinate
(0684)  CS-0x197  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0685)  CS-0x198  0x08109         || 		CALL draw_vertical_line
(0686)                            || 
(0687)  CS-0x199  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0688)  CS-0x19A  0x36718         || 		MOV r7,0x18	 ; starting y coordinate
(0689)  CS-0x19B  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0690)  CS-0x19C  0x08109         || 		CALL draw_vertical_line
(0691)                            || 
(0692)  CS-0x19D  0x3680E         || 		MOV r8,0x0E   ; starting x coordinate
(0693)  CS-0x19E  0x36702         || 		MOV r7,0x02   ; y coordinate
(0694)  CS-0x19F  0x36910         || 		MOV r9,0x10   ; ending x coordinate
(0695)  CS-0x1A0  0x080D9         || 		CALL draw_horizontal_line
(0696)                            || 
(0697)  CS-0x1A1  0x3680E         || 		MOV r8,0x0E   ; starting x coordinate
(0698)  CS-0x1A2  0x36708         || 		MOV r7,0x08   ; y coordinate
(0699)  CS-0x1A3  0x36912         || 		MOV r9,0x12   ; ending x coordinate
(0700)  CS-0x1A4  0x080D9         || 		CALL draw_horizontal_line
(0701)                            || 
(0702)  CS-0x1A5  0x3680E         || 		MOV r8,0x0E   ; starting x coordinate
(0703)  CS-0x1A6  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0704)  CS-0x1A7  0x36912         || 		MOV r9,0x12   ; ending x coordinate
(0705)  CS-0x1A8  0x080D9         || 		CALL draw_horizontal_line
(0706)                            || 
(0707)  CS-0x1A9  0x3680E         || 		MOV r8,0x0E   ; starting x coordinate
(0708)  CS-0x1AA  0x36716         || 		MOV r7,0x16   ; y coordinate
(0709)  CS-0x1AB  0x36912         || 		MOV r9,0x12   ; ending x coordinate
(0710)  CS-0x1AC  0x080D9         || 		CALL draw_horizontal_line
(0711)                            || 
(0712)  CS-0x1AD  0x36810         || 		MOV r8,0x10  ; x coordinate
(0713)  CS-0x1AE  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0714)  CS-0x1AF  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0715)  CS-0x1B0  0x08109         || 		CALL draw_vertical_line
(0716)                            || 
(0717)  CS-0x1B1  0x36810         || 		MOV r8,0x10  ; x coordinate
(0718)  CS-0x1B2  0x36710         || 		MOV r7,0x10	 ; starting y coordinate
(0719)  CS-0x1B3  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0720)  CS-0x1B4  0x08109         || 		CALL draw_vertical_line
(0721)                            || 
(0722)  CS-0x1B5  0x36810         || 		MOV r8,0x10   ; starting x coordinate
(0723)  CS-0x1B6  0x36710         || 		MOV r7,0x10   ; y coordinate
(0724)  CS-0x1B7  0x36916         || 		MOV r9,0x16   ; ending x coordinate
(0725)  CS-0x1B8  0x080D9         || 		CALL draw_horizontal_line
(0726)                            || 
(0727)  CS-0x1B9  0x36810         || 		MOV r8,0x10   ; starting x coordinate
(0728)  CS-0x1BA  0x36712         || 		MOV r7,0x12   ; y coordinate
(0729)  CS-0x1BB  0x36916         || 		MOV r9,0x16   ; ending x coordinate
(0730)  CS-0x1BC  0x080D9         || 		CALL draw_horizontal_line
(0731)                            || 
(0732)  CS-0x1BD  0x36810         || 		MOV r8,0x10   ; starting x coordinate
(0733)  CS-0x1BE  0x3671A         || 		MOV r7,0x1A   ; y coordinate
(0734)  CS-0x1BF  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0735)  CS-0x1C0  0x080D9         || 		CALL draw_horizontal_line
(0736)                            || 
(0737)  CS-0x1C1  0x36812         || 		MOV r8,0x12  ; x coordinate
(0738)  CS-0x1C2  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0739)  CS-0x1C3  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0740)  CS-0x1C4  0x08109         || 		CALL draw_vertical_line
(0741)                            || 
(0742)  CS-0x1C5  0x36812         || 		MOV r8,0x12  ; x coordinate
(0743)  CS-0x1C6  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0744)  CS-0x1C7  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0745)  CS-0x1C8  0x08109         || 		CALL draw_vertical_line
(0746)                            || 
(0747)  CS-0x1C9  0x36812         || 		MOV r8,0x12  ; x coordinate
(0748)  CS-0x1CA  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0749)  CS-0x1CB  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0750)  CS-0x1CC  0x08109         || 		CALL draw_vertical_line
(0751)                            || 
(0752)  CS-0x1CD  0x36812         || 		MOV r8,0x12   ; starting x coordinate
(0753)  CS-0x1CE  0x36702         || 		MOV r7,0x02   ; y coordinate
(0754)  CS-0x1CF  0x36914         || 		MOV r9,0x14   ; ending x coordinate
(0755)  CS-0x1D0  0x080D9         || 		CALL draw_horizontal_line
(0756)                            || 
(0757)  CS-0x1D1  0x36812         || 		MOV r8,0x12   ; starting x coordinate
(0758)  CS-0x1D2  0x36706         || 		MOV r7,0x06   ; y coordinate
(0759)  CS-0x1D3  0x36914         || 		MOV r9,0x14  ; ending x coordinate
(0760)  CS-0x1D4  0x080D9         || 		CALL draw_horizontal_line
(0761)                            || 
(0762)  CS-0x1D5  0x36812         || 		MOV r8,0x12   ; starting x coordinate
(0763)  CS-0x1D6  0x36714         || 		MOV r7,0x14   ; y coordinate
(0764)  CS-0x1D7  0x36916         || 		MOV r9,0x16   ; ending x coordinate
(0765)  CS-0x1D8  0x080D9         || 		CALL draw_horizontal_line
(0766)                            || 
(0767)  CS-0x1D9  0x36814         || 		MOV r8,0x14  ; x coordinate
(0768)  CS-0x1DA  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0769)  CS-0x1DB  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0770)  CS-0x1DC  0x08109         || 		CALL draw_vertical_line
(0771)                            || 
(0772)  CS-0x1DD  0x36814         || 		MOV r8,0x14  ; x coordinate
(0773)  CS-0x1DE  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0774)  CS-0x1DF  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0775)  CS-0x1E0  0x08109         || 		CALL draw_vertical_line
(0776)                            || 
(0777)  CS-0x1E1  0x36814         || 		MOV r8,0x14  ; x coordinate
(0778)  CS-0x1E2  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0779)  CS-0x1E3  0x36918         || 		MOV r9,0x18	 ; ending y coordinate
(0780)  CS-0x1E4  0x08109         || 		CALL draw_vertical_line
(0781)                            || 
(0782)  CS-0x1E5  0x36814         || 		MOV r8,0x14  ; x coordinate
(0783)  CS-0x1E6  0x3671A         || 		MOV r7,0x1A	 ; starting y coordinate
(0784)  CS-0x1E7  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0785)  CS-0x1E8  0x08109         || 		CALL draw_vertical_line
(0786)                            || 
(0787)  CS-0x1E9  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0788)  CS-0x1EA  0x36708         || 		MOV r7,0x08   ; y coordinate
(0789)  CS-0x1EB  0x36918         || 		MOV r9,0x18   ; ending x coordinate
(0790)  CS-0x1EC  0x080D9         || 		CALL draw_horizontal_line
(0791)                            || 
(0792)  CS-0x1ED  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0793)  CS-0x1EE  0x3670A         || 		MOV r7,0x0A   ; y coordinate
(0794)  CS-0x1EF  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0795)  CS-0x1F0  0x080D9         || 		CALL draw_horizontal_line
(0796)                            || 
(0797)  CS-0x1F1  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0798)  CS-0x1F2  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0799)  CS-0x1F3  0x36916         || 		MOV r9,0x16   ; ending x coordinate
(0800)  CS-0x1F4  0x080D9         || 		CALL draw_horizontal_line
(0801)                            || 
(0802)  CS-0x1F5  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0803)  CS-0x1F6  0x36716         || 		MOV r7,0x16   ; y coordinate
(0804)  CS-0x1F7  0x36918         || 		MOV r9,0x18   ; ending x coordinate
(0805)  CS-0x1F8  0x080D9         || 		CALL draw_horizontal_line
(0806)                            || 
(0807)  CS-0x1F9  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0808)  CS-0x1FA  0x36718         || 		MOV r7,0x18   ; y coordinate
(0809)  CS-0x1FB  0x36920         || 		MOV r9,0x20   ; ending x coordinate
(0810)  CS-0x1FC  0x080D9         || 		CALL draw_horizontal_line
(0811)                            || 
(0812)  CS-0x1FD  0x36816         || 		MOV r8,0x16  ; x coordinate
(0813)  CS-0x1FE  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0814)  CS-0x1FF  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0815)  CS-0x200  0x08109         || 		CALL draw_vertical_line
(0816)                            || 
(0817)  CS-0x201  0x36816         || 		MOV r8,0x16  ; x coordinate
(0818)  CS-0x202  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0819)  CS-0x203  0x36906         || 		MOV r9,0x06	 ; ending y coordinate
(0820)  CS-0x204  0x08109         || 		CALL draw_vertical_line
(0821)                            || 
(0822)  CS-0x205  0x36816         || 		MOV r8,0x16  ; x coordinate
(0823)  CS-0x206  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0824)  CS-0x207  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(0825)  CS-0x208  0x08109         || 		CALL draw_vertical_line
(0826)                            || 
(0827)  CS-0x209  0x36816         || 		MOV r8,0x16   ; starting x coordinate
(0828)  CS-0x20A  0x36702         || 		MOV r7,0x02   ; y coordinate
(0829)  CS-0x20B  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0830)  CS-0x20C  0x080D9         || 		CALL draw_horizontal_line
(0831)                            || 
(0832)  CS-0x20D  0x36816         || 		MOV r8,0x16   ; starting x coordinate
(0833)  CS-0x20E  0x3670C         || 		MOV r7,0x0C   ; y coordinate
(0834)  CS-0x20F  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0835)  CS-0x210  0x080D9         || 		CALL draw_horizontal_line
(0836)                            || 
(0837)  CS-0x211  0x36818         || 		MOV r8,0x18  ; x coordinate
(0838)  CS-0x212  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0839)  CS-0x213  0x36906         || 		MOV r9,0x06	 ; ending y coordinate
(0840)  CS-0x214  0x08109         || 		CALL draw_vertical_line
(0841)                            || 
(0842)  CS-0x215  0x36818         || 		MOV r8,0x18  ; x coordinate
(0843)  CS-0x216  0x3670A         || 		MOV r7,0x0A	 ; starting y coordinate
(0844)  CS-0x217  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0845)  CS-0x218  0x08109         || 		CALL draw_vertical_line
(0846)                            || 
(0847)  CS-0x219  0x36818         || 		MOV r8,0x18  ; x coordinate
(0848)  CS-0x21A  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0849)  CS-0x21B  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0850)  CS-0x21C  0x08109         || 		CALL draw_vertical_line
(0851)                            || 
(0852)  CS-0x21D  0x36818         || 		MOV r8,0x18   ; starting x coordinate
(0853)  CS-0x21E  0x36706         || 		MOV r7,0x06   ; y coordinate
(0854)  CS-0x21F  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0855)  CS-0x220  0x080D9         || 		CALL draw_horizontal_line
(0856)                            || 
(0857)  CS-0x221  0x36818         || 		MOV r8,0x18   ; starting x coordinate
(0858)  CS-0x222  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0859)  CS-0x223  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0860)  CS-0x224  0x080D9         || 		CALL draw_horizontal_line
(0861)                            || 
(0862)  CS-0x225  0x36818         || 		MOV r8,0x18   ; starting x coordinate
(0863)  CS-0x226  0x36710         || 		MOV r7,0x10   ; y coordinate
(0864)  CS-0x227  0x36926         || 		MOV r9,0x26   ; ending x coordinate
(0865)  CS-0x228  0x080D9         || 		CALL draw_horizontal_line
(0866)                            || 
(0867)  CS-0x229  0x36818         || 		MOV r8,0x18   ; starting x coordinate
(0868)  CS-0x22A  0x36712         || 		MOV r7,0x12   ; y coordinate
(0869)  CS-0x22B  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0870)  CS-0x22C  0x080D9         || 		CALL draw_horizontal_line
(0871)                            || 
(0872)  CS-0x22D  0x3681A         || 		MOV r8,0x1A  ; x coordinate
(0873)  CS-0x22E  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0874)  CS-0x22F  0x36904         || 		MOV r9,0x04	 ; ending y coordinate
(0875)  CS-0x230  0x08109         || 		CALL draw_vertical_line
(0876)                            || 
(0877)  CS-0x231  0x3681A         || 		MOV r8,0x1A  ; x coordinate
(0878)  CS-0x232  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0879)  CS-0x233  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0880)  CS-0x234  0x08109         || 		CALL draw_vertical_line
(0881)                            || 
(0882)  CS-0x235  0x3681A         || 		MOV r8,0x1A  ; x coordinate
(0883)  CS-0x236  0x36714         || 		MOV r7,0x14	 ; starting y coordinate
(0884)  CS-0x237  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0885)  CS-0x238  0x08109         || 		CALL draw_vertical_line
(0886)                            || 
(0887)  CS-0x239  0x3681C         || 		MOV r8,0x1C  ; x coordinate
(0888)  CS-0x23A  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0889)  CS-0x23B  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0890)  CS-0x23C  0x08109         || 		CALL draw_vertical_line
(0891)                            || 
(0892)  CS-0x23D  0x3681C         || 		MOV r8,0x1C  ; x coordinate
(0893)  CS-0x23E  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0894)  CS-0x23F  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(0895)  CS-0x240  0x08109         || 		CALL draw_vertical_line
(0896)                            || 
(0897)  CS-0x241  0x3681C         || 		MOV r8,0x1C  ; x coordinate
(0898)  CS-0x242  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0899)  CS-0x243  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0900)  CS-0x244  0x08109         || 		CALL draw_vertical_line
(0901)                            || 
(0902)  CS-0x245  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0903)  CS-0x246  0x36702         || 		MOV r7,0x02   ; y coordinate
(0904)  CS-0x247  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0905)  CS-0x248  0x080D9         || 		CALL draw_horizontal_line
(0906)                            || 
(0907)  CS-0x249  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0908)  CS-0x24A  0x36708         || 		MOV r7,0x08   ; y coordinate
(0909)  CS-0x24B  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0910)  CS-0x24C  0x080D9         || 		CALL draw_horizontal_line
(0911)                            || 
(0912)  CS-0x24D  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0913)  CS-0x24E  0x3670A         || 		MOV r7,0x0A   ; y coordinate
(0914)  CS-0x24F  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0915)  CS-0x250  0x080D9         || 		CALL draw_horizontal_line
(0916)                            || 
(0917)  CS-0x251  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0918)  CS-0x252  0x36712         || 		MOV r7,0x12   ; y coordinate
(0919)  CS-0x253  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0920)  CS-0x254  0x080D9         || 		CALL draw_horizontal_line
(0921)                            || 
(0922)  CS-0x255  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0923)  CS-0x256  0x36714         || 		MOV r7,0x14   ; y coordinate
(0924)  CS-0x257  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0925)  CS-0x258  0x080D9         || 		CALL draw_horizontal_line
(0926)                            || 
(0927)  CS-0x259  0x3681E         || 		MOV r8,0x1E  ; x coordinate
(0928)  CS-0x25A  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0929)  CS-0x25B  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0930)  CS-0x25C  0x08109         || 		CALL draw_vertical_line
(0931)                            || 
(0932)  CS-0x25D  0x3681E         || 		MOV r8,0x1E  ; x coordinate
(0933)  CS-0x25E  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0934)  CS-0x25F  0x36908         || 		MOV r9,0x08	 ; ending y coordinate
(0935)  CS-0x260  0x08109         || 		CALL draw_vertical_line
(0936)                            || 
(0937)  CS-0x261  0x3681E         || 		MOV r8,0x1E   ; starting x coordinate
(0938)  CS-0x262  0x36704         || 		MOV r7,0x04   ; y coordinate
(0939)  CS-0x263  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0940)  CS-0x264  0x080D9         || 		CALL draw_horizontal_line
(0941)                            || 
(0942)  CS-0x265  0x3681E         || 		MOV r8,0x1E   ; starting x coordinate
(0943)  CS-0x266  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0944)  CS-0x267  0x36920         || 		MOV r9,0x20   ; ending x coordinate
(0945)  CS-0x268  0x080D9         || 		CALL draw_horizontal_line
(0946)                            || 
(0947)  CS-0x269  0x3681E         || 		MOV r8,0x1E   ; starting x coordinate
(0948)  CS-0x26A  0x36716         || 		MOV r7,0x16   ; y coordinate
(0949)  CS-0x26B  0x36922         || 		MOV r9,0x22   ; ending x coordinate
(0950)  CS-0x26C  0x080D9         || 		CALL draw_horizontal_line
(0951)                            || 
(0952)  CS-0x26D  0x36820         || 		MOV r8,0x20  ; x coordinate
(0953)  CS-0x26E  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0954)  CS-0x26F  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(0955)  CS-0x270  0x08109         || 		CALL draw_vertical_line
(0956)                            || 
(0957)  CS-0x271  0x36820         || 		MOV r8,0x20  ; x coordinate
(0958)  CS-0x272  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0959)  CS-0x273  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0960)  CS-0x274  0x08109         || 		CALL draw_vertical_line
(0961)                            || 
(0962)  CS-0x275  0x36820         || 		MOV r8,0x20  ; x coordinate
(0963)  CS-0x276  0x36718         || 		MOV r7,0x18	 ; starting y coordinate
(0964)  CS-0x277  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0965)  CS-0x278  0x08109         || 		CALL draw_vertical_line
(0966)                            || 
(0967)  CS-0x279  0x36820         || 		MOV r8,0x20   ; starting x coordinate
(0968)  CS-0x27A  0x36702         || 		MOV r7,0x02   ; y coordinate
(0969)  CS-0x27B  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0970)  CS-0x27C  0x080D9         || 		CALL draw_horizontal_line
(0971)                            || 
(0972)  CS-0x27D  0x36820         || 		MOV r8,0x20   ; starting x coordinate
(0973)  CS-0x27E  0x36706         || 		MOV r7,0x06   ; y coordinate
(0974)  CS-0x27F  0x36922         || 		MOV r9,0x22   ; ending x coordinate
(0975)  CS-0x280  0x080D9         || 		CALL draw_horizontal_line
(0976)                            || 
(0977)  CS-0x281  0x36820         || 		MOV r8,0x20   ; starting x coordinate
(0978)  CS-0x282  0x36712         || 		MOV r7,0x12   ; y coordinate
(0979)  CS-0x283  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0980)  CS-0x284  0x080D9         || 		CALL draw_horizontal_line
(0981)                            || 
(0982)  CS-0x285  0x36820         || 		MOV r8,0x20   ; starting x coordinate
(0983)  CS-0x286  0x3671A         || 		MOV r7,0x1A   ; y coordinate
(0984)  CS-0x287  0x36922         || 		MOV r9,0x22   ; ending x coordinate
(0985)  CS-0x288  0x080D9         || 		CALL draw_horizontal_line
(0986)                            || 
(0987)  CS-0x289  0x36822         || 		MOV r8,0x22  ; x coordinate
(0988)  CS-0x28A  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0989)  CS-0x28B  0x36908         || 		MOV r9,0x08	 ; ending y coordinate
(0990)  CS-0x28C  0x08109         || 		CALL draw_vertical_line
(0991)                            || 
(0992)  CS-0x28D  0x36822         || 		MOV r8,0x22  ; x coordinate
(0993)  CS-0x28E  0x3670A         || 		MOV r7,0x0A	 ; starting y coordinate
(0994)  CS-0x28F  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0995)  CS-0x290  0x08109         || 		CALL draw_vertical_line
(0996)                            || 
(0997)  CS-0x291  0x36822         || 		MOV r8,0x22  ; x coordinate
(0998)  CS-0x292  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0999)  CS-0x293  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(1000)  CS-0x294  0x08109         || 		CALL draw_vertical_line
(1001)                            || 
(1002)  CS-0x295  0x36822         || 		MOV r8,0x22   ; starting x coordinate
(1003)  CS-0x296  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(1004)  CS-0x297  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(1005)  CS-0x298  0x080D9         || 		CALL draw_horizontal_line
(1006)                            || 
(1007)  CS-0x299  0x36824         || 		MOV r8,0x24  ; x coordinate
(1008)  CS-0x29A  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(1009)  CS-0x29B  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(1010)  CS-0x29C  0x08109         || 		CALL draw_vertical_line
(1011)                            || 
(1012)  CS-0x29D  0x36824         || 		MOV r8,0x24  ; x coordinate
(1013)  CS-0x29E  0x36714         || 		MOV r7,0x14	 ; starting y coordinate
(1014)  CS-0x29F  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(1015)  CS-0x2A0  0x08109         || 		CALL draw_vertical_line
(1016)                            || 
(1017)  CS-0x2A1  0x3680A         || 		MOV r8,0x0a  ; x coordinate
(1018)  CS-0x2A2  0x3671A         || 		MOV r7,0x1A	 ; starting y coordinate
(1019)  CS-0x2A3  0x3690C         || 		MOV r9,0x0c	 ; ending x coordinate
(1020)  CS-0x2A4  0x080D9         || 		CALL draw_horizontal_line
(1021)                            || 
(1022)  CS-0x2A5  0x3681A         || 		MOV r8,0x1a  ; x coordinate
(1023)  CS-0x2A6  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(1024)  CS-0x2A7  0x3691C         || 		MOV r9,0x1c	 ; ending x coordinate
(1025)  CS-0x2A8  0x080D9         || 		CALL draw_horizontal_line
(1026)                            || 
(1027)  CS-0x2A9  0x3681B         || 		MOV r8,0x1b  ; x coordinate
(1028)  CS-0x2AA  0x36708         || 		MOV r7,0x08	 ; y coordinate
(1029)  CS-0x2AB  0x08189         || 		CALL draw_dot
(1030)                            || 
(1031)  CS-0x2AC  0x18002         || 		RET
(1032)                            || 
(1033)                     0x2AD  || draw_win:
(1034)                            || 
(1035)  CS-0x2AD  0x3661C         || 		MOV r6,M_GREEN
(1036)                            || 
(1037)  CS-0x2AE  0x3680D         || 		MOV r8,0x0d  ; x coordinate
(1038)  CS-0x2AF  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1039)  CS-0x2B0  0x3690F         || 		MOV r9,0x0f	 ; ending y coordinate
(1040)  CS-0x2B1  0x08109         || 		CALL draw_vertical_line
(1041)                            || 
(1042)  CS-0x2B2  0x3680E         || 		MOV r8,0x0e  ; x coordinate
(1043)  CS-0x2B3  0x36710         || 		MOV r7,0x10	 ; y coordinate
(1044)  CS-0x2B4  0x08189         || 		CALL draw_dot
(1045)                            || 
(1046)  CS-0x2B5  0x3680F         || 		MOV r8,0x0f  ; x coordinate
(1047)  CS-0x2B6  0x3670E         || 		MOV r7,0x0e	 ; starting y coordinate
(1048)  CS-0x2B7  0x3690F         || 		MOV r9,0x0f	 ; ending y coordinate
(1049)  CS-0x2B8  0x08109         || 		CALL draw_vertical_line
(1050)                            || 
(1051)  CS-0x2B9  0x36810         || 		MOV r8,0x10  ; x coordinate
(1052)  CS-0x2BA  0x36710         || 		MOV r7,0x10	 ; y coordinate
(1053)  CS-0x2BB  0x08189         || 		CALL draw_dot
(1054)                            || 
(1055)  CS-0x2BC  0x36811         || 		MOV r8,0x11  ; x coordinate
(1056)  CS-0x2BD  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1057)  CS-0x2BE  0x3690F         || 		MOV r9,0x0f	 ; ending y coordinate
(1058)  CS-0x2BF  0x08109         || 		CALL draw_vertical_line
(1059)                            || 
(1060)  CS-0x2C0  0x36813         || 		MOV r8,0x13  ; x coordinate
(1061)  CS-0x2C1  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1062)  CS-0x2C2  0x36915         || 		MOV r9,0x15	 ; ending x coordinate
(1063)  CS-0x2C3  0x080D9         || 		CALL draw_horizontal_line
(1064)                            || 
(1065)  CS-0x2C4  0x36814         || 		MOV r8,0x14  ; x coordinate
(1066)  CS-0x2C5  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1067)  CS-0x2C6  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(1068)  CS-0x2C7  0x08109         || 		CALL draw_vertical_line
(1069)                            || 
(1070)  CS-0x2C8  0x36813         || 		MOV r8,0x13  ; x coordinate
(1071)  CS-0x2C9  0x36710         || 		MOV r7,0x10	 ; starting y coordinate
(1072)  CS-0x2CA  0x36915         || 		MOV r9,0x15	 ; ending x coordinate
(1073)  CS-0x2CB  0x080D9         || 		CALL draw_horizontal_line
(1074)                            || 
(1075)  CS-0x2CC  0x36817         || 		MOV r8,0x17  ; x coordinate
(1076)  CS-0x2CD  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1077)  CS-0x2CE  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(1078)  CS-0x2CF  0x08109         || 		CALL draw_vertical_line
(1079)                            || 
(1080)  CS-0x2D0  0x36818         || 		MOV r8,0x18  ; x coordinate
(1081)  CS-0x2D1  0x3670B         || 		MOV r7,0x0b	 ; y coordinate
(1082)  CS-0x2D2  0x08189         || 		CALL draw_dot
(1083)                            || 
(1084)  CS-0x2D3  0x36819         || 		MOV r8,0x19  ; x coordinate
(1085)  CS-0x2D4  0x3670C         || 		MOV r7,0x0c	 ; y coordinate
(1086)  CS-0x2D5  0x08189         || 		CALL draw_dot
(1087)                            || 
(1088)  CS-0x2D6  0x3681A         || 		MOV r8,0x1a  ; x coordinate
(1089)  CS-0x2D7  0x3670D         || 		MOV r7,0x0d	 ; y coordinate
(1090)  CS-0x2D8  0x08189         || 		CALL draw_dot
(1091)                            || 
(1092)  CS-0x2D9  0x3681B         || 		MOV r8,0x1b  ; x coordinate
(1093)  CS-0x2DA  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1094)  CS-0x2DB  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(1095)  CS-0x2DC  0x08109         || 		CALL draw_vertical_line
(1096)                            || 
(1097)  CS-0x2DD  0x18002         || 		RET





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
DD_ADD40       0x03D   (0166)  ||  0156 
DD_ADD80       0x040   (0170)  ||  0159 
DD_OUT         0x039   (0161)  ||  0171 
DRAW_AT_PREV_LOC 0x09F   (0368)  ||  0279 0311 0334 0357 
DRAW_BACKGROUND 0x027   (0122)  ||  0040 0053 
DRAW_BLOCK     0x053   (0214)  ||  0043 
DRAW_DOT       0x031   (0149)  ||  0079 0105 0220 0286 0318 0341 0364 0372 0382 1029 
                               ||  1044 1053 1082 1086 1090 
DRAW_HORIZ1    0x01C   (0078)  ||  0082 
DRAW_HORIZONTAL_LINE 0x01B   (0075)  ||  0129 0390 0400 0410 0420 0425 0430 0435 0440 0475 
                               ||  0500 0505 0510 0540 0545 0550 0555 0580 0585 0590 
                               ||  0595 0620 0625 0630 0655 0660 0665 0695 0700 0705 
                               ||  0710 0725 0730 0735 0755 0760 0765 0790 0795 0800 
                               ||  0805 0810 0830 0835 0855 0860 0865 0870 0905 0910 
                               ||  0915 0920 0925 0940 0945 0950 0970 0975 0980 0985 
                               ||  1005 1020 1025 1063 1073 
DRAW_MAZE      0x0A4   (0375)  ||  0041 
DRAW_VERT1     0x022   (0104)  ||  0108 
DRAW_VERTICAL_LINE 0x021   (0101)  ||  0395 0405 0415 0445 0450 0455 0460 0465 0470 0480 
                               ||  0485 0490 0495 0515 0520 0525 0530 0535 0560 0565 
                               ||  0570 0575 0600 0605 0610 0615 0635 0640 0645 0650 
                               ||  0670 0675 0680 0685 0690 0715 0720 0740 0745 0750 
                               ||  0770 0775 0780 0785 0815 0820 0825 0840 0845 0850 
                               ||  0875 0880 0885 0890 0895 0900 0930 0935 0955 0960 
                               ||  0965 0990 0995 1000 1010 1015 1040 1049 1058 1068 
                               ||  1078 1095 
DRAW_WIN       0x2AD   (1033)  ||  0056 
INIT           0x010   (0039)  ||  
INSIDE_FOR0    0x064   (0249)  ||  0250 
MAIN           0x013   (0045)  ||  0049 0051 
MIDDLE_FOR0    0x062   (0246)  ||  0252 
MOVE_BLOCK     0x05A   (0232)  ||  0045 
MOVE_DOWN      0x092   (0345)  ||  
MOVE_LEFT      0x078   (0299)  ||  
MOVE_RIGHT     0x06B   (0267)  ||  
MOVE_UP        0x085   (0322)  ||  
OUTSIDE_FOR0   0x060   (0244)  ||  0254 
READ_DOT       0x042   (0181)  ||  0273 0305 0328 0351 
START          0x029   (0125)  ||  0132 
T1             0x037   (0158)  ||  0168 
WIN_SCREEN     0x019   (0055)  ||  0057 
XDD_ADD40      0x04E   (0198)  ||  0188 
XDD_ADD80      0x051   (0202)  ||  0191 
XDD_OUT        0x04A   (0193)  ||  0203 
XT1            0x048   (0190)  ||  0200 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0011)  ||  0123 0371 
BUTTON         0x09A   (0017)  ||  0232 
FOR_COUNT      0x0AA   (0018)  ||  
LEDS           0x040   (0009)  ||  0277 0309 0332 0355 
M_BLACK        0x000   (0014)  ||  0274 0306 0329 0352 0385 
M_GREEN        0x01C   (0015)  ||  0378 1035 
M_RED          0x0E0   (0013)  ||  
M_YELLOW       0x0E0   (0012)  ||  0214 0285 0317 0340 0363 
SSEG           0x081   (0008)  ||  
VGA_COLOR      0x092   (0006)  ||  0163 
VGA_HADD       0x090   (0004)  ||  0162 0194 
VGA_LADD       0x091   (0005)  ||  0161 0193 
VGA_READ       0x093   (0007)  ||  0195 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
