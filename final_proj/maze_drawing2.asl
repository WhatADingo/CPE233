

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
(0010)                       255  || .EQU BG_COLOR   = 0xFF             ; Background:  white
(0011)                            || 
(0012)                       248  || .EQU YELLOW		= 0xF8
(0013)                            || .EQU RED		= 0xE0
            syntax error
            syntax error
            syntax error

(0014)                       019  || .EQU BLUE		= 0x13
(0015)                       000  || .EQU BLACK		= 0x00
(0016)                       144  || .EQU BROWN		= 0x90
(0017)                       255  || .EQU WHITE		= 0xFF
(0018)                            || 
(0019)                       154  || .EQU button     = 0x9A
(0020)                       255  || .EQU For_Count	= 0xFF
(0021)                            || 
(0022)                            || ;r6 is used for color
(0023)                            || ;r7 used for y drawing location
(0024)                            || ;r8 used for x drawing location
(0025)                            || ;r9 used for ending location
(0026)                            || ;r10 used to store current y location
(0027)                            || ;r11 used to store current x location
(0028)                            || ;r12 used for maze counter
(0029)                            || ;r13 used for maze pattern data
(0030)                            || ;r14 used for drawing background
(0031)                            || 
(0032)                            || ;---------------------------------------------------------------------
(0033)                     0x010  || init:
(0034)  CS-0x010  0x08109         || 		CALL	draw_background
(0035)                            || 
(0036)  CS-0x011  0x081E1         || 		CALL	draw_maze_structure
(0037)  CS-0x012  0x08331         || 		CALL	draw_maze_pattern
(0038)                            || 
(0039)  CS-0x013  0x087A1  0x013  || main:   CALL	move_block
(0040)                            || 
(0041)  CS-0x014  0x08098         ||         BRN		main					; continuous loop 
(0042)                            || 
(0043)                            || ;--------------------------------------------------------------------
(0044)                            || 
(0045)                     0x015  || draw_horizontal_line:
(0046)  CS-0x015  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0047)                            || 
(0048)                     0x016  || draw_horiz1:
(0049)  CS-0x016  0x08159         ||         CALL   draw_dot         ; 
(0050)  CS-0x017  0x28801         ||         ADD    r8,0x01
(0051)  CS-0x018  0x04848         ||         CMP    r8,r9
(0052)  CS-0x019  0x080B3         ||         BRNE   draw_horiz1
(0053)  CS-0x01A  0x18002         ||         RET
(0054)                            || 
(0055)                     0x01B  || draw_vertical_line:
(0056)  CS-0x01B  0x28901         ||          ADD    r9,0x01
(0057)                            || 
(0058)                     0x01C  || draw_vert1:          
(0059)  CS-0x01C  0x08159         ||          CALL   draw_dot
(0060)  CS-0x01D  0x28701         ||          ADD    r7,0x01
(0061)  CS-0x01E  0x04748         ||          CMP    r7,R9
(0062)  CS-0x01F  0x080E3         ||          BRNE   draw_vert1
(0063)  CS-0x020  0x18002         ||          RET
(0064)                            || 
(0065)                     0x021  || draw_background: 
(0066)  CS-0x021  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0067)  CS-0x022  0x36E00         ||          MOV   r14,0x00                 ; r13 keeps track of rows
(0068)  CS-0x023  0x04771  0x023  || start:   MOV   r7,r14                   ; load current row count 
(0069)  CS-0x024  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0070)  CS-0x025  0x36927         ||          MOV   r9,0x27 
(0071)                            || 
(0072)  CS-0x026  0x080A9         ||          CALL  draw_horizontal_line
(0073)  CS-0x027  0x28E01         ||          ADD   r14,0x01                 ; increment row count
(0074)  CS-0x028  0x30E1D         ||          CMP   r14,0x1D                 ; see if more rows to draw
(0075)  CS-0x029  0x0811B         ||          BRNE  start                    ; branch to draw more rows
(0076)  CS-0x02A  0x18002         ||          RET
(0077)                            || 
(0078)                     0x02B  || draw_dot: 
(0079)  CS-0x02B  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0080)  CS-0x02C  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0081)                            || 
(0082)  CS-0x02D  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0083)  CS-0x02E  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0084)  CS-0x02F  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0085)  CS-0x030  0x0A1B8         ||            BRCS  dd_add40
(0086)                            || 
(0087)  CS-0x031  0x10401  0x031  || t1:        LSR   r4
(0088)  CS-0x032  0x0A1D0         ||            BRCS  dd_add80
(0089)                            || 
(0090)  CS-0x033  0x34591  0x033  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0091)  CS-0x034  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0092)  CS-0x035  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0093)  CS-0x036  0x18002         ||            RET
(0094)                            || 
(0095)  CS-0x037  0x22540  0x037  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0096)  CS-0x038  0x18000         ||            CLC                  ; freshen bit
(0097)  CS-0x039  0x08188         ||            BRN   t1             
(0098)                            || 
(0099)  CS-0x03A  0x22580  0x03A  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0100)  CS-0x03B  0x08198         ||            BRN   dd_out
(0101)                            || ; --------------------------------------------------------------------
(0102)                            || 
(0103)                     0x03C  || draw_maze_structure: 
(0104)  CS-0x03C  0x36600         || 			MOV r6, BLACK
(0105)                            || 
(0106)                            || 			;borders
(0107)  CS-0x03D  0x36801         || 			MOV    r8,0x01                 ; starting x coordinate
(0108)  CS-0x03E  0x36700         || 			MOV    r7,0x00                 ; start y coordinate
(0109)  CS-0x03F  0x36927         || 			MOV    r9,0x27                 ; ending x coordinate
(0110)  CS-0x040  0x080A9         || 			CALL   draw_horizontal_line
(0111)                            || 
(0112)  CS-0x041  0x36801         || 			MOV    r8,0x01                 ; starting x coordinate
(0113)  CS-0x042  0x3671C         || 			MOV    r7,0x1c                 ; start y coordinate
(0114)  CS-0x043  0x36927         || 			MOV    r9,0x27                 ; ending x coordinate
(0115)  CS-0x044  0x080A9         || 			CALL   draw_horizontal_line
(0116)                            || 
(0117)  CS-0x045  0x36801         || 			MOV    r8,0x01                 ; starting x coordinate
(0118)  CS-0x046  0x36702         || 			MOV    r7,0x02                 ; start y coordinate
(0119)  CS-0x047  0x3691B         || 			MOV    r9,0x1b                 ; ending y coordinate
(0120)  CS-0x048  0x080D9         || 			CALL   draw_vertical_line
(0121)                            || 
(0122)  CS-0x049  0x36827         || 			MOV    r8,0x27                 ; starting x coordinate
(0123)  CS-0x04A  0x36701         || 			MOV    r7,0x01                 ; start y coordinate
(0124)  CS-0x04B  0x3691A         || 			MOV    r9,0x1a                 ; ending y coordinate
(0125)  CS-0x04C  0x080D9         || 			CALL   draw_vertical_line
(0126)                            || 
(0127)                            || 			;black grid 1st layer (known)
(0128)  CS-0x04D  0x36803         || 			MOV r8,0x03   ; starting x coordinate
(0129)  CS-0x04E  0x36702         || 			MOV r7,0x02   ; starting y coordinate
(0130)                            || 
(0131)                     0x04F  || 	structure_loop:
(0132)  CS-0x04F  0x08159         || 			CALL draw_dot
(0133)  CS-0x050  0x28802         || 			ADD r8, 0x02	;increment x location of dot drawing
(0134)  CS-0x051  0x30826         || 			CMP r8, 0x26	;until it reaches the right edge of maze
(0135)  CS-0x052  0x0A279         || 			BRCC structure_loop
(0136)  CS-0x053  0x36803         || 			MOV r8, 0x03	;initialize x location back to starting x location
(0137)  CS-0x054  0x28702         || 			ADD r7, 0x02	;increment y location of dot drawing
(0138)  CS-0x055  0x3071C         || 			CMP r7, 0x1c	;until it reaches the bottom edge of maze
(0139)  CS-0x056  0x0A279         || 			BRCC structure_loop
(0140)                            || 			
(0141)  CS-0x057  0x18002         || 			RET
(0142)                            || 
(0143)                     0x058  || draw_pattern:
(0144)  CS-0x058  0x36C00         || 			MOV r12, 0x00	;initialize data counter
(0145)                            || 
(0146)                     0x059  || 	maze_pattern_loop:
(0147)  CS-0x059  0x12D00         || 			ASR r13			;move lsb into carry
(0148)  CS-0x05A  0x08749         || 			CALL black_or_white	;assign color based on carry bit
(0149)  CS-0x05B  0x08159         || 			CALL draw_dot		;draw dot
(0150)                            || 
(0151)  CS-0x05C  0x28C01         || 			ADD r12, 0x01	;increment counter
(0152)  CS-0x05D  0x30C07         || 			CMP r12, 0x07	;run for 8 times till end of data at r12 (pattern register)
(0153)                            || 			BRCS RET		;finish draw_pattern once all 8 data points are drawn, also leaves drawing location alone (doesn't change it back)
            syntax error

(0154)                            || 
(0155)  CS-0x05E  0x28702         || 			ADD r7, 0x02	;increment y location
(0156)  CS-0x05F  0x3071C         || 			CMP r7, 0x1c
(0157)  CS-0x060  0x0A2C9         || 			BRCC maze_pattern_loop
(0158)  CS-0x061  0x36702         || 			MOV r7, 0x02
(0159)  CS-0x062  0x28802         || 			ADD r8, 0x02	;increment x location
(0160)  CS-0x063  0x30827         || 			CMP r8, 0x27
(0161)  CS-0x064  0x0A2C9         || 			BRCC maze_pattern_loop
(0162)                            || 			
(0163)  CS-0x065  0x18002         || 			RET
(0164)                            || 
(0165)                     0x066  || draw_maze_pattern:
(0166)                            || 			;first half
(0167)  CS-0x066  0x36802         || 			MOV r8,0x02   ; starting x coordinate
(0168)  CS-0x067  0x36702         || 			MOV r7,0x02   ; starting y coordinate
(0169)                            || 			
(0170)                            || 			;blocks of code grouped into every 8 columns
(0171)  CS-0x068  0x36D90         || 			MOV r13, 0x90
(0172)  CS-0x069  0x082C1         || 			CALL draw_pattern
(0173)  CS-0x06A  0x36D80         || 			MOV r13, 0x80
(0174)  CS-0x06B  0x082C1         || 			CALL draw_pattern
(0175)  CS-0x06C  0x36DDD         || 			MOV r13, 0xDD
(0176)  CS-0x06D  0x082C1         || 			CALL draw_pattern
(0177)  CS-0x06E  0x36D70         || 			MOV r13, 0x70
(0178)  CS-0x06F  0x082C1         || 			CALL draw_pattern
(0179)  CS-0x070  0x36DC9         || 			MOV r13, 0xC9
(0180)  CS-0x071  0x082C1         || 			CALL draw_pattern
(0181)  CS-0x072  0x36D85         || 			MOV r13, 0x85
(0182)  CS-0x073  0x082C1         || 			CALL draw_pattern
(0183)  CS-0x074  0x36D74         || 			MOV r13, 0x74
(0184)  CS-0x075  0x082C1         || 			CALL draw_pattern
(0185)  CS-0x076  0x36D2A         || 			MOV r13, 0x2A
(0186)  CS-0x077  0x082C1         || 			CALL draw_pattern
(0187)  CS-0x078  0x36DA2         || 			MOV r13, 0xA2
(0188)  CS-0x079  0x082C1         || 			CALL draw_pattern
(0189)  CS-0x07A  0x36DAD         || 			MOV r13, 0xAD
(0190)  CS-0x07B  0x082C1         || 			CALL draw_pattern
(0191)  CS-0x07C  0x36D2C         || 			MOV r13, 0x2C
(0192)  CS-0x07D  0x082C1         || 			CALL draw_pattern
(0193)  CS-0x07E  0x36D5A         || 			MOV r13, 0x5A
(0194)  CS-0x07F  0x082C1         || 			CALL draw_pattern
(0195)  CS-0x080  0x36D62         || 			MOV r13, 0x62
(0196)  CS-0x081  0x082C1         || 			CALL draw_pattern
(0197)                            || 
(0198)  CS-0x082  0x36DCA         || 			MOV r13, 0xCA
(0199)  CS-0x083  0x082C1         || 			CALL draw_pattern
(0200)  CS-0x084  0x36DF5         || 			MOV r13, 0xF5
(0201)  CS-0x085  0x082C1         || 			CALL draw_pattern
(0202)  CS-0x086  0x36D70         || 			MOV r13, 0x70
(0203)  CS-0x087  0x082C1         || 			CALL draw_pattern
(0204)  CS-0x088  0x36D6A         || 			MOV r13, 0x6A
(0205)  CS-0x089  0x082C1         || 			CALL draw_pattern
(0206)  CS-0x08A  0x36DFF         || 			MOV r13, 0xFF
(0207)  CS-0x08B  0x082C1         || 			CALL draw_pattern
(0208)  CS-0x08C  0x36D1D         || 			MOV r13, 0x1D
(0209)  CS-0x08D  0x082C1         || 			CALL draw_pattern
(0210)  CS-0x08E  0x36D5E         || 			MOV r13, 0x5E
(0211)  CS-0x08F  0x082C1         || 			CALL draw_pattern
(0212)  CS-0x090  0x36D9F         || 			MOV r13, 0x9F
(0213)  CS-0x091  0x082C1         || 			CALL draw_pattern
(0214)  CS-0x092  0x36D41         || 			MOV r13, 0x41
(0215)  CS-0x093  0x082C1         || 			CALL draw_pattern
(0216)  CS-0x094  0x36D79         || 			MOV r13, 0x79
(0217)  CS-0x095  0x082C1         || 			CALL draw_pattern
(0218)  CS-0x096  0x36DEE         || 			MOV r13, 0xEE
(0219)  CS-0x097  0x082C1         || 			CALL draw_pattern
(0220)  CS-0x098  0x36D16         || 			MOV r13, 0x16
(0221)  CS-0x099  0x082C1         || 			CALL draw_pattern
(0222)  CS-0x09A  0x36D76         || 			MOV r13, 0x76
(0223)  CS-0x09B  0x082C1         || 			CALL draw_pattern
(0224)                            || 
(0225)  CS-0x09C  0x36D87         || 			MOV r13, 0x87
(0226)  CS-0x09D  0x082C1         || 			CALL draw_pattern
(0227)  CS-0x09E  0x36D77         || 			MOV r13, 0x77
(0228)  CS-0x09F  0x082C1         || 			CALL draw_pattern
(0229)  CS-0x0A0  0x36D78         || 			MOV r13, 0x78
(0230)  CS-0x0A1  0x082C1         || 			CALL draw_pattern
(0231)  CS-0x0A2  0x36D00         || 			MOV r13, 0x00
(0232)  CS-0x0A3  0x082C1         || 			CALL draw_pattern
(0233)  CS-0x0A4  0x36D01         || 			MOV r13, 0x01
(0234)  CS-0x0A5  0x082C1         || 			CALL draw_pattern
(0235)                            || 			
(0236)                            || 			;second half
(0237)  CS-0x0A6  0x36803         || 			MOV r8,0x03   ; starting x coordinate
(0238)  CS-0x0A7  0x36701         || 			MOV r7,0x01   ; starting y coordinate
(0239)                            || 			
(0240)                            || 			;blocks of code grouped into every 4 columns
(0241)  CS-0x0A8  0x36D46         || 			MOV r13, 0x46
(0242)  CS-0x0A9  0x082C1         || 			CALL draw_pattern
(0243)  CS-0x0AA  0x36DDE         || 			MOV r13, 0xDE
(0244)  CS-0x0AB  0x082C1         || 			CALL draw_pattern
(0245)  CS-0x0AC  0x36DCC         || 			MOV r13, 0xCC
(0246)  CS-0x0AD  0x082C1         || 			CALL draw_pattern
(0247)  CS-0x0AE  0x36DA4         || 			MOV r13, 0xA4
(0248)  CS-0x0AF  0x082C1         || 			CALL draw_pattern
(0249)  CS-0x0B0  0x36DBA         || 			MOV r13, 0xBA
(0250)  CS-0x0B1  0x082C1         || 			CALL draw_pattern
(0251)  CS-0x0B2  0x36D61         || 			MOV r13, 0x61
(0252)  CS-0x0B3  0x082C1         || 			CALL draw_pattern
(0253)  CS-0x0B4  0x36DD9         || 			MOV r13, 0xD9
(0254)  CS-0x0B5  0x082C1         || 			CALL draw_pattern
(0255)                            || 
(0256)  CS-0x0B6  0x36DA8         || 			MOV r13, 0xA8
(0257)  CS-0x0B7  0x082C1         || 			CALL draw_pattern
(0258)  CS-0x0B8  0x36D5D         || 			MOV r13, 0x5D
(0259)  CS-0x0B9  0x082C1         || 			CALL draw_pattern
(0260)  CS-0x0BA  0x36D87         || 			MOV r13, 0x87
(0261)  CS-0x0BB  0x082C1         || 			CALL draw_pattern
(0262)  CS-0x0BC  0x36D52         || 			MOV r13, 0x52
(0263)  CS-0x0BD  0x082C1         || 			CALL draw_pattern
(0264)  CS-0x0BE  0x36D77         || 			MOV r13, 0x77
(0265)  CS-0x0BF  0x082C1         || 			CALL draw_pattern
(0266)  CS-0x0C0  0x36DE3         || 			MOV r13, 0xE3
(0267)  CS-0x0C1  0x082C1         || 			CALL draw_pattern
(0268)  CS-0x0C2  0x36D1C         || 			MOV r13, 0x1C
(0269)  CS-0x0C3  0x082C1         || 			CALL draw_pattern
(0270)                            || 			
(0271)  CS-0x0C4  0x36D31         || 			MOV r13, 0x31
(0272)  CS-0x0C5  0x082C1         || 			CALL draw_pattern
(0273)  CS-0x0C6  0x36D18         || 			MOV r13, 0x18
(0274)  CS-0x0C7  0x082C1         || 			CALL draw_pattern
(0275)  CS-0x0C8  0x36D9E         || 			MOV r13, 0x9E
(0276)  CS-0x0C9  0x082C1         || 			CALL draw_pattern
(0277)  CS-0x0CA  0x36D5A         || 			MOV r13, 0x5A
(0278)  CS-0x0CB  0x082C1         || 			CALL draw_pattern
(0279)  CS-0x0CC  0x36D08         || 			MOV r13, 0x08
(0280)  CS-0x0CD  0x082C1         || 			CALL draw_pattern
(0281)  CS-0x0CE  0x36D98         || 			MOV r13, 0x98
(0282)  CS-0x0CF  0x082C1         || 			CALL draw_pattern
(0283)  CS-0x0D0  0x36D1E         || 			MOV r13, 0x1E
(0284)  CS-0x0D1  0x082C1         || 			CALL draw_pattern
(0285)                            || 
(0286)  CS-0x0D2  0x36D12         || 			MOV r13, 0x12
(0287)  CS-0x0D3  0x082C1         || 			CALL draw_pattern
(0288)  CS-0x0D4  0x36D04         || 			MOV r13, 0x04
(0289)  CS-0x0D5  0x082C1         || 			CALL draw_pattern
(0290)  CS-0x0D6  0x36DA7         || 			MOV r13, 0xA7
(0291)  CS-0x0D7  0x082C1         || 			CALL draw_pattern
(0292)  CS-0x0D8  0x36DD1         || 			MOV r13, 0xD1
(0293)  CS-0x0D9  0x082C1         || 			CALL draw_pattern
(0294)  CS-0x0DA  0x36D00         || 			MOV r13, 0x00
(0295)  CS-0x0DB  0x082C1         || 			CALL draw_pattern
(0296)  CS-0x0DC  0x36DE0         || 			MOV r13, 0xE0
(0297)  CS-0x0DD  0x082C1         || 			CALL draw_pattern
(0298)  CS-0x0DE  0x36D4B         || 			MOV r13, 0x4B
(0299)  CS-0x0DF  0x082C1         || 			CALL draw_pattern
(0300)                            || 			
(0301)  CS-0x0E0  0x36D68         || 			MOV r13, 0x68
(0302)  CS-0x0E1  0x082C1         || 			CALL draw_pattern
(0303)  CS-0x0E2  0x36D98         || 			MOV r13, 0x98
(0304)  CS-0x0E3  0x082C1         || 			CALL draw_pattern
(0305)  CS-0x0E4  0x36D1F         || 			MOV r13, 0x1F
(0306)  CS-0x0E5  0x082C1         || 			CALL draw_pattern
(0307)  CS-0x0E6  0x36D0F         || 			MOV r13, 0x0F
(0308)  CS-0x0E7  0x082C1         || 			CALL draw_pattern
(0309)                            || 
(0310)  CS-0x0E8  0x18002         || 			RET
(0311)                            || 
(0312)                     0x0E9  || black_or_white:
(0313)  CS-0x0E9  0x0A758         || 			BRCS	draw_black
(0314)  CS-0x0EA  0x08769         || 			CALL	draw_white
(0315)                     0x0EB  || 	draw_black:
(0316)  CS-0x0EB  0x36600         || 			MOV r6, BLACK
(0317)  CS-0x0EC  0x18002         || 			RET
(0318)                     0x0ED  || 	draw_white:
(0319)  CS-0x0ED  0x366FF         || 			MOV r6, WHITE
(0320)  CS-0x0EE  0x18002         || 			RET
(0321)                            || 
(0322)  CS-0x0EF  0x366F8  0x0EF  || draw_block: MOV r6, YELLOW
(0323)                            || 
(0324)  CS-0x0F0  0x36A00         || 			MOV r10,0x00
(0325)  CS-0x0F1  0x36B02         || 			MOV r11,0x02
(0326)  CS-0x0F2  0x08159         || 			CALL draw_dot
(0327)  CS-0x0F3  0x18002         || 			RET
(0328)                            || 
(0329)  CS-0x0F4  0x32F9A  0x0F4  || move_block: IN r15,button
(0330)  CS-0x0F5  0x370FF  0x0F5  || 	TimeDelay:	MOV r16,For_Count
(0331)  CS-0x0F6  0x2D001         || 				SUB r16,0x01
(0332)  CS-0x0F7  0x31000         || 				CMP r16,0x00
(0333)  CS-0x0F8  0x087AB         || 				BRNE TimeDelay
(0334)                            || 
(0335)  CS-0x0F9  0x12F00         || 			ASR r15
(0336)  CS-0x0FA  0x0A810         || 			BRCS move_right
(0337)  CS-0x0FB  0x12F00         || 			ASR r15
(0338)  CS-0x0FC  0x0A850         || 			BRCS move_left
(0339)  CS-0x0FD  0x12F00         || 			ASR r15
(0340)  CS-0x0FE  0x0A890         || 			BRCS move_up
(0341)  CS-0x0FF  0x12F00         || 			ASR r15
(0342)  CS-0x100  0x0A8D0         || 			BRCS move_down
(0343)                            || 
(0344)  CS-0x101  0x18002         || 			RET
(0345)                            || 
(0346)                     0x102  || move_right:
(0347)                            || 		
(0348)                            || 		;maze boundary check
(0349)  CS-0x102  0x30B26         || 		CMP	   r11, 0x26
(0350)                            || 		BREQ	RET
            syntax error

(0351)                            || 		
(0352)                            || 		;draw pixel at new location
(0353)  CS-0x103  0x28B01         || 		ADD	   r11, 0x01
(0354)  CS-0x104  0x04751         || 		MOV    r7, r10
(0355)  CS-0x105  0x04859         || 		MOV    r8, r11
(0356)  CS-0x106  0x366F8         || 		MOV    r6, YELLOW
(0357)  CS-0x107  0x08159         || 		CALL   draw_dot
(0358)                            || 
(0359)                            || 		;draw background at previous location
(0360)  CS-0x108  0x08911         || 		CALL erase
(0361)  CS-0x109  0x18002         || 		RET
(0362)                            || 
(0363)                     0x10A  || move_left:
(0364)                            || 		
(0365)                            || 		;maze boundary check
(0366)  CS-0x10A  0x30B02         || 		CMP	   r11, 0x02
(0367)                            || 		BREQ	RET
            syntax error

(0368)                            || 		
(0369)                            || 		;draw pixel at new location
(0370)  CS-0x10B  0x2CB01         || 		SUB	   r11, 0x01
(0371)  CS-0x10C  0x04751         || 		MOV    r7, r10
(0372)  CS-0x10D  0x04859         || 		MOV    r8, r11
(0373)  CS-0x10E  0x366F8         || 		MOV    r6, YELLOW
(0374)  CS-0x10F  0x08159         || 		CALL   draw_dot
(0375)                            || 
(0376)                            || 		;draw background at previous location
(0377)  CS-0x110  0x08911         || 		CALL erase
(0378)  CS-0x111  0x18002         || 		RET
(0379)                            || 
(0380)                     0x112  || move_up:
(0381)                            || 		
(0382)                            || 		;maze boundary check
(0383)  CS-0x112  0x30A01         || 		CMP	   r10, 0x01
(0384)                            || 		BREQ	RET
            syntax error

(0385)                            || 		
(0386)                            || 		;draw pixel at new location
(0387)  CS-0x113  0x28A01         || 		ADD	   r10, 0x01
(0388)  CS-0x114  0x04751         || 		MOV    r7, r10
(0389)  CS-0x115  0x04859         || 		MOV    r8, r11
(0390)  CS-0x116  0x366F8         || 		MOV    r6, YELLOW
(0391)  CS-0x117  0x08159         || 		CALL   draw_dot
(0392)                            || 
(0393)                            || 		;draw background at previous location
(0394)  CS-0x118  0x08911         || 		CALL erase
(0395)  CS-0x119  0x18002         || 		RET
(0396)                            || 
(0397)                     0x11A  || move_down:
(0398)                            || 		
(0399)                            || 		;maze boundary check
(0400)  CS-0x11A  0x30A1C         || 		CMP	   r10, 0x1c
(0401)                            || 		BREQ	RET
            syntax error

(0402)                            || 		
(0403)                            || 		;draw pixel at new location
(0404)  CS-0x11B  0x2CA01         || 		SUB	   r10, 0x01
(0405)  CS-0x11C  0x04751         || 		MOV    r7, r10
(0406)  CS-0x11D  0x04859         || 		MOV    r8, r11
(0407)  CS-0x11E  0x366F8         ||         MOV    r6, YELLOW
(0408)  CS-0x11F  0x08159         || 		CALL   draw_dot
(0409)                            || 
(0410)                            || 		;draw background at previous location
(0411)  CS-0x120  0x08911         || 		CALL erase
(0412)  CS-0x121  0x18002         || 		RET
(0413)                            || 
(0414)                     0x122  || erase:
(0415)  CS-0x122  0x04751         || 		MOV    r7, r10
(0416)  CS-0x123  0x04859         || 		MOV    r8, r11
(0417)  CS-0x124  0x366FF         || 		MOV    r6, BG_COLOR
(0418)  CS-0x125  0x08159         || 		CALL   draw_dot
(0419)  CS-0x126  0x18002         || 		RET
(0420)                            || 
(0421)                            || 





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
BLACK_OR_WHITE 0x0E9   (0312)  ||  0148 
DD_ADD40       0x037   (0095)  ||  0085 
DD_ADD80       0x03A   (0099)  ||  0088 
DD_OUT         0x033   (0090)  ||  0100 
DRAW_BACKGROUND 0x021   (0065)  ||  0034 
DRAW_BLACK     0x0EB   (0315)  ||  0313 
DRAW_BLOCK     0x0EF   (0322)  ||  
DRAW_DOT       0x02B   (0078)  ||  0049 0059 0132 0149 0326 0357 0374 0391 0408 0418 
DRAW_HORIZ1    0x016   (0048)  ||  0052 
DRAW_HORIZONTAL_LINE 0x015   (0045)  ||  0072 0110 0115 
DRAW_MAZE_PATTERN 0x066   (0165)  ||  0037 
DRAW_MAZE_STRUCTURE 0x03C   (0103)  ||  0036 
DRAW_PATTERN   0x058   (0143)  ||  0172 0174 0176 0178 0180 0182 0184 0186 0188 0190 
                               ||  0192 0194 0196 0199 0201 0203 0205 0207 0209 0211 
                               ||  0213 0215 0217 0219 0221 0223 0226 0228 0230 0232 
                               ||  0234 0242 0244 0246 0248 0250 0252 0254 0257 0259 
                               ||  0261 0263 0265 0267 0269 0272 0274 0276 0278 0280 
                               ||  0282 0284 0287 0289 0291 0293 0295 0297 0299 0302 
                               ||  0304 0306 0308 
DRAW_VERT1     0x01C   (0058)  ||  0062 
DRAW_VERTICAL_LINE 0x01B   (0055)  ||  0120 0125 
DRAW_WHITE     0x0ED   (0318)  ||  0314 
ERASE          0x122   (0414)  ||  0360 0377 0394 0411 
INIT           0x010   (0033)  ||  
MAIN           0x013   (0039)  ||  0041 
MAZE_PATTERN_LOOP 0x059   (0146)  ||  0157 0161 
MOVE_BLOCK     0x0F4   (0329)  ||  0039 
MOVE_DOWN      0x11A   (0397)  ||  0342 
MOVE_LEFT      0x10A   (0363)  ||  0338 
MOVE_RIGHT     0x102   (0346)  ||  0336 
MOVE_UP        0x112   (0380)  ||  0340 
START          0x023   (0068)  ||  0075 
STRUCTURE_LOOP 0x04F   (0131)  ||  0135 0139 
T1             0x031   (0087)  ||  0097 
TIMEDELAY      0x0F5   (0330)  ||  0333 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0010)  ||  0066 0417 
BLACK          0x000   (0015)  ||  0104 0316 
BLUE           0x013   (0014)  ||  
BROWN          0x090   (0016)  ||  
BUTTON         0x09A   (0019)  ||  0329 
FOR_COUNT      0x0FF   (0020)  ||  0330 
LEDS           0x040   (0008)  ||  
SSEG           0x081   (0007)  ||  
VGA_COLOR      0x092   (0006)  ||  0092 
VGA_HADD       0x090   (0004)  ||  0091 
VGA_LADD       0x091   (0005)  ||  0090 
WHITE          0x0FF   (0017)  ||  0319 
YELLOW         0x0F8   (0012)  ||  0322 0356 0373 0390 0407 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
