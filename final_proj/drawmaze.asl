

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
(0012)                            || 
(0013)                       248  || .EQU YELLOW		= 0xF8
(0014)                            || .EQU RED		= 0xE0
            syntax error
            syntax error
            syntax error

(0015)                       019  || .EQU BLUE		= 0x13
(0016)                       000  || .EQU BLACK		= 0x00
(0017)                       144  || .EQU BROWN		= 0x90
(0018)                            || 
(0019)                            || ;r6 is used for color
(0020)                            || ;r7 is used for Y
(0021)                            || ;r8 is used for X
(0022)                            || ;r9 is used for ending X or Y draw point
(0023)                            || ;r10 is used for current X location
(0024)                            || ;r11 is used for current Y location
(0025)                            || 
(0026)                            || ;---------------------------------------------------------------------
(0027)                     0x010  || init:
(0028)  CS-0x010  0x08101         ||          CALL   draw_background         ; draw using default color
(0029)                            || 
(0030)                            ||          ;MOV    r7, 0x0F                ; generic Y coordinate
(0031)                            ||          ;MOV    r8, 0x14                ; generic X coordinate
(0032)                            ||          ;MOV    r6, 0xE0                ; color
(0033)                            ||          ;CALL   draw_dot                ; draw red pixel 
(0034)                            || 
(0035)                            ||          ;MOV    r8,0x01                 ; starting x coordinate
(0036)                            ||          ;MOV    r7,0x12                 ; start y coordinate
(0037)                            ||          ;MOV    r9,0x26                 ; ending x coordinate
(0038)                            ||          ;CALL   draw_horizontal_line
(0039)                            || 
(0040)                            ||          ;MOV    r8,0x08                 ; starting x coordinate
(0041)                            ||          ;MOV    r7,0x04                 ; start y coordinate
(0042)                            ||          ;MOV    r9,0x17                 ; ending x coordinate
(0043)                            ||          ;CALL   draw_vertical_line
(0044)                            ||       
(0045)  CS-0x011  0x081D9         || 		CALL	draw_maze_background
(0046)                            || 		
(0047)  CS-0x012  0x00000  0x012  || main:   AND    r0, r0                  ; nop
(0048)                            || 		
(0049)                            || 
(0050)  CS-0x013  0x08090         ||         BRN    main                    ; continuous loop 
(0051)                            || ;--------------------------------------------------------------------
(0052)                            || 
(0053)                            || 
(0054)                     0x014  || draw_horizontal_line:
(0055)  CS-0x014  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0056)                            || 
(0057)                     0x015  || draw_horiz1:
(0058)  CS-0x015  0x08151         ||         CALL   draw_dot         ; 
(0059)  CS-0x016  0x28801         ||         ADD    r8,0x01
(0060)  CS-0x017  0x04848         ||         CMP    r8,r9
(0061)  CS-0x018  0x080AB         ||         BRNE   draw_horiz1
(0062)  CS-0x019  0x18002         ||         RET
(0063)                            || 
(0064)                     0x01A  || draw_vertical_line:
(0065)  CS-0x01A  0x28901         ||          ADD    r9,0x01
(0066)                            || 
(0067)                     0x01B  || draw_vert1:          
(0068)  CS-0x01B  0x08151         ||          CALL   draw_dot
(0069)  CS-0x01C  0x28701         ||          ADD    r7,0x01
(0070)  CS-0x01D  0x04748         ||          CMP    r7,R9
(0071)  CS-0x01E  0x080DB         ||          BRNE   draw_vert1
(0072)  CS-0x01F  0x18002         ||          RET
(0073)                            || 
(0074)                     0x020  || draw_background: 
(0075)  CS-0x020  0x366FF         ||          MOV   r6,BG_COLOR              ; use default color
(0076)  CS-0x021  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0077)  CS-0x022  0x04769  0x022  || start:   MOV   r7,r13                   ; load current row count 
(0078)  CS-0x023  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0079)  CS-0x024  0x36927         ||          MOV   r9,0x27 
(0080)                            ||  
(0081)  CS-0x025  0x080A1         ||          CALL  draw_horizontal_line
(0082)  CS-0x026  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0083)  CS-0x027  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0084)  CS-0x028  0x08113         ||          BRNE  start                    ; branch to draw more rows
(0085)  CS-0x029  0x18002         ||          RET
(0086)                            || 
(0087)                     0x02A  || draw_dot: 
(0088)  CS-0x02A  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0089)  CS-0x02B  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0090)                            || 
(0091)  CS-0x02C  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0092)  CS-0x02D  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0093)  CS-0x02E  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0094)  CS-0x02F  0x0A1B0         ||            BRCS  dd_add40
(0095)  CS-0x030  0x10401  0x030  || t1:        LSR   r4
(0096)  CS-0x031  0x0A1C8         ||            BRCS  dd_add80
(0097)                            || 
(0098)  CS-0x032  0x34591  0x032  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0099)  CS-0x033  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0100)  CS-0x034  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0101)  CS-0x035  0x18002         ||            RET
(0102)                            || 
(0103)  CS-0x036  0x22540  0x036  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0104)  CS-0x037  0x18000         ||            CLC                  ; freshen bit
(0105)  CS-0x038  0x08180         ||            BRN   t1             
(0106)                            || 
(0107)  CS-0x039  0x22580  0x039  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0108)  CS-0x03A  0x08190         ||            BRN   dd_out
(0109)                            || ; --------------------------------------------------------------------
(0110)                     0x03B  || draw_maze_background:
(0111)                            || 		;black
(0112)  CS-0x03B  0x36600         || 		MOV    r6, BLACK
(0113)                            || 
(0114)  CS-0x03C  0x36800         || 		MOV    r8,0x00                 ; starting x coordinate
(0115)  CS-0x03D  0x36700         ||         MOV    r7,0x00                 ; start y coordinate
(0116)  CS-0x03E  0x36927         ||         MOV    r9,0x27                 ; ending x coordinate
(0117)  CS-0x03F  0x080A1         ||         CALL   draw_horizontal_line
(0118)                            || 
(0119)  CS-0x040  0x36800         || 		MOV    r8,0x00                 ; starting x coordinate
(0120)  CS-0x041  0x3671D         ||         MOV    r7,0x1d                 ; start y coordinate
(0121)  CS-0x042  0x36927         ||         MOV    r9,0x27                 ; ending x coordinate
(0122)  CS-0x043  0x080A1         ||         CALL   draw_horizontal_line
(0123)                            || 
(0124)  CS-0x044  0x36800         || 		MOV    r8,0x00                 ; starting x coordinate
(0125)  CS-0x045  0x36700         ||         MOV    r7,0x00                 ; start y coordinate
(0126)  CS-0x046  0x3691D         ||         MOV    r9,0x1d                 ; ending y coordinate
(0127)  CS-0x047  0x080D1         ||         CALL   draw_vertical_line
(0128)                            || 
(0129)  CS-0x048  0x36827         || 		MOV    r8,0x27                 ; starting x coordinate
(0130)  CS-0x049  0x36700         ||         MOV    r7,0x00                 ; start y coordinate
(0131)  CS-0x04A  0x3691D         ||         MOV    r9,0x1d                 ; ending y coordinate
(0132)  CS-0x04B  0x080D1         ||         CALL   draw_vertical_line
(0133)                            || 
(0134)  CS-0x04C  0x18002         || 		RET
(0135)                            || 
(0136)                     0x04D  || move_right:
(0137)                            || 		
(0138)                            || 		;maze boundary check
(0139)  CS-0x04D  0x30825         || 		CMP	   r8, 0x25
(0140)  CS-0x04E  0x083EA         || 		BREQ	end
(0141)                            || 		
(0142)                            || 		;draw pixel at new location
(0143)  CS-0x04F  0x04751         || 		MOV    r7, r10
(0144)  CS-0x050  0x04859         || 		MOV    r8, r11
(0145)  CS-0x051  0x28801         || 		ADD	   r8, 0x01
(0146)  CS-0x052  0x366F8         || 		MOV    r6, YELLOW
(0147)  CS-0x053  0x08151         || 		CALL   draw_dot
(0148)                            || 
(0149)                            || 		;draw background at previous location
(0150)  CS-0x054  0x04751         || 		MOV    r7, r10
(0151)  CS-0x055  0x04859         || 		MOV    r8, r11
(0152)  CS-0x056  0x366FF         || 		MOV    r6, BG_COLOR
(0153)  CS-0x057  0x08151         || 		CALL   draw_dot
(0154)                            || 
(0155)  CS-0x058  0x083E8         || 		BRN 	end
(0156)                            || 
(0157)                     0x059  || move_left:
(0158)                            || 		
(0159)                            || 		;maze boundary check
(0160)  CS-0x059  0x30801         || 		CMP	   r8, 0x01
(0161)  CS-0x05A  0x083EA         || 		BREQ	end
(0162)                            || 		
(0163)                            || 		;draw pixel at new location
(0164)  CS-0x05B  0x04751         || 		MOV    r7, r10
(0165)  CS-0x05C  0x04859         || 		MOV    r8, r11
(0166)  CS-0x05D  0x2C801         || 		SUB	   r8, 0x01
(0167)  CS-0x05E  0x366F8         || 		MOV    r6, YELLOW
(0168)  CS-0x05F  0x08151         || 		CALL   draw_dot
(0169)                            || 
(0170)                            || 		;draw background at previous location
(0171)  CS-0x060  0x04751         || 		MOV    r7, r10
(0172)  CS-0x061  0x04859         || 		MOV    r8, r11
(0173)  CS-0x062  0x366FF         || 		MOV    r6, BG_COLOR
(0174)  CS-0x063  0x08151         || 		CALL   draw_dot
(0175)                            || 		
(0176)  CS-0x064  0x083E8         || 		BRN 	end
(0177)                            || 
(0178)                     0x065  || move_up:
(0179)                            || 		
(0180)                            || 		;maze boundary check
(0181)  CS-0x065  0x30701         || 		CMP	   r7, 0x01
(0182)  CS-0x066  0x083EA         || 		BREQ	end
(0183)                            || 		
(0184)                            || 		;draw pixel at new location
(0185)  CS-0x067  0x04751         || 		MOV    r7, r10
(0186)  CS-0x068  0x04859         || 		MOV    r8, r11
(0187)  CS-0x069  0x28701         || 		ADD	   r7, 0x01
(0188)  CS-0x06A  0x366F8         || 		MOV    r6, YELLOW
(0189)  CS-0x06B  0x08151         || 		CALL   draw_dot
(0190)                            || 
(0191)                            || 		;draw background at previous location
(0192)  CS-0x06C  0x04751         || 		MOV    r7, r10
(0193)  CS-0x06D  0x04859         || 		MOV    r8, r11
(0194)  CS-0x06E  0x366FF         || 		MOV    r6, BG_COLOR
(0195)  CS-0x06F  0x08151         || 		CALL   draw_dot
(0196)                            || 		
(0197)  CS-0x070  0x083E8         || 		BRN 	end
(0198)                            || 
(0199)                     0x071  || move_down:
(0200)                            || 		
(0201)                            || 		;maze boundary check
(0202)  CS-0x071  0x3071B         || 		CMP	   r7, 0x1b
(0203)  CS-0x072  0x083EA         || 		BREQ	end
(0204)                            || 		
(0205)                            || 		;draw pixel at new location
(0206)  CS-0x073  0x04751         || 		MOV    r7, r10
(0207)  CS-0x074  0x04859         || 		MOV    r8, r11
(0208)  CS-0x075  0x2C701         || 		SUB	   r7, 0x01
(0209)  CS-0x076  0x366F8         ||         MOV    r6, YELLOW
(0210)  CS-0x077  0x08151         || 		CALL   draw_dot
(0211)                            || 
(0212)                            || 		;draw background at previous location
(0213)  CS-0x078  0x04751         || 		MOV    r7, r10
(0214)  CS-0x079  0x04859         || 		MOV    r8, r11
(0215)  CS-0x07A  0x366FF         || 		MOV    r6, BG_COLOR
(0216)  CS-0x07B  0x08151         || 		CALL   draw_dot
(0217)                            || 		
(0218)  CS-0x07C  0x083E8         || 		BRN 	end
(0219)                            || 
(0220)  CS-0x07D  0x18002  0x07D  || end:	RET





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
DD_ADD40       0x036   (0103)  ||  0094 
DD_ADD80       0x039   (0107)  ||  0096 
DD_OUT         0x032   (0098)  ||  0108 
DRAW_BACKGROUND 0x020   (0074)  ||  0028 
DRAW_DOT       0x02A   (0087)  ||  0058 0068 0147 0153 0168 0174 0189 0195 0210 0216 
DRAW_HORIZ1    0x015   (0057)  ||  0061 
DRAW_HORIZONTAL_LINE 0x014   (0054)  ||  0081 0117 0122 
DRAW_MAZE_BACKGROUND 0x03B   (0110)  ||  0045 
DRAW_VERT1     0x01B   (0067)  ||  0071 
DRAW_VERTICAL_LINE 0x01A   (0064)  ||  0127 0132 
END            0x07D   (0220)  ||  0140 0155 0161 0176 0182 0197 0203 0218 
INIT           0x010   (0027)  ||  
MAIN           0x012   (0047)  ||  0050 
MOVE_DOWN      0x071   (0199)  ||  
MOVE_LEFT      0x059   (0157)  ||  
MOVE_RIGHT     0x04D   (0136)  ||  
MOVE_UP        0x065   (0178)  ||  
START          0x022   (0077)  ||  0084 
T1             0x030   (0095)  ||  0105 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x0FF   (0010)  ||  0075 0152 0173 0194 0215 
BLACK          0x000   (0016)  ||  0112 
BLUE           0x013   (0015)  ||  
BROWN          0x090   (0017)  ||  
LEDS           0x040   (0008)  ||  
SSEG           0x081   (0007)  ||  
VGA_COLOR      0x092   (0006)  ||  0100 
VGA_HADD       0x090   (0004)  ||  0099 
VGA_LADD       0x091   (0005)  ||  0098 
YELLOW         0x0F8   (0013)  ||  0146 0167 0188 0209 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
