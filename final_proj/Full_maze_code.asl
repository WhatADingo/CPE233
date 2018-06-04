

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
(0018)                            || ;r6 is used for color
(0019)                            || ;r7 is used for Y
(0020)                            || ;r8 is used for X
(0021)                            || ;---------------------------------------------------------------------
(0022)                     0x010  || init:
(0023)  CS-0x010  0x08101         ||          CALL   draw_background         ; draw using default color
(0024)                            ||          ;MOV    r7, 0x0F                ; generic Y coordinate
(0025)                            ||          ;MOV    r8, 0x14                ; generic X coordinate
(0026)                            ||          ;MOV    r6, 0xE0                ; color
(0027)                            ||          ;CALL   draw_dot                ; draw red pixel
(0028)                            ||          ;MOV    r8,0x01                 ; starting x coordinate
(0029)                            ||          ;MOV    r7,0x12                 ; start y coordinate
(0030)                            ||          ;MOV    r9,0x26                 ; ending x coordinate
(0031)                            ||          ;CALL   draw_horizontal_line
(0032)                            || 
(0033)                            ||          ;MOV    r8,0x08                 ; starting x coordinate
(0034)                            ||          ;MOV    r7,0x04                 ; start y coordinate
(0035)                            ||          ;MOV    r9,0x17                 ; ending x coordinate
(0036)                            ||          ;CALL   draw_vertical_line
(0037)                            ||   
(0038)  CS-0x011  0x081D9         || 		CALL	draw_maze
(0039)                            || 
(0040)  CS-0x012  0x00000  0x012  || main:   AND    r0, r0                  ; nop
(0041)  CS-0x013  0x08090         ||         BRN    main                    ; continuous loop 
(0042)                            || 
(0043)                            || ;--------------------------------------------------------------------
(0044)                            || 
(0045)                            || ;--------------------------------------------------------------------
(0046)                            || ;-  Subroutine: draw_horizontal_line
(0047)                            || ;-
(0048)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0049)                            || ;-
(0050)                            || ;-  Parameters:
(0051)                            || ;-   r8  = starting x-coordinate
(0052)                            || ;-   r7  = y-coordinate
(0053)                            || ;-   r9  = ending x-coordinate
(0054)                            || ;-   r6  = color used for line
(0055)                            || ;-
(0056)                            || ;- Tweaked registers: r8,r9
(0057)                            || ;--------------------------------------------------------------------
(0058)                            || 
(0059)                     0x014  || draw_horizontal_line:
(0060)  CS-0x014  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0061)                            || 
(0062)                     0x015  || draw_horiz1:
(0063)  CS-0x015  0x08151         ||         CALL   draw_dot         ; 
(0064)  CS-0x016  0x28801         ||         ADD    r8,0x01
(0065)  CS-0x017  0x04848         ||         CMP    r8,r9
(0066)  CS-0x018  0x080AB         ||         BRNE   draw_horiz1
(0067)  CS-0x019  0x18002         ||         RET
(0068)                            || 
(0069)                            || ;--------------------------------------------------------------------
(0070)                            || 
(0071)                            || ;---------------------------------------------------------------------
(0072)                            || ;-  Subroutine: draw_vertical_line
(0073)                            || ;-
(0074)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0075)                            || ;-
(0076)                            || ;-  Parameters:
(0077)                            || ;-   r8  = x-coordinate
(0078)                            || ;-   r7  = starting y-coordinate
(0079)                            || ;-   r9  = ending y-coordinate
(0080)                            || ;-   r6  = color used for line
(0081)                            || ;- 
(0082)                            || ;- Tweaked registers: r7,r9
(0083)                            || ;--------------------------------------------------------------------
(0084)                            || 
(0085)                     0x01A  || draw_vertical_line:
(0086)  CS-0x01A  0x28901         ||          ADD    r9,0x01
(0087)                            || 
(0088)                     0x01B  || draw_vert1:          
(0089)  CS-0x01B  0x08151         ||          CALL   draw_dot
(0090)  CS-0x01C  0x28701         ||          ADD    r7,0x01
(0091)  CS-0x01D  0x04748         ||          CMP    r7,R9
(0092)  CS-0x01E  0x080DB         ||          BRNE   draw_vert1
(0093)  CS-0x01F  0x18002         ||          RET
(0094)                            || 
(0095)                            || ;--------------------------------------------------------------------
(0096)                            || 
(0097)                            || ;---------------------------------------------------------------------
(0098)                            || ;-  Subroutine: draw_background
(0099)                            || ;-
(0100)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0101)                            || ;-  draw_horizontal_line subroutine. 
(0102)                            || ;- 
(0103)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0104)                            || ;----------------------------------------------------------------------
(0105)                            || 
(0106)                     0x020  || draw_background: 
(0107)  CS-0x020  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0108)  CS-0x021  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0109)  CS-0x022  0x04769  0x022  || start:   MOV   r7,r13                   ; load current row count 
(0110)  CS-0x023  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0111)  CS-0x024  0x36927         ||          MOV   r9,0x27 
(0112)                            || 
(0113)  CS-0x025  0x080A1         ||          CALL  draw_horizontal_line
(0114)  CS-0x026  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0115)  CS-0x027  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0116)  CS-0x028  0x08113         ||          BRNE  start                    ; branch to draw more rows
(0117)  CS-0x029  0x18002         ||          RET
(0118)                            || 
(0119)                            || ;---------------------------------------------------------------------
(0120)                            || 
(0121)                            ||  
(0122)                            || ;---------------------------------------------------------------------
(0123)                            || ;- Subrountine: draw_dot
(0124)                            || ;- 
(0125)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0126)                            || ;- 
(0127)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0128)                            || ;- 
(0129)                            || ;- Tweaked registers: r4,r5
(0130)                            || ;---------------------------------------------------------------------
(0131)                            || 
(0132)                     0x02A  || draw_dot: 
(0133)  CS-0x02A  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0134)  CS-0x02B  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0135)                            || 
(0136)  CS-0x02C  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0137)  CS-0x02D  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0138)  CS-0x02E  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0139)  CS-0x02F  0x0A1B0         ||            BRCS  dd_add40
(0140)                            || 
(0141)  CS-0x030  0x10401  0x030  || t1:        LSR   r4
(0142)  CS-0x031  0x0A1C8         ||            BRCS  dd_add80
(0143)                            || 
(0144)  CS-0x032  0x34591  0x032  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0145)  CS-0x033  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0146)  CS-0x034  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0147)  CS-0x035  0x18002         ||            RET
(0148)                            || 
(0149)  CS-0x036  0x22540  0x036  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0150)  CS-0x037  0x18000         ||            CLC                  ; freshen bit
(0151)  CS-0x038  0x08180         ||            BRN   t1             
(0152)                            || 
(0153)  CS-0x039  0x22580  0x039  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0154)  CS-0x03A  0x08190         ||            BRN   dd_out
(0155)                            || ; --------------------------------------------------------------------
(0156)                     0x03B  || draw_maze: 
(0157)  CS-0x03B  0x36600         || 		   MOV r6,M_BLACK
(0158)                            || 		   
(0159)  CS-0x03C  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0160)  CS-0x03D  0x36700         || 		   MOV r7,0x00   ; y coordinate
(0161)  CS-0x03E  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0162)  CS-0x03F  0x080A1         || 		   CALL draw_horizontal_line
(0163)                            || 
(0164)  CS-0x040  0x36800         ||            MOV r8,0x00   ; x coordinate
(0165)  CS-0x041  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0166)  CS-0x042  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0167)  CS-0x043  0x080D1         || 		   CALL draw_vertical_line
(0168)                            || 
(0169)  CS-0x044  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0170)  CS-0x045  0x3671C         || 		   MOV r7,0x1C   ; y coordinate
(0171)  CS-0x046  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0172)  CS-0x047  0x080A1         || 		   CALL draw_horizontal_line
(0173)                            || 
(0174)  CS-0x048  0x36826         || 		   MOV r8,0x26   ; x coordinate
(0175)  CS-0x049  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0176)  CS-0x04A  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0177)  CS-0x04B  0x080D1         || 		   CALL draw_vertical_line
(0178)                            || 
(0179)  CS-0x04C  0x36800         || 		   MOV r8,0x00  ; starting x coordinate
(0180)  CS-0x04D  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0181)  CS-0x04E  0x36902         || 		   MOV r9,0x02   ; ending x coordinate
(0182)  CS-0x04F  0x080A1         || 		   CALL draw_horizontal_line
(0183)                            ||  
(0184)  CS-0x050  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0185)  CS-0x051  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0186)  CS-0x052  0x36904         || 		   MOV r9,0x04   ; ending x coordinate
(0187)  CS-0x053  0x080A1         || 		   CALL draw_horizontal_line
(0188)                            || 
(0189)  CS-0x054  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0190)  CS-0x055  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0191)  CS-0x056  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0192)  CS-0x057  0x080A1         || 		   CALL draw_horizontal_line
(0193)                            || 
(0194)  CS-0x058  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0195)  CS-0x059  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0196)  CS-0x05A  0x36902         || 		   MOV r9,0x02   ; ending x coordinate
(0197)  CS-0x05B  0x080A1         || 		   CALL draw_horizontal_line
(0198)                            || 
(0199)  CS-0x05C  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0200)  CS-0x05D  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0201)  CS-0x05E  0x36904         || 		   MOV r9,0x04   ; ending x coordinate
(0202)  CS-0x05F  0x080A1         || 		   CALL draw_horizontal_line
(0203)                            || 
(0204)  CS-0x060  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0205)  CS-0x061  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0206)  CS-0x062  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0207)  CS-0x063  0x080D1         || 		   CALL draw_vertical_line
(0208)                            || 
(0209)  CS-0x064  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0210)  CS-0x065  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0211)  CS-0x066  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0212)  CS-0x067  0x080D1         || 		   CALL draw_vertical_line
(0213)                            || 
(0214)  CS-0x068  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0215)  CS-0x069  0x3670C         || 		   MOV r7,0x0C	 ; starting y coordinate
(0216)  CS-0x06A  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0217)  CS-0x06B  0x080D1         || 		   CALL draw_vertical_line
(0218)                            || 
(0219)  CS-0x06C  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0220)  CS-0x06D  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0221)  CS-0x06E  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0222)  CS-0x06F  0x080D1         || 		   CALL draw_vertical_line
(0223)                            || 
(0224)  CS-0x070  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0225)  CS-0x071  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0226)  CS-0x072  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0227)  CS-0x073  0x080D1         || 		   CALL draw_vertical_line
(0228)                            || 
(0229)  CS-0x074  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0230)  CS-0x075  0x3671A         || 		   MOV r7,0x1A	 ; starting y coordinate
(0231)  CS-0x076  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0232)  CS-0x077  0x080D1         || 		   CALL draw_vertical_line
(0233)                            || 
(0234)  CS-0x078  0x36802         || 		   MOV r8,0x02   ; starting x coordinate
(0235)  CS-0x079  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0236)  CS-0x07A  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0237)  CS-0x07B  0x080A1         || 		   CALL draw_horizontal_line
(0238)                            || 
(0239)  CS-0x07C  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0240)  CS-0x07D  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0241)  CS-0x07E  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0242)  CS-0x07F  0x080D1         || 		   CALL draw_vertical_line
(0243)                            || 
(0244)  CS-0x080  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0245)  CS-0x081  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0246)  CS-0x082  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0247)  CS-0x083  0x080D1         || 		   CALL draw_vertical_line
(0248)                            || 
(0249)  CS-0x084  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0250)  CS-0x085  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0251)  CS-0x086  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0252)  CS-0x087  0x080D1         || 		   CALL draw_vertical_line
(0253)                            || 
(0254)  CS-0x088  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0255)  CS-0x089  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0256)  CS-0x08A  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0257)  CS-0x08B  0x080D1         || 		   CALL draw_vertical_line
(0258)                            || 
(0259)  CS-0x08C  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0260)  CS-0x08D  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0261)  CS-0x08E  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0262)  CS-0x08F  0x080A1         || 		   CALL draw_horizontal_line
(0263)                            || 
(0264)  CS-0x090  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0265)  CS-0x091  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0266)  CS-0x092  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0267)  CS-0x093  0x080A1         || 		   CALL draw_horizontal_line
(0268)                            || 		
(0269)  CS-0x094  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0270)  CS-0x095  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0271)  CS-0x096  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0272)  CS-0x097  0x080A1         || 		   CALL draw_horizontal_line
(0273)                            || 
(0274)  CS-0x098  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0275)  CS-0x099  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0276)  CS-0x09A  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0277)  CS-0x09B  0x080D1         || 		   CALL draw_vertical_line
(0278)                            || 
(0279)  CS-0x09C  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0280)  CS-0x09D  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0281)  CS-0x09E  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0282)  CS-0x09F  0x080D1         || 		   CALL draw_vertical_line
(0283)                            || 
(0284)  CS-0x0A0  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0285)  CS-0x0A1  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0286)  CS-0x0A2  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0287)  CS-0x0A3  0x080D1         || 		   CALL draw_vertical_line
(0288)                            || 
(0289)  CS-0x0A4  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0290)  CS-0x0A5  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0291)  CS-0x0A6  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0292)  CS-0x0A7  0x080D1         || 		   CALL draw_vertical_line
(0293)                            || 
(0294)  CS-0x0A8  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0295)  CS-0x0A9  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0296)  CS-0x0AA  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0297)  CS-0x0AB  0x080D1         || 		   CALL draw_vertical_line
(0298)                            || 
(0299)  CS-0x0AC  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0300)  CS-0x0AD  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0301)  CS-0x0AE  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0302)  CS-0x0AF  0x080A1         || 		   CALL draw_horizontal_line
(0303)                            || 
(0304)  CS-0x0B0  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0305)  CS-0x0B1  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0306)  CS-0x0B2  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0307)  CS-0x0B3  0x080A1         || 		   CALL draw_horizontal_line
(0308)                            || 
(0309)  CS-0x0B4  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0310)  CS-0x0B5  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0311)  CS-0x0B6  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0312)  CS-0x0B7  0x080A1         || 		   CALL draw_horizontal_line
(0313)                            || 
(0314)  CS-0x0B8  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0315)  CS-0x0B9  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0316)  CS-0x0BA  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0317)  CS-0x0BB  0x080A1         || 		   CALL draw_horizontal_line
(0318)                            || 
(0319)  CS-0x0BC  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0320)  CS-0x0BD  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0321)  CS-0x0BE  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0322)  CS-0x0BF  0x080D1         || 		   CALL draw_vertical_line
(0323)                            || 
(0324)  CS-0x0C0  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0325)  CS-0x0C1  0x3670C         || 		   MOV r7,0x0C	 ; starting y coordinate
(0326)  CS-0x0C2  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0327)  CS-0x0C3  0x080D1         || 		   CALL draw_vertical_line
(0328)                            || 
(0329)  CS-0x0C4  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0330)  CS-0x0C5  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0331)  CS-0x0C6  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0332)  CS-0x0C7  0x080D1         || 		   CALL draw_vertical_line
(0333)                            || 
(0334)  CS-0x0C8  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0335)  CS-0x0C9  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0336)  CS-0x0CA  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0337)  CS-0x0CB  0x080D1         || 		   CALL draw_vertical_line
(0338)                            || 
(0339)  CS-0x0CC  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0340)  CS-0x0CD  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0341)  CS-0x0CE  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0342)  CS-0x0CF  0x080A1         || 		   CALL draw_horizontal_line
(0343)                            || 
(0344)  CS-0x0D0  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0345)  CS-0x0D1  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0346)  CS-0x0D2  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0347)  CS-0x0D3  0x080A1         || 		   CALL draw_horizontal_line
(0348)                            || 
(0349)  CS-0x0D4  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0350)  CS-0x0D5  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0351)  CS-0x0D6  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0352)  CS-0x0D7  0x080A1         || 		   CALL draw_horizontal_line
(0353)                            || 
(0354)  CS-0x0D8  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0355)  CS-0x0D9  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0356)  CS-0x0DA  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0357)  CS-0x0DB  0x080A1         || 		   CALL draw_horizontal_line
(0358)                            || 
(0359)  CS-0x0DC  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0360)  CS-0x0DD  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0361)  CS-0x0DE  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0362)  CS-0x0DF  0x080D1         || 		   CALL draw_vertical_line
(0363)                            || 
(0364)  CS-0x0E0  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0365)  CS-0x0E1  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0366)  CS-0x0E2  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0367)  CS-0x0E3  0x080D1         || 		   CALL draw_vertical_line
(0368)                            || 
(0369)  CS-0x0E4  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0370)  CS-0x0E5  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0371)  CS-0x0E6  0x36912         || 		   MOV r9,0x12	 ; ending y coordinate
(0372)  CS-0x0E7  0x080D1         || 		   CALL draw_vertical_line
(0373)                            || 
(0374)  CS-0x0E8  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0375)  CS-0x0E9  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0376)  CS-0x0EA  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0377)  CS-0x0EB  0x080D1         || 		   CALL draw_vertical_line
(0378)                            || 
(0379)  CS-0x0EC  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0380)  CS-0x0ED  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0381)  CS-0x0EE  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0382)  CS-0x0EF  0x080A1         || 		   CALL draw_horizontal_line
(0383)                            || 
(0384)  CS-0x0F0  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0385)  CS-0x0F1  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0386)  CS-0x0F2  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0387)  CS-0x0F3  0x080A1         || 		   CALL draw_horizontal_line
(0388)                            || 
(0389)  CS-0x0F4  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0390)  CS-0x0F5  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0391)  CS-0x0F6  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0392)  CS-0x0F7  0x080A1         || 		   CALL draw_horizontal_line
(0393)                            || 
(0394)  CS-0x0F8  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0395)  CS-0x0F9  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0396)  CS-0x0FA  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0397)  CS-0x0FB  0x080D1         || 		   CALL draw_vertical_line
(0398)                            || 
(0399)  CS-0x0FC  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0400)  CS-0x0FD  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0401)  CS-0x0FE  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0402)  CS-0x0FF  0x080D1         || 		   CALL draw_vertical_line
(0403)                            || 
(0404)  CS-0x100  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0405)  CS-0x101  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0406)  CS-0x102  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0407)  CS-0x103  0x080D1         || 		   CALL draw_vertical_line
(0408)                            || 
(0409)  CS-0x104  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0410)  CS-0x105  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0411)  CS-0x106  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0412)  CS-0x107  0x080D1         || 		   CALL draw_vertical_line
(0413)                            || 
(0414)  CS-0x108  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0415)  CS-0x109  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0416)  CS-0x10A  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0417)  CS-0x10B  0x080A1         || 		   CALL draw_horizontal_line
(0418)                            || 
(0419)  CS-0x10C  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0420)  CS-0x10D  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0421)  CS-0x10E  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0422)  CS-0x10F  0x080A1         || 		   CALL draw_horizontal_line
(0423)                            || 
(0424)  CS-0x110  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0425)  CS-0x111  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0426)  CS-0x112  0x36910         || 		   MOV r9,0x10   ; ending x coordinate
(0427)  CS-0x113  0x080A1         || 		   CALL draw_horizontal_line
(0428)                            || 
(0429)  CS-0x114  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0430)  CS-0x115  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0431)  CS-0x116  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0432)  CS-0x117  0x080D1         || 		   CALL draw_vertical_line
(0433)                            || 
(0434)  CS-0x118  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0435)  CS-0x119  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0436)  CS-0x11A  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0437)  CS-0x11B  0x080D1         || 		   CALL draw_vertical_line
(0438)                            || 
(0439)  CS-0x11C  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0440)  CS-0x11D  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0441)  CS-0x11E  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0442)  CS-0x11F  0x080D1         || 		   CALL draw_vertical_line
(0443)                            || 
(0444)  CS-0x120  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0445)  CS-0x121  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0446)  CS-0x122  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0447)  CS-0x123  0x080D1         || 		   CALL draw_vertical_line
(0448)                            || 
(0449)  CS-0x124  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0450)  CS-0x125  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0451)  CS-0x126  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0452)  CS-0x127  0x080D1         || 		   CALL draw_vertical_line
(0453)                            || 
(0454)  CS-0x128  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0455)  CS-0x129  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0456)  CS-0x12A  0x36910         || 		   MOV r9,0x10   ; ending x coordinate
(0457)  CS-0x12B  0x080A1         || 		   CALL draw_horizontal_line
(0458)                            || 
(0459)  CS-0x12C  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0460)  CS-0x12D  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0461)  CS-0x12E  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0462)  CS-0x12F  0x080A1         || 		   CALL draw_horizontal_line
(0463)                            || 
(0464)  CS-0x130  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0465)  CS-0x131  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0466)  CS-0x132  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0467)  CS-0x133  0x080A1         || 		   CALL draw_horizontal_line
(0468)                            || 
(0469)  CS-0x134  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0470)  CS-0x135  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0471)  CS-0x136  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0472)  CS-0x137  0x080A1         || 		   CALL draw_horizontal_line
(0473)                            || 
(0474)  CS-0x138  0x36810         || 		   MOV r8,0x10  ; x coordinate
(0475)  CS-0x139  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0476)  CS-0x13A  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0477)  CS-0x13B  0x080D1         || 		   CALL draw_vertical_line
(0478)                            || 
(0479)  CS-0x13C  0x36810         || 		   MOV r8,0x10  ; x coordinate
(0480)  CS-0x13D  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0481)  CS-0x13E  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0482)  CS-0x13F  0x080D1         || 		   CALL draw_vertical_line
(0483)                            || 
(0484)  CS-0x140  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0485)  CS-0x141  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0486)  CS-0x142  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0487)  CS-0x143  0x080A1         || 		   CALL draw_horizontal_line
(0488)                            || 
(0489)  CS-0x144  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0490)  CS-0x145  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0491)  CS-0x146  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0492)  CS-0x147  0x080A1         || 		   CALL draw_horizontal_line
(0493)                            || 
(0494)  CS-0x148  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0495)  CS-0x149  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0496)  CS-0x14A  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0497)  CS-0x14B  0x080A1         || 		   CALL draw_horizontal_line
(0498)                            || 
(0499)  CS-0x14C  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0500)  CS-0x14D  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0501)  CS-0x14E  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0502)  CS-0x14F  0x080D1         || 		   CALL draw_vertical_line
(0503)                            || 
(0504)  CS-0x150  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0505)  CS-0x151  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0506)  CS-0x152  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0507)  CS-0x153  0x080D1         || 		   CALL draw_vertical_line
(0508)                            || 
(0509)  CS-0x154  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0510)  CS-0x155  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0511)  CS-0x156  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0512)  CS-0x157  0x080D1         || 		   CALL draw_vertical_line
(0513)                            || 
(0514)  CS-0x158  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0515)  CS-0x159  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0516)  CS-0x15A  0x36914         || 		   MOV r9,0x14   ; ending x coordinate
(0517)  CS-0x15B  0x080A1         || 		   CALL draw_horizontal_line
(0518)                            || 
(0519)  CS-0x15C  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0520)  CS-0x15D  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0521)  CS-0x15E  0x36914         || 		   MOV r9,0x14  ; ending x coordinate
(0522)  CS-0x15F  0x080A1         || 		   CALL draw_horizontal_line
(0523)                            || 
(0524)  CS-0x160  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0525)  CS-0x161  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0526)  CS-0x162  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0527)  CS-0x163  0x080A1         || 		   CALL draw_horizontal_line
(0528)                            || 
(0529)  CS-0x164  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0530)  CS-0x165  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0531)  CS-0x166  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0532)  CS-0x167  0x080D1         || 		   CALL draw_vertical_line
(0533)                            || 
(0534)  CS-0x168  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0535)  CS-0x169  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0536)  CS-0x16A  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0537)  CS-0x16B  0x080D1         || 		   CALL draw_vertical_line
(0538)                            || 
(0539)  CS-0x16C  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0540)  CS-0x16D  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0541)  CS-0x16E  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0542)  CS-0x16F  0x080D1         || 		   CALL draw_vertical_line
(0543)                            || 
(0544)  CS-0x170  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0545)  CS-0x171  0x3671A         || 		   MOV r7,0x1A	 ; starting y coordinate
(0546)  CS-0x172  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0547)  CS-0x173  0x080D1         || 		   CALL draw_vertical_line
(0548)                            || 
(0549)  CS-0x174  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0550)  CS-0x175  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0551)  CS-0x176  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0552)  CS-0x177  0x080A1         || 		   CALL draw_horizontal_line
(0553)                            || 
(0554)  CS-0x178  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0555)  CS-0x179  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0556)  CS-0x17A  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0557)  CS-0x17B  0x080A1         || 		   CALL draw_horizontal_line
(0558)                            || 
(0559)  CS-0x17C  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0560)  CS-0x17D  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0561)  CS-0x17E  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0562)  CS-0x17F  0x080A1         || 		   CALL draw_horizontal_line
(0563)                            || 
(0564)  CS-0x180  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0565)  CS-0x181  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0566)  CS-0x182  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0567)  CS-0x183  0x080A1         || 		   CALL draw_horizontal_line
(0568)                            || 
(0569)  CS-0x184  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0570)  CS-0x185  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0571)  CS-0x186  0x36920         || 		   MOV r9,0x20   ; ending x coordinate
(0572)  CS-0x187  0x080A1         || 		   CALL draw_horizontal_line
(0573)                            || 
(0574)  CS-0x188  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0575)  CS-0x189  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0576)  CS-0x18A  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0577)  CS-0x18B  0x080D1         || 		   CALL draw_vertical_line
(0578)                            || 
(0579)  CS-0x18C  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0580)  CS-0x18D  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0581)  CS-0x18E  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0582)  CS-0x18F  0x080D1         || 		   CALL draw_vertical_line
(0583)                            || 
(0584)  CS-0x190  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0585)  CS-0x191  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0586)  CS-0x192  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0587)  CS-0x193  0x080D1         || 		   CALL draw_vertical_line
(0588)                            || 
(0589)  CS-0x194  0x36816         || 		   MOV r8,0x16   ; starting x coordinate
(0590)  CS-0x195  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0591)  CS-0x196  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0592)  CS-0x197  0x080A1         || 		   CALL draw_horizontal_line
(0593)                            || 
(0594)  CS-0x198  0x36816         || 		   MOV r8,0x16   ; starting x coordinate
(0595)  CS-0x199  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0596)  CS-0x19A  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0597)  CS-0x19B  0x080A1         || 		   CALL draw_horizontal_line
(0598)                            || 
(0599)  CS-0x19C  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0600)  CS-0x19D  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0601)  CS-0x19E  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0602)  CS-0x19F  0x080D1         || 		   CALL draw_vertical_line
(0603)                            || 
(0604)  CS-0x1A0  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0605)  CS-0x1A1  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0606)  CS-0x1A2  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0607)  CS-0x1A3  0x080D1         || 		   CALL draw_vertical_line
(0608)                            || 
(0609)  CS-0x1A4  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0610)  CS-0x1A5  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0611)  CS-0x1A6  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0612)  CS-0x1A7  0x080D1         || 		   CALL draw_vertical_line
(0613)                            || 
(0614)  CS-0x1A8  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0615)  CS-0x1A9  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0616)  CS-0x1AA  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0617)  CS-0x1AB  0x080A1         || 		   CALL draw_horizontal_line
(0618)                            || 
(0619)  CS-0x1AC  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0620)  CS-0x1AD  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0621)  CS-0x1AE  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0622)  CS-0x1AF  0x080A1         || 		   CALL draw_horizontal_line
(0623)                            || 
(0624)  CS-0x1B0  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0625)  CS-0x1B1  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0626)  CS-0x1B2  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0627)  CS-0x1B3  0x080A1         || 		   CALL draw_horizontal_line
(0628)                            || 
(0629)  CS-0x1B4  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0630)  CS-0x1B5  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0631)  CS-0x1B6  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0632)  CS-0x1B7  0x080A1         || 		   CALL draw_horizontal_line
(0633)                            || 
(0634)  CS-0x1B8  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0635)  CS-0x1B9  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0636)  CS-0x1BA  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0637)  CS-0x1BB  0x080D1         || 		   CALL draw_vertical_line
(0638)                            || 
(0639)  CS-0x1BC  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0640)  CS-0x1BD  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0641)  CS-0x1BE  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0642)  CS-0x1BF  0x080D1         || 		   CALL draw_vertical_line
(0643)                            || 
(0644)  CS-0x1C0  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0645)  CS-0x1C1  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0646)  CS-0x1C2  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0647)  CS-0x1C3  0x080D1         || 		   CALL draw_vertical_line
(0648)                            || 
(0649)  CS-0x1C4  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0650)  CS-0x1C5  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0651)  CS-0x1C6  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0652)  CS-0x1C7  0x080D1         || 		   CALL draw_vertical_line
(0653)                            || 
(0654)  CS-0x1C8  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0655)  CS-0x1C9  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0656)  CS-0x1CA  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0657)  CS-0x1CB  0x080D1         || 		   CALL draw_vertical_line
(0658)                            || 
(0659)  CS-0x1CC  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0660)  CS-0x1CD  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0661)  CS-0x1CE  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0662)  CS-0x1CF  0x080D1         || 		   CALL draw_vertical_line
(0663)                            || 
(0664)  CS-0x1D0  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0665)  CS-0x1D1  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0666)  CS-0x1D2  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0667)  CS-0x1D3  0x080A1         || 		   CALL draw_horizontal_line
(0668)                            || 
(0669)  CS-0x1D4  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0670)  CS-0x1D5  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0671)  CS-0x1D6  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0672)  CS-0x1D7  0x080A1         || 		   CALL draw_horizontal_line
(0673)                            || 
(0674)  CS-0x1D8  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0675)  CS-0x1D9  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0676)  CS-0x1DA  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0677)  CS-0x1DB  0x080A1         || 		   CALL draw_horizontal_line
(0678)                            || 
(0679)  CS-0x1DC  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0680)  CS-0x1DD  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0681)  CS-0x1DE  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0682)  CS-0x1DF  0x080A1         || 		   CALL draw_horizontal_line
(0683)                            || 
(0684)  CS-0x1E0  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0685)  CS-0x1E1  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0686)  CS-0x1E2  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0687)  CS-0x1E3  0x080A1         || 		   CALL draw_horizontal_line
(0688)                            || 
(0689)  CS-0x1E4  0x3681E         || 		   MOV r8,0x1E  ; x coordinate
(0690)  CS-0x1E5  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0691)  CS-0x1E6  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0692)  CS-0x1E7  0x080D1         || 		   CALL draw_vertical_line
(0693)                            || 
(0694)  CS-0x1E8  0x3681E         || 		   MOV r8,0x1E  ; x coordinate
(0695)  CS-0x1E9  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0696)  CS-0x1EA  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0697)  CS-0x1EB  0x080D1         || 		   CALL draw_vertical_line
(0698)                            || 
(0699)  CS-0x1EC  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0700)  CS-0x1ED  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0701)  CS-0x1EE  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0702)  CS-0x1EF  0x080A1         || 		   CALL draw_horizontal_line
(0703)                            || 
(0704)  CS-0x1F0  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0705)  CS-0x1F1  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0706)  CS-0x1F2  0x36920         || 		   MOV r9,0x20   ; ending x coordinate
(0707)  CS-0x1F3  0x080A1         || 		   CALL draw_horizontal_line
(0708)                            || 
(0709)  CS-0x1F4  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0710)  CS-0x1F5  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0711)  CS-0x1F6  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0712)  CS-0x1F7  0x080A1         || 		   CALL draw_horizontal_line
(0713)                            || 
(0714)  CS-0x1F8  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0715)  CS-0x1F9  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0716)  CS-0x1FA  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0717)  CS-0x1FB  0x080D1         || 		   CALL draw_vertical_line
(0718)                            || 
(0719)  CS-0x1FC  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0720)  CS-0x1FD  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0721)  CS-0x1FE  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0722)  CS-0x1FF  0x080D1         || 		   CALL draw_vertical_line
(0723)                            || 
(0724)  CS-0x200  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0725)  CS-0x201  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0726)  CS-0x202  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0727)  CS-0x203  0x080D1         || 		   CALL draw_vertical_line
(0728)                            || 
(0729)  CS-0x204  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0730)  CS-0x205  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0731)  CS-0x206  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0732)  CS-0x207  0x080A1         || 		   CALL draw_horizontal_line
(0733)                            || 
(0734)  CS-0x208  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0735)  CS-0x209  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0736)  CS-0x20A  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0737)  CS-0x20B  0x080A1         || 		   CALL draw_horizontal_line
(0738)                            || 
(0739)  CS-0x20C  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0740)  CS-0x20D  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0741)  CS-0x20E  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0742)  CS-0x20F  0x080A1         || 		   CALL draw_horizontal_line
(0743)                            || 
(0744)  CS-0x210  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0745)  CS-0x211  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0746)  CS-0x212  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0747)  CS-0x213  0x080A1         || 		   CALL draw_horizontal_line
(0748)                            || 
(0749)  CS-0x214  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0750)  CS-0x215  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0751)  CS-0x216  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0752)  CS-0x217  0x080D1         || 		   CALL draw_vertical_line
(0753)                            || 
(0754)  CS-0x218  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0755)  CS-0x219  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0756)  CS-0x21A  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0757)  CS-0x21B  0x080D1         || 		   CALL draw_vertical_line
(0758)                            || 
(0759)  CS-0x21C  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0760)  CS-0x21D  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0761)  CS-0x21E  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0762)  CS-0x21F  0x080D1         || 		   CALL draw_vertical_line
(0763)                            || 
(0764)  CS-0x220  0x36822         || 		   MOV r8,0x22   ; starting x coordinate
(0765)  CS-0x221  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0766)  CS-0x222  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0767)  CS-0x223  0x080A1         || 		   CALL draw_horizontal_line
(0768)                            || 
(0769)  CS-0x224  0x36824         || 		   MOV r8,0x24  ; x coordinate
(0770)  CS-0x225  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0771)  CS-0x226  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0772)  CS-0x227  0x080D1         || 		   CALL draw_vertical_line
(0773)                            || 
(0774)  CS-0x228  0x36824         || 		   MOV r8,0x24  ; x coordinate
(0775)  CS-0x229  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0776)  CS-0x22A  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0777)  CS-0x22B  0x080D1         || 		   CALL draw_vertical_line





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
DD_ADD40       0x036   (0149)  ||  0139 
DD_ADD80       0x039   (0153)  ||  0142 
DD_OUT         0x032   (0144)  ||  0154 
DRAW_BACKGROUND 0x020   (0106)  ||  0023 
DRAW_DOT       0x02A   (0132)  ||  0063 0089 
DRAW_HORIZ1    0x015   (0062)  ||  0066 
DRAW_HORIZONTAL_LINE 0x014   (0059)  ||  0113 0162 0172 0182 0187 0192 0197 0202 0237 0262 
                               ||  0267 0272 0302 0307 0312 0317 0342 0347 0352 0357 
                               ||  0382 0387 0392 0417 0422 0427 0457 0462 0467 0472 
                               ||  0487 0492 0497 0517 0522 0527 0552 0557 0562 0567 
                               ||  0572 0592 0597 0617 0622 0627 0632 0667 0672 0677 
                               ||  0682 0687 0702 0707 0712 0732 0737 0742 0747 0767 
