

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


(0001)                            || ;---------------------------------------------------------------------
(0002)                            || ; An expanded "draw_dot" program that includes subrountines to draw
(0003)                            || ; vertical lines, horizontal lines, and a full background. 
(0004)                            || ; 
(0005)                            || ; As written, this programs does the following: 
(0006)                            || ;   1) draws a the background blue (draws all the tiles)
(0007)                            || ;   2) draws a red dot
(0008)                            || ;   3) draws a red horizontal lines
(0009)                            || ;   4) draws a red vertical line
(0010)                            || ;
(0011)                            || ; Author: Bridget Benson 
(0012)                            || ; Modifications: bryan mealy
(0013)                            || ;---------------------------------------------------------------------
(0014)                            || 
(0015)                            || .CSEG
(0016)                       016  || .ORG 0x10
(0017)                            || 
(0018)                       144  || .EQU VGA_HADD = 0x90
(0019)                       145  || .EQU VGA_LADD = 0x91
(0020)                       146  || .EQU VGA_COLOR = 0x92
(0021)                       129  || .EQU SSEG = 0x81
(0022)                       064  || .EQU LEDS = 0x40
(0023)                            || 
(0024)                       255  || .EQU BG_COLOR       = 0xFF             ; Background:  white
(0025)                            || 
(0026)                            || 
(0027)                       248  || .EQU M_YELLOW		= 0xF8
(0028)                       224  || .EQU M_RED			= 0xE0
(0029)                       019  || .EQU M_BLUE			= 0x13
(0030)                       000  || .EQU M_BLACK		= 0x00
(0031)                       144  || .EQU M_BROWN		= 0x90
(0032)                            || 
(0033)                            || ;r6 is used for color
(0034)                            || ;r7 is used for Y
(0035)                            || ;r8 is used for X
(0036)                            || 
(0037)                            || ;---------------------------------------------------------------------
(0038)                     0x010  || init:
(0039)  CS-0x010  0x08101         ||          CALL   draw_background         ; draw using default color
(0040)                            || 
(0041)                            ||          ;MOV    r7, 0x0F                ; generic Y coordinate
(0042)                            ||          ;MOV    r8, 0x14                ; generic X coordinate
(0043)                            ||          ;MOV    r6, 0xE0                ; color
(0044)                            ||          ;CALL   draw_dot                ; draw red pixel 
(0045)                            || 
(0046)                            ||          ;MOV    r8,0x01                 ; starting x coordinate
(0047)                            ||          ;MOV    r7,0x12                 ; start y coordinate
(0048)                            ||          ;MOV    r9,0x26                 ; ending x coordinate
(0049)                            ||          ;CALL   draw_horizontal_line
(0050)                            || 
(0051)                            ||          ;MOV    r8,0x08                 ; starting x coordinate
(0052)                            ||          ;MOV    r7,0x04                 ; start y coordinate
(0053)                            ||          ;MOV    r9,0x17                 ; ending x coordinate
(0054)                            ||          ;CALL   draw_vertical_line
(0055)                            ||       
(0056)  CS-0x011  0x081D9         || 		CALL	draw_mario
(0057)                            || 		
(0058)  CS-0x012  0x00000  0x012  || main:   AND    r0, r0                  ; nop
(0059)                            || 		
(0060)                            || 
(0061)  CS-0x013  0x08090         ||         BRN    main                    ; continuous loop 
(0062)                            || ;--------------------------------------------------------------------
(0063)                            || 
(0064)                            ||    
(0065)                            || ;--------------------------------------------------------------------
(0066)                            || ;-  Subroutine: draw_horizontal_line
(0067)                            || ;-
(0068)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0069)                            || ;-
(0070)                            || ;-  Parameters:
(0071)                            || ;-   r8  = starting x-coordinate
(0072)                            || ;-   r7  = y-coordinate
(0073)                            || ;-   r9  = ending x-coordinate
(0074)                            || ;-   r6  = color used for line
(0075)                            || ;- 
(0076)                            || ;- Tweaked registers: r8,r9
(0077)                            || ;--------------------------------------------------------------------
(0078)                     0x014  || draw_horizontal_line:
(0079)  CS-0x014  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0080)                            || 
(0081)                     0x015  || draw_horiz1:
(0082)  CS-0x015  0x08151         ||         CALL   draw_dot         ; 
(0083)  CS-0x016  0x28801         ||         ADD    r8,0x01
(0084)  CS-0x017  0x04848         ||         CMP    r8,r9
(0085)  CS-0x018  0x080AB         ||         BRNE   draw_horiz1
(0086)  CS-0x019  0x18002         ||         RET
(0087)                            || ;--------------------------------------------------------------------
(0088)                            || 
(0089)                            || 
(0090)                            || ;---------------------------------------------------------------------
(0091)                            || ;-  Subroutine: draw_vertical_line
(0092)                            || ;-
(0093)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0094)                            || ;-
(0095)                            || ;-  Parameters:
(0096)                            || ;-   r8  = x-coordinate
(0097)                            || ;-   r7  = starting y-coordinate
(0098)                            || ;-   r9  = ending y-coordinate
(0099)                            || ;-   r6  = color used for line
(0100)                            || ;- 
(0101)                            || ;- Tweaked registers: r7,r9
(0102)                            || ;--------------------------------------------------------------------
(0103)                     0x01A  || draw_vertical_line:
(0104)  CS-0x01A  0x28901         ||          ADD    r9,0x01
(0105)                            || 
(0106)                     0x01B  || draw_vert1:          
(0107)  CS-0x01B  0x08151         ||          CALL   draw_dot
(0108)  CS-0x01C  0x28701         ||          ADD    r7,0x01
(0109)  CS-0x01D  0x04748         ||          CMP    r7,R9
(0110)  CS-0x01E  0x080DB         ||          BRNE   draw_vert1
(0111)  CS-0x01F  0x18002         ||          RET
(0112)                            || ;--------------------------------------------------------------------
(0113)                            || 
(0114)                            || ;---------------------------------------------------------------------
(0115)                            || ;-  Subroutine: draw_background
(0116)                            || ;-
(0117)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0118)                            || ;-  draw_horizontal_line subroutine. 
(0119)                            || ;- 
(0120)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0121)                            || ;----------------------------------------------------------------------
(0122)                     0x020  || draw_background: 
(0123)  CS-0x020  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0124)  CS-0x021  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0125)  CS-0x022  0x04769  0x022  || start:   MOV   r7,r13                   ; load current row count 
(0126)  CS-0x023  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0127)  CS-0x024  0x36927         ||          MOV   r9,0x27 
(0128)                            ||  
(0129)  CS-0x025  0x080A1         ||          CALL  draw_horizontal_line
(0130)  CS-0x026  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0131)  CS-0x027  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0132)  CS-0x028  0x08113         ||          BRNE  start                    ; branch to draw more rows
(0133)  CS-0x029  0x18002         ||          RET
(0134)                            || ;---------------------------------------------------------------------
(0135)                            ||     
(0136)                            || ;---------------------------------------------------------------------
(0137)                            || ;- Subrountine: draw_dot
(0138)                            || ;- 
(0139)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0140)                            || ;- 
(0141)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0142)                            || ;- 
(0143)                            || ;- Tweaked registers: r4,r5
(0144)                            || ;---------------------------------------------------------------------
(0145)                     0x02A  || draw_dot: 
(0146)  CS-0x02A  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0147)  CS-0x02B  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0148)                            || 
(0149)  CS-0x02C  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0150)  CS-0x02D  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0151)  CS-0x02E  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0152)  CS-0x02F  0x0A1B0         ||            BRCS  dd_add40
(0153)  CS-0x030  0x10401  0x030  || t1:        LSR   r4
(0154)  CS-0x031  0x0A1C8         ||            BRCS  dd_add80
(0155)                            || 
(0156)  CS-0x032  0x34591  0x032  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0157)  CS-0x033  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0158)  CS-0x034  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0159)  CS-0x035  0x18002         ||            RET
(0160)                            || 
(0161)  CS-0x036  0x22540  0x036  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0162)  CS-0x037  0x18000         ||            CLC                  ; freshen bit
(0163)  CS-0x038  0x08180         ||            BRN   t1             
(0164)                            || 
(0165)  CS-0x039  0x22580  0x039  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0166)  CS-0x03A  0x08190         ||            BRN   dd_out
(0167)                            || ; --------------------------------------------------------------------
(0168)                     0x03B  || draw_mario:
(0169)                            || 		;red
(0170)  CS-0x03B  0x366E0         || 		MOV    r6, M_RED
(0171)                            || 
(0172)  CS-0x03C  0x36811         || 		MOV    r8,0x11                 ; starting x coordinate
(0173)  CS-0x03D  0x36705         ||         MOV    r7,0x05                 ; start y coordinate
(0174)  CS-0x03E  0x36915         ||         MOV    r9,0x15                 ; ending x coordinate
(0175)  CS-0x03F  0x080A1         ||         CALL   draw_horizontal_line
(0176)                            || 
(0177)  CS-0x040  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0178)  CS-0x041  0x36706         ||         MOV    r7,0x06                 ; start y coordinate
(0179)  CS-0x042  0x36918         ||         MOV    r9,0x18                 ; ending x coordinate
(0180)  CS-0x043  0x080A1         ||         CALL   draw_horizontal_line
(0181)                            || 
(0182)  CS-0x044  0x36818         || 		MOV    r8,0x18                 ; starting x coordinate
(0183)  CS-0x045  0x36707         ||         MOV    r7,0x07                 ; start y coordinate
(0184)  CS-0x046  0x3691A         ||         MOV    r9,0x1a                 ; ending x coordinate
(0185)  CS-0x047  0x080A1         ||         CALL   draw_horizontal_line
(0186)                            || 
(0187)  CS-0x048  0x36819         || 		MOV    r8,0x19                 ; starting x coordinate
(0188)  CS-0x049  0x36708         ||         MOV    r7,0x08                 ; start y coordinate
(0189)  CS-0x04A  0x3691A         ||         MOV    r9,0x1a                 ; ending x coordinate
(0190)  CS-0x04B  0x080A1         ||         CALL   draw_horizontal_line
(0191)                            || 
(0192)  CS-0x04C  0x3681A         || 		MOV    r8, 0x1a                ; X coordinate
(0193)  CS-0x04D  0x36709         || 		MOV    r7, 0x09                ; Y coordinate
(0194)  CS-0x04E  0x08151         ||         CALL   draw_dot                ; draw pixel
(0195)                            || 
(0196)  CS-0x04F  0x36819         || 		MOV    r8, 0x19                ; X coordinate
(0197)  CS-0x050  0x3670A         || 		MOV    r7, 0x0a                ; Y coordinate
(0198)  CS-0x051  0x08151         ||         CALL   draw_dot                ; draw pixel
(0199)                            || 
(0200)  CS-0x052  0x36818         || 		MOV    r8,0x18                 ; starting x coordinate
(0201)  CS-0x053  0x3670B         ||         MOV    r7,0x0b                 ; start y coordinate
(0202)  CS-0x054  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0203)  CS-0x055  0x080A1         ||         CALL   draw_horizontal_line
(0204)                            || 
(0205)  CS-0x056  0x3680E         || 		MOV    r8,0x0e                 ; starting x coordinate
(0206)  CS-0x057  0x3670C         ||         MOV    r7,0x0c                 ; start y coordinate
(0207)  CS-0x058  0x36918         ||         MOV    r9,0x18                 ; ending x coordinate
(0208)  CS-0x059  0x080A1         ||         CALL   draw_horizontal_line
(0209)                            || 
(0210)  CS-0x05A  0x3680E         || 		MOV    r8,0x0e                 ; starting x coordinate
(0211)  CS-0x05B  0x3670D         ||         MOV    r7,0x0d                 ; start y coordinate
(0212)  CS-0x05C  0x36916         ||         MOV    r9,0x16                 ; ending x coordinate
(0213)  CS-0x05D  0x080A1         ||         CALL   draw_horizontal_line
(0214)                            || 
(0215)  CS-0x05E  0x3680F         || 		MOV    r8,0x0f                 ; starting x coordinate
(0216)  CS-0x05F  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0217)  CS-0x060  0x36912         ||         MOV    r9,0x12                 ; ending x coordinate
(0218)  CS-0x061  0x080A1         ||         CALL   draw_horizontal_line
(0219)                            || 
(0220)                            || 		;yellow
(0221)  CS-0x062  0x366F8         || 		MOV    r6, M_YELLOW
(0222)                            || 
(0223)  CS-0x063  0x36818         || 		MOV    r8,0x18                 ; starting x coordinate
(0224)  CS-0x064  0x36705         ||         MOV    r7,0x05                 ; start y coordinate
(0225)  CS-0x065  0x3691A         ||         MOV    r9,0x1a                 ; ending x coordinate
(0226)  CS-0x066  0x080A1         ||         CALL   draw_horizontal_line
(0227)                            || 
(0228)  CS-0x067  0x36819         || 		MOV    r8,0x19                 ; starting x coordinate
(0229)  CS-0x068  0x36706         ||         MOV    r7,0x06                 ; start y coordinate
(0230)  CS-0x069  0x3691A         ||         MOV    r9,0x1a                 ; ending x coordinate
(0231)  CS-0x06A  0x080A1         ||         CALL   draw_horizontal_line
(0232)                            || 
(0233)  CS-0x06B  0x36813         || 		MOV    r8,0x13                 ; starting x coordinate
(0234)  CS-0x06C  0x36707         ||         MOV    r7,0x07                 ; start y coordinate
(0235)  CS-0x06D  0x36916         ||         MOV    r9,0x16                 ; ending x coordinate
(0236)  CS-0x06E  0x080A1         ||         CALL   draw_horizontal_line
(0237)                            || 
(0238)  CS-0x06F  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0239)  CS-0x070  0x36708         ||         MOV    r7,0x08                 ; start y coordinate
(0240)  CS-0x071  0x36918         ||         MOV    r9,0x18                 ; ending x coordinate
(0241)  CS-0x072  0x080A1         ||         CALL   draw_horizontal_line
(0242)                            || 
(0243)  CS-0x073  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0244)  CS-0x074  0x36709         ||         MOV    r7,0x09                 ; start y coordinate
(0245)  CS-0x075  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0246)  CS-0x076  0x080A1         ||         CALL   draw_horizontal_line
(0247)                            || 
(0248)  CS-0x077  0x36811         || 		MOV    r8,0x11                 ; starting x coordinate
(0249)  CS-0x078  0x3670A         ||         MOV    r7,0x0a                 ; start y coordinate
(0250)  CS-0x079  0x36914         ||         MOV    r9,0x14                 ; ending x coordinate
(0251)  CS-0x07A  0x080A1         ||         CALL   draw_horizontal_line
(0252)                            || 
(0253)  CS-0x07B  0x36811         || 		MOV    r8,0x11                 ; starting x coordinate
(0254)  CS-0x07C  0x3670B         ||         MOV    r7,0x0b                 ; start y coordinate
(0255)  CS-0x07D  0x36917         ||         MOV    r9,0x17                 ; ending x coordinate
(0256)  CS-0x07E  0x080A1         ||         CALL   draw_horizontal_line
(0257)                            || 
(0258)  CS-0x07F  0x3680C         || 		MOV    r8,0x0c                 ; starting x coordinate
(0259)  CS-0x080  0x3670C         ||         MOV    r7,0x0c                 ; start y coordinate
(0260)  CS-0x081  0x3690D         ||         MOV    r9,0x0d                 ; ending x coordinate
(0261)  CS-0x082  0x080A1         ||         CALL   draw_horizontal_line
(0262)                            || 
(0263)  CS-0x083  0x3680C         || 		MOV    r8,0x0c                 ; starting x coordinate
(0264)  CS-0x084  0x3670D         ||         MOV    r7,0x0d                 ; start y coordinate
(0265)  CS-0x085  0x3690D         ||         MOV    r9,0x0d                 ; ending x coordinate
(0266)  CS-0x086  0x080A1         ||         CALL   draw_horizontal_line
(0267)                            || 
(0268)  CS-0x087  0x3680D         || 		MOV    r8,0x0d                 ; starting x coordinate
(0269)  CS-0x088  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0270)  CS-0x089  0x3690E         ||         MOV    r9,0x0e                 ; ending x coordinate
(0271)  CS-0x08A  0x080A1         ||         CALL   draw_horizontal_line
(0272)                            || 
(0273)  CS-0x08B  0x36814         || 		MOV    r8,0x14                 ; starting x coordinate
(0274)  CS-0x08C  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0275)  CS-0x08D  0x36917         ||         MOV    r9,0x17                 ; ending x coordinate
(0276)  CS-0x08E  0x080A1         ||         CALL   draw_horizontal_line
(0277)                            || 
(0278)                            || 		;blue
(0279)  CS-0x08F  0x36613         || 		MOV    r6, M_BLUE
(0280)                            || 
(0281)  CS-0x090  0x36812         || 		MOV    r8, 0x12                ; X coordinate
(0282)  CS-0x091  0x3670C         || 		MOV    r7, 0x0c                ; Y coordinate
(0283)  CS-0x092  0x08151         ||         CALL   draw_dot                ; draw pixel
(0284)                            || 
(0285)  CS-0x093  0x36816         || 		MOV    r8, 0x16                ; X coordinate
(0286)  CS-0x094  0x3670C         || 		MOV    r7, 0x0c                ; Y coordinate
(0287)  CS-0x095  0x08151         ||         CALL   draw_dot                ; draw pixel
(0288)                            || 
(0289)  CS-0x096  0x36813         || 		MOV    r8, 0x13                ; X coordinate
(0290)  CS-0x097  0x3670D         || 		MOV    r7, 0x0d                ; Y coordinate
(0291)  CS-0x098  0x08151         ||         CALL   draw_dot                ; draw pixel
(0292)                            || 
(0293)  CS-0x099  0x36817         || 		MOV    r8, 0x17                ; X coordinate
(0294)  CS-0x09A  0x3670D         || 		MOV    r7, 0x0d                ; Y coordinate
(0295)  CS-0x09B  0x08151         ||         CALL   draw_dot                ; draw pixel
(0296)                            || 
(0297)  CS-0x09C  0x36813         || 		MOV    r8, 0x13                ; X coordinate
(0298)  CS-0x09D  0x3670E         || 		MOV    r7, 0x0e                ; Y coordinate
(0299)  CS-0x09E  0x08151         ||         CALL   draw_dot                ; draw pixel
(0300)                            || 
(0301)  CS-0x09F  0x36815         || 		MOV    r8,0x15                 ; starting x coordinate
(0302)  CS-0x0A0  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0303)  CS-0x0A1  0x36916         ||         MOV    r9,0x16                 ; ending x coordinate
(0304)  CS-0x0A2  0x080A1         ||         CALL   draw_horizontal_line
(0305)                            || 
(0306)  CS-0x0A3  0x36818         || 		MOV    r8,0x18                 ; starting x coordinate
(0307)  CS-0x0A4  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0308)  CS-0x0A5  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0309)  CS-0x0A6  0x080A1         ||         CALL   draw_horizontal_line
(0310)                            || 
(0311)  CS-0x0A7  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0312)  CS-0x0A8  0x3670F         ||         MOV    r7,0x0f                 ; start y coordinate
(0313)  CS-0x0A9  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0314)  CS-0x0AA  0x080A1         ||         CALL   draw_horizontal_line
(0315)                            || 
(0316)  CS-0x0AB  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0317)  CS-0x0AC  0x36710         ||         MOV    r7,0x10                 ; start y coordinate
(0318)  CS-0x0AD  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0319)  CS-0x0AE  0x080A1         ||         CALL   draw_horizontal_line
(0320)                            || 
(0321)  CS-0x0AF  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0322)  CS-0x0B0  0x36711         ||         MOV    r7,0x11                 ; start y coordinate
(0323)  CS-0x0B1  0x36915         ||         MOV    r9,0x15                 ; ending x coordinate
(0324)  CS-0x0B2  0x080A1         ||         CALL   draw_horizontal_line
(0325)                            || 
(0326)                            || 		;brown
(0327)  CS-0x0B3  0x36690         || 		MOV    r6, M_BROWN
(0328)                            || 
(0329)  CS-0x0B4  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0330)  CS-0x0B5  0x36707         ||         MOV    r7,0x07                 ; start y coordinate
(0331)  CS-0x0B6  0x36912         ||         MOV    r9,0x12                 ; ending x coordinate
(0332)  CS-0x0B7  0x080A1         ||         CALL   draw_horizontal_line
(0333)                            || 
(0334)  CS-0x0B8  0x3680F         || 		MOV    r8,0x0f                 ; starting x coordinate
(0335)  CS-0x0B9  0x36708         ||         MOV    r7,0x08                 ; start y coordinate
(0336)  CS-0x0BA  0x36909         ||         MOV    r9,0x09                 ; ending x coordinate
(0337)  CS-0x0BB  0x080D1         ||         CALL   draw_vertical_line
(0338)                            || 
(0339)  CS-0x0BC  0x36811         || 		MOV    r8,0x11                 ; starting x coordinate
(0340)  CS-0x0BD  0x36708         ||         MOV    r7,0x08                 ; start y coordinate
(0341)  CS-0x0BE  0x36909         ||         MOV    r9,0x09                 ; ending x coordinate
(0342)  CS-0x0BF  0x080D1         ||         CALL   draw_vertical_line
(0343)                            || 
(0344)  CS-0x0C0  0x36812         || 		MOV    r8, 0x12                ; X coordinate
(0345)  CS-0x0C1  0x36709         || 		MOV    r7, 0x09                ; Y coordinate
(0346)  CS-0x0C2  0x08151         ||         CALL   draw_dot                ; draw pixel
(0347)                            || 
(0348)  CS-0x0C3  0x36810         || 		MOV    r8, 0x10                ; X coordinate
(0349)  CS-0x0C4  0x3670A         || 		MOV    r7, 0x0a                ; Y coordinate
(0350)  CS-0x0C5  0x08151         ||         CALL   draw_dot                ; draw pixel
(0351)                            || 
(0352)  CS-0x0C6  0x3680E         || 		MOV    r8,0x0e                 ; starting x coordinate
(0353)  CS-0x0C7  0x36710         ||         MOV    r7,0x10                 ; start y coordinate
(0354)  CS-0x0C8  0x36913         ||         MOV    r9,0x13                 ; ending x coordinate
(0355)  CS-0x0C9  0x080D1         ||         CALL   draw_vertical_line
(0356)                            || 
(0357)  CS-0x0CA  0x3680F         || 		MOV    r8,0x0f                 ; starting x coordinate
(0358)  CS-0x0CB  0x36710         ||         MOV    r7,0x10                 ; start y coordinate
(0359)  CS-0x0CC  0x36912         ||         MOV    r9,0x12                 ; ending x coordinate
(0360)  CS-0x0CD  0x080D1         ||         CALL   draw_vertical_line
(0361)                            || 
(0362)  CS-0x0CE  0x3681A         || 		MOV    r8,0x1a                 ; starting x coordinate
(0363)  CS-0x0CF  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0364)  CS-0x0D0  0x36911         ||         MOV    r9,0x11                 ; ending x coordinate
(0365)  CS-0x0D1  0x080D1         ||         CALL   draw_vertical_line
(0366)                            || 
(0367)  CS-0x0D2  0x3681B         || 		MOV    r8,0x1b                 ; starting x coordinate
(0368)  CS-0x0D3  0x3670D         ||         MOV    r7,0x0d                 ; start y coordinate
(0369)  CS-0x0D4  0x36911         ||         MOV    r9,0x11                 ; ending x coordinate
(0370)  CS-0x0D5  0x080D1         ||         CALL   draw_vertical_line
(0371)                            || 
(0372)                            || 		;black
(0373)  CS-0x0D6  0x36600         || 		MOV    r6, M_BLACK
(0374)                            || 
(0375)  CS-0x0D7  0x36815         || 		MOV    r8,0x15                 ; starting x coordinate
(0376)  CS-0x0D8  0x36707         ||         MOV    r7,0x07                 ; start y coordinate
(0377)  CS-0x0D9  0x36908         ||         MOV    r9,0x08                 ; ending x coordinate
(0378)  CS-0x0DA  0x080D1         ||         CALL   draw_vertical_line
(0379)                            || 
(0380)  CS-0x0DB  0x36816         || 		MOV    r8, 0x16                ; X coordinate
(0381)  CS-0x0DC  0x36709         || 		MOV    r7, 0x09                ; Y coordinate
(0382)  CS-0x0DD  0x08151         ||         CALL   draw_dot                ; draw pixel
(0383)                            || 
(0384)  CS-0x0DE  0x36815         || 		MOV    r8,0x15                 ; starting x coordinate
(0385)  CS-0x0DF  0x3670A         ||         MOV    r7,0x0a                 ; start y coordinate
(0386)  CS-0x0E0  0x36918         ||         MOV    r9,0x18                 ; ending x coordinate
(0387)  CS-0x0E1  0x080A1         ||         CALL   draw_horizontal_line
(0388)                            || 		
(0389)  CS-0x0E2  0x18002         || 		RET





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
DD_ADD40       0x036   (0161)  ||  0152 
DD_ADD80       0x039   (0165)  ||  0154 
DD_OUT         0x032   (0156)  ||  0166 
DRAW_BACKGROUND 0x020   (0122)  ||  0039 
DRAW_DOT       0x02A   (0145)  ||  0082 0107 0194 0198 0283 0287 0291 0295 0299 0346 
                               ||  0350 0382 
