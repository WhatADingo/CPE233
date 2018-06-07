

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
(0026)  CS-0x010  0x08111         ||          CALL   draw_background         ; draw using default color
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
(0041)  CS-0x011  0x081E9         || 		CALL	draw_maze
(0042)  CS-0x012  0x09191         || 		CALL 	draw_block
(0043)                            || 
(0044)                     0x013  || main:   
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0045)                            || =======
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0046)  CS-0x013  0x00000  0x013  || main:   AND    r0, r0                  ; nop
(0047)                            || 
(0048)  CS-0x014  0x091E9         || 		CALL	move_block
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0049)                            || 	
(0050)  CS-0x015  0x08098         ||         BRN    main                    ; continuous loop 
(0051)                            || 
(0052)                            || ;--------------------------------------------------------------------
(0053)                            || 
(0054)                            || ;--------------------------------------------------------------------
(0055)                            || ;-  Subroutine: draw_horizontal_line
(0056)                            || ;-
(0057)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0058)                            || ;-
(0059)                            || ;-  Parameters:
(0060)                            || ;-   r8  = starting x-coordinate
(0061)                            || ;-   r7  = y-coordinate
(0062)                            || ;-   r9  = ending x-coordinate
(0063)                            || ;-   r6  = color used for line
(0064)                            || ;-
(0065)                            || ;- Tweaked registers: r8,r9
(0066)                            || ;--------------------------------------------------------------------
(0067)                            || 
(0068)                     0x016  || draw_horizontal_line:
(0069)  CS-0x016  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0070)                            || 
(0071)                     0x017  || draw_horiz1:
(0072)  CS-0x017  0x08161         ||         CALL   draw_dot         ; 
(0073)  CS-0x018  0x28801         ||         ADD    r8,0x01
(0074)  CS-0x019  0x04848         ||         CMP    r8,r9
(0075)  CS-0x01A  0x080BB         ||         BRNE   draw_horiz1
(0076)  CS-0x01B  0x18002         ||         RET
(0077)                            || 
(0078)                            || ;--------------------------------------------------------------------
(0079)                            || 
(0080)                            || ;---------------------------------------------------------------------
(0081)                            || ;-  Subroutine: draw_vertical_line
(0082)                            || ;-
(0083)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0084)                            || ;-
(0085)                            || ;-  Parameters:
(0086)                            || ;-   r8  = x-coordinate
(0087)                            || ;-   r7  = starting y-coordinate
(0088)                            || ;-   r9  = ending y-coordinate
(0089)                            || ;-   r6  = color used for line
(0090)                            || ;- 
(0091)                            || ;- Tweaked registers: r7,r9
(0092)                            || ;--------------------------------------------------------------------
(0093)                            || 
(0094)                     0x01C  || draw_vertical_line:
(0095)  CS-0x01C  0x28901         ||          ADD    r9,0x01
(0096)                            || 
(0097)                     0x01D  || draw_vert1:          
(0098)  CS-0x01D  0x08161         ||          CALL   draw_dot
(0099)  CS-0x01E  0x28701         ||          ADD    r7,0x01
(0100)  CS-0x01F  0x04748         ||          CMP    r7,R9
(0101)  CS-0x020  0x080EB         ||          BRNE   draw_vert1
(0102)  CS-0x021  0x18002         ||          RET
(0103)                            || 
(0104)                            || ;--------------------------------------------------------------------
(0105)                            || 
(0106)                            || ;---------------------------------------------------------------------
(0107)                            || ;-  Subroutine: draw_background
(0108)                            || ;-
(0109)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0110)                            || ;-  draw_horizontal_line subroutine. 
(0111)                            || ;- 
(0112)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0113)                            || ;----------------------------------------------------------------------
(0114)                            || 
(0115)                     0x022  || draw_background: 
(0116)  CS-0x022  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0117)  CS-0x023  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0118)  CS-0x024  0x04769  0x024  || start:   MOV   r7,r13                   ; load current row count 
(0119)  CS-0x025  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0120)  CS-0x026  0x36927         ||          MOV   r9,0x27 
(0121)                            || 
(0122)  CS-0x027  0x080B1         ||          CALL  draw_horizontal_line
(0123)  CS-0x028  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0124)  CS-0x029  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0125)  CS-0x02A  0x08123         ||          BRNE  start                    ; branch to draw more rows
(0126)  CS-0x02B  0x18002         ||          RET
(0127)                            || 
(0128)                            || ;---------------------------------------------------------------------
(0129)                            || 
(0130)                            ||  
(0131)                            || ;---------------------------------------------------------------------
(0132)                            || ;- Subrountine: draw_dot
(0133)                            || ;- 
(0134)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0135)                            || ;- 
(0136)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0137)                            || ;- 
(0138)                            || ;- Tweaked registers: r4,r5
(0139)                            || ;---------------------------------------------------------------------
(0140)                            || 
(0141)                     0x02C  || draw_dot: 
(0142)  CS-0x02C  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0143)  CS-0x02D  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0144)                            || 
(0145)  CS-0x02E  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0146)  CS-0x02F  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0147)  CS-0x030  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0148)  CS-0x031  0x0A1C0         ||            BRCS  dd_add40
(0149)                            || 
(0150)  CS-0x032  0x10401  0x032  || t1:        LSR   r4
(0151)  CS-0x033  0x0A1D8         ||            BRCS  dd_add80
(0152)                            || 
(0153)  CS-0x034  0x34591  0x034  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0154)  CS-0x035  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0155)  CS-0x036  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0156)  CS-0x037  0x18002         ||            RET
(0157)                            || 
(0158)  CS-0x038  0x22540  0x038  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0159)  CS-0x039  0x18000         ||            CLC                  ; freshen bit
(0160)  CS-0x03A  0x08190         ||            BRN   t1             
(0161)                            || 
(0162)  CS-0x03B  0x22580  0x03B  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0163)  CS-0x03C  0x081A0         ||            BRN   dd_out
(0164)                            || ; --------------------------------------------------------------------
(0165)                     0x03D  || draw_maze: 
(0166)  CS-0x03D  0x36600         || 		   MOV r6,M_BLACK
(0167)                            || 		   
(0168)  CS-0x03E  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0169)  CS-0x03F  0x36700         || 		   MOV r7,0x00   ; y coordinate
(0170)  CS-0x040  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0171)  CS-0x041  0x080B1         || 		   CALL draw_horizontal_line
(0172)                            || 
(0173)  CS-0x042  0x36800         ||            MOV r8,0x00   ; x coordinate
(0174)  CS-0x043  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0175)  CS-0x044  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0176)  CS-0x045  0x080E1         || 		   CALL draw_vertical_line
(0177)                            || 
(0178)  CS-0x046  0x36801         ||            MOV r8,0x01   ; x coordinate
(0179)  CS-0x047  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0180)  CS-0x048  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0181)  CS-0x049  0x080E1         || 		   CALL draw_vertical_line
(0182)                            || 
(0183)  CS-0x04A  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0184)  CS-0x04B  0x3671C         || 		   MOV r7,0x1C   ; y coordinate
(0185)  CS-0x04C  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0186)  CS-0x04D  0x080B1         || 		   CALL draw_horizontal_line
(0187)                            || 
(0188)  CS-0x04E  0x36826         || 		   MOV r8,0x26   ; x coordinate
(0189)  CS-0x04F  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0190)  CS-0x050  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0191)  CS-0x051  0x080E1         || 		   CALL draw_vertical_line
(0192)                            || 
(0193)  CS-0x052  0x36800         || 		   MOV r8,0x00  ; starting x coordinate
(0194)  CS-0x053  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0195)  CS-0x054  0x36902         || 		   MOV r9,0x02   ; ending x coordinate
(0196)  CS-0x055  0x080B1         || 		   CALL draw_horizontal_line
(0197)                            ||  
(0198)  CS-0x056  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0199)  CS-0x057  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0200)  CS-0x058  0x36904         || 		   MOV r9,0x04   ; ending x coordinate
(0201)  CS-0x059  0x080B1         || 		   CALL draw_horizontal_line
(0202)                            || 
(0203)  CS-0x05A  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0204)  CS-0x05B  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0205)  CS-0x05C  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0206)  CS-0x05D  0x080B1         || 		   CALL draw_horizontal_line
(0207)                            || 
(0208)  CS-0x05E  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0209)  CS-0x05F  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0210)  CS-0x060  0x36902         || 		   MOV r9,0x02   ; ending x coordinate
(0211)  CS-0x061  0x080B1         || 		   CALL draw_horizontal_line
(0212)                            || 
(0213)  CS-0x062  0x36800         || 		   MOV r8,0x00   ; starting x coordinate
(0214)  CS-0x063  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0215)  CS-0x064  0x36904         || 		   MOV r9,0x04   ; ending x coordinate
(0216)  CS-0x065  0x080B1         || 		   CALL draw_horizontal_line
(0217)                            || 
(0218)  CS-0x066  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0219)  CS-0x067  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0220)  CS-0x068  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0221)  CS-0x069  0x080E1         || 		   CALL draw_vertical_line
(0222)                            || 
(0223)  CS-0x06A  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0224)  CS-0x06B  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0225)  CS-0x06C  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0226)  CS-0x06D  0x080E1         || 		   CALL draw_vertical_line
(0227)                            || 
(0228)  CS-0x06E  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0229)  CS-0x06F  0x3670C         || 		   MOV r7,0x0C	 ; starting y coordinate
(0230)  CS-0x070  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0231)  CS-0x071  0x080E1         || 		   CALL draw_vertical_line
(0232)                            || 
(0233)  CS-0x072  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0234)  CS-0x073  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0235)  CS-0x074  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0236)  CS-0x075  0x080E1         || 		   CALL draw_vertical_line
(0237)                            || 
(0238)  CS-0x076  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0239)  CS-0x077  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0240)  CS-0x078  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0241)  CS-0x079  0x080E1         || 		   CALL draw_vertical_line
(0242)                            || 
(0243)  CS-0x07A  0x36802         || 		   MOV r8,0x02  ; x coordinate
(0244)  CS-0x07B  0x3671A         || 		   MOV r7,0x1A	 ; starting y coordinate
(0245)  CS-0x07C  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0246)  CS-0x07D  0x080E1         || 		   CALL draw_vertical_line
(0247)                            || 
(0248)  CS-0x07E  0x36802         || 		   MOV r8,0x02   ; starting x coordinate
(0249)  CS-0x07F  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0250)  CS-0x080  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0251)  CS-0x081  0x080B1         || 		   CALL draw_horizontal_line
(0252)                            || 
(0253)  CS-0x082  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0254)  CS-0x083  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0255)  CS-0x084  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0256)  CS-0x085  0x080E1         || 		   CALL draw_vertical_line
(0257)                            || 
(0258)  CS-0x086  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0259)  CS-0x087  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0260)  CS-0x088  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0261)  CS-0x089  0x080E1         || 		   CALL draw_vertical_line
(0262)                            || 
(0263)  CS-0x08A  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0264)  CS-0x08B  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0265)  CS-0x08C  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0266)  CS-0x08D  0x080E1         || 		   CALL draw_vertical_line
(0267)                            || 
(0268)  CS-0x08E  0x36804         || 		   MOV r8,0x04  ; x coordinate
(0269)  CS-0x08F  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0270)  CS-0x090  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0271)  CS-0x091  0x080E1         || 		   CALL draw_vertical_line
(0272)                            || 
(0273)  CS-0x092  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0274)  CS-0x093  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0275)  CS-0x094  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0276)  CS-0x095  0x080B1         || 		   CALL draw_horizontal_line
(0277)                            || 
(0278)  CS-0x096  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0279)  CS-0x097  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0280)  CS-0x098  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0281)  CS-0x099  0x080B1         || 		   CALL draw_horizontal_line
(0282)                            || 		
(0283)  CS-0x09A  0x36804         || 		   MOV r8,0x04   ; starting x coordinate
(0284)  CS-0x09B  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0285)  CS-0x09C  0x36906         || 		   MOV r9,0x06   ; ending x coordinate
(0286)  CS-0x09D  0x080B1         || 		   CALL draw_horizontal_line
(0287)                            || 
(0288)  CS-0x09E  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0289)  CS-0x09F  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0290)  CS-0x0A0  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0291)  CS-0x0A1  0x080E1         || 		   CALL draw_vertical_line
(0292)                            || 
(0293)  CS-0x0A2  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0294)  CS-0x0A3  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0295)  CS-0x0A4  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0296)  CS-0x0A5  0x080E1         || 		   CALL draw_vertical_line
(0297)                            || 
(0298)  CS-0x0A6  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0299)  CS-0x0A7  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0300)  CS-0x0A8  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0301)  CS-0x0A9  0x080E1         || 		   CALL draw_vertical_line
(0302)                            || 
(0303)  CS-0x0AA  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0304)  CS-0x0AB  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0305)  CS-0x0AC  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0306)  CS-0x0AD  0x080E1         || 		   CALL draw_vertical_line
(0307)                            || 
(0308)  CS-0x0AE  0x36806         || 		   MOV r8,0x06  ; x coordinate
(0309)  CS-0x0AF  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0310)  CS-0x0B0  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0311)  CS-0x0B1  0x080E1         || 		   CALL draw_vertical_line
(0312)                            || 
(0313)  CS-0x0B2  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0314)  CS-0x0B3  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0315)  CS-0x0B4  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0316)  CS-0x0B5  0x080B1         || 		   CALL draw_horizontal_line
(0317)                            || 
(0318)  CS-0x0B6  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0319)  CS-0x0B7  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0320)  CS-0x0B8  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0321)  CS-0x0B9  0x080B1         || 		   CALL draw_horizontal_line
(0322)                            || 
(0323)  CS-0x0BA  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0324)  CS-0x0BB  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0325)  CS-0x0BC  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0326)  CS-0x0BD  0x080B1         || 		   CALL draw_horizontal_line
(0327)                            || 
(0328)  CS-0x0BE  0x36806         || 		   MOV r8,0x06   ; starting x coordinate
(0329)  CS-0x0BF  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0330)  CS-0x0C0  0x36908         || 		   MOV r9,0x08   ; ending x coordinate
(0331)  CS-0x0C1  0x080B1         || 		   CALL draw_horizontal_line
(0332)                            || 
(0333)  CS-0x0C2  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0334)  CS-0x0C3  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0335)  CS-0x0C4  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0336)  CS-0x0C5  0x080E1         || 		   CALL draw_vertical_line
(0337)                            || 
(0338)  CS-0x0C6  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0339)  CS-0x0C7  0x3670C         || 		   MOV r7,0x0C	 ; starting y coordinate
(0340)  CS-0x0C8  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0341)  CS-0x0C9  0x080E1         || 		   CALL draw_vertical_line
(0342)                            || 
(0343)  CS-0x0CA  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0344)  CS-0x0CB  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0345)  CS-0x0CC  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0346)  CS-0x0CD  0x080E1         || 		   CALL draw_vertical_line
(0347)                            || 
(0348)  CS-0x0CE  0x36808         || 		   MOV r8,0x08  ; x coordinate
(0349)  CS-0x0CF  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0350)  CS-0x0D0  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0351)  CS-0x0D1  0x080E1         || 		   CALL draw_vertical_line
(0352)                            || 
(0353)  CS-0x0D2  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0354)  CS-0x0D3  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0355)  CS-0x0D4  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0356)  CS-0x0D5  0x080B1         || 		   CALL draw_horizontal_line
(0357)                            || 
(0358)  CS-0x0D6  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0359)  CS-0x0D7  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0360)  CS-0x0D8  0x3690A         || 		   MOV r9,0x0A   ; ending x coordinate
(0361)  CS-0x0D9  0x080B1         || 		   CALL draw_horizontal_line
(0362)                            || 
(0363)  CS-0x0DA  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0364)  CS-0x0DB  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0365)  CS-0x0DC  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0366)  CS-0x0DD  0x080B1         || 		   CALL draw_horizontal_line
(0367)                            || 
(0368)  CS-0x0DE  0x36808         || 		   MOV r8,0x08   ; starting x coordinate
(0369)  CS-0x0DF  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0370)  CS-0x0E0  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0371)  CS-0x0E1  0x080B1         || 		   CALL draw_horizontal_line
(0372)                            || 
(0373)  CS-0x0E2  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0374)  CS-0x0E3  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0375)  CS-0x0E4  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0376)  CS-0x0E5  0x080E1         || 		   CALL draw_vertical_line
(0377)                            || 
(0378)  CS-0x0E6  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0379)  CS-0x0E7  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0380)  CS-0x0E8  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0381)  CS-0x0E9  0x080E1         || 		   CALL draw_vertical_line
(0382)                            || 
(0383)  CS-0x0EA  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0384)  CS-0x0EB  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0385)  CS-0x0EC  0x36912         || 		   MOV r9,0x12	 ; ending y coordinate
(0386)  CS-0x0ED  0x080E1         || 		   CALL draw_vertical_line
(0387)                            || 
(0388)  CS-0x0EE  0x3680A         || 		   MOV r8,0x0A  ; x coordinate
(0389)  CS-0x0EF  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0390)  CS-0x0F0  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0391)  CS-0x0F1  0x080E1         || 		   CALL draw_vertical_line
(0392)                            || 
(0393)  CS-0x0F2  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0394)  CS-0x0F3  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0395)  CS-0x0F4  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0396)  CS-0x0F5  0x080B1         || 		   CALL draw_horizontal_line
(0397)                            || 
(0398)  CS-0x0F6  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0399)  CS-0x0F7  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0400)  CS-0x0F8  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0401)  CS-0x0F9  0x080B1         || 		   CALL draw_horizontal_line
(0402)                            || 
(0403)  CS-0x0FA  0x3680A         || 		   MOV r8,0x0A   ; starting x coordinate
(0404)  CS-0x0FB  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0405)  CS-0x0FC  0x3690C         || 		   MOV r9,0x0C   ; ending x coordinate
(0406)  CS-0x0FD  0x080B1         || 		   CALL draw_horizontal_line
(0407)                            || 
(0408)  CS-0x0FE  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0409)  CS-0x0FF  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0410)  CS-0x100  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0411)  CS-0x101  0x080E1         || 		   CALL draw_vertical_line
(0412)                            || 
(0413)  CS-0x102  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0414)  CS-0x103  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0415)  CS-0x104  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0416)  CS-0x105  0x080E1         || 		   CALL draw_vertical_line
(0417)                            || 
(0418)  CS-0x106  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0419)  CS-0x107  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0420)  CS-0x108  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0421)  CS-0x109  0x080E1         || 		   CALL draw_vertical_line
(0422)                            || 
(0423)  CS-0x10A  0x3680C         || 		   MOV r8,0x0C  ; x coordinate
(0424)  CS-0x10B  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0425)  CS-0x10C  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0426)  CS-0x10D  0x080E1         || 		   CALL draw_vertical_line
(0427)                            || 
(0428)  CS-0x10E  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0429)  CS-0x10F  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0430)  CS-0x110  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0431)  CS-0x111  0x080B1         || 		   CALL draw_horizontal_line
(0432)                            || 
(0433)  CS-0x112  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0434)  CS-0x113  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0435)  CS-0x114  0x3690E         || 		   MOV r9,0x0E   ; ending x coordinate
(0436)  CS-0x115  0x080B1         || 		   CALL draw_horizontal_line
(0437)                            || 
(0438)  CS-0x116  0x3680C         || 		   MOV r8,0x0C   ; starting x coordinate
(0439)  CS-0x117  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0440)  CS-0x118  0x36910         || 		   MOV r9,0x10   ; ending x coordinate
(0441)  CS-0x119  0x080B1         || 		   CALL draw_horizontal_line
(0442)                            || 
(0443)  CS-0x11A  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0444)  CS-0x11B  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0445)  CS-0x11C  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0446)  CS-0x11D  0x080E1         || 		   CALL draw_vertical_line
(0447)                            || 
(0448)  CS-0x11E  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0449)  CS-0x11F  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0450)  CS-0x120  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0451)  CS-0x121  0x080E1         || 		   CALL draw_vertical_line
(0452)                            || 
(0453)  CS-0x122  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0454)  CS-0x123  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0455)  CS-0x124  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0456)  CS-0x125  0x080E1         || 		   CALL draw_vertical_line
(0457)                            || 
(0458)  CS-0x126  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0459)  CS-0x127  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0460)  CS-0x128  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0461)  CS-0x129  0x080E1         || 		   CALL draw_vertical_line
(0462)                            || 
(0463)  CS-0x12A  0x3680E         || 		   MOV r8,0x0E  ; x coordinate
(0464)  CS-0x12B  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0465)  CS-0x12C  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0466)  CS-0x12D  0x080E1         || 		   CALL draw_vertical_line
(0467)                            || 
(0468)  CS-0x12E  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0469)  CS-0x12F  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0470)  CS-0x130  0x36910         || 		   MOV r9,0x10   ; ending x coordinate
(0471)  CS-0x131  0x080B1         || 		   CALL draw_horizontal_line
(0472)                            || 
(0473)  CS-0x132  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0474)  CS-0x133  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0475)  CS-0x134  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0476)  CS-0x135  0x080B1         || 		   CALL draw_horizontal_line
(0477)                            || 
(0478)  CS-0x136  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0479)  CS-0x137  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0480)  CS-0x138  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0481)  CS-0x139  0x080B1         || 		   CALL draw_horizontal_line
(0482)                            || 
(0483)  CS-0x13A  0x3680E         || 		   MOV r8,0x0E   ; starting x coordinate
(0484)  CS-0x13B  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0485)  CS-0x13C  0x36912         || 		   MOV r9,0x12   ; ending x coordinate
(0486)  CS-0x13D  0x080B1         || 		   CALL draw_horizontal_line
(0487)                            || 
(0488)  CS-0x13E  0x36810         || 		   MOV r8,0x10  ; x coordinate
(0489)  CS-0x13F  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0490)  CS-0x140  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0491)  CS-0x141  0x080E1         || 		   CALL draw_vertical_line
(0492)                            || 
(0493)  CS-0x142  0x36810         || 		   MOV r8,0x10  ; x coordinate
(0494)  CS-0x143  0x36710         || 		   MOV r7,0x10	 ; starting y coordinate
(0495)  CS-0x144  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0496)  CS-0x145  0x080E1         || 		   CALL draw_vertical_line
(0497)                            || 
(0498)  CS-0x146  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0499)  CS-0x147  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0500)  CS-0x148  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0501)  CS-0x149  0x080B1         || 		   CALL draw_horizontal_line
(0502)                            || 
(0503)  CS-0x14A  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0504)  CS-0x14B  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0505)  CS-0x14C  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0506)  CS-0x14D  0x080B1         || 		   CALL draw_horizontal_line
(0507)                            || 
(0508)  CS-0x14E  0x36810         || 		   MOV r8,0x10   ; starting x coordinate
(0509)  CS-0x14F  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0510)  CS-0x150  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0511)  CS-0x151  0x080B1         || 		   CALL draw_horizontal_line
(0512)                            || 
(0513)  CS-0x152  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0514)  CS-0x153  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0515)  CS-0x154  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0516)  CS-0x155  0x080E1         || 		   CALL draw_vertical_line
(0517)                            || 
(0518)  CS-0x156  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0519)  CS-0x157  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0520)  CS-0x158  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0521)  CS-0x159  0x080E1         || 		   CALL draw_vertical_line
(0522)                            || 
(0523)  CS-0x15A  0x36812         || 		   MOV r8,0x12  ; x coordinate
(0524)  CS-0x15B  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0525)  CS-0x15C  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0526)  CS-0x15D  0x080E1         || 		   CALL draw_vertical_line
(0527)                            || 
(0528)  CS-0x15E  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0529)  CS-0x15F  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0530)  CS-0x160  0x36914         || 		   MOV r9,0x14   ; ending x coordinate
(0531)  CS-0x161  0x080B1         || 		   CALL draw_horizontal_line
(0532)                            || 
(0533)  CS-0x162  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0534)  CS-0x163  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0535)  CS-0x164  0x36914         || 		   MOV r9,0x14  ; ending x coordinate
(0536)  CS-0x165  0x080B1         || 		   CALL draw_horizontal_line
(0537)                            || 
(0538)  CS-0x166  0x36812         || 		   MOV r8,0x12   ; starting x coordinate
(0539)  CS-0x167  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0540)  CS-0x168  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0541)  CS-0x169  0x080B1         || 		   CALL draw_horizontal_line
(0542)                            || 
(0543)  CS-0x16A  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0544)  CS-0x16B  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0545)  CS-0x16C  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0546)  CS-0x16D  0x080E1         || 		   CALL draw_vertical_line
(0547)                            || 
(0548)  CS-0x16E  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0549)  CS-0x16F  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0550)  CS-0x170  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0551)  CS-0x171  0x080E1         || 		   CALL draw_vertical_line
(0552)                            || 
(0553)  CS-0x172  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0554)  CS-0x173  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0555)  CS-0x174  0x36918         || 		   MOV r9,0x18	 ; ending y coordinate
(0556)  CS-0x175  0x080E1         || 		   CALL draw_vertical_line
(0557)                            || 
(0558)  CS-0x176  0x36814         || 		   MOV r8,0x14  ; x coordinate
(0559)  CS-0x177  0x3671A         || 		   MOV r7,0x1A	 ; starting y coordinate
(0560)  CS-0x178  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0561)  CS-0x179  0x080E1         || 		   CALL draw_vertical_line
(0562)                            || 
(0563)  CS-0x17A  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0564)  CS-0x17B  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0565)  CS-0x17C  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0566)  CS-0x17D  0x080B1         || 		   CALL draw_horizontal_line
(0567)                            || 
(0568)  CS-0x17E  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0569)  CS-0x17F  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0570)  CS-0x180  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0571)  CS-0x181  0x080B1         || 		   CALL draw_horizontal_line
(0572)                            || 
(0573)  CS-0x182  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0574)  CS-0x183  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0575)  CS-0x184  0x36916         || 		   MOV r9,0x16   ; ending x coordinate
(0576)  CS-0x185  0x080B1         || 		   CALL draw_horizontal_line
(0577)                            || 
(0578)  CS-0x186  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0579)  CS-0x187  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0580)  CS-0x188  0x36918         || 		   MOV r9,0x18   ; ending x coordinate
(0581)  CS-0x189  0x080B1         || 		   CALL draw_horizontal_line
(0582)                            || 
(0583)  CS-0x18A  0x36814         || 		   MOV r8,0x14   ; starting x coordinate
(0584)  CS-0x18B  0x36718         || 		   MOV r7,0x18   ; y coordinate
(0585)  CS-0x18C  0x36920         || 		   MOV r9,0x20   ; ending x coordinate
(0586)  CS-0x18D  0x080B1         || 		   CALL draw_horizontal_line
(0587)                            || 
(0588)  CS-0x18E  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0589)  CS-0x18F  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0590)  CS-0x190  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0591)  CS-0x191  0x080E1         || 		   CALL draw_vertical_line
(0592)                            || 
(0593)  CS-0x192  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0594)  CS-0x193  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0595)  CS-0x194  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0596)  CS-0x195  0x080E1         || 		   CALL draw_vertical_line
(0597)                            || 
(0598)  CS-0x196  0x36816         || 		   MOV r8,0x16  ; x coordinate
(0599)  CS-0x197  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0600)  CS-0x198  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0601)  CS-0x199  0x080E1         || 		   CALL draw_vertical_line
(0602)                            || 
(0603)  CS-0x19A  0x36816         || 		   MOV r8,0x16   ; starting x coordinate
(0604)  CS-0x19B  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0605)  CS-0x19C  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0606)  CS-0x19D  0x080B1         || 		   CALL draw_horizontal_line
(0607)                            || 
(0608)  CS-0x19E  0x36816         || 		   MOV r8,0x16   ; starting x coordinate
(0609)  CS-0x19F  0x3670C         || 		   MOV r7,0x0C   ; y coordinate
(0610)  CS-0x1A0  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0611)  CS-0x1A1  0x080B1         || 		   CALL draw_horizontal_line
(0612)                            || 
(0613)  CS-0x1A2  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0614)  CS-0x1A3  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0615)  CS-0x1A4  0x36906         || 		   MOV r9,0x06	 ; ending y coordinate
(0616)  CS-0x1A5  0x080E1         || 		   CALL draw_vertical_line
(0617)                            || 
(0618)  CS-0x1A6  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0619)  CS-0x1A7  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0620)  CS-0x1A8  0x3690C         || 		   MOV r9,0x0C	 ; ending y coordinate
(0621)  CS-0x1A9  0x080E1         || 		   CALL draw_vertical_line
(0622)                            || 
(0623)  CS-0x1AA  0x36818         || 		   MOV r8,0x18  ; x coordinate
(0624)  CS-0x1AB  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0625)  CS-0x1AC  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0626)  CS-0x1AD  0x080E1         || 		   CALL draw_vertical_line
(0627)                            || 
(0628)  CS-0x1AE  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0629)  CS-0x1AF  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0630)  CS-0x1B0  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0631)  CS-0x1B1  0x080B1         || 		   CALL draw_horizontal_line
(0632)                            || 
(0633)  CS-0x1B2  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0634)  CS-0x1B3  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0635)  CS-0x1B4  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0636)  CS-0x1B5  0x080B1         || 		   CALL draw_horizontal_line
(0637)                            || 
(0638)  CS-0x1B6  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0639)  CS-0x1B7  0x36710         || 		   MOV r7,0x10   ; y coordinate
(0640)  CS-0x1B8  0x36926         || 		   MOV r9,0x26   ; ending x coordinate
(0641)  CS-0x1B9  0x080B1         || 		   CALL draw_horizontal_line
(0642)                            || 
(0643)  CS-0x1BA  0x36818         || 		   MOV r8,0x18   ; starting x coordinate
(0644)  CS-0x1BB  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0645)  CS-0x1BC  0x3691A         || 		   MOV r9,0x1A   ; ending x coordinate
(0646)  CS-0x1BD  0x080B1         || 		   CALL draw_horizontal_line
(0647)                            || 
(0648)  CS-0x1BE  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0649)  CS-0x1BF  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0650)  CS-0x1C0  0x36904         || 		   MOV r9,0x04	 ; ending y coordinate
(0651)  CS-0x1C1  0x080E1         || 		   CALL draw_vertical_line
(0652)                            || 
(0653)  CS-0x1C2  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0654)  CS-0x1C3  0x36708         || 		   MOV r7,0x08	 ; starting y coordinate
(0655)  CS-0x1C4  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0656)  CS-0x1C5  0x080E1         || 		   CALL draw_vertical_line
(0657)                            || 
(0658)  CS-0x1C6  0x3681A         || 		   MOV r8,0x1A  ; x coordinate
(0659)  CS-0x1C7  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0660)  CS-0x1C8  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0661)  CS-0x1C9  0x080E1         || 		   CALL draw_vertical_line
(0662)                            || 
(0663)  CS-0x1CA  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0664)  CS-0x1CB  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0665)  CS-0x1CC  0x3690A         || 		   MOV r9,0x0A	 ; ending y coordinate
(0666)  CS-0x1CD  0x080E1         || 		   CALL draw_vertical_line
(0667)                            || 
(0668)  CS-0x1CE  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0669)  CS-0x1CF  0x3670E         || 		   MOV r7,0x0E	 ; starting y coordinate
(0670)  CS-0x1D0  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0671)  CS-0x1D1  0x080E1         || 		   CALL draw_vertical_line
(0672)                            || 
(0673)  CS-0x1D2  0x3681C         || 		   MOV r8,0x1C  ; x coordinate
(0674)  CS-0x1D3  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0675)  CS-0x1D4  0x36916         || 		   MOV r9,0x16	 ; ending y coordinate
(0676)  CS-0x1D5  0x080E1         || 		   CALL draw_vertical_line
(0677)                            || 
(0678)  CS-0x1D6  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0679)  CS-0x1D7  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0680)  CS-0x1D8  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0681)  CS-0x1D9  0x080B1         || 		   CALL draw_horizontal_line
(0682)                            || 
(0683)  CS-0x1DA  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0684)  CS-0x1DB  0x36708         || 		   MOV r7,0x08   ; y coordinate
(0685)  CS-0x1DC  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0686)  CS-0x1DD  0x080B1         || 		   CALL draw_horizontal_line
(0687)                            || 
(0688)  CS-0x1DE  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0689)  CS-0x1DF  0x3670A         || 		   MOV r7,0x0A   ; y coordinate
(0690)  CS-0x1E0  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0691)  CS-0x1E1  0x080B1         || 		   CALL draw_horizontal_line
(0692)                            || 
(0693)  CS-0x1E2  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0694)  CS-0x1E3  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0695)  CS-0x1E4  0x3691E         || 		   MOV r9,0x1E   ; ending x coordinate
(0696)  CS-0x1E5  0x080B1         || 		   CALL draw_horizontal_line
(0697)                            || 
(0698)  CS-0x1E6  0x3681C         || 		   MOV r8,0x1C   ; starting x coordinate
(0699)  CS-0x1E7  0x36714         || 		   MOV r7,0x14   ; y coordinate
(0700)  CS-0x1E8  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0701)  CS-0x1E9  0x080B1         || 		   CALL draw_horizontal_line
(0702)                            || 
(0703)  CS-0x1EA  0x3681E         || 		   MOV r8,0x1E  ; x coordinate
(0704)  CS-0x1EB  0x36700         || 		   MOV r7,0x00	 ; starting y coordinate
(0705)  CS-0x1EC  0x36902         || 		   MOV r9,0x02	 ; ending y coordinate
(0706)  CS-0x1ED  0x080E1         || 		   CALL draw_vertical_line
(0707)                            || 
(0708)  CS-0x1EE  0x3681E         || 		   MOV r8,0x1E  ; x coordinate
(0709)  CS-0x1EF  0x36704         || 		   MOV r7,0x04	 ; starting y coordinate
(0710)  CS-0x1F0  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0711)  CS-0x1F1  0x080E1         || 		   CALL draw_vertical_line
(0712)                            || 
(0713)  CS-0x1F2  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0714)  CS-0x1F3  0x36704         || 		   MOV r7,0x04   ; y coordinate
(0715)  CS-0x1F4  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0716)  CS-0x1F5  0x080B1         || 		   CALL draw_horizontal_line
(0717)                            || 
(0718)  CS-0x1F6  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0719)  CS-0x1F7  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0720)  CS-0x1F8  0x36920         || 		   MOV r9,0x20   ; ending x coordinate
(0721)  CS-0x1F9  0x080B1         || 		   CALL draw_horizontal_line
(0722)                            || 
(0723)  CS-0x1FA  0x3681E         || 		   MOV r8,0x1E   ; starting x coordinate
(0724)  CS-0x1FB  0x36716         || 		   MOV r7,0x16   ; y coordinate
(0725)  CS-0x1FC  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0726)  CS-0x1FD  0x080B1         || 		   CALL draw_horizontal_line
(0727)                            || 
(0728)  CS-0x1FE  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0729)  CS-0x1FF  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0730)  CS-0x200  0x36910         || 		   MOV r9,0x10	 ; ending y coordinate
(0731)  CS-0x201  0x080E1         || 		   CALL draw_vertical_line
(0732)                            || 
(0733)  CS-0x202  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0734)  CS-0x203  0x36712         || 		   MOV r7,0x12	 ; starting y coordinate
(0735)  CS-0x204  0x36914         || 		   MOV r9,0x14	 ; ending y coordinate
(0736)  CS-0x205  0x080E1         || 		   CALL draw_vertical_line
(0737)                            || 
(0738)  CS-0x206  0x36820         || 		   MOV r8,0x20  ; x coordinate
(0739)  CS-0x207  0x36718         || 		   MOV r7,0x18	 ; starting y coordinate
(0740)  CS-0x208  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0741)  CS-0x209  0x080E1         || 		   CALL draw_vertical_line
(0742)                            || 
(0743)  CS-0x20A  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0744)  CS-0x20B  0x36702         || 		   MOV r7,0x02   ; y coordinate
(0745)  CS-0x20C  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0746)  CS-0x20D  0x080B1         || 		   CALL draw_horizontal_line
(0747)                            || 
(0748)  CS-0x20E  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0749)  CS-0x20F  0x36706         || 		   MOV r7,0x06   ; y coordinate
(0750)  CS-0x210  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0751)  CS-0x211  0x080B1         || 		   CALL draw_horizontal_line
(0752)                            || 
(0753)  CS-0x212  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0754)  CS-0x213  0x36712         || 		   MOV r7,0x12   ; y coordinate
(0755)  CS-0x214  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0756)  CS-0x215  0x080B1         || 		   CALL draw_horizontal_line
(0757)                            || 
(0758)  CS-0x216  0x36820         || 		   MOV r8,0x20   ; starting x coordinate
(0759)  CS-0x217  0x3671A         || 		   MOV r7,0x1A   ; y coordinate
(0760)  CS-0x218  0x36922         || 		   MOV r9,0x22   ; ending x coordinate
(0761)  CS-0x219  0x080B1         || 		   CALL draw_horizontal_line
(0762)                            || 
(0763)  CS-0x21A  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0764)  CS-0x21B  0x36706         || 		   MOV r7,0x06	 ; starting y coordinate
(0765)  CS-0x21C  0x36908         || 		   MOV r9,0x08	 ; ending y coordinate
(0766)  CS-0x21D  0x080E1         || 		   CALL draw_vertical_line
(0767)                            || 
(0768)  CS-0x21E  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0769)  CS-0x21F  0x3670A         || 		   MOV r7,0x0A	 ; starting y coordinate
(0770)  CS-0x220  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0771)  CS-0x221  0x080E1         || 		   CALL draw_vertical_line
(0772)                            || 
(0773)  CS-0x222  0x36822         || 		   MOV r8,0x22  ; x coordinate
(0774)  CS-0x223  0x36716         || 		   MOV r7,0x16	 ; starting y coordinate
(0775)  CS-0x224  0x3691A         || 		   MOV r9,0x1A	 ; ending y coordinate
(0776)  CS-0x225  0x080E1         || 		   CALL draw_vertical_line
(0777)                            || 
(0778)  CS-0x226  0x36822         || 		   MOV r8,0x22   ; starting x coordinate
(0779)  CS-0x227  0x3670E         || 		   MOV r7,0x0E   ; y coordinate
(0780)  CS-0x228  0x36924         || 		   MOV r9,0x24   ; ending x coordinate
(0781)  CS-0x229  0x080B1         || 		   CALL draw_horizontal_line
(0782)                            || 
(0783)  CS-0x22A  0x36824         || 		   MOV r8,0x24  ; x coordinate
(0784)  CS-0x22B  0x36702         || 		   MOV r7,0x02	 ; starting y coordinate
(0785)  CS-0x22C  0x3690E         || 		   MOV r9,0x0E	 ; ending y coordinate
(0786)  CS-0x22D  0x080E1         || 		   CALL draw_vertical_line
(0787)                            || 
(0788)  CS-0x22E  0x36824         || 		   MOV r8,0x24  ; x coordinate
(0789)  CS-0x22F  0x36714         || 		   MOV r7,0x14	 ; starting y coordinate
(0790)  CS-0x230  0x3691C         || 		   MOV r9,0x1C	 ; ending y coordinate
(0791)  CS-0x231  0x080E1         || 		   CALL draw_vertical_line
(0792)                            || 
(0793)  CS-0x232  0x366F8  0x232  || draw_block: MOV r6,M_YELLOW
(0794)                            || 
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0795)  CS-0x233  0x36A01         || 			MOV r10,0x01
(0796)  CS-0x234  0x04751         || 			MOV r7, r10
(0797)  CS-0x235  0x36B00         || 			MOV r11,0x00
(0798)  CS-0x236  0x04859         || 			MOV r8, r11
(0799)                            || =======
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0800)                            || 			
(0801)  CS-0x237  0x36A02         || 			MOV r10,0x02
(0802)  CS-0x238  0x04751         || 			MOV r7,r10
(0803)  CS-0x239  0x36B03         || 			MOV r11,0x03
(0804)  CS-0x23A  0x04859         || 			MOV r8,r11
(0805)  CS-0x23B  0x08161         || 			CALL draw_dot
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0806)                            || 			
(0807)  CS-0x23C  0x18002         || 			RET
(0808)                            || 
(0809)  CS-0x23D  0x32F9A  0x23D  || move_block: IN r15,button
(0810)                            || 
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0811)                            || =======
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0812)                            || 			;MOV r16,For_Count
(0813)                            || 			;TimeDelay:	SUB r16,0x01
(0814)                            || 			;			BRNE TimeDelay
(0815)  CS-0x23E  0x12F00         || 			ASR r15
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0816)  CS-0x23F  0x0B280         || 			BRCS move_right
(0817)                     0x240  || 			move_right_end:
(0818)  CS-0x240  0x12F00         || 			ASR r15
(0819)  CS-0x241  0x0B2D0         || 			BRCS move_left
(0820)                     0x242  || 			move_left_end:
(0821)  CS-0x242  0x12F00         || 			ASR r15
(0822)  CS-0x243  0x0B318         || 			BRCS move_up
(0823)                     0x244  || 			move_up_end:
(0824)  CS-0x244  0x12F00         || 			ASR r15
(0825)  CS-0x245  0x0B360         || 			BRCS move_down
(0826)                     0x246  || 			move_down_end:
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0827)                            || 
(0828)  CS-0x246  0x370AA         || 			MOV r16, For_Count
(0829)  CS-0x247  0x2D001  0x247  || 	delay0:		SUB r16, 0x01
(0830)  CS-0x248  0x371AA         || 				MOV r17, For_Count
(0831)  CS-0x249  0x2D101  0x249  || 		delay1: 	SUB r17, 0x01
(0832)  CS-0x24A  0x372AA         || 					MOV r18, For_Count
(0833)  CS-0x24B  0x2D201  0x24B  || 			delay2: 	SUB r18, 0x01
(0834)  CS-0x24C  0x0925B         || 						BRNE delay2
(0835)  CS-0x24D  0x0924B         || 					BRNE delay1
(0836)  CS-0x24E  0x0923B         || 				BRNE delay0
(0837)                            || 
(0838)                            || =======
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0839)                            || 			
(0840)  CS-0x24F  0x18002         || 			RET
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0841)                            || 
(0842)                     0x250  || move_right:
(0843)                            || 		
(0844)                            || 		;maze boundary check
(0845)  CS-0x250  0x30826         || 		CMP	   r8, 0x26
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0846)  CS-0x251  0x09202         || 		BREQ	move_right_end
(0847)                            || =======
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0848)  CS-0x252  0x30827         || 		CMP	   r8,0x27
(0849)                            || 		BREQ   RET
            syntax error