DRAW_MAZE      0x03B   (0156)  ||  0038 
DRAW_VERT1     0x01B   (0088)  ||  0092 
DRAW_VERTICAL_LINE 0x01A   (0085)  ||  0167 0177 0207 0212 0217 0222 0227 0232 0242 0247 
                               ||  0252 0257 0277 0282 0287 0292 0297 0322 0327 0332 
                               ||  0337 0362 0367 0372 0377 0397 0402 0407 0412 0432 
                               ||  0437 0442 0447 0452 0477 0482 0502 0507 0512 0532 
                               ||  0537 0542 0547 0577 0582 0587 0602 0607 0612 0637 
                               ||  0642 0647 0652 0657 0662 0692 0697 0717 0722 0727 
                               ||  0752 0757 0762 0772 0777 
INIT           0x010   (0022)  ||  
MAIN           0x012   (0040)  ||  0041 
START          0x022   (0109)  ||  0116 
T1             0x030   (0141)  ||  0151 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0010)  ||  0107 
LEDS           0x040   (0008)  ||  
M_BLACK        0x000   (0015)  ||  0157 
M_BLUE         0x013   (0014)  ||  
M_BROWN        0x090   (0016)  ||  
M_RED          0x0E0   (0013)  ||  
M_YELLOW       0x0F8   (0012)  ||  
SSEG           0x081   (0007)  ||  
VGA_COLOR      0x092   (0006)  ||  0146 
VGA_HADD       0x090   (0004)  ||  0145 
VGA_LADD       0x091   (0005)  ||  0144 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