DRAW_HORIZ1    0x015   (0081)  ||  0085 
DRAW_HORIZONTAL_LINE 0x014   (0078)  ||  0129 0175 0180 0185 0190 0203 0208 0213 0218 0226 
                               ||  0231 0236 0241 0246 0251 0256 0261 0266 0271 0276 
                               ||  0304 0309 0314 0319 0324 0332 0387 
DRAW_MARIO     0x03B   (0168)  ||  0056 
DRAW_VERT1     0x01B   (0106)  ||  0110 
DRAW_VERTICAL_LINE 0x01A   (0103)  ||  0337 0342 0355 0360 0365 0370 0378 
INIT           0x010   (0038)  ||  
MAIN           0x012   (0058)  ||  0061 
START          0x022   (0125)  ||  0132 
T1             0x030   (0153)  ||  0163 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0024)  ||  0123 
LEDS           0x040   (0022)  ||  
M_BLACK        0x000   (0030)  ||  0373 
M_BLUE         0x013   (0029)  ||  0279 
M_BROWN        0x090   (0031)  ||  0327 
M_RED          0x0E0   (0028)  ||  0170 
M_YELLOW       0x0F8   (0027)  ||  0221 
SSEG           0x081   (0021)  ||  
VGA_COLOR      0x092   (0020)  ||  0158 
VGA_HADD       0x090   (0018)  ||  0157 
VGA_LADD       0x091   (0019)  ||  0156 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