(0850)                            || 		
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0851)  CS-0x253  0x093B1         || 		CALL	draw_at_prev_loc
(0852)                            || 
(0853)                            || 		;draw pixel at new location
(0854)  CS-0x254  0x28B01         || 		ADD	   r11, 0x01
(0855)  CS-0x255  0x04751         || 		MOV    r7, r10
(0856)  CS-0x256  0x04859         || 		MOV    r8, r11
(0857)  CS-0x257  0x366F8         || 		MOV    r6, M_YELLOW
(0858)  CS-0x258  0x08161         || 		CALL   draw_dot
(0859)                            || 
(0860)  CS-0x259  0x09200         || 		BRN move_right_end
(0861)                            || 
(0862)                     0x25A  || move_left:
(0863)                            || 		
(0864)                            || 		;maze boundary check
(0865)  CS-0x25A  0x30801         || 		CMP	   r8, 0x01
(0866)  CS-0x25B  0x09212         || 		BREQ	move_left_end
(0867)                            || 		
(0868)  CS-0x25C  0x093B1         || 		CALL	draw_at_prev_loc
(0869)                            || 
(0870)                            || 		;draw pixel at new location
(0871)  CS-0x25D  0x2CB01         || 		SUB	   r11, 0x01
(0872)  CS-0x25E  0x04751         || 		MOV    r7, r10
(0873)  CS-0x25F  0x04859         || 		MOV    r8, r11
(0874)  CS-0x260  0x366F8         || 		MOV    r6, M_YELLOW
(0875)  CS-0x261  0x08161         || 		CALL   draw_dot
(0876)                            || 
(0877)  CS-0x262  0x09210         || 		BRN move_left_end
(0878)                            || 
(0879)                     0x263  || move_up:
(0880)                            || 		
(0881)                            || 		;maze boundary check
(0882)  CS-0x263  0x30701         || 		CMP	   r7, 0x01
(0883)  CS-0x264  0x09222         || 		BREQ	move_up_end
(0884)                            || 		
(0885)  CS-0x265  0x093B1         || 		CALL	draw_at_prev_loc
(0886)                            || 
(0887)                            || 		;draw pixel at new location
(0888)  CS-0x266  0x28A01         || 		ADD	   r10, 0x01
(0889)  CS-0x267  0x04751         || 		MOV    r7, r10
(0890)  CS-0x268  0x04859         || 		MOV    r8, r11
(0891)  CS-0x269  0x366F8         || 		MOV    r6, M_YELLOW
(0892)  CS-0x26A  0x08161         || 		CALL   draw_dot
(0893)                            || 
(0894)  CS-0x26B  0x09220         || 		BRN move_up_end
(0895)                            || 
(0896)                     0x26C  || move_down:
(0897)                            || 		
(0898)                            || 		;maze boundary check
(0899)  CS-0x26C  0x3071B         || 		CMP	   r7, 0x1b
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0900)  CS-0x26D  0x09232         || 		BREQ	move_down_end
(0901)                            || =======
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0902)  CS-0x26E  0x3071C         || 		CMP	   r7, 0x1C
(0903)                            || 		BREQ	RET
            syntax error

