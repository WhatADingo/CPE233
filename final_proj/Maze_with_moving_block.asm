.CSEG
.ORG 0x10

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92
.EQU SSEG = 0x81
.EQU LEDS = 0x40

.EQU BG_COLOR       = 0xFF             ; Background:  white

.EQU M_YELLOW		= 0xF8
.EQU M_RED			= 0xE0
.EQU M_BLUE			= 0x13
.EQU M_BLACK		= 0x00
.EQU M_BROWN		= 0x90

.EQU button         = 0x9A
.EQU For_Count		= 0xAA

;r6 is used for color
;r7 is used for Y
;r8 is used for X
;---------------------------------------------------------------------
init:
         CALL   draw_background         ; draw using default color
         ;MOV    r7, 0x0F                ; generic Y coordinate
         ;MOV    r8, 0x14                ; generic X coordinate
         ;MOV    r6, 0xE0                ; color
         ;CALL   draw_dot                ; draw red pixel
         ;MOV    r8,0x01                 ; starting x coordinate
         ;MOV    r7,0x12                 ; start y coordinate
         ;MOV    r9,0x26                 ; ending x coordinate
         ;CALL   draw_horizontal_line

         ;MOV    r8,0x08                 ; starting x coordinate
         ;MOV    r7,0x04                 ; start y coordinate
         ;MOV    r9,0x17                 ; ending x coordinate
         ;CALL   draw_vertical_line
  
		CALL	draw_maze

main:   AND    r0, r0                  ; nop
        BRN    main                    ; continuous loop 

;--------------------------------------------------------------------

;--------------------------------------------------------------------
;-  Subroutine: draw_horizontal_line
;-
;-  Draws a horizontal line from (r8,r7) to (r9,r7) using color in r6
;-
;-  Parameters:
;-   r8  = starting x-coordinate
;-   r7  = y-coordinate
;-   r9  = ending x-coordinate
;-   r6  = color used for line
;-
;- Tweaked registers: r8,r9
;--------------------------------------------------------------------

draw_horizontal_line:
        ADD    r9,0x01          ; go from r8 to r15 inclusive

draw_horiz1:
        CALL   draw_dot         ; 
        ADD    r8,0x01
        CMP    r8,r9
        BRNE   draw_horiz1
        RET

;--------------------------------------------------------------------

;---------------------------------------------------------------------
;-  Subroutine: draw_vertical_line
;-
;-  Draws a horizontal line from (r8,r7) to (r8,r9) using color in r6
;-
;-  Parameters:
;-   r8  = x-coordinate
;-   r7  = starting y-coordinate
;-   r9  = ending y-coordinate
;-   r6  = color used for line
;- 
;- Tweaked registers: r7,r9
;--------------------------------------------------------------------

draw_vertical_line:
         ADD    r9,0x01

draw_vert1:          
         CALL   draw_dot
         ADD    r7,0x01
         CMP    r7,R9
         BRNE   draw_vert1
         RET

;--------------------------------------------------------------------

;---------------------------------------------------------------------
;-  Subroutine: draw_background
;-
;-  Fills the 30x40 grid with one color using successive calls to 
;-  draw_horizontal_line subroutine. 
;- 
;-  Tweaked registers: r13,r7,r8,r9
;----------------------------------------------------------------------

draw_background: 
         MOV   r6,BG_COLOR              ; use default color
         MOV   r13,0x00                 ; r13 keeps track of rows
start:   MOV   r7,r13                   ; load current row count 
         MOV   r8,0x00                  ; restart x coordinates
         MOV   r9,0x27 

         CALL  draw_horizontal_line
         ADD   r13,0x01                 ; increment row count
         CMP   r13,0x1D                 ; see if more rows to draw
         BRNE  start                    ; branch to draw more rows
         RET

;---------------------------------------------------------------------

 
;---------------------------------------------------------------------
;- Subrountine: draw_dot
;- 
;- This subroutine draws a dot on the display the given coordinates: 
;- 
;- (X,Y) = (r8,r7)  with a color stored in r6  
;- 
;- Tweaked registers: r4,r5
;---------------------------------------------------------------------

draw_dot: 
           MOV   r4,r7         ; copy Y coordinate
           MOV   r5,r8         ; copy X coordinate

           AND   r5,0x3F       ; make sure top 2 bits cleared
           AND   r4,0x1F       ; make sure top 3 bits cleared
           LSR   r4             ; need to get the bot 2 bits of r4 into sA
           BRCS  dd_add40

