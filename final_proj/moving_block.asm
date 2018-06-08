.CSEG
.ORG 0x10

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92
.EQU VGA_READ = 0x93
.EQU SSEG = 0x81
.EQU LEDS = 0x40

.EQU BG_COLOR       = 0xFF             ; Background:  white

.EQU M_YELLOW		= 0xF8
.EQU M_RED			= 0xE0
.EQU M_BLUE			= 0x03
.EQU M_BLACK		= 0x00
.EQU M_BROWN		= 0x90
.EQU M_GREEN		= 0x1C

.EQU button         = 0x9A
.EQU For_Count		= 0xAA

;r6 is used for color
;r7 is used for Y
;r8 is used for X
;---------------------------------------------------------------------
;init:
        CALL   draw_background         ; draw using default color
		CALL	draw_maze
		
		CALL	draw_block

main:   CALL	move_block

		CMP		r11, 0x25
		BRNE	main
		CMP		r10, 0x1b
		BRNE	main
		CALL	draw_background

	win_screen:
		CALL	draw_win
		BRN		win_screen

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

read_dot: 
           MOV   r19,r7         ; copy Y coordinate
           MOV   r20,r8         ; copy X coordinate

           AND   r20,0x3F       ; make sure top 2 bits cleared
           AND   r19,0x1F       ; make sure top 3 bits cleared
           LSR   r19             ; need to get the bot 2 bits of r4 into sA
           BRCS  xdd_add40

xt1:        LSR   r19
           BRCS  xdd_add80

xdd_out:   OUT   r20,VGA_LADD   ; write bot 8 address bits to register
           OUT   r19,VGA_HADD   ; write top 3 address bits to register
           IN	 r6,VGA_READ  ; write data to frame buffer
           RET

xdd_add40:  OR    r20,0x40       ; set bit if needed
           CLC                  ; freshen bit
           BRN   xt1             

xdd_add80:  OR    r20,0x80       ; set bit if needed
           BRN   xdd_out

; --------------------------------------------------------------------

draw_block: MOV r6,M_YELLOW

			MOV r10,0x01
			MOV r7, r10
			MOV r11,0x01
			MOV r8, r11
			CALL draw_dot
			RET

move_block: IN r15,button

			LSR r15
			BRCS move_right
			move_right_end:
			LSR r15
			BRCS move_left
			move_left_end:
			LSR r15
			BRCS move_up
			move_up_end:
			LSR r15
			BRCS move_down
			move_down_end:

			MOV r16, 0xFF
			outside_for0: SUB r16, 0x01
						  
						  MOV r17, 0xFF
			middle_for0:  SUB r17, 0x01
					
						  MOV r18, 0x0F
			inside_for0:  SUB r18, 0x01
						  BRNE inside_for0
			
			OR R17, 0x00
			BRNE middle_for0

			OR R16, 0x00
			BRNE outside_for0

			RET

move_right:
		
		;maze boundary check
		MOV		r8, r11
		MOV		r7, r10
		ADD		r8, 0x01
		CALL	read_dot
		CMP	   	r6, M_BLACK
		BREQ	move_right_end
		
		OUT		r6, LEDS

		CALL	draw_at_prev_loc

		;draw pixel at new location
		ADD	   r11, 0x01
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, M_YELLOW
		CALL   draw_dot

		BRN move_right_end

move_left:
		
		;maze boundary check
		MOV		r8, r11
		MOV		r7, r10
		SUB		r8, 0x01
		CALL	read_dot
		CMP	   	r6, M_BLACK
		BREQ	move_left_end

		OUT		r6, LEDS
		
		CALL	draw_at_prev_loc

		;draw pixel at new location
		SUB	   r11, 0x01
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, M_YELLOW
		CALL   draw_dot

		BRN move_left_end

move_up:
		
		;maze boundary check
		MOV		r7, r10
		MOV		r8, r11
		SUB		r7, 0x01
		CALL	read_dot
		CMP	   	r6, M_BLACK
		BREQ	move_up_end
		
		OUT		r6, LEDS

		CALL	draw_at_prev_loc

		;draw pixel at new location
		SUB	   r10, 0x01
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, M_YELLOW
		CALL   draw_dot

		BRN move_up_end

move_down:
		
		;maze boundary check
		MOV		r7, r10
		MOV		r8, r11
		ADD		r7, 0x01
		CALL	read_dot
		CMP	   	r6, M_BLACK
		BREQ	move_down_end

		OUT		r6, LEDS
		
		CALL	draw_at_prev_loc

		;draw pixel at new location
		ADD	   r10, 0x01
		MOV    r7, r10
		MOV    r8, r11
        MOV    r6, M_YELLOW
		CALL   draw_dot

		BRN move_down_end