(0904)                            || 		
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error
            syntax error

(0905)  CS-0x26F  0x093B1         || 		CALL	draw_at_prev_loc
(0906)                            || 
(0907)                            || 		;draw pixel at new location
(0908)  CS-0x270  0x2CA01         || 		SUB	   r10, 0x01
(0909)  CS-0x271  0x04751         || 		MOV    r7, r10
(0910)  CS-0x272  0x04859         || 		MOV    r8, r11
(0911)  CS-0x273  0x366F8         ||         MOV    r6, M_YELLOW
(0912)  CS-0x274  0x08161         || 		CALL   draw_dot
(0913)                            || 
(0914)  CS-0x275  0x09230         || 		BRN move_down_end
(0915)                            || 
(0916)                     0x276  || draw_at_prev_loc:
(0917)  CS-0x276  0x04751         || 		MOV    r7, r10
(0918)  CS-0x277  0x04859         || 		MOV    r8, r11
(0919)  CS-0x278  0x366FF         || 		MOV    r6, BG_COLOR
(0920)  CS-0x279  0x08161         || 		CALL   draw_dot
(0921)  CS-0x27A  0x18002         || 		RET
(0922)                            || 





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
DD_ADD40       0x038   (0158)  ||  0148 
DD_ADD80       0x03B   (0162)  ||  0151 
DD_OUT         0x034   (0153)  ||  0163 
DELAY0         0x247   (0829)  ||  0836 
DELAY1         0x249   (0831)  ||  0835 
DELAY2         0x24B   (0833)  ||  0834 
DRAW_AT_PREV_LOC 0x276   (0916)  ||  0851 0868 0885 0905 
DRAW_BACKGROUND 0x022   (0115)  ||  0026 
DRAW_BLOCK     0x232   (0793)  ||  0042 
DRAW_DOT       0x02C   (0141)  ||  0072 0098 0805 0858 0875 0892 0912 0920 
DRAW_HORIZ1    0x017   (0071)  ||  0075 
DRAW_HORIZONTAL_LINE 0x016   (0068)  ||  0122 0171 0186 0196 0201 0206 0211 0216 0251 0276 
                               ||  0281 0286 0316 0321 0326 0331 0356 0361 0366 0371 
                               ||  0396 0401 0406 0431 0436 0441 0471 0476 0481 0486 
                               ||  0501 0506 0511 0531 0536 0541 0566 0571 0576 0581 
                               ||  0586 0606 0611 0631 0636 0641 0646 0681 0686 0691 
                               ||  0696 0701 0716 0721 0726 0746 0751 0756 0761 0781 
