;---------------------------------------------------------------------
; An expanded "draw_dot" program that includes subrountines to draw
; vertical lines, horizontal lines, and a full background. 
; 
; As written, this programs does the following: 
;   1) draws a the background blue (draws all the tiles)
;   2) draws a red dot
;   3) draws a red horizontal lines
;   4) draws a red vertical line
;
; Author: Bridget Benson 
; Modifications: bryan mealy
;---------------------------------------------------------------------

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
      
main:   AND    r0, r0                  ; nop
		
		;red
		MOV    r6, M_RED

		MOV    r8,0x11                 ; starting x coordinate
        MOV    r7,0x05                 ; start y coordinate
        MOV    r9,0x15                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x10                 ; starting x coordinate
        MOV    r7,0x06                 ; start y coordinate
        MOV    r9,0x18                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x18                 ; starting x coordinate
        MOV    r7,0x07                 ; start y coordinate
        MOV    r9,0x1a                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x19                 ; starting x coordinate
        MOV    r7,0x08                 ; start y coordinate
        MOV    r9,0x1a                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8, 0x1a                ; X coordinate
		MOV    r7, 0x09                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8, 0x19                ; X coordinate
		MOV    r7, 0x0a                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8,0x18                 ; starting x coordinate
        MOV    r7,0x11                 ; start y coordinate
        MOV    r9,0x19                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x0e                 ; starting x coordinate
        MOV    r7,0x0c                 ; start y coordinate
        MOV    r9,0x18                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x0e                 ; starting x coordinate
        MOV    r7,0x0d                 ; start y coordinate
        MOV    r9,0x16                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x0f                 ; starting x coordinate
        MOV    r7,0x0e                 ; start y coordinate
        MOV    r9,0x12                 ; ending x coordinate
        CALL   draw_horizontal_line

		;yellow
		MOV    r6, M_YELLOW

		MOV    r8,0x18                 ; starting x coordinate
        MOV    r7,0x05                 ; start y coordinate
        MOV    r9,0x1a                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x19                 ; starting x coordinate
        MOV    r7,0x06                 ; start y coordinate
        MOV    r9,0x1a                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x13                 ; starting x coordinate
        MOV    r7,0x07                 ; start y coordinate
        MOV    r9,0x16                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x10                 ; starting x coordinate
        MOV    r7,0x08                 ; start y coordinate
        MOV    r9,0x18                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x10                 ; starting x coordinate
        MOV    r7,0x09                 ; start y coordinate
        MOV    r9,0x19                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x11                 ; starting x coordinate
        MOV    r7,0x0a                 ; start y coordinate
        MOV    r9,0x14                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x11                 ; starting x coordinate
        MOV    r7,0x0b                 ; start y coordinate
        MOV    r9,0x17                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x0c                 ; starting x coordinate
        MOV    r7,0x0c                 ; start y coordinate
        MOV    r9,0x0d                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x0c                 ; starting x coordinate
        MOV    r7,0x0d                 ; start y coordinate
        MOV    r9,0x0d                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x0d                 ; starting x coordinate
        MOV    r7,0x0e                 ; start y coordinate
        MOV    r9,0x0e                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x14                 ; starting x coordinate
        MOV    r7,0x0e                 ; start y coordinate
        MOV    r9,0x17                 ; ending x coordinate
        CALL   draw_horizontal_line

		;blue
		MOV    r6, M_BLUE

		MOV    r8, 0x12                ; X coordinate
		MOV    r7, 0x0c                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8, 0x16                ; X coordinate
		MOV    r7, 0x0c                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8, 0x13                ; X coordinate
		MOV    r7, 0x0d                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8, 0x17                ; X coordinate
		MOV    r7, 0x0d                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8, 0x13                ; X coordinate
		MOV    r7, 0x0e                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8,0x15                 ; starting x coordinate
        MOV    r7,0x0e                 ; start y coordinate
        MOV    r9,0x16                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x18                 ; starting x coordinate
        MOV    r7,0x0e                 ; start y coordinate
        MOV    r9,0x19                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x10                 ; starting x coordinate
        MOV    r7,0x0f                 ; start y coordinate
        MOV    r9,0x19                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x10                 ; starting x coordinate
        MOV    r7,0x10                 ; start y coordinate
        MOV    r9,0x19                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x10                 ; starting x coordinate
        MOV    r7,0x11                 ; start y coordinate
        MOV    r9,0x15                 ; ending x coordinate
        CALL   draw_horizontal_line

		;brown
		MOV    r6, M_BROWN

		MOV    r8,0x10                 ; starting x coordinate
        MOV    r7,0x07                 ; start y coordinate
        MOV    r9,0x12                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x0f                 ; starting x coordinate
        MOV    r7,0x08                 ; start y coordinate
        MOV    r9,0x09                 ; ending x coordinate
        CALL   draw_vertical_line

		MOV    r8,0x11                 ; starting x coordinate
        MOV    r7,0x08                 ; start y coordinate
        MOV    r9,0x09                 ; ending x coordinate
        CALL   draw_vertical_line

		MOV    r8, 0x12                ; X coordinate
		MOV    r7, 0x09                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8, 0x10                ; X coordinate
		MOV    r7, 0x0a                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8,0x0e                 ; starting x coordinate
        MOV    r7,0x10                 ; start y coordinate
        MOV    r9,0x13                 ; ending x coordinate
        CALL   draw_vertical_line

		MOV    r8,0x0f                 ; starting x coordinate
        MOV    r7,0x10                 ; start y coordinate
        MOV    r9,0x12                 ; ending x coordinate
        CALL   draw_vertical_line

		MOV    r8,0x1a                 ; starting x coordinate
        MOV    r7,0x0e                 ; start y coordinate
        MOV    r9,0x11                 ; ending x coordinate
        CALL   draw_vertical_line

		MOV    r8,0x1b                 ; starting x coordinate
        MOV    r7,0x0d                 ; start y coordinate
        MOV    r9,0x11                 ; ending x coordinate
        CALL   draw_vertical_line

		;black
		MOV    r6, M_BLACK

		MOV    r8,0x15                 ; starting x coordinate
        MOV    r7,0x07                 ; start y coordinate
        MOV    r9,0x08                 ; ending x coordinate
        CALL   draw_vertical_line

		MOV    r8, 0x17                ; X coordinate
		MOV    r7, 0x07                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8, 0x16                ; X coordinate
		MOV    r7, 0x09                ; Y coordinate
        CALL   draw_dot                ; draw pixel

		MOV    r8,0x15                 ; starting x coordinate
        MOV    r7,0x0a                 ; start y coordinate
        MOV    r9,0x18                 ; ending x coordinate
        CALL   draw_horizontal_line

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

