

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
(0039)  CS-0x010  0x08649         ||          CALL   draw_background         ; draw using default color
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
(0056)  CS-0x011  0x00000  0x011  || main:   AND    r0, r0                  ; nop
(0057)                            || 		
(0058)                            || 		;red
(0059)  CS-0x012  0x366E0         || 		MOV    r6, M_RED
(0060)                            || 
(0061)  CS-0x013  0x36811         || 		MOV    r8,0x11                 ; starting x coordinate
(0062)  CS-0x014  0x36705         ||         MOV    r7,0x05                 ; start y coordinate
(0063)  CS-0x015  0x36915         ||         MOV    r9,0x15                 ; ending x coordinate
(0064)  CS-0x016  0x085E9         ||         CALL   draw_horizontal_line
(0065)                            || 
(0066)  CS-0x017  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0067)  CS-0x018  0x36706         ||         MOV    r7,0x06                 ; start y coordinate
(0068)  CS-0x019  0x36918         ||         MOV    r9,0x18                 ; ending x coordinate
(0069)  CS-0x01A  0x085E9         ||         CALL   draw_horizontal_line
(0070)                            || 
(0071)  CS-0x01B  0x36818         || 		MOV    r8,0x18                 ; starting x coordinate
(0072)  CS-0x01C  0x36707         ||         MOV    r7,0x07                 ; start y coordinate
(0073)  CS-0x01D  0x3691A         ||         MOV    r9,0x1a                 ; ending x coordinate
(0074)  CS-0x01E  0x085E9         ||         CALL   draw_horizontal_line
(0075)                            || 
(0076)  CS-0x01F  0x36819         || 		MOV    r8,0x19                 ; starting x coordinate
(0077)  CS-0x020  0x36708         ||         MOV    r7,0x08                 ; start y coordinate
(0078)  CS-0x021  0x3691A         ||         MOV    r9,0x1a                 ; ending x coordinate
(0079)  CS-0x022  0x085E9         ||         CALL   draw_horizontal_line
(0080)                            || 
(0081)  CS-0x023  0x3681A         || 		MOV    r8, 0x1a                ; X coordinate
(0082)  CS-0x024  0x36709         || 		MOV    r7, 0x09                ; Y coordinate
(0083)  CS-0x025  0x08699         ||         CALL   draw_dot                ; draw pixel
(0084)                            || 
(0085)  CS-0x026  0x36819         || 		MOV    r8, 0x19                ; X coordinate
(0086)  CS-0x027  0x3670A         || 		MOV    r7, 0x0a                ; Y coordinate
(0087)  CS-0x028  0x08699         ||         CALL   draw_dot                ; draw pixel
(0088)                            || 
(0089)  CS-0x029  0x36818         || 		MOV    r8,0x18                 ; starting x coordinate
(0090)  CS-0x02A  0x36711         ||         MOV    r7,0x11                 ; start y coordinate
(0091)  CS-0x02B  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0092)  CS-0x02C  0x085E9         ||         CALL   draw_horizontal_line
(0093)                            || 
(0094)  CS-0x02D  0x3680E         || 		MOV    r8,0x0e                 ; starting x coordinate
(0095)  CS-0x02E  0x3670C         ||         MOV    r7,0x0c                 ; start y coordinate
(0096)  CS-0x02F  0x36918         ||         MOV    r9,0x18                 ; ending x coordinate
(0097)  CS-0x030  0x085E9         ||         CALL   draw_horizontal_line
(0098)                            || 
(0099)  CS-0x031  0x3680E         || 		MOV    r8,0x0e                 ; starting x coordinate
(0100)  CS-0x032  0x3670D         ||         MOV    r7,0x0d                 ; start y coordinate
(0101)  CS-0x033  0x36916         ||         MOV    r9,0x16                 ; ending x coordinate
(0102)  CS-0x034  0x085E9         ||         CALL   draw_horizontal_line
(0103)                            || 
(0104)  CS-0x035  0x3680F         || 		MOV    r8,0x0f                 ; starting x coordinate
(0105)  CS-0x036  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0106)  CS-0x037  0x36912         ||         MOV    r9,0x12                 ; ending x coordinate
(0107)  CS-0x038  0x085E9         ||         CALL   draw_horizontal_line
(0108)                            || 
(0109)                            || 		;yellow
(0110)  CS-0x039  0x366F8         || 		MOV    r6, M_YELLOW
(0111)                            || 
(0112)  CS-0x03A  0x36818         || 		MOV    r8,0x18                 ; starting x coordinate
(0113)  CS-0x03B  0x36705         ||         MOV    r7,0x05                 ; start y coordinate
(0114)  CS-0x03C  0x3691A         ||         MOV    r9,0x1a                 ; ending x coordinate
(0115)  CS-0x03D  0x085E9         ||         CALL   draw_horizontal_line
(0116)                            || 
(0117)  CS-0x03E  0x36819         || 		MOV    r8,0x19                 ; starting x coordinate
(0118)  CS-0x03F  0x36706         ||         MOV    r7,0x06                 ; start y coordinate
(0119)  CS-0x040  0x3691A         ||         MOV    r9,0x1a                 ; ending x coordinate
(0120)  CS-0x041  0x085E9         ||         CALL   draw_horizontal_line
(0121)                            || 
(0122)  CS-0x042  0x36813         || 		MOV    r8,0x13                 ; starting x coordinate
(0123)  CS-0x043  0x36707         ||         MOV    r7,0x07                 ; start y coordinate
(0124)  CS-0x044  0x36916         ||         MOV    r9,0x16                 ; ending x coordinate
(0125)  CS-0x045  0x085E9         ||         CALL   draw_horizontal_line
(0126)                            || 
(0127)  CS-0x046  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0128)  CS-0x047  0x36708         ||         MOV    r7,0x08                 ; start y coordinate
(0129)  CS-0x048  0x36918         ||         MOV    r9,0x18                 ; ending x coordinate
(0130)  CS-0x049  0x085E9         ||         CALL   draw_horizontal_line
(0131)                            || 
(0132)  CS-0x04A  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0133)  CS-0x04B  0x36709         ||         MOV    r7,0x09                 ; start y coordinate
(0134)  CS-0x04C  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0135)  CS-0x04D  0x085E9         ||         CALL   draw_horizontal_line
(0136)                            || 
(0137)  CS-0x04E  0x36811         || 		MOV    r8,0x11                 ; starting x coordinate
(0138)  CS-0x04F  0x3670A         ||         MOV    r7,0x0a                 ; start y coordinate
(0139)  CS-0x050  0x36914         ||         MOV    r9,0x14                 ; ending x coordinate
(0140)  CS-0x051  0x085E9         ||         CALL   draw_horizontal_line
(0141)                            || 
(0142)  CS-0x052  0x36811         || 		MOV    r8,0x11                 ; starting x coordinate
(0143)  CS-0x053  0x3670B         ||         MOV    r7,0x0b                 ; start y coordinate
(0144)  CS-0x054  0x36917         ||         MOV    r9,0x17                 ; ending x coordinate
(0145)  CS-0x055  0x085E9         ||         CALL   draw_horizontal_line
(0146)                            || 
(0147)  CS-0x056  0x3680C         || 		MOV    r8,0x0c                 ; starting x coordinate
(0148)  CS-0x057  0x3670C         ||         MOV    r7,0x0c                 ; start y coordinate
(0149)  CS-0x058  0x3690D         ||         MOV    r9,0x0d                 ; ending x coordinate
(0150)  CS-0x059  0x085E9         ||         CALL   draw_horizontal_line
(0151)                            || 
(0152)  CS-0x05A  0x3680C         || 		MOV    r8,0x0c                 ; starting x coordinate
(0153)  CS-0x05B  0x3670D         ||         MOV    r7,0x0d                 ; start y coordinate
(0154)  CS-0x05C  0x3690D         ||         MOV    r9,0x0d                 ; ending x coordinate
(0155)  CS-0x05D  0x085E9         ||         CALL   draw_horizontal_line
(0156)                            || 
(0157)  CS-0x05E  0x3680D         || 		MOV    r8,0x0d                 ; starting x coordinate
(0158)  CS-0x05F  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0159)  CS-0x060  0x3690E         ||         MOV    r9,0x0e                 ; ending x coordinate
(0160)  CS-0x061  0x085E9         ||         CALL   draw_horizontal_line
(0161)                            || 
(0162)  CS-0x062  0x36814         || 		MOV    r8,0x14                 ; starting x coordinate
(0163)  CS-0x063  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0164)  CS-0x064  0x36917         ||         MOV    r9,0x17                 ; ending x coordinate
(0165)  CS-0x065  0x085E9         ||         CALL   draw_horizontal_line
(0166)                            || 
(0167)                            || 		;blue
(0168)  CS-0x066  0x36613         || 		MOV    r6, M_BLUE
(0169)                            || 
(0170)  CS-0x067  0x36812         || 		MOV    r8, 0x12                ; X coordinate
(0171)  CS-0x068  0x3670C         || 		MOV    r7, 0x0c                ; Y coordinate
(0172)  CS-0x069  0x08699         ||         CALL   draw_dot                ; draw pixel
(0173)                            || 
(0174)  CS-0x06A  0x36816         || 		MOV    r8, 0x16                ; X coordinate
(0175)  CS-0x06B  0x3670C         || 		MOV    r7, 0x0c                ; Y coordinate
(0176)  CS-0x06C  0x08699         ||         CALL   draw_dot                ; draw pixel
(0177)                            || 
(0178)  CS-0x06D  0x36813         || 		MOV    r8, 0x13                ; X coordinate
(0179)  CS-0x06E  0x3670D         || 		MOV    r7, 0x0d                ; Y coordinate
(0180)  CS-0x06F  0x08699         ||         CALL   draw_dot                ; draw pixel
(0181)                            || 
(0182)  CS-0x070  0x36817         || 		MOV    r8, 0x17                ; X coordinate
(0183)  CS-0x071  0x3670D         || 		MOV    r7, 0x0d                ; Y coordinate
(0184)  CS-0x072  0x08699         ||         CALL   draw_dot                ; draw pixel
(0185)                            || 
(0186)  CS-0x073  0x36813         || 		MOV    r8, 0x13                ; X coordinate
(0187)  CS-0x074  0x3670E         || 		MOV    r7, 0x0e                ; Y coordinate
(0188)  CS-0x075  0x08699         ||         CALL   draw_dot                ; draw pixel
(0189)                            || 
(0190)  CS-0x076  0x36815         || 		MOV    r8,0x15                 ; starting x coordinate
(0191)  CS-0x077  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0192)  CS-0x078  0x36916         ||         MOV    r9,0x16                 ; ending x coordinate
(0193)  CS-0x079  0x085E9         ||         CALL   draw_horizontal_line
(0194)                            || 
(0195)  CS-0x07A  0x36818         || 		MOV    r8,0x18                 ; starting x coordinate
(0196)  CS-0x07B  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0197)  CS-0x07C  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0198)  CS-0x07D  0x085E9         ||         CALL   draw_horizontal_line
(0199)                            || 
(0200)  CS-0x07E  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0201)  CS-0x07F  0x3670F         ||         MOV    r7,0x0f                 ; start y coordinate
(0202)  CS-0x080  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0203)  CS-0x081  0x085E9         ||         CALL   draw_horizontal_line
(0204)                            || 
(0205)  CS-0x082  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0206)  CS-0x083  0x36710         ||         MOV    r7,0x10                 ; start y coordinate
(0207)  CS-0x084  0x36919         ||         MOV    r9,0x19                 ; ending x coordinate
(0208)  CS-0x085  0x085E9         ||         CALL   draw_horizontal_line
(0209)                            || 
(0210)  CS-0x086  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0211)  CS-0x087  0x36711         ||         MOV    r7,0x11                 ; start y coordinate
(0212)  CS-0x088  0x36915         ||         MOV    r9,0x15                 ; ending x coordinate
(0213)  CS-0x089  0x085E9         ||         CALL   draw_horizontal_line
(0214)                            || 
(0215)                            || 		;brown
(0216)  CS-0x08A  0x36690         || 		MOV    r6, M_BROWN
(0217)                            || 
(0218)  CS-0x08B  0x36810         || 		MOV    r8,0x10                 ; starting x coordinate
(0219)  CS-0x08C  0x36707         ||         MOV    r7,0x07                 ; start y coordinate
(0220)  CS-0x08D  0x36912         ||         MOV    r9,0x12                 ; ending x coordinate
(0221)  CS-0x08E  0x085E9         ||         CALL   draw_horizontal_line
(0222)                            || 
(0223)  CS-0x08F  0x3680F         || 		MOV    r8,0x0f                 ; starting x coordinate
(0224)  CS-0x090  0x36708         ||         MOV    r7,0x08                 ; start y coordinate
(0225)  CS-0x091  0x36909         ||         MOV    r9,0x09                 ; ending x coordinate
(0226)  CS-0x092  0x08619         ||         CALL   draw_vertical_line
(0227)                            || 
(0228)  CS-0x093  0x36811         || 		MOV    r8,0x11                 ; starting x coordinate
(0229)  CS-0x094  0x36708         ||         MOV    r7,0x08                 ; start y coordinate
(0230)  CS-0x095  0x36909         ||         MOV    r9,0x09                 ; ending x coordinate
(0231)  CS-0x096  0x08619         ||         CALL   draw_vertical_line
(0232)                            || 
(0233)  CS-0x097  0x36812         || 		MOV    r8, 0x12                ; X coordinate
(0234)  CS-0x098  0x36709         || 		MOV    r7, 0x09                ; Y coordinate
(0235)  CS-0x099  0x08699         ||         CALL   draw_dot                ; draw pixel
(0236)                            || 
(0237)  CS-0x09A  0x36810         || 		MOV    r8, 0x10                ; X coordinate
(0238)  CS-0x09B  0x3670A         || 		MOV    r7, 0x0a                ; Y coordinate
(0239)  CS-0x09C  0x08699         ||         CALL   draw_dot                ; draw pixel
(0240)                            || 
(0241)  CS-0x09D  0x3680E         || 		MOV    r8,0x0e                 ; starting x coordinate
(0242)  CS-0x09E  0x36710         ||         MOV    r7,0x10                 ; start y coordinate
(0243)  CS-0x09F  0x36913         ||         MOV    r9,0x13                 ; ending x coordinate
(0244)  CS-0x0A0  0x08619         ||         CALL   draw_vertical_line
(0245)                            || 
(0246)  CS-0x0A1  0x3680F         || 		MOV    r8,0x0f                 ; starting x coordinate
(0247)  CS-0x0A2  0x36710         ||         MOV    r7,0x10                 ; start y coordinate
(0248)  CS-0x0A3  0x36912         ||         MOV    r9,0x12                 ; ending x coordinate
(0249)  CS-0x0A4  0x08619         ||         CALL   draw_vertical_line
(0250)                            || 
(0251)  CS-0x0A5  0x3681A         || 		MOV    r8,0x1a                 ; starting x coordinate
(0252)  CS-0x0A6  0x3670E         ||         MOV    r7,0x0e                 ; start y coordinate
(0253)  CS-0x0A7  0x36911         ||         MOV    r9,0x11                 ; ending x coordinate
(0254)  CS-0x0A8  0x08619         ||         CALL   draw_vertical_line
(0255)                            || 
(0256)  CS-0x0A9  0x3681B         || 		MOV    r8,0x1b                 ; starting x coordinate
(0257)  CS-0x0AA  0x3670D         ||         MOV    r7,0x0d                 ; start y coordinate
(0258)  CS-0x0AB  0x36911         ||         MOV    r9,0x11                 ; ending x coordinate
(0259)  CS-0x0AC  0x08619         ||         CALL   draw_vertical_line
(0260)                            || 
(0261)                            || 		;black
(0262)  CS-0x0AD  0x36600         || 		MOV    r6, M_BLACK
(0263)                            || 
(0264)  CS-0x0AE  0x36815         || 		MOV    r8,0x15                 ; starting x coordinate
(0265)  CS-0x0AF  0x36707         ||         MOV    r7,0x07                 ; start y coordinate
(0266)  CS-0x0B0  0x36908         ||         MOV    r9,0x08                 ; ending x coordinate
(0267)  CS-0x0B1  0x08619         ||         CALL   draw_vertical_line
(0268)                            || 
(0269)  CS-0x0B2  0x36817         || 		MOV    r8, 0x17                ; X coordinate
(0270)  CS-0x0B3  0x36707         || 		MOV    r7, 0x07                ; Y coordinate
(0271)  CS-0x0B4  0x08699         ||         CALL   draw_dot                ; draw pixel
(0272)                            || 
(0273)  CS-0x0B5  0x36816         || 		MOV    r8, 0x16                ; X coordinate
(0274)  CS-0x0B6  0x36709         || 		MOV    r7, 0x09                ; Y coordinate
(0275)  CS-0x0B7  0x08699         ||         CALL   draw_dot                ; draw pixel
(0276)                            || 
(0277)  CS-0x0B8  0x36815         || 		MOV    r8,0x15                 ; starting x coordinate
(0278)  CS-0x0B9  0x3670A         ||         MOV    r7,0x0a                 ; start y coordinate
(0279)  CS-0x0BA  0x36918         ||         MOV    r9,0x18                 ; ending x coordinate
(0280)  CS-0x0BB  0x085E9         ||         CALL   draw_horizontal_line
(0281)                            || 
(0282)  CS-0x0BC  0x08088         ||         BRN    main                    ; continuous loop 
(0283)                            || ;--------------------------------------------------------------------
(0284)                            || 
(0285)                            ||    
(0286)                            || ;--------------------------------------------------------------------
(0287)                            || ;-  Subroutine: draw_horizontal_line
(0288)                            || ;-
(0289)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0290)                            || ;-
(0291)                            || ;-  Parameters:
(0292)                            || ;-   r8  = starting x-coordinate
(0293)                            || ;-   r7  = y-coordinate
(0294)                            || ;-   r9  = ending x-coordinate
(0295)                            || ;-   r6  = color used for line
(0296)                            || ;- 
(0297)                            || ;- Tweaked registers: r8,r9
(0298)                            || ;--------------------------------------------------------------------
(0299)                     0x0BD  || draw_horizontal_line:
(0300)  CS-0x0BD  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0301)                            || 
(0302)                     0x0BE  || draw_horiz1:
(0303)  CS-0x0BE  0x08699         ||         CALL   draw_dot         ; 
(0304)  CS-0x0BF  0x28801         ||         ADD    r8,0x01
(0305)  CS-0x0C0  0x04848         ||         CMP    r8,r9
(0306)  CS-0x0C1  0x085F3         ||         BRNE   draw_horiz1
(0307)  CS-0x0C2  0x18002         ||         RET
(0308)                            || ;--------------------------------------------------------------------
(0309)                            || 
(0310)                            || 
(0311)                            || ;---------------------------------------------------------------------
(0312)                            || ;-  Subroutine: draw_vertical_line
(0313)                            || ;-
(0314)                            || ;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
(0315)                            || ;-
(0316)                            || ;-  Parameters:
(0317)                            || ;-   r8  = x-coordinate
(0318)                            || ;-   r7  = starting y-coordinate
(0319)                            || ;-   r9  = ending y-coordinate
(0320)                            || ;-   r6  = color used for line
(0321)                            || ;- 
(0322)                            || ;- Tweaked registers: r7,r9
(0323)                            || ;--------------------------------------------------------------------
(0324)                     0x0C3  || draw_vertical_line:
(0325)  CS-0x0C3  0x28901         ||          ADD    r9,0x01
(0326)                            || 
(0327)                     0x0C4  || draw_vert1:          
(0328)  CS-0x0C4  0x08699         ||          CALL   draw_dot
(0329)  CS-0x0C5  0x28701         ||          ADD    r7,0x01
(0330)  CS-0x0C6  0x04748         ||          CMP    r7,R9
(0331)  CS-0x0C7  0x08623         ||          BRNE   draw_vert1
(0332)  CS-0x0C8  0x18002         ||          RET
(0333)                            || ;--------------------------------------------------------------------
(0334)                            || 
(0335)                            || ;---------------------------------------------------------------------
(0336)                            || ;-  Subroutine: draw_background
(0337)                            || ;-
(0338)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0339)                            || ;-  draw_horizontal_line subroutine. 
(0340)                            || ;- 
(0341)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0342)                            || ;----------------------------------------------------------------------
(0343)                     0x0C9  || draw_background: 
(0344)  CS-0x0C9  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0345)  CS-0x0CA  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0346)  CS-0x0CB  0x04769  0x0CB  || start:   MOV   r7,r13                   ; load current row count 
(0347)  CS-0x0CC  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0348)  CS-0x0CD  0x36927         ||          MOV   r9,0x27 
(0349)                            ||  
(0350)  CS-0x0CE  0x085E9         ||          CALL  draw_horizontal_line
(0351)  CS-0x0CF  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0352)  CS-0x0D0  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0353)  CS-0x0D1  0x0865B         ||          BRNE  start                    ; branch to draw more rows
(0354)  CS-0x0D2  0x18002         ||          RET
(0355)                            || ;---------------------------------------------------------------------
(0356)                            ||     
(0357)                            || ;---------------------------------------------------------------------
(0358)                            || ;- Subrountine: draw_dot
(0359)                            || ;- 
(0360)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0361)                            || ;- 
(0362)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0363)                            || ;- 
(0364)                            || ;- Tweaked registers: r4,r5
(0365)                            || ;---------------------------------------------------------------------
(0366)                     0x0D3  || draw_dot: 
(0367)  CS-0x0D3  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0368)  CS-0x0D4  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0369)                            || 
(0370)  CS-0x0D5  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0371)  CS-0x0D6  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0372)  CS-0x0D7  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0373)  CS-0x0D8  0x0A6F8         ||            BRCS  dd_add40
(0374)  CS-0x0D9  0x10401  0x0D9  || t1:        LSR   r4
(0375)  CS-0x0DA  0x0A710         ||            BRCS  dd_add80
(0376)                            || 
(0377)  CS-0x0DB  0x34591  0x0DB  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0378)  CS-0x0DC  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0379)  CS-0x0DD  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0380)  CS-0x0DE  0x18002         ||            RET
(0381)                            || 
(0382)  CS-0x0DF  0x22540  0x0DF  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0383)  CS-0x0E0  0x18000         ||            CLC                  ; freshen bit
(0384)  CS-0x0E1  0x086C8         ||            BRN   t1             
(0385)                            || 
(0386)  CS-0x0E2  0x22580  0x0E2  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0387)  CS-0x0E3  0x086D8         ||            BRN   dd_out
(0388)                            || ; --------------------------------------------------------------------
(0389)                            || 





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
DD_ADD40       0x0DF   (0382)  ||  0373 
DD_ADD80       0x0E2   (0386)  ||  0375 
DD_OUT         0x0DB   (0377)  ||  0387 
DRAW_BACKGROUND 0x0C9   (0343)  ||  0039 
DRAW_DOT       0x0D3   (0366)  ||  0083 0087 0172 0176 0180 0184 0188 0235 0239 0271 
                               ||  0275 0303 0328 