DRAW_MAZE      0x03D   (0165)  ||  0041 
DRAW_VERT1     0x01D   (0097)  ||  0101 
DRAW_VERTICAL_LINE 0x01C   (0094)  ||  0176 0181 0191 0221 0226 0231 0236 0241 0246 0256 
                               ||  0261 0266 0271 0291 0296 0301 0306 0311 0336 0341 
                               ||  0346 0351 0376 0381 0386 0391 0411 0416 0421 0426 
                               ||  0446 0451 0456 0461 0466 0491 0496 0516 0521 0526 
                               ||  0546 0551 0556 0561 0591 0596 0601 0616 0621 0626 
                               ||  0651 0656 0661 0666 0671 0676 0706 0711 0731 0736 
                               ||  0741 0766 0771 0776 0786 0791 
INIT           0x010   (0025)  ||  
MAIN           0x013   (0044)  ||  0050 
MOVE_BLOCK     0x23D   (0809)  ||  0048 
MOVE_DOWN      0x26C   (0896)  ||  0825 
MOVE_DOWN_END  0x246   (0826)  ||  0900 0914 
MOVE_LEFT      0x25A   (0862)  ||  0819 
MOVE_LEFT_END  0x242   (0820)  ||  0866 0877 
MOVE_RIGHT     0x250   (0842)  ||  0816 
MOVE_RIGHT_END 0x240   (0817)  ||  0846 0860 
MOVE_UP        0x263   (0879)  ||  0822 
MOVE_UP_END    0x244   (0823)  ||  0883 0894 
START          0x024   (0118)  ||  0125 
T1             0x032   (0150)  ||  0160 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0010)  ||  0116 0919 
BUTTON         0x09A   (0018)  ||  0809 
FOR_COUNT      0x0AA   (0019)  ||  0828 0830 0832 
LEDS           0x040   (0008)  ||  
M_BLACK        0x000   (0015)  ||  0166 
M_BLUE         0x013   (0014)  ||  
M_BROWN        0x090   (0016)  ||  
M_RED          0x0E0   (0013)  ||  
M_YELLOW       0x0F8   (0012)  ||  0793 0857 0874 0891 0911 
SSEG           0x081   (0007)  ||  
VGA_COLOR      0x092   (0006)  ||  0155 
VGA_HADD       0x090   (0004)  ||  0154 
VGA_LADD       0x091   (0005)  ||  0153 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