t1:        LSR   r4
           BRCS  dd_add80

dd_out:    OUT   r5,VGA_LADD   ; write bot 8 address bits to register
           OUT   r4,VGA_HADD   ; write top 3 address bits to register
           OUT   r6,VGA_COLOR  ; write data to frame buffer
           RET

dd_add40:  OR    r5,0x40       ; set bit if needed
           CLC                  ; freshen bit
           BRN   t1             

dd_add80:  OR    r5,0x80       ; set bit if needed
           BRN   dd_out
; --------------------------------------------------------------------
draw_maze: 
		   MOV r6,M_BLACK
		   
		   MOV r8,0x00   ; starting x coordinate
		   MOV r7,0x00   ; y coordinate
		   MOV r9,0x26   ; ending x coordinate
		   CALL draw_horizontal_line

           MOV r8,0x00   ; x coordinate
		   MOV r7,0x02	 ; starting y coordinate
		   MOV r9,0x1C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x00   ; starting x coordinate
		   MOV r7,0x1C   ; y coordinate
		   MOV r9,0x26   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x26   ; x coordinate
		   MOV r7,0x00	 ; starting y coordinate
		   MOV r9,0x1A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x00  ; starting x coordinate
		   MOV r7,0x02   ; y coordinate
		   MOV r9,0x02   ; ending x coordinate
		   CALL draw_horizontal_line
 
		   MOV r8,0x00   ; starting x coordinate
		   MOV r7,0x06   ; y coordinate
		   MOV r9,0x04   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x00   ; starting x coordinate
		   MOV r7,0x08   ; y coordinate
		   MOV r9,0x08   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x00   ; starting x coordinate
		   MOV r7,0x0E   ; y coordinate
		   MOV r9,0x02   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x00   ; starting x coordinate
		   MOV r7,0x16   ; y coordinate
		   MOV r9,0x04   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x02  ; x coordinate
		   MOV r7,0x02	 ; starting y coordinate
		   MOV r9,0x04	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x02  ; x coordinate
		   MOV r7,0x08	 ; starting y coordinate
		   MOV r9,0x0A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x02  ; x coordinate
		   MOV r7,0x0C	 ; starting y coordinate
		   MOV r9,0x10	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x02  ; x coordinate
		   MOV r7,0x12	 ; starting y coordinate
		   MOV r9,0x14	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x02  ; x coordinate
		   MOV r7,0x16	 ; starting y coordinate
		   MOV r9,0x18	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x02  ; x coordinate
		   MOV r7,0x1A	 ; starting y coordinate
		   MOV r9,0x1C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x02   ; starting x coordinate
		   MOV r7,0x14   ; y coordinate
		   MOV r9,0x06   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x04  ; x coordinate
		   MOV r7,0x00	 ; starting y coordinate
		   MOV r9,0x04	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x04  ; x coordinate
		   MOV r7,0x08	 ; starting y coordinate
		   MOV r9,0x0C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x04  ; x coordinate
		   MOV r7,0x10	 ; starting y coordinate
		   MOV r9,0x14	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x04  ; x coordinate
		   MOV r7,0x18	 ; starting y coordinate
		   MOV r9,0x1A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x04   ; starting x coordinate
		   MOV r7,0x0E   ; y coordinate
		   MOV r9,0x06   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x04   ; starting x coordinate
		   MOV r7,0x0A   ; y coordinate
		   MOV r9,0x06   ; ending x coordinate
		   CALL draw_horizontal_line
		
		   MOV r8,0x04   ; starting x coordinate
		   MOV r7,0x1A   ; y coordinate
		   MOV r9,0x06   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x06  ; x coordinate
		   MOV r7,0x02	 ; starting y coordinate
		   MOV r9,0x04	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x06  ; x coordinate
		   MOV r7,0x06	 ; starting y coordinate
		   MOV r9,0x08	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x06  ; x coordinate
		   MOV r7,0x0A	 ; starting y coordinate
		   MOV r9,0x0C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x06  ; x coordinate
		   MOV r7,0x0E	 ; starting y coordinate
		   MOV r9,0x14	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x06  ; x coordinate
		   MOV r7,0x16	 ; starting y coordinate
		   MOV r9,0x1A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x06   ; starting x coordinate
		   MOV r7,0x02   ; y coordinate
		   MOV r9,0x0C   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x06   ; starting x coordinate
		   MOV r7,0x04   ; y coordinate
		   MOV r9,0x0A   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x06   ; starting x coordinate
		   MOV r7,0x12   ; y coordinate
		   MOV r9,0x08   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x06   ; starting x coordinate
		   MOV r7,0x18   ; y coordinate
		   MOV r9,0x08   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x08  ; x coordinate
		   MOV r7,0x06	 ; starting y coordinate
		   MOV r9,0x0A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x08  ; x coordinate
		   MOV r7,0x0C	 ; starting y coordinate
		   MOV r9,0x0E	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x08  ; x coordinate
		   MOV r7,0x12	 ; starting y coordinate
		   MOV r9,0x16	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x08  ; x coordinate
		   MOV r7,0x18	 ; starting y coordinate
		   MOV r9,0x1C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x08   ; starting x coordinate
		   MOV r7,0x06   ; y coordinate
		   MOV r9,0x0A   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x08   ; starting x coordinate
		   MOV r7,0x0C   ; y coordinate
		   MOV r9,0x0A   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x08   ; starting x coordinate
		   MOV r7,0x10   ; y coordinate
		   MOV r9,0x0E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x08   ; starting x coordinate
		   MOV r7,0x14   ; y coordinate
		   MOV r9,0x0C   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0A  ; x coordinate
		   MOV r7,0x06	 ; starting y coordinate
		   MOV r9,0x08	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0A  ; x coordinate
		   MOV r7,0x0A	 ; starting y coordinate
		   MOV r9,0x0C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0A  ; x coordinate
		   MOV r7,0x0E	 ; starting y coordinate
		   MOV r9,0x12	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0A  ; x coordinate
		   MOV r7,0x14	 ; starting y coordinate
		   MOV r9,0x1A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0A   ; starting x coordinate
		   MOV r7,0x0A   ; y coordinate
		   MOV r9,0x0E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0A   ; starting x coordinate
		   MOV r7,0x0E   ; y coordinate
		   MOV r9,0x0C   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0A   ; starting x coordinate
		   MOV r7,0x16   ; y coordinate
		   MOV r9,0x0C   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0C  ; x coordinate
		   MOV r7,0x00	 ; starting y coordinate
		   MOV r9,0x02	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0C  ; x coordinate
		   MOV r7,0x04	 ; starting y coordinate
		   MOV r9,0x0A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0C  ; x coordinate
		   MOV r7,0x12	 ; starting y coordinate
		   MOV r9,0x14	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0C  ; x coordinate
		   MOV r7,0x16	 ; starting y coordinate
		   MOV r9,0x18	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0C   ; starting x coordinate
		   MOV r7,0x04   ; y coordinate
		   MOV r9,0x18   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0C   ; starting x coordinate
		   MOV r7,0x0C   ; y coordinate
		   MOV r9,0x0E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0C   ; starting x coordinate
		   MOV r7,0x18   ; y coordinate
		   MOV r9,0x10   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0E  ; x coordinate
		   MOV r7,0x00	 ; starting y coordinate
		   MOV r9,0x02	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0E  ; x coordinate
		   MOV r7,0x04	 ; starting y coordinate
		   MOV r9,0x06	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0E  ; x coordinate
		   MOV r7,0x08	 ; starting y coordinate
		   MOV r9,0x0E	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0E  ; x coordinate
		   MOV r7,0x10	 ; starting y coordinate
		   MOV r9,0x16	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0E  ; x coordinate
		   MOV r7,0x18	 ; starting y coordinate
		   MOV r9,0x1C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x0E   ; starting x coordinate
		   MOV r7,0x02   ; y coordinate
		   MOV r9,0x10   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0E   ; starting x coordinate
		   MOV r7,0x08   ; y coordinate
		   MOV r9,0x12   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0E   ; starting x coordinate
		   MOV r7,0x0E   ; y coordinate
		   MOV r9,0x12   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x0E   ; starting x coordinate
		   MOV r7,0x16   ; y coordinate
		   MOV r9,0x12   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x10  ; x coordinate
		   MOV r7,0x06	 ; starting y coordinate
		   MOV r9,0x0C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x10  ; x coordinate
		   MOV r7,0x10	 ; starting y coordinate
		   MOV r9,0x16	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x10   ; starting x coordinate
		   MOV r7,0x10   ; y coordinate
		   MOV r9,0x16   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x10   ; starting x coordinate
		   MOV r7,0x12   ; y coordinate
		   MOV r9,0x16   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x10   ; starting x coordinate
		   MOV r7,0x1A   ; y coordinate
		   MOV r9,0x1E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x12  ; x coordinate
		   MOV r7,0x00	 ; starting y coordinate
		   MOV r9,0x02	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x12  ; x coordinate
		   MOV r7,0x08	 ; starting y coordinate
		   MOV r9,0x0C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x12  ; x coordinate
		   MOV r7,0x16	 ; starting y coordinate
		   MOV r9,0x1A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x12   ; starting x coordinate
		   MOV r7,0x02   ; y coordinate
		   MOV r9,0x14   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x12   ; starting x coordinate
		   MOV r7,0x06   ; y coordinate
		   MOV r9,0x14  ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x12   ; starting x coordinate
		   MOV r7,0x14   ; y coordinate
		   MOV r9,0x16   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x14  ; x coordinate
		   MOV r7,0x06	 ; starting y coordinate
		   MOV r9,0x0E	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x14  ; x coordinate
		   MOV r7,0x12	 ; starting y coordinate
		   MOV r9,0x14	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x14  ; x coordinate
		   MOV r7,0x16	 ; starting y coordinate
		   MOV r9,0x18	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x14  ; x coordinate
		   MOV r7,0x1A	 ; starting y coordinate
		   MOV r9,0x1C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x14   ; starting x coordinate
		   MOV r7,0x08   ; y coordinate
		   MOV r9,0x18   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x14   ; starting x coordinate
		   MOV r7,0x0A   ; y coordinate
		   MOV r9,0x1A   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x14   ; starting x coordinate
		   MOV r7,0x0E   ; y coordinate
		   MOV r9,0x16   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x14   ; starting x coordinate
		   MOV r7,0x16   ; y coordinate
		   MOV r9,0x18   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x14   ; starting x coordinate
		   MOV r7,0x18   ; y coordinate
		   MOV r9,0x20   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x16  ; x coordinate
		   MOV r7,0x00	 ; starting y coordinate
		   MOV r9,0x02	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x16  ; x coordinate
		   MOV r7,0x04	 ; starting y coordinate
		   MOV r9,0x06	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x16  ; x coordinate
		   MOV r7,0x0E	 ; starting y coordinate
		   MOV r9,0x10	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x16   ; starting x coordinate
		   MOV r7,0x02   ; y coordinate
		   MOV r9,0x1A   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x16   ; starting x coordinate
		   MOV r7,0x0C   ; y coordinate
		   MOV r9,0x1E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x18  ; x coordinate
		   MOV r7,0x02	 ; starting y coordinate
		   MOV r9,0x06	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x18  ; x coordinate
		   MOV r7,0x0A	 ; starting y coordinate
		   MOV r9,0x0C	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x18  ; x coordinate
		   MOV r7,0x0E	 ; starting y coordinate
		   MOV r9,0x16	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x18   ; starting x coordinate
		   MOV r7,0x06   ; y coordinate
		   MOV r9,0x1A   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x18   ; starting x coordinate
		   MOV r7,0x0E   ; y coordinate
		   MOV r9,0x1A   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x18   ; starting x coordinate
		   MOV r7,0x10   ; y coordinate
		   MOV r9,0x26   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x18   ; starting x coordinate
		   MOV r7,0x12   ; y coordinate
		   MOV r9,0x1A   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x1A  ; x coordinate
		   MOV r7,0x02	 ; starting y coordinate
		   MOV r9,0x04	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x1A  ; x coordinate
		   MOV r7,0x08	 ; starting y coordinate
		   MOV r9,0x0A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x1A  ; x coordinate
		   MOV r7,0x14	 ; starting y coordinate
		   MOV r9,0x16	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x1C  ; x coordinate
		   MOV r7,0x04	 ; starting y coordinate
		   MOV r9,0x0A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x1C  ; x coordinate
		   MOV r7,0x0E	 ; starting y coordinate
		   MOV r9,0x10	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x1C  ; x coordinate
		   MOV r7,0x12	 ; starting y coordinate
		   MOV r9,0x16	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x1C   ; starting x coordinate
		   MOV r7,0x02   ; y coordinate
		   MOV r9,0x1E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x1C   ; starting x coordinate
		   MOV r7,0x08   ; y coordinate
		   MOV r9,0x1E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x1C   ; starting x coordinate
		   MOV r7,0x0A   ; y coordinate
		   MOV r9,0x1E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x1C   ; starting x coordinate
		   MOV r7,0x12   ; y coordinate
		   MOV r9,0x1E   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x1C   ; starting x coordinate
		   MOV r7,0x14   ; y coordinate
		   MOV r9,0x24   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x1E  ; x coordinate
		   MOV r7,0x00	 ; starting y coordinate
		   MOV r9,0x02	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x1E  ; x coordinate
		   MOV r7,0x04	 ; starting y coordinate
		   MOV r9,0x08	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x1E   ; starting x coordinate
		   MOV r7,0x04   ; y coordinate
		   MOV r9,0x24   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x1E   ; starting x coordinate
		   MOV r7,0x0E   ; y coordinate
		   MOV r9,0x20   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x1E   ; starting x coordinate
		   MOV r7,0x16   ; y coordinate
		   MOV r9,0x22   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x20  ; x coordinate
		   MOV r7,0x06	 ; starting y coordinate
		   MOV r9,0x10	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x20  ; x coordinate
		   MOV r7,0x12	 ; starting y coordinate
		   MOV r9,0x14	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x20  ; x coordinate
		   MOV r7,0x18	 ; starting y coordinate
		   MOV r9,0x1A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x20   ; starting x coordinate
		   MOV r7,0x02   ; y coordinate
		   MOV r9,0x24   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x20   ; starting x coordinate
		   MOV r7,0x06   ; y coordinate
		   MOV r9,0x22   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x20   ; starting x coordinate
		   MOV r7,0x12   ; y coordinate
		   MOV r9,0x24   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x20   ; starting x coordinate
		   MOV r7,0x1A   ; y coordinate
		   MOV r9,0x22   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x22  ; x coordinate
		   MOV r7,0x06	 ; starting y coordinate
		   MOV r9,0x08	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x22  ; x coordinate
		   MOV r7,0x0A	 ; starting y coordinate
		   MOV r9,0x0E	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x22  ; x coordinate
		   MOV r7,0x16	 ; starting y coordinate
		   MOV r9,0x1A	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x22   ; starting x coordinate
		   MOV r7,0x0E   ; y coordinate
		   MOV r9,0x24   ; ending x coordinate
		   CALL draw_horizontal_line

		   MOV r8,0x24  ; x coordinate
		   MOV r7,0x02	 ; starting y coordinate
		   MOV r9,0x0E	 ; ending y coordinate
		   CALL draw_vertical_line

		   MOV r8,0x24  ; x coordinate
		   MOV r7,0x14	 ; starting y coordinate
		   MOV r9,0x1C	 ; ending y coordinate
		   CALL draw_vertical_line