DRAW_HORIZ1    0x0BE   (0302)  ||  0306 
DRAW_HORIZONTAL_LINE 0x0BD   (0299)  ||  0064 0069 0074 0079 0092 0097 0102 0107 0115 0120 
                               ||  0125 0130 0135 0140 0145 0150 0155 0160 0165 0193 
                               ||  0198 0203 0208 0213 0221 0280 0350 
DRAW_VERT1     0x0C4   (0327)  ||  0331 
DRAW_VERTICAL_LINE 0x0C3   (0324)  ||  0226 0231 0244 0249 0254 0259 0267 
INIT           0x010   (0038)  ||  
MAIN           0x011   (0056)  ||  0282 
START          0x0CB   (0346)  ||  0353 
T1             0x0D9   (0374)  ||  0384 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0024)  ||  0344 
LEDS           0x040   (0022)  ||  
M_BLACK        0x000   (0030)  ||  0262 
M_BLUE         0x013   (0029)  ||  0168 
M_BROWN        0x090   (0031)  ||  0216 
M_RED          0x0E0   (0028)  ||  0059 
M_YELLOW       0x0F8   (0027)  ||  0110 
SSEG           0x081   (0021)  ||  
VGA_COLOR      0x092   (0020)  ||  0379 
VGA_HADD       0x090   (0018)  ||  0378 
VGA_LADD       0x091   (0019)  ||  0377 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
