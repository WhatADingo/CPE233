

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
(0011)                       255  || .EQU BG_COLOR       = 0xFF             ; Background:  white
(0012)                            || 
(0013)                       224  || .EQU M_YELLOW		= 0xE0 ;0xF8
(0014)                       224  || .EQU M_RED			= 0xE0
(0015)                       003  || .EQU M_BLUE			= 0x03
(0016)                       000  || .EQU M_BLACK		= 0x00
(0017)                       144  || .EQU M_BROWN		= 0x90
(0018)                       028  || .EQU M_GREEN		= 0x1C
(0019)                            || 
(0020)                       154  || .EQU button         = 0x9A
(0021)                       170  || .EQU For_Count		= 0xAA
(0022)                            || 
(0023)                            || ;r6 is used for color
(0024)                            || ;r7 is used for Y
(0025)                            || ;r8 is used for X
(0026)                            || ;---------------------------------------------------------------------
(0027)                            || ;init:
(0028)  CS-0x010  0x08139         ||         CALL   draw_background         ; draw using default color
(0029)  CS-0x011  0x08561         || 		CALL	draw_maze
(0030)                            || 		
(0031)  CS-0x012  0x08299         || 		CALL	draw_block
(0032)                            || 
(0033)  CS-0x013  0x082D1  0x013  || main:   CALL	move_block
(0034)                            || 
(0035)  CS-0x014  0x30B25         || 		CMP		r11, 0x25
(0036)  CS-0x015  0x0809B         || 		BRNE	main
(0037)  CS-0x016  0x30A1B         || 		CMP		r10, 0x1b
(0038)  CS-0x017  0x0809B         || 		BRNE	main
(0039)  CS-0x018  0x08139         || 		CALL	draw_background
(0040)                            || 
(0041)                     0x019  || 	win_screen:
(0042)  CS-0x019  0x095A9         || 		CALL	draw_win
(0043)  CS-0x01A  0x080C8         || 		BRN		win_screen
(0044)                            || 
(0045)                            || ;--------------------------------------------------------------------
(0046)                            || 
(0047)                            || ;--------------------------------------------------------------------
(0048)                            || ;-  Subroutine: draw_horizontal_line
(0049)                            || ;-
(0050)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0051)                            || ;-
(0052)                            || ;-  Parameters:
(0053)                            || ;-   r8  = starting x-coordinate
(0054)                            || ;-   r7  = y-coordinate
(0055)                            || ;-   r9  = ending x-coordinate
(0056)                            || ;-   r6  = color used for line
(0057)                            || ;-
(0058)                            || ;- Tweaked registers: r8,r9
(0059)                            || ;--------------------------------------------------------------------
(0060)                            || 
(0061)                     0x01B  || draw_horizontal_line:
(0062)  CS-0x01B  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0063)                            || 
(0064)                     0x01C  || draw_horiz1:
(0065)  CS-0x01C  0x08189         ||         CALL   draw_dot         ; 
(0066)  CS-0x01D  0x28801         ||         ADD    r8,0x01
(0067)  CS-0x01E  0x04848         ||         CMP    r8,r9
(0068)  CS-0x01F  0x080E3         ||         BRNE   draw_horiz1
(0069)  CS-0x020  0x18002         ||         RET
(0070)                            || 
(0071)                            || ;--------------------------------------------------------------------
(0072)                            || 
(0073)                            || ;---------------------------------------------------------------------
(0074)                            || ;-  Subroutine: draw_vertical_line
(0075)                            || ;-
(0076)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0077)                            || ;-
(0078)                            || ;-  Parameters:
(0079)                            || ;-   r8  = x-coordinate
(0080)                            || ;-   r7  = starting y-coordinate
(0081)                            || ;-   r9  = ending y-coordinate
(0082)                            || ;-   r6  = color used for line
(0083)                            || ;- 
(0084)                            || ;- Tweaked registers: r7,r9
(0085)                            || ;--------------------------------------------------------------------
(0086)                            || 
(0087)                     0x021  || draw_vertical_line:
(0088)  CS-0x021  0x28901         ||          ADD    r9,0x01
(0089)                            || 
(0090)                     0x022  || draw_vert1:          
(0091)  CS-0x022  0x08189         ||          CALL   draw_dot
(0092)  CS-0x023  0x28701         ||          ADD    r7,0x01
(0093)  CS-0x024  0x04748         ||          CMP    r7,R9
(0094)  CS-0x025  0x08113         ||          BRNE   draw_vert1
(0095)  CS-0x026  0x18002         ||          RET
(0096)                            || 
(0097)                            || ;--------------------------------------------------------------------
(0098)                            || 
(0099)                            || ;---------------------------------------------------------------------
(0100)                            || ;-  Subroutine: draw_background
(0101)                            || ;-
(0102)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0103)                            || ;-  draw_horizontal_line subroutine. 
(0104)                            || ;- 
(0105)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0106)                            || ;----------------------------------------------------------------------
(0107)                            || 
(0108)                     0x027  || draw_background: 
(0109)  CS-0x027  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0110)  CS-0x028  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0111)  CS-0x029  0x04769  0x029  || start:   MOV   r7,r13                   ; load current row count 
(0112)  CS-0x02A  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0113)  CS-0x02B  0x36927         ||          MOV   r9,0x27 
(0114)                            || 
(0115)  CS-0x02C  0x080D9         ||          CALL  draw_horizontal_line
(0116)  CS-0x02D  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0117)  CS-0x02E  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0118)  CS-0x02F  0x0814B         ||          BRNE  start                    ; branch to draw more rows
(0119)                            || 
(0120)  CS-0x030  0x18002         ||          RET
(0121)                            || 
(0122)                            || ;---------------------------------------------------------------------
(0123)                            || 
(0124)                            ||  
(0125)                            || ;---------------------------------------------------------------------
(0126)                            || ;- Subrountine: draw_dot
(0127)                            || ;- 
(0128)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0129)                            || ;- 
(0130)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0131)                            || ;- 
(0132)                            || ;- Tweaked registers: r4,r5
(0133)                            || ;---------------------------------------------------------------------
(0134)                            || 
(0135)                     0x031  || draw_dot: 
(0136)  CS-0x031  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0137)  CS-0x032  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0138)                            || 
(0139)  CS-0x033  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0140)  CS-0x034  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0141)  CS-0x035  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0142)  CS-0x036  0x0A1E8         ||            BRCS  dd_add40
(0143)                            || 
(0144)  CS-0x037  0x10401  0x037  || t1:        LSR   r4
(0145)  CS-0x038  0x0A200         ||            BRCS  dd_add80
(0146)                            || 
(0147)  CS-0x039  0x34591  0x039  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0148)  CS-0x03A  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0149)  CS-0x03B  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0150)  CS-0x03C  0x18002         ||            RET
(0151)                            || 
(0152)  CS-0x03D  0x22540  0x03D  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0153)  CS-0x03E  0x18000         ||            CLC                  ; freshen bit
(0154)  CS-0x03F  0x081B8         ||            BRN   t1             
(0155)                            || 
(0156)  CS-0x040  0x22580  0x040  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0157)  CS-0x041  0x081C8         ||            BRN   dd_out
(0158)                            || ; --------------------------------------------------------------------
(0159)                            || 
(0160)                     0x042  || read_dot: 
(0161)  CS-0x042  0x05339         ||            MOV   r19,r7         ; copy Y coordinate
(0162)  CS-0x043  0x05441         ||            MOV   r20,r8         ; copy X coordinate
(0163)                            || 
(0164)  CS-0x044  0x2143F         ||            AND   r20,0x3F       ; make sure top 2 bits cleared
(0165)  CS-0x045  0x2131F         ||            AND   r19,0x1F       ; make sure top 3 bits cleared
(0166)  CS-0x046  0x11301         ||            LSR   r19             ; need to get the bot 2 bits of r4 into sA
(0167)  CS-0x047  0x0A270         ||            BRCS  xdd_add40
(0168)                            || 
(0169)  CS-0x048  0x11301  0x048  || xt1:        LSR   r19
(0170)  CS-0x049  0x0A288         ||            BRCS  xdd_add80
(0171)                            || 
(0172)  CS-0x04A  0x35491  0x04A  || xdd_out:   OUT   r20,VGA_LADD   ; write bot 8 address bits to register
(0173)  CS-0x04B  0x35390         ||            OUT   r19,VGA_HADD   ; write top 3 address bits to register
(0174)  CS-0x04C  0x32693         ||            IN	 r6,VGA_READ  ; write data to frame buffer
(0175)  CS-0x04D  0x18002         ||            RET
(0176)                            || 
(0177)  CS-0x04E  0x23440  0x04E  || xdd_add40:  OR    r20,0x40       ; set bit if needed
(0178)  CS-0x04F  0x18000         ||            CLC                  ; freshen bit
(0179)  CS-0x050  0x08240         ||            BRN   xt1             
(0180)                            || 
(0181)  CS-0x051  0x23480  0x051  || xdd_add80:  OR    r20,0x80       ; set bit if needed
(0182)  CS-0x052  0x08250         ||            BRN   xdd_out
(0183)                            || 
(0184)                            || ; --------------------------------------------------------------------
(0185)                            || 
(0186)  CS-0x053  0x366E0  0x053  || draw_block: MOV r6,M_YELLOW
(0187)                            || 
(0188)  CS-0x054  0x36A01         || 			MOV r10,0x01
(0189)  CS-0x055  0x04751         || 			MOV r7, r10
(0190)  CS-0x056  0x36B01         || 			MOV r11,0x01
(0191)  CS-0x057  0x04859         || 			MOV r8, r11
(0192)  CS-0x058  0x08189         || 			CALL draw_dot
(0193)  CS-0x059  0x18002         || 			RET
(0194)                            || 
(0195)  CS-0x05A  0x32F9A  0x05A  || move_block: IN r15,button
(0196)                            || 
(0197)  CS-0x05B  0x10F01         || 			LSR r15
(0198)  CS-0x05C  0x0A378         || 			BRCS move_right
(0199)                     0x05D  || 			move_right_end:
(0200)  CS-0x05D  0x10F01         || 			LSR r15
(0201)  CS-0x05E  0x0A3E8         || 			BRCS move_left
(0202)                     0x05F  || 			move_left_end:
(0203)  CS-0x05F  0x10F01         || 			LSR r15
(0204)  CS-0x060  0x0A458         || 			BRCS move_up
(0205)                     0x061  || 			move_up_end:
(0206)  CS-0x061  0x10F01         || 			LSR r15
(0207)  CS-0x062  0x0A4C8         || 			BRCS move_down
(0208)                     0x063  || 			move_down_end:
(0209)                            || 
(0210)  CS-0x063  0x370FF         || 			MOV r16, 0xFF
(0211)  CS-0x064  0x2D001  0x064  || 			outside_for0: SUB r16, 0x01
(0212)                            || 						  
(0213)  CS-0x065  0x371FF         || 						  MOV r17, 0xFF
(0214)  CS-0x066  0x2D101  0x066  || 			middle_for0:  SUB r17, 0x01
(0215)                            || 					
(0216)  CS-0x067  0x3720F         || 						  MOV r18, 0x0F
(0217)  CS-0x068  0x2D201  0x068  || 			inside_for0:  SUB r18, 0x01
(0218)  CS-0x069  0x08343         || 						  BRNE inside_for0
(0219)                            || 			
(0220)  CS-0x06A  0x23100         || 			OR R17, 0x00
(0221)  CS-0x06B  0x08333         || 			BRNE middle_for0
(0222)                            || 
(0223)  CS-0x06C  0x23000         || 			OR R16, 0x00
(0224)  CS-0x06D  0x08323         || 			BRNE outside_for0
(0225)                            || 
(0226)  CS-0x06E  0x18002         || 			RET
(0227)                            || 
(0228)                     0x06F  || move_right:
(0229)                            || 		
(0230)                            || 		;maze boundary check
(0231)  CS-0x06F  0x04859         || 		MOV		r8, r11
(0232)  CS-0x070  0x04751         || 		MOV		r7, r10
(0233)  CS-0x071  0x28801         || 		ADD		r8, 0x01
(0234)  CS-0x072  0x08211         || 		CALL	read_dot
(0235)  CS-0x073  0x30600         || 		CMP	   	r6, M_BLACK
(0236)  CS-0x074  0x082EA         || 		BREQ	move_right_end
(0237)                            || 		
(0238)  CS-0x075  0x34640         || 		OUT		r6, LEDS
(0239)                            || 
(0240)  CS-0x076  0x08539         || 		CALL	draw_at_prev_loc
(0241)                            || 
(0242)                            || 		;draw pixel at new location
(0243)  CS-0x077  0x28B01         || 		ADD	   r11, 0x01
(0244)  CS-0x078  0x04751         || 		MOV    r7, r10
(0245)  CS-0x079  0x04859         || 		MOV    r8, r11
(0246)  CS-0x07A  0x366E0         || 		MOV    r6, M_YELLOW
(0247)  CS-0x07B  0x08189         || 		CALL   draw_dot
(0248)                            || 
(0249)  CS-0x07C  0x082E8         || 		BRN move_right_end
(0250)                            || 
(0251)                     0x07D  || move_left:
(0252)                            || 		
(0253)                            || 		;maze boundary check
(0254)  CS-0x07D  0x04859         || 		MOV		r8, r11
(0255)  CS-0x07E  0x04751         || 		MOV		r7, r10
(0256)  CS-0x07F  0x2C801         || 		SUB		r8, 0x01
(0257)  CS-0x080  0x08211         || 		CALL	read_dot
(0258)  CS-0x081  0x30600         || 		CMP	   	r6, M_BLACK
(0259)  CS-0x082  0x082FA         || 		BREQ	move_left_end
(0260)                            || 
(0261)  CS-0x083  0x34640         || 		OUT		r6, LEDS
(0262)                            || 		
(0263)  CS-0x084  0x08539         || 		CALL	draw_at_prev_loc
(0264)                            || 
(0265)                            || 		;draw pixel at new location
(0266)  CS-0x085  0x2CB01         || 		SUB	   r11, 0x01
(0267)  CS-0x086  0x04751         || 		MOV    r7, r10
(0268)  CS-0x087  0x04859         || 		MOV    r8, r11
(0269)  CS-0x088  0x366E0         || 		MOV    r6, M_YELLOW
(0270)  CS-0x089  0x08189         || 		CALL   draw_dot
(0271)                            || 
(0272)  CS-0x08A  0x082F8         || 		BRN move_left_end
(0273)                            || 
(0274)                     0x08B  || move_up:
(0275)                            || 		
(0276)                            || 		;maze boundary check
(0277)  CS-0x08B  0x04751         || 		MOV		r7, r10
(0278)  CS-0x08C  0x04859         || 		MOV		r8, r11
(0279)  CS-0x08D  0x2C701         || 		SUB		r7, 0x01
(0280)  CS-0x08E  0x08211         || 		CALL	read_dot
(0281)  CS-0x08F  0x30600         || 		CMP	   	r6, M_BLACK
(0282)  CS-0x090  0x0830A         || 		BREQ	move_up_end
(0283)                            || 		
(0284)  CS-0x091  0x34640         || 		OUT		r6, LEDS
(0285)                            || 
(0286)  CS-0x092  0x08539         || 		CALL	draw_at_prev_loc
(0287)                            || 
(0288)                            || 		;draw pixel at new location
(0289)  CS-0x093  0x2CA01         || 		SUB	   r10, 0x01
(0290)  CS-0x094  0x04751         || 		MOV    r7, r10
(0291)  CS-0x095  0x04859         || 		MOV    r8, r11
(0292)  CS-0x096  0x366E0         || 		MOV    r6, M_YELLOW
(0293)  CS-0x097  0x08189         || 		CALL   draw_dot
(0294)                            || 
(0295)  CS-0x098  0x08308         || 		BRN move_up_end
(0296)                            || 
(0297)                     0x099  || move_down:
(0298)                            || 		
(0299)                            || 		;maze boundary check
(0300)  CS-0x099  0x04751         || 		MOV		r7, r10
(0301)  CS-0x09A  0x04859         || 		MOV		r8, r11
(0302)  CS-0x09B  0x28701         || 		ADD		r7, 0x01
(0303)  CS-0x09C  0x08211         || 		CALL	read_dot
(0304)  CS-0x09D  0x30600         || 		CMP	   	r6, M_BLACK
(0305)  CS-0x09E  0x0831A         || 		BREQ	move_down_end
(0306)                            || 
(0307)  CS-0x09F  0x34640         || 		OUT		r6, LEDS
(0308)                            || 		
(0309)  CS-0x0A0  0x08539         || 		CALL	draw_at_prev_loc
(0310)                            || 
(0311)                            || 		;draw pixel at new location
(0312)  CS-0x0A1  0x28A01         || 		ADD	   r10, 0x01
(0313)  CS-0x0A2  0x04751         || 		MOV    r7, r10
(0314)  CS-0x0A3  0x04859         || 		MOV    r8, r11
(0315)  CS-0x0A4  0x366E0         ||         MOV    r6, M_YELLOW
(0316)  CS-0x0A5  0x08189         || 		CALL   draw_dot
(0317)                            || 
(0318)  CS-0x0A6  0x08318         || 		BRN move_down_end
(0319)                            || 
(0320)                     0x0A7  || draw_at_prev_loc:
(0321)  CS-0x0A7  0x04751         || 		MOV    r7, r10
(0322)  CS-0x0A8  0x04859         || 		MOV    r8, r11
(0323)  CS-0x0A9  0x366FF         || 		MOV    r6, BG_COLOR
(0324)  CS-0x0AA  0x08189         || 		CALL   draw_dot
(0325)  CS-0x0AB  0x18002         || 		RET
(0326)                            || 
(0327)                     0x0AC  || draw_maze: 
(0328)                            || 
(0329)                            || 		;endpoint
(0330)  CS-0x0AC  0x3661C         || 		MOV r6,M_GREEN
(0331)                            || 
(0332)  CS-0x0AD  0x36825         || 		MOV r8,0x25  ; x coordinate
(0333)  CS-0x0AE  0x3671B         || 		MOV r7,0x1B	 ; y coordinate
(0334)  CS-0x0AF  0x08189         || 		CALL draw_dot
(0335)                            || 
(0336)                            || 
(0337)  CS-0x0B0  0x36600         || 		MOV r6,M_BLACK
(0338)                            || 
(0339)  CS-0x0B1  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0340)  CS-0x0B2  0x36700         || 		MOV r7,0x00   ; y coordinate
(0341)  CS-0x0B3  0x36926         || 		MOV r9,0x26   ; ending x coordinate
(0342)  CS-0x0B4  0x080D9         || 		CALL draw_horizontal_line
(0343)                            || 
(0344)  CS-0x0B5  0x36800         || 		MOV r8,0x00   ; x coordinate
(0345)  CS-0x0B6  0x36701         || 		MOV r7,0x01	 ; starting y coordinate
(0346)  CS-0x0B7  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0347)  CS-0x0B8  0x08109         || 		CALL draw_vertical_line
(0348)                            || 
(0349)  CS-0x0B9  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0350)  CS-0x0BA  0x3671C         || 		MOV r7,0x1C   ; y coordinate
(0351)  CS-0x0BB  0x36926         || 		MOV r9,0x26   ; ending x coordinate
(0352)  CS-0x0BC  0x080D9         || 		CALL draw_horizontal_line
(0353)                            || 
(0354)  CS-0x0BD  0x36826         || 		MOV r8,0x26   ; x coordinate
(0355)  CS-0x0BE  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0356)  CS-0x0BF  0x3691B         || 		MOV r9,0x1B	 ; ending y coordinate
(0357)  CS-0x0C0  0x08109         || 		CALL draw_vertical_line
(0358)                            || 
(0359)  CS-0x0C1  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0360)  CS-0x0C2  0x3671D         || 		MOV r7,0x1D   ; y coordinate
(0361)  CS-0x0C3  0x36927         || 		MOV r9,0x27   ; ending x coordinate
(0362)  CS-0x0C4  0x080D9         || 		CALL draw_horizontal_line
(0363)                            || 
(0364)  CS-0x0C5  0x36827         || 		MOV r8,0x27   ; x coordinate
(0365)  CS-0x0C6  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0366)  CS-0x0C7  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0367)  CS-0x0C8  0x08109         || 		CALL draw_vertical_line
(0368)                            || 
(0369)  CS-0x0C9  0x36800         || 		MOV r8,0x00  ; starting x coordinate
(0370)  CS-0x0CA  0x36702         || 		MOV r7,0x02   ; y coordinate
(0371)  CS-0x0CB  0x36902         || 		MOV r9,0x02   ; ending x coordinate
(0372)  CS-0x0CC  0x080D9         || 		CALL draw_horizontal_line
(0373)                            || 
(0374)  CS-0x0CD  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0375)  CS-0x0CE  0x36706         || 		MOV r7,0x06   ; y coordinate
(0376)  CS-0x0CF  0x36904         || 		MOV r9,0x04   ; ending x coordinate
(0377)  CS-0x0D0  0x080D9         || 		CALL draw_horizontal_line
(0378)                            || 
(0379)  CS-0x0D1  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0380)  CS-0x0D2  0x36708         || 		MOV r7,0x08   ; y coordinate
(0381)  CS-0x0D3  0x36908         || 		MOV r9,0x08   ; ending x coordinate
(0382)  CS-0x0D4  0x080D9         || 		CALL draw_horizontal_line
(0383)                            || 
(0384)  CS-0x0D5  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0385)  CS-0x0D6  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0386)  CS-0x0D7  0x36902         || 		MOV r9,0x02   ; ending x coordinate
(0387)  CS-0x0D8  0x080D9         || 		CALL draw_horizontal_line
(0388)                            || 
(0389)  CS-0x0D9  0x36800         || 		MOV r8,0x00   ; starting x coordinate
(0390)  CS-0x0DA  0x36716         || 		MOV r7,0x16   ; y coordinate
(0391)  CS-0x0DB  0x36904         || 		MOV r9,0x04   ; ending x coordinate
(0392)  CS-0x0DC  0x080D9         || 		CALL draw_horizontal_line
(0393)                            || 
(0394)  CS-0x0DD  0x36802         || 		MOV r8,0x02  ; x coordinate
(0395)  CS-0x0DE  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0396)  CS-0x0DF  0x36904         || 		MOV r9,0x04	 ; ending y coordinate
(0397)  CS-0x0E0  0x08109         || 		CALL draw_vertical_line
(0398)                            || 
(0399)  CS-0x0E1  0x36802         || 		MOV r8,0x02  ; x coordinate
(0400)  CS-0x0E2  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0401)  CS-0x0E3  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0402)  CS-0x0E4  0x08109         || 		CALL draw_vertical_line
(0403)                            || 
(0404)  CS-0x0E5  0x36802         || 		MOV r8,0x02  ; x coordinate
(0405)  CS-0x0E6  0x3670C         || 		MOV r7,0x0C	 ; starting y coordinate
(0406)  CS-0x0E7  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(0407)  CS-0x0E8  0x08109         || 		CALL draw_vertical_line
(0408)                            || 
(0409)  CS-0x0E9  0x36802         || 		MOV r8,0x02  ; x coordinate
(0410)  CS-0x0EA  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0411)  CS-0x0EB  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0412)  CS-0x0EC  0x08109         || 		CALL draw_vertical_line
(0413)                            || 
(0414)  CS-0x0ED  0x36802         || 		MOV r8,0x02  ; x coordinate
(0415)  CS-0x0EE  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0416)  CS-0x0EF  0x36918         || 		MOV r9,0x18	 ; ending y coordinate
(0417)  CS-0x0F0  0x08109         || 		CALL draw_vertical_line
(0418)                            || 
(0419)  CS-0x0F1  0x36802         || 		MOV r8,0x02  ; x coordinate
(0420)  CS-0x0F2  0x3671A         || 		MOV r7,0x1A	 ; starting y coordinate
(0421)  CS-0x0F3  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0422)  CS-0x0F4  0x08109         || 		CALL draw_vertical_line
(0423)                            || 
(0424)  CS-0x0F5  0x36802         || 		MOV r8,0x02   ; starting x coordinate
(0425)  CS-0x0F6  0x36714         || 		MOV r7,0x14   ; y coordinate
(0426)  CS-0x0F7  0x36906         || 		MOV r9,0x06   ; ending x coordinate
(0427)  CS-0x0F8  0x080D9         || 		CALL draw_horizontal_line
(0428)                            || 
(0429)  CS-0x0F9  0x36804         || 		MOV r8,0x04  ; x coordinate
(0430)  CS-0x0FA  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0431)  CS-0x0FB  0x36904         || 		MOV r9,0x04	 ; ending y coordinate
(0432)  CS-0x0FC  0x08109         || 		CALL draw_vertical_line
(0433)                            || 
(0434)  CS-0x0FD  0x36804         || 		MOV r8,0x04  ; x coordinate
(0435)  CS-0x0FE  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0436)  CS-0x0FF  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0437)  CS-0x100  0x08109         || 		CALL draw_vertical_line
(0438)                            || 
(0439)  CS-0x101  0x36804         || 		MOV r8,0x04  ; x coordinate
(0440)  CS-0x102  0x36710         || 		MOV r7,0x10	 ; starting y coordinate
(0441)  CS-0x103  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0442)  CS-0x104  0x08109         || 		CALL draw_vertical_line
(0443)                            || 
(0444)  CS-0x105  0x36804         || 		MOV r8,0x04  ; x coordinate
(0445)  CS-0x106  0x36718         || 		MOV r7,0x18	 ; starting y coordinate
(0446)  CS-0x107  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0447)  CS-0x108  0x08109         || 		CALL draw_vertical_line
(0448)                            || 
(0449)  CS-0x109  0x36804         || 		MOV r8,0x04   ; starting x coordinate
(0450)  CS-0x10A  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0451)  CS-0x10B  0x36906         || 		MOV r9,0x06   ; ending x coordinate
(0452)  CS-0x10C  0x080D9         || 		CALL draw_horizontal_line
(0453)                            || 
(0454)  CS-0x10D  0x36804         || 		MOV r8,0x04   ; starting x coordinate
(0455)  CS-0x10E  0x3670A         || 		MOV r7,0x0A   ; y coordinate
(0456)  CS-0x10F  0x36906         || 		MOV r9,0x06   ; ending x coordinate
(0457)  CS-0x110  0x080D9         || 		CALL draw_horizontal_line
(0458)                            || 
(0459)  CS-0x111  0x36804         || 		MOV r8,0x04   ; starting x coordinate
(0460)  CS-0x112  0x3671A         || 		MOV r7,0x1A   ; y coordinate
(0461)  CS-0x113  0x36906         || 		MOV r9,0x06   ; ending x coordinate
(0462)  CS-0x114  0x080D9         || 		CALL draw_horizontal_line
(0463)                            || 
(0464)  CS-0x115  0x36806         || 		MOV r8,0x06  ; x coordinate
(0465)  CS-0x116  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0466)  CS-0x117  0x36904         || 		MOV r9,0x04	 ; ending y coordinate
(0467)  CS-0x118  0x08109         || 		CALL draw_vertical_line
(0468)                            || 
(0469)  CS-0x119  0x36806         || 		MOV r8,0x06  ; x coordinate
(0470)  CS-0x11A  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0471)  CS-0x11B  0x36908         || 		MOV r9,0x08	 ; ending y coordinate
(0472)  CS-0x11C  0x08109         || 		CALL draw_vertical_line
(0473)                            || 
(0474)  CS-0x11D  0x36806         || 		MOV r8,0x06  ; x coordinate
(0475)  CS-0x11E  0x3670A         || 		MOV r7,0x0A	 ; starting y coordinate
(0476)  CS-0x11F  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0477)  CS-0x120  0x08109         || 		CALL draw_vertical_line
(0478)                            || 
(0479)  CS-0x121  0x36806         || 		MOV r8,0x06  ; x coordinate
(0480)  CS-0x122  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0481)  CS-0x123  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0482)  CS-0x124  0x08109         || 		CALL draw_vertical_line
(0483)                            || 
(0484)  CS-0x125  0x36806         || 		MOV r8,0x06  ; x coordinate
(0485)  CS-0x126  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0486)  CS-0x127  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0487)  CS-0x128  0x08109         || 		CALL draw_vertical_line
(0488)                            || 
(0489)  CS-0x129  0x36806         || 		MOV r8,0x06   ; starting x coordinate
(0490)  CS-0x12A  0x36702         || 		MOV r7,0x02   ; y coordinate
(0491)  CS-0x12B  0x3690C         || 		MOV r9,0x0C   ; ending x coordinate
(0492)  CS-0x12C  0x080D9         || 		CALL draw_horizontal_line
(0493)                            || 
(0494)  CS-0x12D  0x36806         || 		MOV r8,0x06   ; starting x coordinate
(0495)  CS-0x12E  0x36704         || 		MOV r7,0x04   ; y coordinate
(0496)  CS-0x12F  0x3690A         || 		MOV r9,0x0A   ; ending x coordinate
(0497)  CS-0x130  0x080D9         || 		CALL draw_horizontal_line
(0498)                            || 
(0499)  CS-0x131  0x36806         || 		MOV r8,0x06   ; starting x coordinate
(0500)  CS-0x132  0x36712         || 		MOV r7,0x12   ; y coordinate
(0501)  CS-0x133  0x36908         || 		MOV r9,0x08   ; ending x coordinate
(0502)  CS-0x134  0x080D9         || 		CALL draw_horizontal_line
(0503)                            || 
(0504)  CS-0x135  0x36806         || 		MOV r8,0x06   ; starting x coordinate
(0505)  CS-0x136  0x36718         || 		MOV r7,0x18   ; y coordinate
(0506)  CS-0x137  0x36908         || 		MOV r9,0x08   ; ending x coordinate
(0507)  CS-0x138  0x080D9         || 		CALL draw_horizontal_line
(0508)                            || 
(0509)  CS-0x139  0x36808         || 		MOV r8,0x08  ; x coordinate
(0510)  CS-0x13A  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0511)  CS-0x13B  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0512)  CS-0x13C  0x08109         || 		CALL draw_vertical_line
(0513)                            || 
(0514)  CS-0x13D  0x36808         || 		MOV r8,0x08  ; x coordinate
(0515)  CS-0x13E  0x3670C         || 		MOV r7,0x0C	 ; starting y coordinate
(0516)  CS-0x13F  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0517)  CS-0x140  0x08109         || 		CALL draw_vertical_line
(0518)                            || 
(0519)  CS-0x141  0x36808         || 		MOV r8,0x08  ; x coordinate
(0520)  CS-0x142  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0521)  CS-0x143  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0522)  CS-0x144  0x08109         || 		CALL draw_vertical_line
(0523)                            || 
(0524)  CS-0x145  0x36808         || 		MOV r8,0x08  ; x coordinate
(0525)  CS-0x146  0x36718         || 		MOV r7,0x18	 ; starting y coordinate
(0526)  CS-0x147  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0527)  CS-0x148  0x08109         || 		CALL draw_vertical_line
(0528)                            || 
(0529)  CS-0x149  0x36808         || 		MOV r8,0x08   ; starting x coordinate
(0530)  CS-0x14A  0x36706         || 		MOV r7,0x06   ; y coordinate
(0531)  CS-0x14B  0x3690A         || 		MOV r9,0x0A   ; ending x coordinate
(0532)  CS-0x14C  0x080D9         || 		CALL draw_horizontal_line
(0533)                            || 
(0534)  CS-0x14D  0x36808         || 		MOV r8,0x08   ; starting x coordinate
(0535)  CS-0x14E  0x3670C         || 		MOV r7,0x0C   ; y coordinate
(0536)  CS-0x14F  0x3690A         || 		MOV r9,0x0A   ; ending x coordinate
(0537)  CS-0x150  0x080D9         || 		CALL draw_horizontal_line
(0538)                            || 
(0539)  CS-0x151  0x36808         || 		MOV r8,0x08   ; starting x coordinate
(0540)  CS-0x152  0x36710         || 		MOV r7,0x10   ; y coordinate
(0541)  CS-0x153  0x3690E         || 		MOV r9,0x0E   ; ending x coordinate
(0542)  CS-0x154  0x080D9         || 		CALL draw_horizontal_line
(0543)                            || 
(0544)  CS-0x155  0x36808         || 		MOV r8,0x08   ; starting x coordinate
(0545)  CS-0x156  0x36714         || 		MOV r7,0x14   ; y coordinate
(0546)  CS-0x157  0x3690C         || 		MOV r9,0x0C   ; ending x coordinate
(0547)  CS-0x158  0x080D9         || 		CALL draw_horizontal_line
(0548)                            || 
(0549)  CS-0x159  0x3680A         || 		MOV r8,0x0A  ; x coordinate
(0550)  CS-0x15A  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0551)  CS-0x15B  0x36908         || 		MOV r9,0x08	 ; ending y coordinate
(0552)  CS-0x15C  0x08109         || 		CALL draw_vertical_line
(0553)                            || 
(0554)  CS-0x15D  0x3680A         || 		MOV r8,0x0A  ; x coordinate
(0555)  CS-0x15E  0x3670A         || 		MOV r7,0x0A	 ; starting y coordinate
(0556)  CS-0x15F  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0557)  CS-0x160  0x08109         || 		CALL draw_vertical_line
(0558)                            || 
(0559)  CS-0x161  0x3680A         || 		MOV r8,0x0A  ; x coordinate
(0560)  CS-0x162  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0561)  CS-0x163  0x36912         || 		MOV r9,0x12	 ; ending y coordinate
(0562)  CS-0x164  0x08109         || 		CALL draw_vertical_line
(0563)                            || 
(0564)  CS-0x165  0x3680A         || 		MOV r8,0x0A  ; x coordinate
(0565)  CS-0x166  0x36714         || 		MOV r7,0x14	 ; starting y coordinate
(0566)  CS-0x167  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0567)  CS-0x168  0x08109         || 		CALL draw_vertical_line
(0568)                            || 
(0569)  CS-0x169  0x3680A         || 		MOV r8,0x0A   ; starting x coordinate
(0570)  CS-0x16A  0x3670A         || 		MOV r7,0x0A   ; y coordinate
(0571)  CS-0x16B  0x3690E         || 		MOV r9,0x0E   ; ending x coordinate
(0572)  CS-0x16C  0x080D9         || 		CALL draw_horizontal_line
(0573)                            || 
(0574)  CS-0x16D  0x3680A         || 		MOV r8,0x0A   ; starting x coordinate
(0575)  CS-0x16E  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0576)  CS-0x16F  0x3690C         || 		MOV r9,0x0C   ; ending x coordinate
(0577)  CS-0x170  0x080D9         || 		CALL draw_horizontal_line
(0578)                            || 
(0579)  CS-0x171  0x3680A         || 		MOV r8,0x0A   ; starting x coordinate
(0580)  CS-0x172  0x36716         || 		MOV r7,0x16   ; y coordinate
(0581)  CS-0x173  0x3690C         || 		MOV r9,0x0C   ; ending x coordinate
(0582)  CS-0x174  0x080D9         || 		CALL draw_horizontal_line
(0583)                            || 
(0584)  CS-0x175  0x3680C         || 		MOV r8,0x0C  ; x coordinate
(0585)  CS-0x176  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0586)  CS-0x177  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0587)  CS-0x178  0x08109         || 		CALL draw_vertical_line
(0588)                            || 
(0589)  CS-0x179  0x3680C         || 		MOV r8,0x0C  ; x coordinate
(0590)  CS-0x17A  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0591)  CS-0x17B  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0592)  CS-0x17C  0x08109         || 		CALL draw_vertical_line
(0593)                            || 
(0594)  CS-0x17D  0x3680C         || 		MOV r8,0x0C  ; x coordinate
(0595)  CS-0x17E  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0596)  CS-0x17F  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0597)  CS-0x180  0x08109         || 		CALL draw_vertical_line
(0598)                            || 
(0599)  CS-0x181  0x3680C         || 		MOV r8,0x0C  ; x coordinate
(0600)  CS-0x182  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0601)  CS-0x183  0x36918         || 		MOV r9,0x18	 ; ending y coordinate
(0602)  CS-0x184  0x08109         || 		CALL draw_vertical_line
(0603)                            || 
(0604)  CS-0x185  0x3680C         || 		MOV r8,0x0C   ; starting x coordinate
(0605)  CS-0x186  0x36704         || 		MOV r7,0x04   ; y coordinate
(0606)  CS-0x187  0x36918         || 		MOV r9,0x18   ; ending x coordinate
(0607)  CS-0x188  0x080D9         || 		CALL draw_horizontal_line
(0608)                            || 
(0609)  CS-0x189  0x3680C         || 		MOV r8,0x0C   ; starting x coordinate
(0610)  CS-0x18A  0x3670C         || 		MOV r7,0x0C   ; y coordinate
(0611)  CS-0x18B  0x3690E         || 		MOV r9,0x0E   ; ending x coordinate
(0612)  CS-0x18C  0x080D9         || 		CALL draw_horizontal_line
(0613)                            || 
(0614)  CS-0x18D  0x3680C         || 		MOV r8,0x0C   ; starting x coordinate
(0615)  CS-0x18E  0x36718         || 		MOV r7,0x18   ; y coordinate
(0616)  CS-0x18F  0x36910         || 		MOV r9,0x10   ; ending x coordinate
(0617)  CS-0x190  0x080D9         || 		CALL draw_horizontal_line
(0618)                            || 
(0619)  CS-0x191  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0620)  CS-0x192  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0621)  CS-0x193  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0622)  CS-0x194  0x08109         || 		CALL draw_vertical_line
(0623)                            || 
(0624)  CS-0x195  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0625)  CS-0x196  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0626)  CS-0x197  0x36906         || 		MOV r9,0x06	 ; ending y coordinate
(0627)  CS-0x198  0x08109         || 		CALL draw_vertical_line
(0628)                            || 
(0629)  CS-0x199  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0630)  CS-0x19A  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0631)  CS-0x19B  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0632)  CS-0x19C  0x08109         || 		CALL draw_vertical_line
(0633)                            || 
(0634)  CS-0x19D  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0635)  CS-0x19E  0x36710         || 		MOV r7,0x10	 ; starting y coordinate
(0636)  CS-0x19F  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0637)  CS-0x1A0  0x08109         || 		CALL draw_vertical_line
(0638)                            || 
(0639)  CS-0x1A1  0x3680E         || 		MOV r8,0x0E  ; x coordinate
(0640)  CS-0x1A2  0x36718         || 		MOV r7,0x18	 ; starting y coordinate
(0641)  CS-0x1A3  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0642)  CS-0x1A4  0x08109         || 		CALL draw_vertical_line
(0643)                            || 
(0644)  CS-0x1A5  0x3680E         || 		MOV r8,0x0E   ; starting x coordinate
(0645)  CS-0x1A6  0x36702         || 		MOV r7,0x02   ; y coordinate
(0646)  CS-0x1A7  0x36910         || 		MOV r9,0x10   ; ending x coordinate
(0647)  CS-0x1A8  0x080D9         || 		CALL draw_horizontal_line
(0648)                            || 
(0649)  CS-0x1A9  0x3680E         || 		MOV r8,0x0E   ; starting x coordinate
(0650)  CS-0x1AA  0x36708         || 		MOV r7,0x08   ; y coordinate
(0651)  CS-0x1AB  0x36912         || 		MOV r9,0x12   ; ending x coordinate
(0652)  CS-0x1AC  0x080D9         || 		CALL draw_horizontal_line
(0653)                            || 
(0654)  CS-0x1AD  0x3680E         || 		MOV r8,0x0E   ; starting x coordinate
(0655)  CS-0x1AE  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0656)  CS-0x1AF  0x36912         || 		MOV r9,0x12   ; ending x coordinate
(0657)  CS-0x1B0  0x080D9         || 		CALL draw_horizontal_line
(0658)                            || 
(0659)  CS-0x1B1  0x3680E         || 		MOV r8,0x0E   ; starting x coordinate
(0660)  CS-0x1B2  0x36716         || 		MOV r7,0x16   ; y coordinate
(0661)  CS-0x1B3  0x36912         || 		MOV r9,0x12   ; ending x coordinate
(0662)  CS-0x1B4  0x080D9         || 		CALL draw_horizontal_line
(0663)                            || 
(0664)  CS-0x1B5  0x36810         || 		MOV r8,0x10  ; x coordinate
(0665)  CS-0x1B6  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0666)  CS-0x1B7  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0667)  CS-0x1B8  0x08109         || 		CALL draw_vertical_line
(0668)                            || 
(0669)  CS-0x1B9  0x36810         || 		MOV r8,0x10  ; x coordinate
(0670)  CS-0x1BA  0x36710         || 		MOV r7,0x10	 ; starting y coordinate
(0671)  CS-0x1BB  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0672)  CS-0x1BC  0x08109         || 		CALL draw_vertical_line
(0673)                            || 
(0674)  CS-0x1BD  0x36810         || 		MOV r8,0x10   ; starting x coordinate
(0675)  CS-0x1BE  0x36710         || 		MOV r7,0x10   ; y coordinate
(0676)  CS-0x1BF  0x36916         || 		MOV r9,0x16   ; ending x coordinate
(0677)  CS-0x1C0  0x080D9         || 		CALL draw_horizontal_line
(0678)                            || 
(0679)  CS-0x1C1  0x36810         || 		MOV r8,0x10   ; starting x coordinate
(0680)  CS-0x1C2  0x36712         || 		MOV r7,0x12   ; y coordinate
(0681)  CS-0x1C3  0x36916         || 		MOV r9,0x16   ; ending x coordinate
(0682)  CS-0x1C4  0x080D9         || 		CALL draw_horizontal_line
(0683)                            || 
(0684)  CS-0x1C5  0x36810         || 		MOV r8,0x10   ; starting x coordinate
(0685)  CS-0x1C6  0x3671A         || 		MOV r7,0x1A   ; y coordinate
(0686)  CS-0x1C7  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0687)  CS-0x1C8  0x080D9         || 		CALL draw_horizontal_line
(0688)                            || 
(0689)  CS-0x1C9  0x36812         || 		MOV r8,0x12  ; x coordinate
(0690)  CS-0x1CA  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0691)  CS-0x1CB  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0692)  CS-0x1CC  0x08109         || 		CALL draw_vertical_line
(0693)                            || 
(0694)  CS-0x1CD  0x36812         || 		MOV r8,0x12  ; x coordinate
(0695)  CS-0x1CE  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0696)  CS-0x1CF  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0697)  CS-0x1D0  0x08109         || 		CALL draw_vertical_line
(0698)                            || 
(0699)  CS-0x1D1  0x36812         || 		MOV r8,0x12  ; x coordinate
(0700)  CS-0x1D2  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0701)  CS-0x1D3  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0702)  CS-0x1D4  0x08109         || 		CALL draw_vertical_line
(0703)                            || 
(0704)  CS-0x1D5  0x36812         || 		MOV r8,0x12   ; starting x coordinate
(0705)  CS-0x1D6  0x36702         || 		MOV r7,0x02   ; y coordinate
(0706)  CS-0x1D7  0x36914         || 		MOV r9,0x14   ; ending x coordinate
(0707)  CS-0x1D8  0x080D9         || 		CALL draw_horizontal_line
(0708)                            || 
(0709)  CS-0x1D9  0x36812         || 		MOV r8,0x12   ; starting x coordinate
(0710)  CS-0x1DA  0x36706         || 		MOV r7,0x06   ; y coordinate
(0711)  CS-0x1DB  0x36914         || 		MOV r9,0x14  ; ending x coordinate
(0712)  CS-0x1DC  0x080D9         || 		CALL draw_horizontal_line
(0713)                            || 
(0714)  CS-0x1DD  0x36812         || 		MOV r8,0x12   ; starting x coordinate
(0715)  CS-0x1DE  0x36714         || 		MOV r7,0x14   ; y coordinate
(0716)  CS-0x1DF  0x36916         || 		MOV r9,0x16   ; ending x coordinate
(0717)  CS-0x1E0  0x080D9         || 		CALL draw_horizontal_line
(0718)                            || 
(0719)  CS-0x1E1  0x36814         || 		MOV r8,0x14  ; x coordinate
(0720)  CS-0x1E2  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0721)  CS-0x1E3  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0722)  CS-0x1E4  0x08109         || 		CALL draw_vertical_line
(0723)                            || 
(0724)  CS-0x1E5  0x36814         || 		MOV r8,0x14  ; x coordinate
(0725)  CS-0x1E6  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0726)  CS-0x1E7  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0727)  CS-0x1E8  0x08109         || 		CALL draw_vertical_line
(0728)                            || 
(0729)  CS-0x1E9  0x36814         || 		MOV r8,0x14  ; x coordinate
(0730)  CS-0x1EA  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0731)  CS-0x1EB  0x36918         || 		MOV r9,0x18	 ; ending y coordinate
(0732)  CS-0x1EC  0x08109         || 		CALL draw_vertical_line
(0733)                            || 
(0734)  CS-0x1ED  0x36814         || 		MOV r8,0x14  ; x coordinate
(0735)  CS-0x1EE  0x3671A         || 		MOV r7,0x1A	 ; starting y coordinate
(0736)  CS-0x1EF  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0737)  CS-0x1F0  0x08109         || 		CALL draw_vertical_line
(0738)                            || 
(0739)  CS-0x1F1  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0740)  CS-0x1F2  0x36708         || 		MOV r7,0x08   ; y coordinate
(0741)  CS-0x1F3  0x36918         || 		MOV r9,0x18   ; ending x coordinate
(0742)  CS-0x1F4  0x080D9         || 		CALL draw_horizontal_line
(0743)                            || 
(0744)  CS-0x1F5  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0745)  CS-0x1F6  0x3670A         || 		MOV r7,0x0A   ; y coordinate
(0746)  CS-0x1F7  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0747)  CS-0x1F8  0x080D9         || 		CALL draw_horizontal_line
(0748)                            || 
(0749)  CS-0x1F9  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0750)  CS-0x1FA  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0751)  CS-0x1FB  0x36916         || 		MOV r9,0x16   ; ending x coordinate
(0752)  CS-0x1FC  0x080D9         || 		CALL draw_horizontal_line
(0753)                            || 
(0754)  CS-0x1FD  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0755)  CS-0x1FE  0x36716         || 		MOV r7,0x16   ; y coordinate
(0756)  CS-0x1FF  0x36918         || 		MOV r9,0x18   ; ending x coordinate
(0757)  CS-0x200  0x080D9         || 		CALL draw_horizontal_line
(0758)                            || 
(0759)  CS-0x201  0x36814         || 		MOV r8,0x14   ; starting x coordinate
(0760)  CS-0x202  0x36718         || 		MOV r7,0x18   ; y coordinate
(0761)  CS-0x203  0x36920         || 		MOV r9,0x20   ; ending x coordinate
(0762)  CS-0x204  0x080D9         || 		CALL draw_horizontal_line
(0763)                            || 
(0764)  CS-0x205  0x36816         || 		MOV r8,0x16  ; x coordinate
(0765)  CS-0x206  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0766)  CS-0x207  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0767)  CS-0x208  0x08109         || 		CALL draw_vertical_line
(0768)                            || 
(0769)  CS-0x209  0x36816         || 		MOV r8,0x16  ; x coordinate
(0770)  CS-0x20A  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0771)  CS-0x20B  0x36906         || 		MOV r9,0x06	 ; ending y coordinate
(0772)  CS-0x20C  0x08109         || 		CALL draw_vertical_line
(0773)                            || 
(0774)  CS-0x20D  0x36816         || 		MOV r8,0x16  ; x coordinate
(0775)  CS-0x20E  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0776)  CS-0x20F  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(0777)  CS-0x210  0x08109         || 		CALL draw_vertical_line
(0778)                            || 
(0779)  CS-0x211  0x36816         || 		MOV r8,0x16   ; starting x coordinate
(0780)  CS-0x212  0x36702         || 		MOV r7,0x02   ; y coordinate
(0781)  CS-0x213  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0782)  CS-0x214  0x080D9         || 		CALL draw_horizontal_line
(0783)                            || 
(0784)  CS-0x215  0x36816         || 		MOV r8,0x16   ; starting x coordinate
(0785)  CS-0x216  0x3670C         || 		MOV r7,0x0C   ; y coordinate
(0786)  CS-0x217  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0787)  CS-0x218  0x080D9         || 		CALL draw_horizontal_line
(0788)                            || 
(0789)  CS-0x219  0x36818         || 		MOV r8,0x18  ; x coordinate
(0790)  CS-0x21A  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0791)  CS-0x21B  0x36906         || 		MOV r9,0x06	 ; ending y coordinate
(0792)  CS-0x21C  0x08109         || 		CALL draw_vertical_line
(0793)                            || 
(0794)  CS-0x21D  0x36818         || 		MOV r8,0x18  ; x coordinate
(0795)  CS-0x21E  0x3670A         || 		MOV r7,0x0A	 ; starting y coordinate
(0796)  CS-0x21F  0x3690C         || 		MOV r9,0x0C	 ; ending y coordinate
(0797)  CS-0x220  0x08109         || 		CALL draw_vertical_line
(0798)                            || 
(0799)  CS-0x221  0x36818         || 		MOV r8,0x18  ; x coordinate
(0800)  CS-0x222  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0801)  CS-0x223  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0802)  CS-0x224  0x08109         || 		CALL draw_vertical_line
(0803)                            || 
(0804)  CS-0x225  0x36818         || 		MOV r8,0x18   ; starting x coordinate
(0805)  CS-0x226  0x36706         || 		MOV r7,0x06   ; y coordinate
(0806)  CS-0x227  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0807)  CS-0x228  0x080D9         || 		CALL draw_horizontal_line
(0808)                            || 
(0809)  CS-0x229  0x36818         || 		MOV r8,0x18   ; starting x coordinate
(0810)  CS-0x22A  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0811)  CS-0x22B  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0812)  CS-0x22C  0x080D9         || 		CALL draw_horizontal_line
(0813)                            || 
(0814)  CS-0x22D  0x36818         || 		MOV r8,0x18   ; starting x coordinate
(0815)  CS-0x22E  0x36710         || 		MOV r7,0x10   ; y coordinate
(0816)  CS-0x22F  0x36926         || 		MOV r9,0x26   ; ending x coordinate
(0817)  CS-0x230  0x080D9         || 		CALL draw_horizontal_line
(0818)                            || 
(0819)  CS-0x231  0x36818         || 		MOV r8,0x18   ; starting x coordinate
(0820)  CS-0x232  0x36712         || 		MOV r7,0x12   ; y coordinate
(0821)  CS-0x233  0x3691A         || 		MOV r9,0x1A   ; ending x coordinate
(0822)  CS-0x234  0x080D9         || 		CALL draw_horizontal_line
(0823)                            || 
(0824)  CS-0x235  0x3681A         || 		MOV r8,0x1A  ; x coordinate
(0825)  CS-0x236  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0826)  CS-0x237  0x36904         || 		MOV r9,0x04	 ; ending y coordinate
(0827)  CS-0x238  0x08109         || 		CALL draw_vertical_line
(0828)                            || 
(0829)  CS-0x239  0x3681A         || 		MOV r8,0x1A  ; x coordinate
(0830)  CS-0x23A  0x36708         || 		MOV r7,0x08	 ; starting y coordinate
(0831)  CS-0x23B  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0832)  CS-0x23C  0x08109         || 		CALL draw_vertical_line
(0833)                            || 
(0834)  CS-0x23D  0x3681A         || 		MOV r8,0x1A  ; x coordinate
(0835)  CS-0x23E  0x36714         || 		MOV r7,0x14	 ; starting y coordinate
(0836)  CS-0x23F  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0837)  CS-0x240  0x08109         || 		CALL draw_vertical_line
(0838)                            || 
(0839)  CS-0x241  0x3681C         || 		MOV r8,0x1C  ; x coordinate
(0840)  CS-0x242  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0841)  CS-0x243  0x3690A         || 		MOV r9,0x0A	 ; ending y coordinate
(0842)  CS-0x244  0x08109         || 		CALL draw_vertical_line
(0843)                            || 
(0844)  CS-0x245  0x3681C         || 		MOV r8,0x1C  ; x coordinate
(0845)  CS-0x246  0x3670E         || 		MOV r7,0x0E	 ; starting y coordinate
(0846)  CS-0x247  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(0847)  CS-0x248  0x08109         || 		CALL draw_vertical_line
(0848)                            || 
(0849)  CS-0x249  0x3681C         || 		MOV r8,0x1C  ; x coordinate
(0850)  CS-0x24A  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0851)  CS-0x24B  0x36916         || 		MOV r9,0x16	 ; ending y coordinate
(0852)  CS-0x24C  0x08109         || 		CALL draw_vertical_line
(0853)                            || 
(0854)  CS-0x24D  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0855)  CS-0x24E  0x36702         || 		MOV r7,0x02   ; y coordinate
(0856)  CS-0x24F  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0857)  CS-0x250  0x080D9         || 		CALL draw_horizontal_line
(0858)                            || 
(0859)  CS-0x251  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0860)  CS-0x252  0x36708         || 		MOV r7,0x08   ; y coordinate
(0861)  CS-0x253  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0862)  CS-0x254  0x080D9         || 		CALL draw_horizontal_line
(0863)                            || 
(0864)  CS-0x255  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0865)  CS-0x256  0x3670A         || 		MOV r7,0x0A   ; y coordinate
(0866)  CS-0x257  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0867)  CS-0x258  0x080D9         || 		CALL draw_horizontal_line
(0868)                            || 
(0869)  CS-0x259  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0870)  CS-0x25A  0x36712         || 		MOV r7,0x12   ; y coordinate
(0871)  CS-0x25B  0x3691E         || 		MOV r9,0x1E   ; ending x coordinate
(0872)  CS-0x25C  0x080D9         || 		CALL draw_horizontal_line
(0873)                            || 
(0874)  CS-0x25D  0x3681C         || 		MOV r8,0x1C   ; starting x coordinate
(0875)  CS-0x25E  0x36714         || 		MOV r7,0x14   ; y coordinate
(0876)  CS-0x25F  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0877)  CS-0x260  0x080D9         || 		CALL draw_horizontal_line
(0878)                            || 
(0879)  CS-0x261  0x3681E         || 		MOV r8,0x1E  ; x coordinate
(0880)  CS-0x262  0x36700         || 		MOV r7,0x00	 ; starting y coordinate
(0881)  CS-0x263  0x36902         || 		MOV r9,0x02	 ; ending y coordinate
(0882)  CS-0x264  0x08109         || 		CALL draw_vertical_line
(0883)                            || 
(0884)  CS-0x265  0x3681E         || 		MOV r8,0x1E  ; x coordinate
(0885)  CS-0x266  0x36704         || 		MOV r7,0x04	 ; starting y coordinate
(0886)  CS-0x267  0x36908         || 		MOV r9,0x08	 ; ending y coordinate
(0887)  CS-0x268  0x08109         || 		CALL draw_vertical_line
(0888)                            || 
(0889)  CS-0x269  0x3681E         || 		MOV r8,0x1E   ; starting x coordinate
(0890)  CS-0x26A  0x36704         || 		MOV r7,0x04   ; y coordinate
(0891)  CS-0x26B  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0892)  CS-0x26C  0x080D9         || 		CALL draw_horizontal_line
(0893)                            || 
(0894)  CS-0x26D  0x3681E         || 		MOV r8,0x1E   ; starting x coordinate
(0895)  CS-0x26E  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0896)  CS-0x26F  0x36920         || 		MOV r9,0x20   ; ending x coordinate
(0897)  CS-0x270  0x080D9         || 		CALL draw_horizontal_line
(0898)                            || 
(0899)  CS-0x271  0x3681E         || 		MOV r8,0x1E   ; starting x coordinate
(0900)  CS-0x272  0x36716         || 		MOV r7,0x16   ; y coordinate
(0901)  CS-0x273  0x36922         || 		MOV r9,0x22   ; ending x coordinate
(0902)  CS-0x274  0x080D9         || 		CALL draw_horizontal_line
(0903)                            || 
(0904)  CS-0x275  0x36820         || 		MOV r8,0x20  ; x coordinate
(0905)  CS-0x276  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0906)  CS-0x277  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(0907)  CS-0x278  0x08109         || 		CALL draw_vertical_line
(0908)                            || 
(0909)  CS-0x279  0x36820         || 		MOV r8,0x20  ; x coordinate
(0910)  CS-0x27A  0x36712         || 		MOV r7,0x12	 ; starting y coordinate
(0911)  CS-0x27B  0x36914         || 		MOV r9,0x14	 ; ending y coordinate
(0912)  CS-0x27C  0x08109         || 		CALL draw_vertical_line
(0913)                            || 
(0914)  CS-0x27D  0x36820         || 		MOV r8,0x20  ; x coordinate
(0915)  CS-0x27E  0x36718         || 		MOV r7,0x18	 ; starting y coordinate
(0916)  CS-0x27F  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0917)  CS-0x280  0x08109         || 		CALL draw_vertical_line
(0918)                            || 
(0919)  CS-0x281  0x36820         || 		MOV r8,0x20   ; starting x coordinate
(0920)  CS-0x282  0x36702         || 		MOV r7,0x02   ; y coordinate
(0921)  CS-0x283  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0922)  CS-0x284  0x080D9         || 		CALL draw_horizontal_line
(0923)                            || 
(0924)  CS-0x285  0x36820         || 		MOV r8,0x20   ; starting x coordinate
(0925)  CS-0x286  0x36706         || 		MOV r7,0x06   ; y coordinate
(0926)  CS-0x287  0x36922         || 		MOV r9,0x22   ; ending x coordinate
(0927)  CS-0x288  0x080D9         || 		CALL draw_horizontal_line
(0928)                            || 
(0929)  CS-0x289  0x36820         || 		MOV r8,0x20   ; starting x coordinate
(0930)  CS-0x28A  0x36712         || 		MOV r7,0x12   ; y coordinate
(0931)  CS-0x28B  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0932)  CS-0x28C  0x080D9         || 		CALL draw_horizontal_line
(0933)                            || 
(0934)  CS-0x28D  0x36820         || 		MOV r8,0x20   ; starting x coordinate
(0935)  CS-0x28E  0x3671A         || 		MOV r7,0x1A   ; y coordinate
(0936)  CS-0x28F  0x36922         || 		MOV r9,0x22   ; ending x coordinate
(0937)  CS-0x290  0x080D9         || 		CALL draw_horizontal_line
(0938)                            || 
(0939)  CS-0x291  0x36822         || 		MOV r8,0x22  ; x coordinate
(0940)  CS-0x292  0x36706         || 		MOV r7,0x06	 ; starting y coordinate
(0941)  CS-0x293  0x36908         || 		MOV r9,0x08	 ; ending y coordinate
(0942)  CS-0x294  0x08109         || 		CALL draw_vertical_line
(0943)                            || 
(0944)  CS-0x295  0x36822         || 		MOV r8,0x22  ; x coordinate
(0945)  CS-0x296  0x3670A         || 		MOV r7,0x0A	 ; starting y coordinate
(0946)  CS-0x297  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0947)  CS-0x298  0x08109         || 		CALL draw_vertical_line
(0948)                            || 
(0949)  CS-0x299  0x36822         || 		MOV r8,0x22  ; x coordinate
(0950)  CS-0x29A  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0951)  CS-0x29B  0x3691A         || 		MOV r9,0x1A	 ; ending y coordinate
(0952)  CS-0x29C  0x08109         || 		CALL draw_vertical_line
(0953)                            || 
(0954)  CS-0x29D  0x36822         || 		MOV r8,0x22   ; starting x coordinate
(0955)  CS-0x29E  0x3670E         || 		MOV r7,0x0E   ; y coordinate
(0956)  CS-0x29F  0x36924         || 		MOV r9,0x24   ; ending x coordinate
(0957)  CS-0x2A0  0x080D9         || 		CALL draw_horizontal_line
(0958)                            || 
(0959)  CS-0x2A1  0x36824         || 		MOV r8,0x24  ; x coordinate
(0960)  CS-0x2A2  0x36702         || 		MOV r7,0x02	 ; starting y coordinate
(0961)  CS-0x2A3  0x3690E         || 		MOV r9,0x0E	 ; ending y coordinate
(0962)  CS-0x2A4  0x08109         || 		CALL draw_vertical_line
(0963)                            || 
(0964)  CS-0x2A5  0x36824         || 		MOV r8,0x24  ; x coordinate
(0965)  CS-0x2A6  0x36714         || 		MOV r7,0x14	 ; starting y coordinate
(0966)  CS-0x2A7  0x3691C         || 		MOV r9,0x1C	 ; ending y coordinate
(0967)  CS-0x2A8  0x08109         || 		CALL draw_vertical_line
(0968)                            || 
(0969)  CS-0x2A9  0x3680A         || 		MOV r8,0x0a  ; x coordinate
(0970)  CS-0x2AA  0x3671A         || 		MOV r7,0x1A	 ; starting y coordinate
(0971)  CS-0x2AB  0x3690C         || 		MOV r9,0x0c	 ; ending x coordinate
(0972)  CS-0x2AC  0x080D9         || 		CALL draw_horizontal_line
(0973)                            || 
(0974)  CS-0x2AD  0x3681A         || 		MOV r8,0x1a  ; x coordinate
(0975)  CS-0x2AE  0x36716         || 		MOV r7,0x16	 ; starting y coordinate
(0976)  CS-0x2AF  0x3691C         || 		MOV r9,0x1c	 ; ending x coordinate
(0977)  CS-0x2B0  0x080D9         || 		CALL draw_horizontal_line
(0978)                            || 
(0979)  CS-0x2B1  0x3681B         || 		MOV r8,0x1b  ; x coordinate
(0980)  CS-0x2B2  0x36708         || 		MOV r7,0x08	 ; y coordinate
(0981)  CS-0x2B3  0x08189         || 		CALL draw_dot
(0982)                            || 
(0983)  CS-0x2B4  0x18002         || 		RET
(0984)                            || 
(0985)                     0x2B5  || draw_win:
(0986)                            || 
(0987)  CS-0x2B5  0x3661C         || 		MOV r6,M_GREEN
(0988)                            || 
(0989)  CS-0x2B6  0x3680D         || 		MOV r8,0x0d  ; x coordinate
(0990)  CS-0x2B7  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(0991)  CS-0x2B8  0x3690F         || 		MOV r9,0x0f	 ; ending y coordinate
(0992)  CS-0x2B9  0x08109         || 		CALL draw_vertical_line
(0993)                            || 
(0994)  CS-0x2BA  0x3680E         || 		MOV r8,0x0e  ; x coordinate
(0995)  CS-0x2BB  0x36710         || 		MOV r7,0x10	 ; y coordinate
(0996)  CS-0x2BC  0x08189         || 		CALL draw_dot
(0997)                            || 
(0998)  CS-0x2BD  0x3680F         || 		MOV r8,0x0f  ; x coordinate
(0999)  CS-0x2BE  0x3670E         || 		MOV r7,0x0e	 ; starting y coordinate
(1000)  CS-0x2BF  0x3690F         || 		MOV r9,0x0f	 ; ending y coordinate
(1001)  CS-0x2C0  0x08109         || 		CALL draw_vertical_line
(1002)                            || 
(1003)  CS-0x2C1  0x36810         || 		MOV r8,0x10  ; x coordinate
(1004)  CS-0x2C2  0x36710         || 		MOV r7,0x10	 ; y coordinate
(1005)  CS-0x2C3  0x08189         || 		CALL draw_dot
(1006)                            || 
(1007)  CS-0x2C4  0x36811         || 		MOV r8,0x11  ; x coordinate
(1008)  CS-0x2C5  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1009)  CS-0x2C6  0x3690F         || 		MOV r9,0x0f	 ; ending y coordinate
(1010)  CS-0x2C7  0x08109         || 		CALL draw_vertical_line
(1011)                            || 
(1012)  CS-0x2C8  0x36813         || 		MOV r8,0x13  ; x coordinate
(1013)  CS-0x2C9  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1014)  CS-0x2CA  0x36915         || 		MOV r9,0x15	 ; ending x coordinate
(1015)  CS-0x2CB  0x080D9         || 		CALL draw_horizontal_line
(1016)                            || 
(1017)  CS-0x2CC  0x36814         || 		MOV r8,0x14  ; x coordinate
(1018)  CS-0x2CD  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1019)  CS-0x2CE  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(1020)  CS-0x2CF  0x08109         || 		CALL draw_vertical_line
(1021)                            || 
(1022)  CS-0x2D0  0x36813         || 		MOV r8,0x13  ; x coordinate
(1023)  CS-0x2D1  0x36710         || 		MOV r7,0x10	 ; starting y coordinate
(1024)  CS-0x2D2  0x36915         || 		MOV r9,0x15	 ; ending x coordinate
(1025)  CS-0x2D3  0x080D9         || 		CALL draw_horizontal_line
(1026)                            || 
(1027)  CS-0x2D4  0x36817         || 		MOV r8,0x17  ; x coordinate
(1028)  CS-0x2D5  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1029)  CS-0x2D6  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(1030)  CS-0x2D7  0x08109         || 		CALL draw_vertical_line
(1031)                            || 
(1032)  CS-0x2D8  0x36818         || 		MOV r8,0x18  ; x coordinate
(1033)  CS-0x2D9  0x3670B         || 		MOV r7,0x0b	 ; y coordinate
(1034)  CS-0x2DA  0x08189         || 		CALL draw_dot
(1035)                            || 
(1036)  CS-0x2DB  0x36819         || 		MOV r8,0x19  ; x coordinate
(1037)  CS-0x2DC  0x3670C         || 		MOV r7,0x0c	 ; y coordinate
(1038)  CS-0x2DD  0x08189         || 		CALL draw_dot
(1039)                            || 
(1040)  CS-0x2DE  0x3681A         || 		MOV r8,0x1a  ; x coordinate
(1041)  CS-0x2DF  0x3670D         || 		MOV r7,0x0d	 ; y coordinate
(1042)  CS-0x2E0  0x08189         || 		CALL draw_dot
(1043)                            || 
(1044)  CS-0x2E1  0x3681B         || 		MOV r8,0x1b  ; x coordinate
(1045)  CS-0x2E2  0x3670A         || 		MOV r7,0x0a	 ; starting y coordinate
(1046)  CS-0x2E3  0x36910         || 		MOV r9,0x10	 ; ending y coordinate
(1047)  CS-0x2E4  0x08109         || 		CALL draw_vertical_line
(1048)                            || 
(1049)  CS-0x2E5  0x18002         || 		RET





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
DD_ADD40       0x03D   (0152)  ||  0142 
DD_ADD80       0x040   (0156)  ||  0145 
DD_OUT         0x039   (0147)  ||  0157 
DRAW_AT_PREV_LOC 0x0A7   (0320)  ||  0240 0263 0286 0309 
DRAW_BACKGROUND 0x027   (0108)  ||  0028 0039 
DRAW_BLOCK     0x053   (0186)  ||  0031 
DRAW_DOT       0x031   (0135)  ||  0065 0091 0192 0247 0270 0293 0316 0324 0334 0981 
                               ||  0996 1005 1034 1038 1042 