draw_block: MOV r6,M_YELLOW

			MOV r7,0x00
			MOV r8,0x03
			CALL draw_dot

Move_block: IN r15,button
			TimeDelay:	MOV r16,For_Count
						SUB r16,0x01
			ASR r15
			BRCS move_right
			ASR r15
			BRCS move_left
			ASR r15
			BRCS move_up
			ASR r15
			BRCS move_down

move_right:
		
		;maze boundary check
		CMP	   r8, 0x25
		BREQ	end
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		ADD	   r8, 0x01
		MOV    r6, M_YELLOW
		CALL   draw_dot

		;draw background at previous location
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, BG_COLOR
		CALL   draw_dot

		BRN 	end

move_left:
		
		;maze boundary check
		CMP	   r8, 0x01
		BREQ	end
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		SUB	   r8, 0x01
		MOV    r6, M_YELLOW
		CALL   draw_dot

		;draw background at previous location
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, BG_COLOR
		CALL   draw_dot
		
		BRN 	end

move_up:
		
		;maze boundary check
		CMP	   r7, 0x01
		BREQ	end
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		ADD	   r7, 0x01
		MOV    r6, M_YELLOW
		CALL   draw_dot

		;draw background at previous location
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, BG_COLOR
		CALL   draw_dot
		
		BRN 	end

move_down:
		
		;maze boundary check
		CMP	   r7, 0x1b
		BREQ	end
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		SUB	   r7, 0x01
        MOV    r6, M_YELLOW
		CALL   draw_dot

		;draw background at previous location
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, BG_COLOR
		CALL   draw_dot
		
		BRN 	end

end:	RET
			

