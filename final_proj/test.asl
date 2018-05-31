

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
(0024)                       003  || .EQU BG_COLOR       = 0x03             ; Background:  blue
(0025)                            || 
(0026)                            || 
(0027)                            || ;r6 is used for color
(0028)                            || ;r7 is used for Y
(0029)                            || ;r8 is used for X
(0030)                            || 
(0031)                            || ;---------------------------------------------------------------------
(0032)                     0x010  || init:
(0033)  CS-0x010  0x08159         ||          CALL   draw_background         ; draw using default color
(0034)                            || 
(0035)  CS-0x011  0x3670F         ||          MOV    r7, 0x0F                ; generic Y coordinate
(0036)  CS-0x012  0x36814         ||          MOV    r8, 0x14                ; generic X coordinate
(0037)  CS-0x013  0x366E0         ||          MOV    r6, 0xE0                ; color
(0038)  CS-0x014  0x081A9         ||          CALL   draw_dot                ; draw red pixel 
(0039)                            || 
(0040)  CS-0x015  0x36801         ||          MOV    r8,0x01                 ; starting x coordinate
(0041)  CS-0x016  0x36712         ||          MOV    r7,0x12                 ; start y coordinate
(0042)  CS-0x017  0x36926         ||          MOV    r9,0x26                 ; ending x coordinate
(0043)  CS-0x018  0x080F9         ||          CALL   draw_horizontal_line
(0044)                            || 
(0045)  CS-0x019  0x36808         ||          MOV    r8,0x08                 ; starting x coordinate
(0046)  CS-0x01A  0x36704         ||          MOV    r7,0x04                 ; start y coordinate
(0047)  CS-0x01B  0x36917         ||          MOV    r9,0x17                 ; ending x coordinate
(0048)  CS-0x01C  0x08129         ||          CALL   draw_vertical_line
(0049)                            ||       
(0050)  CS-0x01D  0x00000  0x01D  || main:    AND    r0, r0                  ; nop
(0051)  CS-0x01E  0x080E8         ||          BRN    main                    ; continuous loop 
(0052)                            || ;--------------------------------------------------------------------
(0053)                            || 
(0054)                            ||    
(0055)                            || ;--------------------------------------------------------------------
(0056)                            || ;-  Subroutine: draw_horizontal_line
(0057)                            || ;-
(0058)                            || ;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
(0059)                            || ;-
(0060)                            || ;-  Parameters:
(0061)                            || ;-   r8  = starting x-coordinate
(0062)                            || ;-   r7  = y-coordinate
(0063)                            || ;-   r9  = ending x-coordinate
(0064)                            || ;-   r6  = color used for line
(0065)                            || ;- 
(0066)                            || ;- Tweaked registers: r8,r9
(0067)                            || ;--------------------------------------------------------------------
(0068)                     0x01F  || draw_horizontal_line:
(0069)  CS-0x01F  0x28901         ||         ADD    r9,0x01          ; go from r8 to r15 inclusive
(0070)                            || 
(0071)                     0x020  || draw_horiz1:
(0072)  CS-0x020  0x081A9         ||         CALL   draw_dot         ; 
(0073)  CS-0x021  0x28801         ||         ADD    r8,0x01
(0074)  CS-0x022  0x04848         ||         CMP    r8,r9
(0075)  CS-0x023  0x08103         ||         BRNE   draw_horiz1
(0076)  CS-0x024  0x18002         ||         RET
(0077)                            || ;--------------------------------------------------------------------
(0078)                            || 
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
(0093)                     0x025  || draw_vertical_line:
(0094)  CS-0x025  0x28901         ||          ADD    r9,0x01
(0095)                            || 
(0096)                     0x026  || draw_vert1:          
(0097)  CS-0x026  0x081A9         ||          CALL   draw_dot
(0098)  CS-0x027  0x28701         ||          ADD    r7,0x01
(0099)  CS-0x028  0x04748         ||          CMP    r7,R9
(0100)  CS-0x029  0x08133         ||          BRNE   draw_vert1
(0101)  CS-0x02A  0x18002         ||          RET
(0102)                            || ;--------------------------------------------------------------------
(0103)                            || 
(0104)                            || ;---------------------------------------------------------------------
(0105)                            || ;-  Subroutine: draw_background
(0106)                            || ;-
(0107)                            || ;-  Fills the 30x40 grid with one color using successive calls to 
(0108)                            || ;-  draw_horizontal_line subroutine. 
(0109)                            || ;- 
(0110)                            || ;-  Tweaked registers: r13,r7,r8,r9
(0111)                            || ;----------------------------------------------------------------------
(0112)                     0x02B  || draw_background: 
(0113)  CS-0x02B  0x36603         ||          MOV   r6,BG_COLOR              ; use default color
(0114)  CS-0x02C  0x36D00         ||          MOV   r13,0x00                 ; r13 keeps track of rows
(0115)  CS-0x02D  0x04769  0x02D  || start:   MOV   r7,r13                   ; load current row count 
(0116)  CS-0x02E  0x36800         ||          MOV   r8,0x00                  ; restart x coordinates
(0117)  CS-0x02F  0x36927         ||          MOV   r9,0x27 
(0118)                            ||  
(0119)  CS-0x030  0x080F9         ||          CALL  draw_horizontal_line
(0120)  CS-0x031  0x28D01         ||          ADD   r13,0x01                 ; increment row count
(0121)  CS-0x032  0x30D1D         ||          CMP   r13,0x1D                 ; see if more rows to draw
(0122)  CS-0x033  0x0816B         ||          BRNE  start                    ; branch to draw more rows
(0123)  CS-0x034  0x18002         ||          RET
(0124)                            || ;---------------------------------------------------------------------
(0125)                            ||     
(0126)                            || ;---------------------------------------------------------------------
(0127)                            || ;- Subrountine: draw_dot
(0128)                            || ;- 
(0129)                            || ;- This subroutine draws a dot on the display the given coordinates: 
(0130)                            || ;- 
(0131)                            || ;- (X,Y) = (r8,r7)  with a color stored in r6  
(0132)                            || ;- 
(0133)                            || ;- Tweaked registers: r4,r5
(0134)                            || ;---------------------------------------------------------------------
(0135)                     0x035  || draw_dot: 
(0136)  CS-0x035  0x04439         ||            MOV   r4,r7         ; copy Y coordinate
(0137)  CS-0x036  0x04541         ||            MOV   r5,r8         ; copy X coordinate
(0138)                            || 
(0139)  CS-0x037  0x2053F         ||            AND   r5,0x3F       ; make sure top 2 bits cleared
(0140)  CS-0x038  0x2041F         ||            AND   r4,0x1F       ; make sure top 3 bits cleared
(0141)  CS-0x039  0x10401         ||            LSR   r4             ; need to get the bot 2 bits of r4 into sA
(0142)  CS-0x03A  0x0A208         ||            BRCS  dd_add40
(0143)  CS-0x03B  0x10401  0x03B  || t1:        LSR   r4
(0144)  CS-0x03C  0x0A220         ||            BRCS  dd_add80
(0145)                            || 
(0146)  CS-0x03D  0x34591  0x03D  || dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
(0147)  CS-0x03E  0x34490         ||            OUT   r4,VGA_HADD   ; write top 3 address bits to register
(0148)  CS-0x03F  0x34692         ||            OUT   r6,VGA_COLOR  ; write data to frame buffer
(0149)  CS-0x040  0x18002         ||            RET
(0150)                            || 
(0151)  CS-0x041  0x22540  0x041  || dd_add40:  OR    r5,0x40       ; set bit if needed
(0152)  CS-0x042  0x18000         ||            CLC                  ; freshen bit
(0153)  CS-0x043  0x081D8         ||            BRN   t1             
(0154)                            || 
(0155)  CS-0x044  0x22580  0x044  || dd_add80:  OR    r5,0x80       ; set bit if needed
(0156)  CS-0x045  0x081E8         ||            BRN   dd_out
(0157)                            || ; --------------------------------------------------------------------
(0158)                            || 





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
DD_ADD40       0x041   (0151)  ||  0142 
DD_ADD80       0x044   (0155)  ||  0144 
DD_OUT         0x03D   (0146)  ||  0156 
DRAW_BACKGROUND 0x02B   (0112)  ||  0033 
DRAW_DOT       0x035   (0135)  ||  0038 0072 0097 
DRAW_HORIZ1    0x020   (0071)  ||  0075 
DRAW_HORIZONTAL_LINE 0x01F   (0068)  ||  0043 0119 
DRAW_VERT1     0x026   (0096)  ||  0100 
DRAW_VERTICAL_LINE 0x025   (0093)  ||  0048 
INIT           0x010   (0032)  ||  
MAIN           0x01D   (0050)  ||  0051 
START          0x02D   (0115)  ||  0122 
T1             0x03B   (0143)  ||  0153 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BG_COLOR       0x003   (0024)  ||  0113 
LEDS           0x040   (0022)  ||  
SSEG           0x081   (0021)  ||  
VGA_COLOR      0x092   (0020)  ||  0148 
VGA_HADD       0x090   (0018)  ||  0147 
VGA_LADD       0x091   (0019)  ||  0146 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
