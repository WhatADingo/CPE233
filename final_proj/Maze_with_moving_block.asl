

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
(0026)  CS-0x010  0x08109         ||          CALL   draw_background         ; draw using default color
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
(0041)  CS-0x011  0x081E1         || 		CALL	draw_maze
(0042)                            || 
(0043)  CS-0x012  0x00000  0x012  || main:   AND    r0, r0                  ; nop
(0044)                            || 
(0045)  CS-0x013  0x09189         || 		CALL	move_block
(0046)                            || 	
(0047)  CS-0x014  0x08090         ||         BRN    main                    ; continuous loop 
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
(0065)                     0x015  || draw_horizontal_line:
(0066)  CS-0x015  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0067)                            || 
(0068)                     0x016  || draw_horiz1:
(0069)  CS-0x016  0x08159         ||         CALL   draw_dot         ; 
(0070)  CS-0x017  0x28801         ||         ADD    r8,0x01
(0071)  CS-0x018  0x04848         ||         CMP    r8,r9
(0072)  CS-0x019  0x080B3         ||         BRNE   draw_horiz1
(0073)  CS-0x01A  0x18002         ||         RET
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
(0091)                     0x01B  || draw_vertical_line:
(0092)  CS-0x01B  0x28901         ||          ADD    r9,0x01
(0093)                            || 
(0094)                     0x01C  || draw_vert1:          
(0095)  CS-0x01C  0x08159         ||          CALL   draw_dot
(0096)  CS-0x01D  0x28701         ||          ADD    r7,0x01
(0097)  CS-0x01E  0x04748         ||          CMP    r7,R9
(0098)  CS-0x01F  0x080E3         ||          BRNE   draw_vert1
(0099)  CS-0x020  0x18002         ||          RET
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
(0112)                     0x021  || draw_background: 
(0113)  CS-0x021  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0114)  CS-0x022  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0115)  CS-0x023  0x04769  0x023  || start:   MOV   r7,r13                   ; load current row count 
(0116)  CS-0x024  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0117)  CS-0x025  0x36927         ||          MOV   r9,0x27 
(0118)                            || 
(0119)  CS-0x026  0x080A9         ||          CALL  draw_horizontal_line
(0120)  CS-0x027  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0121)  CS-0x028  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0122)  CS-0x029  0x0811B         ||          BRNE  start                    ; branch to draw more rows
(0123)  CS-0x02A  0x18002         ||          RET
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
(0138)                     0x02B  || draw_dot: 
(0139)  CS-0x02B  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0140)  CS-0x02C  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0141)                            || 
(0142)  CS-0x02D  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0143)  CS-0x02E  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0144)  CS-0x02F  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0145)  CS-0x030  0x0A1B8         ||            BRCS  dd_add40
(0146)                            || 
(0147)  CS-0x031  0x10401  0x031  || t1:        LSR   r4
(0148)  CS-0x032  0x0A1D0         ||            BRCS  dd_add80
(0149)                            || 
(0150)  CS-0x033  0x34591  0x033  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0151)  CS-0x034  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0152)  CS-0x035  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0153)  CS-0x036  0x18002         ||            RET
(0154)                            || 
(0155)  CS-0x037  0x22540  0x037  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0156)  CS-0x038  0x18000         ||            CLC                  ; freshen bit
(0157)  CS-0x039  0x08188         ||            BRN   t1             
(0158)                            || 
(0159)  CS-0x03A  0x22580  0x03A  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0160)  CS-0x03B  0x08198         ||            BRN   dd_out
(0161)                            || ; --------------------------------------------------------------------
(0162)                     0x03C  || draw_maze: 
(0163)  CS-0x03C  0x36600         || 		   MOV r6,M_BLACK
(0164)                            || 		   
(0165)  CS-0x03D  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0166)  CS-0x03E  0x36700         || 		   MOV r7,0x00   ; y coordinate
(0167)  CS-0x03F  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0168)  CS-0x040  0x080A9         || 		   CALL draw_horizontal_line
(0169)                            || 
(0170)  CS-0x041  0x36800         ||            MOV r8,0x00   ; x coordinate
(0171)  CS-0x042  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0172)  CS-0x043  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0173)  CS-0x044  0x080D9         || 		   CALL draw_vertical_line
(0174)                            || 
(0175)  CS-0x045  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0176)  CS-0x046  0x3671C         || 		   MOV r7,0x1C   ; y coordinate
(0177)  CS-0x047  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0178)  CS-0x048  0x080A9         || 		   CALL draw_horizontal_line
(0179)                            || 
(0180)  CS-0x049  0x36826         || 		   MOV r8,0x26   ; x coordinate
(0181)  CS-0x04A  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0182)  CS-0x04B  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0183)  CS-0x04C  0x080D9         || 		   CALL draw_vertical_line
(0184)                            || 
(0185)  CS-0x04D  0x36800         || 		   MOV r8,0x00  ; starting x coordinate
(0186)  CS-0x04E  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0187)  CS-0x04F  0x36902         || 		   MOV r9,0x02   ; ending x coordinate
(0188)  CS-0x050  0x080A9         || 		   CALL draw_horizontal_line
(0189)                            ||  
(0190)  CS-0x051  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0191)  CS-0x052  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0192)  CS-0x053  0x36904         || 		   MOV r9,0x04   ; ending x coordinate
(0193)  CS-0x054  0x080A9         || 		   CALL draw_horizontal_line
(0194)                            || 
(0195)  CS-0x055  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0196)  CS-0x056  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0197)  CS-0x057  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0198)  CS-0x058  0x080A9         || 		   CALL draw_horizontal_line
(0199)                            || 
(0200)  CS-0x059  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0201)  CS-0x05A  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0202)  CS-0x05B  0x36902         || 		   MOV r9,0x02   ; ending x coordinate
(0203)  CS-0x05C  0x080A9         || 		   CALL draw_horizontal_line
(0204)                            || 
(0205)  CS-0x05D  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0206)  CS-0x05E  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0207)  CS-0x05F  0x36904         || 		   MOV r9,0x04   ; ending x coordinate
(0208)  CS-0x060  0x080A9         || 		   CALL draw_horizontal_line
(0209)                            || 
(0210)  CS-0x061  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0211)  CS-0x062  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0212)  CS-0x063  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0213)  CS-0x064  0x080D9         || 		   CALL draw_vertical_line
(0214)                            || 
(0215)  CS-0x065  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0216)  CS-0x066  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0217)  CS-0x067  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0218)  CS-0x068  0x080D9         || 		   CALL draw_vertical_line
(0219)                            || 
(0220)  CS-0x069  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0221)  CS-0x06A  0x3670C         || 		   MOV r7,0x0C	 ; starting y coordinate
(0222)  CS-0x06B  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0223)  CS-0x06C  0x080D9         || 		   CALL draw_vertical_line
(0224)                            || 
(0225)  CS-0x06D  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0226)  CS-0x06E  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0227)  CS-0x06F  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0228)  CS-0x070  0x080D9         || 		   CALL draw_vertical_line
(0229)                            || 
(0230)  CS-0x071  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0231)  CS-0x072  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0232)  CS-0x073  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0233)  CS-0x074  0x080D9         || 		   CALL draw_vertical_line
(0234)                            || 
(0235)  CS-0x075  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0236)  CS-0x076  0x3671A         || 		   MOV r7,0x1A	 ; starting y coordinate
(0237)  CS-0x077  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0238)  CS-0x078  0x080D9         || 		   CALL draw_vertical_line
(0239)                            || 
(0240)  CS-0x079  0x36802         || 		   MOV r8,0x02   ; starting x coordinate
(0241)  CS-0x07A  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0242)  CS-0x07B  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0243)  CS-0x07C  0x080A9         || 		   CALL draw_horizontal_line
(0244)                            || 
(0245)  CS-0x07D  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0246)  CS-0x07E  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0247)  CS-0x07F  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0248)  CS-0x080  0x080D9         || 		   CALL draw_vertical_line
(0249)                            || 
(0250)  CS-0x081  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0251)  CS-0x082  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0252)  CS-0x083  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0253)  CS-0x084  0x080D9         || 		   CALL draw_vertical_line
(0254)                            || 
(0255)  CS-0x085  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0256)  CS-0x086  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0257)  CS-0x087  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0258)  CS-0x088  0x080D9         || 		   CALL draw_vertical_line
(0259)                            || 
(0260)  CS-0x089  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0261)  CS-0x08A  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0262)  CS-0x08B  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0263)  CS-0x08C  0x080D9         || 		   CALL draw_vertical_line
(0264)                            || 
(0265)  CS-0x08D  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0266)  CS-0x08E  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0267)  CS-0x08F  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0268)  CS-0x090  0x080A9         || 		   CALL draw_horizontal_line
(0269)                            || 
(0270)  CS-0x091  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0271)  CS-0x092  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0272)  CS-0x093  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0273)  CS-0x094  0x080A9         || 		   CALL draw_horizontal_line
(0274)                            || 		
(0275)  CS-0x095  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0276)  CS-0x096  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0277)  CS-0x097  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0278)  CS-0x098  0x080A9         || 		   CALL draw_horizontal_line
(0279)                            || 
(0280)  CS-0x099  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0281)  CS-0x09A  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0282)  CS-0x09B  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0283)  CS-0x09C  0x080D9         || 		   CALL draw_vertical_line
(0284)                            || 
(0285)  CS-0x09D  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0286)  CS-0x09E  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0287)  CS-0x09F  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0288)  CS-0x0A0  0x080D9         || 		   CALL draw_vertical_line
(0289)                            || 
(0290)  CS-0x0A1  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0291)  CS-0x0A2  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0292)  CS-0x0A3  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0293)  CS-0x0A4  0x080D9         || 		   CALL draw_vertical_line
(0294)                            || 
(0295)  CS-0x0A5  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0296)  CS-0x0A6  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0297)  CS-0x0A7  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0298)  CS-0x0A8  0x080D9         || 		   CALL draw_vertical_line
(0299)                            || 
(0300)  CS-0x0A9  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0301)  CS-0x0AA  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0302)  CS-0x0AB  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0303)  CS-0x0AC  0x080D9         || 		   CALL draw_vertical_line
(0304)                            || 
(0305)  CS-0x0AD  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0306)  CS-0x0AE  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0307)  CS-0x0AF  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0308)  CS-0x0B0  0x080A9         || 		   CALL draw_horizontal_line
(0309)                            || 
(0310)  CS-0x0B1  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0311)  CS-0x0B2  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0312)  CS-0x0B3  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0313)  CS-0x0B4  0x080A9         || 		   CALL draw_horizontal_line
(0314)                            || 
(0315)  CS-0x0B5  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0316)  CS-0x0B6  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0317)  CS-0x0B7  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0318)  CS-0x0B8  0x080A9         || 		   CALL draw_horizontal_line
(0319)                            || 
(0320)  CS-0x0B9  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0321)  CS-0x0BA  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0322)  CS-0x0BB  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0323)  CS-0x0BC  0x080A9         || 		   CALL draw_horizontal_line
(0324)                            || 
(0325)  CS-0x0BD  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0326)  CS-0x0BE  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0327)  CS-0x0BF  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0328)  CS-0x0C0  0x080D9         || 		   CALL draw_vertical_line
(0329)                            || 
(0330)  CS-0x0C1  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0331)  CS-0x0C2  0x3670C         || 		   MOV r7,0x0C	 ; starting y coordinate
(0332)  CS-0x0C3  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0333)  CS-0x0C4  0x080D9         || 		   CALL draw_vertical_line
(0334)                            || 
(0335)  CS-0x0C5  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0336)  CS-0x0C6  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0337)  CS-0x0C7  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0338)  CS-0x0C8  0x080D9         || 		   CALL draw_vertical_line
(0339)                            || 
(0340)  CS-0x0C9  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0341)  CS-0x0CA  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0342)  CS-0x0CB  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0343)  CS-0x0CC  0x080D9         || 		   CALL draw_vertical_line
(0344)                            || 
(0345)  CS-0x0CD  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0346)  CS-0x0CE  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0347)  CS-0x0CF  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0348)  CS-0x0D0  0x080A9         || 		   CALL draw_horizontal_line
(0349)                            || 
(0350)  CS-0x0D1  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0351)  CS-0x0D2  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0352)  CS-0x0D3  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0353)  CS-0x0D4  0x080A9         || 		   CALL draw_horizontal_line
(0354)                            || 
(0355)  CS-0x0D5  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0356)  CS-0x0D6  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0357)  CS-0x0D7  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0358)  CS-0x0D8  0x080A9         || 		   CALL draw_horizontal_line
(0359)                            || 
(0360)  CS-0x0D9  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0361)  CS-0x0DA  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0362)  CS-0x0DB  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0363)  CS-0x0DC  0x080A9         || 		   CALL draw_horizontal_line
(0364)                            || 
(0365)  CS-0x0DD  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0366)  CS-0x0DE  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0367)  CS-0x0DF  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0368)  CS-0x0E0  0x080D9         || 		   CALL draw_vertical_line
(0369)                            || 
(0370)  CS-0x0E1  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0371)  CS-0x0E2  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0372)  CS-0x0E3  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0373)  CS-0x0E4  0x080D9         || 		   CALL draw_vertical_line
(0374)                            || 
(0375)  CS-0x0E5  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0376)  CS-0x0E6  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0377)  CS-0x0E7  0x36912         || 		   MOV r9,0x12	 ; ending y coordinate
(0378)  CS-0x0E8  0x080D9         || 		   CALL draw_vertical_line
(0379)                            || 
(0380)  CS-0x0E9  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0381)  CS-0x0EA  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0382)  CS-0x0EB  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0383)  CS-0x0EC  0x080D9         || 		   CALL draw_vertical_line
(0384)                            || 
(0385)  CS-0x0ED  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0386)  CS-0x0EE  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0387)  CS-0x0EF  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0388)  CS-0x0F0  0x080A9         || 		   CALL draw_horizontal_line
(0389)                            || 
(0390)  CS-0x0F1  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0391)  CS-0x0F2  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0392)  CS-0x0F3  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0393)  CS-0x0F4  0x080A9         || 		   CALL draw_horizontal_line
(0394)                            || 
(0395)  CS-0x0F5  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0396)  CS-0x0F6  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0397)  CS-0x0F7  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0398)  CS-0x0F8  0x080A9         || 		   CALL draw_horizontal_line
(0399)                            || 
(0400)  CS-0x0F9  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0401)  CS-0x0FA  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0402)  CS-0x0FB  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0403)  CS-0x0FC  0x080D9         || 		   CALL draw_vertical_line
(0404)                            || 
(0405)  CS-0x0FD  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0406)  CS-0x0FE  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0407)  CS-0x0FF  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0408)  CS-0x100  0x080D9         || 		   CALL draw_vertical_line
(0409)                            || 
(0410)  CS-0x101  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0411)  CS-0x102  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0412)  CS-0x103  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0413)  CS-0x104  0x080D9         || 		   CALL draw_vertical_line
(0414)                            || 
(0415)  CS-0x105  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0416)  CS-0x106  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0417)  CS-0x107  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0418)  CS-0x108  0x080D9         || 		   CALL draw_vertical_line
(0419)                            || 
(0420)  CS-0x109  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0421)  CS-0x10A  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0422)  CS-0x10B  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0423)  CS-0x10C  0x080A9         || 		   CALL draw_horizontal_line
(0424)                            || 
(0425)  CS-0x10D  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0426)  CS-0x10E  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0427)  CS-0x10F  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0428)  CS-0x110  0x080A9         || 		   CALL draw_horizontal_line
(0429)                            || 
(0430)  CS-0x111  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0431)  CS-0x112  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0432)  CS-0x113  0x36910         || 		   MOV r9,0x10   ; ending x coordinate
(0433)  CS-0x114  0x080A9         || 		   CALL draw_horizontal_line
(0434)                            || 
(0435)  CS-0x115  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0436)  CS-0x116  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0437)  CS-0x117  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0438)  CS-0x118  0x080D9         || 		   CALL draw_vertical_line
(0439)                            || 
(0440)  CS-0x119  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0441)  CS-0x11A  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0442)  CS-0x11B  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0443)  CS-0x11C  0x080D9         || 		   CALL draw_vertical_line
(0444)                            || 
(0445)  CS-0x11D  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0446)  CS-0x11E  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0447)  CS-0x11F  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0448)  CS-0x120  0x080D9         || 		   CALL draw_vertical_line
(0449)                            || 
(0450)  CS-0x121  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0451)  CS-0x122  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0452)  CS-0x123  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0453)  CS-0x124  0x080D9         || 		   CALL draw_vertical_line
(0454)                            || 
(0455)  CS-0x125  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0456)  CS-0x126  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0457)  CS-0x127  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0458)  CS-0x128  0x080D9         || 		   CALL draw_vertical_line
(0459)                            || 
(0460)  CS-0x129  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0461)  CS-0x12A  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0462)  CS-0x12B  0x36910         || 		   MOV r9,0x10   ; ending x coordinate
(0463)  CS-0x12C  0x080A9         || 		   CALL draw_horizontal_line
(0464)                            || 
(0465)  CS-0x12D  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0466)  CS-0x12E  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0467)  CS-0x12F  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0468)  CS-0x130  0x080A9         || 		   CALL draw_horizontal_line
(0469)                            || 
(0470)  CS-0x131  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0471)  CS-0x132  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0472)  CS-0x133  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0473)  CS-0x134  0x080A9         || 		   CALL draw_horizontal_line
(0474)                            || 
(0475)  CS-0x135  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0476)  CS-0x136  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0477)  CS-0x137  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0478)  CS-0x138  0x080A9         || 		   CALL draw_horizontal_line
(0479)                            || 
(0480)  CS-0x139  0x36810         || 		   MOV r8,0x10  ; x coordinate
(0481)  CS-0x13A  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0482)  CS-0x13B  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0483)  CS-0x13C  0x080D9         || 		   CALL draw_vertical_line
(0484)                            || 
(0485)  CS-0x13D  0x36810         || 		   MOV r8,0x10  ; x coordinate
(0486)  CS-0x13E  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0487)  CS-0x13F  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0488)  CS-0x140  0x080D9         || 		   CALL draw_vertical_line
(0489)                            || 
(0490)  CS-0x141  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0491)  CS-0x142  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0492)  CS-0x143  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0493)  CS-0x144  0x080A9         || 		   CALL draw_horizontal_line
(0494)                            || 
(0495)  CS-0x145  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0496)  CS-0x146  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0497)  CS-0x147  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0498)  CS-0x148  0x080A9         || 		   CALL draw_horizontal_line
(0499)                            || 
(0500)  CS-0x149  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0501)  CS-0x14A  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0502)  CS-0x14B  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0503)  CS-0x14C  0x080A9         || 		   CALL draw_horizontal_line
(0504)                            || 
(0505)  CS-0x14D  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0506)  CS-0x14E  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0507)  CS-0x14F  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0508)  CS-0x150  0x080D9         || 		   CALL draw_vertical_line
(0509)                            || 
(0510)  CS-0x151  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0511)  CS-0x152  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0512)  CS-0x153  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0513)  CS-0x154  0x080D9         || 		   CALL draw_vertical_line
(0514)                            || 
(0515)  CS-0x155  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0516)  CS-0x156  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0517)  CS-0x157  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0518)  CS-0x158  0x080D9         || 		   CALL draw_vertical_line
(0519)                            || 
(0520)  CS-0x159  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0521)  CS-0x15A  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0522)  CS-0x15B  0x36914         || 		   MOV r9,0x14   ; ending x coordinate
(0523)  CS-0x15C  0x080A9         || 		   CALL draw_horizontal_line
(0524)                            || 
(0525)  CS-0x15D  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0526)  CS-0x15E  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0527)  CS-0x15F  0x36914         || 		   MOV r9,0x14  ; ending x coordinate
(0528)  CS-0x160  0x080A9         || 		   CALL draw_horizontal_line
(0529)                            || 
(0530)  CS-0x161  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0531)  CS-0x162  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0532)  CS-0x163  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0533)  CS-0x164  0x080A9         || 		   CALL draw_horizontal_line
(0534)                            || 
(0535)  CS-0x165  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0536)  CS-0x166  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0537)  CS-0x167  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0538)  CS-0x168  0x080D9         || 		   CALL draw_vertical_line
(0539)                            || 
(0540)  CS-0x169  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0541)  CS-0x16A  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0542)  CS-0x16B  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0543)  CS-0x16C  0x080D9         || 		   CALL draw_vertical_line
(0544)                            || 
(0545)  CS-0x16D  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0546)  CS-0x16E  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0547)  CS-0x16F  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0548)  CS-0x170  0x080D9         || 		   CALL draw_vertical_line
(0549)                            || 
(0550)  CS-0x171  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0551)  CS-0x172  0x3671A         || 		   MOV r7,0x1A	 ; starting y coordinate
(0552)  CS-0x173  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0553)  CS-0x174  0x080D9         || 		   CALL draw_vertical_line
(0554)                            || 
(0555)  CS-0x175  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0556)  CS-0x176  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0557)  CS-0x177  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0558)  CS-0x178  0x080A9         || 		   CALL draw_horizontal_line
(0559)                            || 
(0560)  CS-0x179  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0561)  CS-0x17A  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0562)  CS-0x17B  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0563)  CS-0x17C  0x080A9         || 		   CALL draw_horizontal_line
(0564)                            || 
(0565)  CS-0x17D  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0566)  CS-0x17E  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0567)  CS-0x17F  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0568)  CS-0x180  0x080A9         || 		   CALL draw_horizontal_line
(0569)                            || 
(0570)  CS-0x181  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0571)  CS-0x182  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0572)  CS-0x183  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0573)  CS-0x184  0x080A9         || 		   CALL draw_horizontal_line
(0574)                            || 
(0575)  CS-0x185  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0576)  CS-0x186  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0577)  CS-0x187  0x36920         || 		   MOV r9,0x20   ; ending x coordinate
(0578)  CS-0x188  0x080A9         || 		   CALL draw_horizontal_line
(0579)                            || 
(0580)  CS-0x189  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0581)  CS-0x18A  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0582)  CS-0x18B  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0583)  CS-0x18C  0x080D9         || 		   CALL draw_vertical_line
(0584)                            || 
(0585)  CS-0x18D  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0586)  CS-0x18E  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0587)  CS-0x18F  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0588)  CS-0x190  0x080D9         || 		   CALL draw_vertical_line
(0589)                            || 
(0590)  CS-0x191  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0591)  CS-0x192  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0592)  CS-0x193  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0593)  CS-0x194  0x080D9         || 		   CALL draw_vertical_line
(0594)                            || 
(0595)  CS-0x195  0x36816         || 		   MOV r8,0x16   ; starting x coordinate
(0596)  CS-0x196  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0597)  CS-0x197  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0598)  CS-0x198  0x080A9         || 		   CALL draw_horizontal_line
(0599)                            || 
(0600)  CS-0x199  0x36816         || 		   MOV r8,0x16   ; starting x coordinate
(0601)  CS-0x19A  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0602)  CS-0x19B  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0603)  CS-0x19C  0x080A9         || 		   CALL draw_horizontal_line
(0604)                            || 
(0605)  CS-0x19D  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0606)  CS-0x19E  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0607)  CS-0x19F  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0608)  CS-0x1A0  0x080D9         || 		   CALL draw_vertical_line
(0609)                            || 
(0610)  CS-0x1A1  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0611)  CS-0x1A2  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0612)  CS-0x1A3  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0613)  CS-0x1A4  0x080D9         || 		   CALL draw_vertical_line
(0614)                            || 
(0615)  CS-0x1A5  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0616)  CS-0x1A6  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0617)  CS-0x1A7  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0618)  CS-0x1A8  0x080D9         || 		   CALL draw_vertical_line
(0619)                            || 
(0620)  CS-0x1A9  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0621)  CS-0x1AA  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0622)  CS-0x1AB  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0623)  CS-0x1AC  0x080A9         || 		   CALL draw_horizontal_line
(0624)                            || 
(0625)  CS-0x1AD  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0626)  CS-0x1AE  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0627)  CS-0x1AF  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0628)  CS-0x1B0  0x080A9         || 		   CALL draw_horizontal_line
(0629)                            || 
(0630)  CS-0x1B1  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0631)  CS-0x1B2  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0632)  CS-0x1B3  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0633)  CS-0x1B4  0x080A9         || 		   CALL draw_horizontal_line
(0634)                            || 
(0635)  CS-0x1B5  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0636)  CS-0x1B6  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0637)  CS-0x1B7  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0638)  CS-0x1B8  0x080A9         || 		   CALL draw_horizontal_line
(0639)                            || 
(0640)  CS-0x1B9  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0641)  CS-0x1BA  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0642)  CS-0x1BB  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0643)  CS-0x1BC  0x080D9         || 		   CALL draw_vertical_line
(0644)                            || 
(0645)  CS-0x1BD  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0646)  CS-0x1BE  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0647)  CS-0x1BF  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0648)  CS-0x1C0  0x080D9         || 		   CALL draw_vertical_line
(0649)                            || 
(0650)  CS-0x1C1  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0651)  CS-0x1C2  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0652)  CS-0x1C3  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0653)  CS-0x1C4  0x080D9         || 		   CALL draw_vertical_line
(0654)                            || 
(0655)  CS-0x1C5  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0656)  CS-0x1C6  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0657)  CS-0x1C7  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0658)  CS-0x1C8  0x080D9         || 		   CALL draw_vertical_line
(0659)                            || 
(0660)  CS-0x1C9  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0661)  CS-0x1CA  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0662)  CS-0x1CB  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0663)  CS-0x1CC  0x080D9         || 		   CALL draw_vertical_line
(0664)                            || 
(0665)  CS-0x1CD  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0666)  CS-0x1CE  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0667)  CS-0x1CF  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0668)  CS-0x1D0  0x080D9         || 		   CALL draw_vertical_line
(0669)                            || 
(0670)  CS-0x1D1  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0671)  CS-0x1D2  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0672)  CS-0x1D3  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0673)  CS-0x1D4  0x080A9         || 		   CALL draw_horizontal_line
(0674)                            || 
(0675)  CS-0x1D5  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0676)  CS-0x1D6  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0677)  CS-0x1D7  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0678)  CS-0x1D8  0x080A9         || 		   CALL draw_horizontal_line
(0679)                            || 
(0680)  CS-0x1D9  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0681)  CS-0x1DA  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0682)  CS-0x1DB  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0683)  CS-0x1DC  0x080A9         || 		   CALL draw_horizontal_line
(0684)                            || 
(0685)  CS-0x1DD  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0686)  CS-0x1DE  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0687)  CS-0x1DF  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0688)  CS-0x1E0  0x080A9         || 		   CALL draw_horizontal_line
(0689)                            || 
(0690)  CS-0x1E1  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0691)  CS-0x1E2  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0692)  CS-0x1E3  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0693)  CS-0x1E4  0x080A9         || 		   CALL draw_horizontal_line
(0694)                            || 
(0695)  CS-0x1E5  0x3681E         || 		   MOV r8,0x1E  ; x coordinate
(0696)  CS-0x1E6  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0697)  CS-0x1E7  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0698)  CS-0x1E8  0x080D9         || 		   CALL draw_vertical_line
(0699)                            || 
(0700)  CS-0x1E9  0x3681E         || 		   MOV r8,0x1E  ; x coordinate
(0701)  CS-0x1EA  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0702)  CS-0x1EB  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0703)  CS-0x1EC  0x080D9         || 		   CALL draw_vertical_line
(0704)                            || 
(0705)  CS-0x1ED  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0706)  CS-0x1EE  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0707)  CS-0x1EF  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0708)  CS-0x1F0  0x080A9         || 		   CALL draw_horizontal_line
(0709)                            || 
(0710)  CS-0x1F1  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0711)  CS-0x1F2  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0712)  CS-0x1F3  0x36920         || 		   MOV r9,0x20   ; ending x coordinate
(0713)  CS-0x1F4  0x080A9         || 		   CALL draw_horizontal_line
(0714)                            || 
(0715)  CS-0x1F5  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0716)  CS-0x1F6  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0717)  CS-0x1F7  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0718)  CS-0x1F8  0x080A9         || 		   CALL draw_horizontal_line
(0719)                            || 
(0720)  CS-0x1F9  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0721)  CS-0x1FA  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0722)  CS-0x1FB  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0723)  CS-0x1FC  0x080D9         || 		   CALL draw_vertical_line
(0724)                            || 
(0725)  CS-0x1FD  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0726)  CS-0x1FE  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0727)  CS-0x1FF  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0728)  CS-0x200  0x080D9         || 		   CALL draw_vertical_line
(0729)                            || 
(0730)  CS-0x201  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0731)  CS-0x202  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0732)  CS-0x203  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0733)  CS-0x204  0x080D9         || 		   CALL draw_vertical_line
(0734)                            || 
(0735)  CS-0x205  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0736)  CS-0x206  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0737)  CS-0x207  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0738)  CS-0x208  0x080A9         || 		   CALL draw_horizontal_line
(0739)                            || 
(0740)  CS-0x209  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0741)  CS-0x20A  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0742)  CS-0x20B  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0743)  CS-0x20C  0x080A9         || 		   CALL draw_horizontal_line
(0744)                            || 
(0745)  CS-0x20D  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0746)  CS-0x20E  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0747)  CS-0x20F  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0748)  CS-0x210  0x080A9         || 		   CALL draw_horizontal_line
(0749)                            || 
(0750)  CS-0x211  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0751)  CS-0x212  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0752)  CS-0x213  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0753)  CS-0x214  0x080A9         || 		   CALL draw_horizontal_line
(0754)                            || 
(0755)  CS-0x215  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0756)  CS-0x216  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0757)  CS-0x217  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0758)  CS-0x218  0x080D9         || 		   CALL draw_vertical_line
(0759)                            || 
(0760)  CS-0x219  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0761)  CS-0x21A  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0762)  CS-0x21B  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0763)  CS-0x21C  0x080D9         || 		   CALL draw_vertical_line
(0764)                            || 
(0765)  CS-0x21D  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0766)  CS-0x21E  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0767)  CS-0x21F  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0768)  CS-0x220  0x080D9         || 		   CALL draw_vertical_line
(0769)                            || 
(0770)  CS-0x221  0x36822         || 		   MOV r8,0x22   ; starting x coordinate
(0771)  CS-0x222  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0772)  CS-0x223  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0773)  CS-0x224  0x080A9         || 		   CALL draw_horizontal_line
(0774)                            || 
(0775)  CS-0x225  0x36824         || 		   MOV r8,0x24  ; x coordinate
(0776)  CS-0x226  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0777)  CS-0x227  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0778)  CS-0x228  0x080D9         || 		   CALL draw_vertical_line
(0779)                            || 
(0780)  CS-0x229  0x36824         || 		   MOV r8,0x24  ; x coordinate
(0781)  CS-0x22A  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0782)  CS-0x22B  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0783)  CS-0x22C  0x080D9         || 		   CALL draw_vertical_line
(0784)                            || 
(0785)  CS-0x22D  0x366F8  0x22D  || draw_block: MOV r6,M_YELLOW
(0786)                            || 
(0787)  CS-0x22E  0x36A00         || 			MOV r10,0x00
(0788)  CS-0x22F  0x36B02         || 			MOV r11,0x02
(0789)  CS-0x230  0x08159         || 			CALL draw_dot
(0790)                            || 
(0791)  CS-0x231  0x32F9A  0x231  || move_block: IN r15,button
(0792)  CS-0x232  0x370AA  0x232  || 			TimeDelay:	MOV r16,For_Count
(0793)  CS-0x233  0x2D001         || 						SUB r16,0x01
(0794)  CS-0x234  0x12F00         || 			ASR r15
(0795)  CS-0x235  0x0B1E0         || 			BRCS move_right
(0796)  CS-0x236  0x12F00         || 			ASR r15
(0797)  CS-0x237  0x0B240         || 			BRCS move_left
(0798)  CS-0x238  0x12F00         || 			ASR r15
(0799)  CS-0x239  0x0B2A0         || 			BRCS move_up
(0800)  CS-0x23A  0x12F00         || 			ASR r15
(0801)  CS-0x23B  0x0B300         || 			BRCS move_down
(0802)                            || 
(0803)                     0x23C  || move_right:
(0804)                            || 		
(0805)                            || 		;maze boundary check
(0806)  CS-0x23C  0x30825         || 		CMP	   r8, 0x25
(0807)  CS-0x23D  0x09362         || 		BREQ	end
(0808)                            || 		
(0809)                            || 		;draw pixel at new location
(0810)  CS-0x23E  0x04751         || 		MOV    r7, r10
(0811)  CS-0x23F  0x04859         || 		MOV    r8, r11
(0812)  CS-0x240  0x28801         || 		ADD	   r8, 0x01
(0813)  CS-0x241  0x366F8         || 		MOV    r6, M_YELLOW
(0814)  CS-0x242  0x08159         || 		CALL   draw_dot
(0815)                            || 
(0816)                            || 		;draw background at previous location
(0817)  CS-0x243  0x04751         || 		MOV    r7, r10
(0818)  CS-0x244  0x04859         || 		MOV    r8, r11
(0819)  CS-0x245  0x366FF         || 		MOV    r6, BG_COLOR
(0820)  CS-0x246  0x08159         || 		CALL   draw_dot
(0821)                            || 
(0822)  CS-0x247  0x09360         || 		BRN 	end
(0823)                            || 
(0824)                     0x248  || move_left:
(0825)                            || 		
(0826)                            || 		;maze boundary check
(0827)  CS-0x248  0x30801         || 		CMP	   r8, 0x01
(0828)  CS-0x249  0x09362         || 		BREQ	end
(0829)                            || 		
(0830)                            || 		;draw pixel at new location
(0831)  CS-0x24A  0x04751         || 		MOV    r7, r10
(0832)  CS-0x24B  0x04859         || 		MOV    r8, r11
(0833)  CS-0x24C  0x2C801         || 		SUB	   r8, 0x01
(0834)  CS-0x24D  0x366F8         || 		MOV    r6, M_YELLOW
(0835)  CS-0x24E  0x08159         || 		CALL   draw_dot
(0836)                            || 
(0837)                            || 		;draw background at previous location
(0838)  CS-0x24F  0x04751         || 		MOV    r7, r10
(0839)  CS-0x250  0x04859         || 		MOV    r8, r11
(0840)  CS-0x251  0x366FF         || 		MOV    r6, BG_COLOR
(0841)  CS-0x252  0x08159         || 		CALL   draw_dot
(0842)                            || 		
(0843)  CS-0x253  0x09360         || 		BRN 	end
(0844)                            || 
(0845)                     0x254  || move_up:
(0846)                            || 		
(0847)                            || 		;maze boundary check
(0848)  CS-0x254  0x30701         || 		CMP	   r7, 0x01
(0849)  CS-0x255  0x09362         || 		BREQ	end
(0850)                            || 		
(0851)                            || 		;draw pixel at new location
(0852)  CS-0x256  0x04751         || 		MOV    r7, r10
(0853)  CS-0x257  0x04859         || 		MOV    r8, r11
(0854)  CS-0x258  0x28701         || 		ADD	   r7, 0x01
(0855)  CS-0x259  0x366F8         || 		MOV    r6, M_YELLOW
(0856)  CS-0x25A  0x08159         || 		CALL   draw_dot
(0857)                            || 
(0858)                            || 		;draw background at previous location
(0859)  CS-0x25B  0x04751         || 		MOV    r7, r10
(0860)  CS-0x25C  0x04859         || 		MOV    r8, r11
(0861)  CS-0x25D  0x366FF         || 		MOV    r6, BG_COLOR
(0862)  CS-0x25E  0x08159         || 		CALL   draw_dot
(0863)                            || 		
(0864)  CS-0x25F  0x09360         || 		BRN 	end
(0865)                            || 
(0866)                     0x260  || move_down:
(0867)                            || 		
(0868)                            || 		;maze boundary check
(0869)  CS-0x260  0x3071B         || 		CMP	   r7, 0x1b
(0870)  CS-0x261  0x09362         || 		BREQ	end
(0871)                            || 		
(0872)                            || 		;draw pixel at new location
(0873)  CS-0x262  0x04751         || 		MOV    r7, r10
(0874)  CS-0x263  0x04859         || 		MOV    r8, r11
(0875)  CS-0x264  0x2C701         || 		SUB	   r7, 0x01
(0876)  CS-0x265  0x366F8         ||         MOV    r6, M_YELLOW
(0877)  CS-0x266  0x08159         || 		CALL   draw_dot
(0878)                            || 
(0879)                            || 		;draw background at previous location
(0880)  CS-0x267  0x04751         || 		MOV    r7, r10
(0881)  CS-0x268  0x04859         || 		MOV    r8, r11
(0882)  CS-0x269  0x366FF         || 		MOV    r6, BG_COLOR
(0883)  CS-0x26A  0x08159         || 		CALL   draw_dot
(0884)                            || 		
(0885)  CS-0x26B  0x09360         || 		BRN 	end
(0886)                            || 
(0887)  CS-0x26C  0x18002  0x26C  || end:	RET
(0888)                            || 			





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
DD_ADD40       0x037   (0155)  ||  0145 
DD_ADD80       0x03A   (0159)  ||  0148 
DD_OUT         0x033   (0150)  ||  0160 
DRAW_BACKGROUND 0x021   (0112)  ||  0026 
DRAW_BLOCK     0x22D   (0785)  ||  
DRAW_DOT       0x02B   (0138)  ||  0069 0095 0789 0814 0820 0835 0841 0856 0862 0877 
                               ||  0883 