DRAW_HORIZ1    0x01C   (0064)  ||  0068 
DRAW_HORIZONTAL_LINE 0x01B   (0061)  ||  0115 0342 0352 0362 0372 0377 0382 0387 0392 0427 
                               ||  0452 0457 0462 0492 0497 0502 0507 0532 0537 0542 
                               ||  0547 0572 0577 0582 0607 0612 0617 0647 0652 0657 
                               ||  0662 0677 0682 0687 0707 0712 0717 0742 0747 0752 
                               ||  0757 0762 0782 0787 0807 0812 0817 0822 0857 0862 
                               ||  0867 0872 0877 0892 0897 0902 0922 0927 0932 0937 
                               ||  0957 0972 0977 1015 1025 
DRAW_MAZE      0x0AC   (0327)  ||  0029 
DRAW_VERT1     0x022   (0090)  ||  0094 
DRAW_VERTICAL_LINE 0x021   (0087)  ||  0347 0357 0367 0397 0402 0407 0412 0417 0422 0432 
                               ||  0437 0442 0447 0467 0472 0477 0482 0487 0512 0517 
                               ||  0522 0527 0552 0557 0562 0567 0587 0592 0597 0602 
                               ||  0622 0627 0632 0637 0642 0667 0672 0692 0697 0702 
                               ||  0722 0727 0732 0737 0767 0772 0777 0792 0797 0802 
                               ||  0827 0832 0837 0842 0847 0852 0882 0887 0907 0912 
                               ||  0917 0942 0947 0952 0962 0967 0992 1001 1010 1020 
                               ||  1030 1047 