draw_at_prev_loc:
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, BG_COLOR
		CALL   draw_dot
		RET

draw_maze: 

		;endpoint
		MOV r6,M_GREEN

		MOV r8,0x25  ; x coordinate
		MOV r7,0x1B	 ; y coordinate
		CALL draw_dot


		MOV r6,M_BLACK

		MOV r8,0x00   ; starting x coordinate
		MOV r7,0x00   ; y coordinate
		MOV r9,0x26   ; ending x coordinate
		CALL draw_horizontal_line

		MOV r8,0x00   ; x coordinate
		MOV r7,0x01	 ; starting y coordinate
		MOV r9,0x1C	 ; ending y coordinate
		CALL draw_vertical_line

		MOV r8,0x00   ; starting x coordinate
		MOV r7,0x1C   ; y coordinate
		MOV r9,0x26   ; ending x coordinate
		CALL draw_horizontal_line

		MOV r8,0x26   ; x coordinate
		MOV r7,0x00	 ; starting y coordinate
		MOV r9,0x1B	 ; ending y coordinate
		CALL draw_vertical_line

		MOV r8,0x00   ; starting x coordinate
		MOV r7,0x1D   ; y coordinate
		MOV r9,0x27   ; ending x coordinate
		CALL draw_horizontal_line

		MOV r8,0x27   ; x coordinate
		MOV r7,0x00	 ; starting y coordinate
		MOV r9,0x1C	 ; ending y coordinate
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

		MOV r8,0x0a  ; x coordinate
		MOV r7,0x1A	 ; starting y coordinate
		MOV r9,0x0c	 ; ending x coordinate
		CALL draw_horizontal_line

		MOV r8,0x1a  ; x coordinate
		MOV r7,0x16	 ; starting y coordinate
		MOV r9,0x1c	 ; ending x coordinate
		CALL draw_horizontal_line

		MOV r8,0x1b  ; x coordinate
		MOV r7,0x08	 ; y coordinate
		CALL draw_dot

		RET

draw_win:

		MOV r6,M_GREEN

		MOV r8,0x0d  ; x coordinate
		MOV r7,0x0a	 ; starting y coordinate
		MOV r9,0x0f	 ; ending y coordinate
		CALL draw_vertical_line

		MOV r8,0x0e  ; x coordinate
		MOV r7,0x10	 ; y coordinate
		CALL draw_dot

		MOV r8,0x0f  ; x coordinate
		MOV r7,0x0e	 ; starting y coordinate
		MOV r9,0x0f	 ; ending y coordinate
		CALL draw_vertical_line

		MOV r8,0x10  ; x coordinate
		MOV r7,0x10	 ; y coordinate
		CALL draw_dot

		MOV r8,0x11  ; x coordinate
		MOV r7,0x0a	 ; starting y coordinate
		MOV r9,0x0f	 ; ending y coordinate
		CALL draw_vertical_line

		MOV r8,0x13  ; x coordinate
		MOV r7,0x0a	 ; starting y coordinate
		MOV r9,0x15	 ; ending x coordinate
		CALL draw_horizontal_line

		MOV r8,0x14  ; x coordinate
		MOV r7,0x0a	 ; starting y coordinate
		MOV r9,0x10	 ; ending y coordinate
		CALL draw_vertical_line

		MOV r8,0x13  ; x coordinate
		MOV r7,0x10	 ; starting y coordinate
		MOV r9,0x15	 ; ending x coordinate
		CALL draw_horizontal_line

		MOV r8,0x17  ; x coordinate
		MOV r7,0x0a	 ; starting y coordinate
		MOV r9,0x10	 ; ending y coordinate
		CALL draw_vertical_line

		MOV r8,0x18  ; x coordinate
		MOV r7,0x0b	 ; y coordinate
		CALL draw_dot

		MOV r8,0x19  ; x coordinate
		MOV r7,0x0c	 ; y coordinate
		CALL draw_dot

		MOV r8,0x1a  ; x coordinate
		MOV r7,0x0d	 ; y coordinate
		CALL draw_dot

		MOV r8,0x1b  ; x coordinate
		MOV r7,0x0a	 ; starting y coordinate
		MOV r9,0x10	 ; ending y coordinate
		CALL draw_vertical_line

		RET