DRAW_HORIZ1    0x016   (0068)  ||  0072 
DRAW_HORIZONTAL_LINE 0x015   (0065)  ||  0119 0168 0178 0188 0193 0198 0203 0208 0243 0268 
                               ||  0273 0278 0308 0313 0318 0323 0348 0353 0358 0363 
                               ||  0388 0393 0398 0423 0428 0433 0463 0468 0473 0478 
                               ||  0493 0498 0503 0523 0528 0533 0558 0563 0568 0573 
                               ||  0578 0598 0603 0623 0628 0633 0638 0673 0678 0683 
                               ||  0688 0693 0708 0713 0718 0738 0743 0748 0753 0773 
DRAW_MAZE      0x03C   (0162)  ||  0041 
DRAW_VERT1     0x01C   (0094)  ||  0098 
DRAW_VERTICAL_LINE 0x01B   (0091)  ||  0173 0183 0213 0218 0223 0228 0233 0238 0248 0253 
                               ||  0258 0263 0283 0288 0293 0298 0303 0328 0333 0338 
                               ||  0343 0368 0373 0378 0383 0403 0408 0413 0418 0438 
                               ||  0443 0448 0453 0458 0483 0488 0508 0513 0518 0538 
                               ||  0543 0548 0553 0583 0588 0593 0608 0613 0618 0643 
                               ||  0648 0653 0658 0663 0668 0698 0703 0723 0728 0733 
                               ||  0758 0763 0768 0778 0783 
END            0x26C   (0887)  ||  0807 0822 0828 0843 0849 0864 0870 0885 
INIT           0x010   (0025)  ||  
MAIN           0x012   (0043)  ||  0047 
MOVE_BLOCK     0x231   (0791)  ||  0045 
MOVE_DOWN      0x260   (0866)  ||  0801 
MOVE_LEFT      0x248   (0824)  ||  0797 
MOVE_RIGHT     0x23C   (0803)  ||  0795 
MOVE_UP        0x254   (0845)  ||  0799 
START          0x023   (0115)  ||  0122 
T1             0x031   (0147)  ||  0157 
TIMEDELAY      0x232   (0792)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0010)  ||  0113 0819 0840 0861 0882 
BUTTON         0x09A   (0018)  ||  0791 
FOR_COUNT      0x0AA   (0019)  ||  0792 
LEDS           0x040   (0008)  ||  
M_BLACK        0x000   (0015)  ||  0163 
M_BLUE         0x013   (0014)  ||  
M_BROWN        0x090   (0016)  ||  
M_RED          0x0E0   (0013)  ||  
M_YELLOW       0x0F8   (0012)  ||  0785 0813 0834 0855 0876 
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