DRAW_WIN       0x2B5   (0985)  ||  0042 
INSIDE_FOR0    0x068   (0217)  ||  0218 
MAIN           0x013   (0033)  ||  0036 0038 
MIDDLE_FOR0    0x066   (0214)  ||  0221 
MOVE_BLOCK     0x05A   (0195)  ||  0033 
MOVE_DOWN      0x099   (0297)  ||  0207 
MOVE_DOWN_END  0x063   (0208)  ||  0305 0318 
MOVE_LEFT      0x07D   (0251)  ||  0201 
MOVE_LEFT_END  0x05F   (0202)  ||  0259 0272 
MOVE_RIGHT     0x06F   (0228)  ||  0198 
MOVE_RIGHT_END 0x05D   (0199)  ||  0236 0249 
MOVE_UP        0x08B   (0274)  ||  0204 
MOVE_UP_END    0x061   (0205)  ||  0282 0295 
OUTSIDE_FOR0   0x064   (0211)  ||  0224 
READ_DOT       0x042   (0160)  ||  0234 0257 0280 0303 
START          0x029   (0111)  ||  0118 
T1             0x037   (0144)  ||  0154 
WIN_SCREEN     0x019   (0041)  ||  0043 
XDD_ADD40      0x04E   (0177)  ||  0167 
XDD_ADD80      0x051   (0181)  ||  0170 
XDD_OUT        0x04A   (0172)  ||  0182 
XT1            0x048   (0169)  ||  0179 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0011)  ||  0109 0323 
BUTTON         0x09A   (0020)  ||  0195 
FOR_COUNT      0x0AA   (0021)  ||  
LEDS           0x040   (0009)  ||  0238 0261 0284 0307 
M_BLACK        0x000   (0016)  ||  0235 0258 0281 0304 0337 
M_BLUE         0x003   (0015)  ||  
M_BROWN        0x090   (0017)  ||  
M_GREEN        0x01C   (0018)  ||  0330 0987 
M_RED          0x0E0   (0014)  ||  
M_YELLOW       0x0E0   (0013)  ||  0186 0246 0269 0292 0315 
SSEG           0x081   (0008)  ||  
VGA_COLOR      0x092   (0006)  ||  0149 
VGA_HADD       0x090   (0004)  ||  0148 0173 
VGA_LADD       0x091   (0005)  ||  0147 0172 
VGA_READ       0x093   (0007)  ||  0174 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
