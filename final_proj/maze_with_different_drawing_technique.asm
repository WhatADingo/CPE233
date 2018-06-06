.CSEG
.ORG 0x10

.EQU VGA_HADD = 0x90
.EQU VGA_LADD = 0x91
.EQU VGA_COLOR = 0x92
.EQU SSEG = 0x81
.EQU LEDS = 0x40

.EQU BG_COLOR   = 0xFF             ; Background:  white

.EQU YELLOW		= 0xF8
.EQU RED		= 0xE0
.EQU BLUE		= 0x13
.EQU BLACK		= 0x00
.EQU BROWN		= 0x90
.EQU WHITE		= 0xFF

.EQU button         = 0x9A
.EQU For_Count		= 0xFF

;r6 is used for color
;r7 used for y drawing location
;r8 used for x drawing location
;r9 used for ending location
;r10 used to store current y location
;r11 used to store current x location
;r12 used to store maze pattern
;r13 used for maze pattern counter

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
  
		CALL	draw_maze_structure
		CALL	draw_maze_pattern

main:   AND    r0, r0                  ; nop

		CALL	move_block
	
        BRN    main                    ; continuous loop 

;--------------------------------------------------------------------

draw_horizontal_line:
        ADD    r9,0x01          ; go from r8 to r15 inclusive

draw_horiz1:
        CALL   draw_dot         ; 
        ADD    r8,0x01
        CMP    r8,r9
        BRNE   draw_horiz1
        RET

draw_vertical_line:
         ADD    r9,0x01

draw_vert1:          
         CALL   draw_dot
         ADD    r7,0x01
         CMP    r7,R9
         BRNE   draw_vert1
         RET

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

draw_maze_structure: 
			MOV r6, BLACK

			;borders
			MOV    r8,0x01                 ; starting x coordinate
			MOV    r7,0x01                 ; start y coordinate
			MOV    r9,0x27                 ; ending x coordinate
			CALL   draw_horizontal_line

			MOV    r8,0x01                 ; starting x coordinate
			MOV    r7,0x1d                 ; start y coordinate
			MOV    r9,0x27                 ; ending x coordinate
			CALL   draw_horizontal_line

			MOV    r8,0x01                 ; starting x coordinate
			MOV    r7,0x03                 ; start y coordinate
			MOV    r9,0x1c                 ; ending y coordinate
			CALL   draw_vertical_line

			MOV    r8,0x01                 ; starting x coordinate
			MOV    r7,0x02                 ; start y coordinate
			MOV    r9,0x1b                 ; ending y coordinate
			CALL   draw_vertical_line

			;black grid 1st layer (known)
			MOV r8,0x03   ; starting x coordinate
			MOV r7,0x03   ; starting y coordinate

structure_loop:
			CALL draw_dot
			ADD r8, 0x02	;increment x location of dot drawing
			CMP r8, 0x26	;until it reaches the right edge of maze
			BRCC structure_loop
			MOV r8, 0x03	;initialize x location back to starting x location
			ADD r7, 0x02	;increment y location of dot drawing
			CMP r7, 0x1c	;until it reaches the bottom edge of maze
			BRCC structure_loop
			CALL initialize_location	;changes location back to known
			
			RET

draw_pattern:
			MOV r13, 0x00	;initialize data counter

	maze_pattern_loop:
			ASR r12			;move lsb into carry
			CALL black_or_white	;assign color based on carry bit
			CALL draw_dot		;draw dot

			ADD r13, 0x01	;increment counter
			CMP r13, 0x07	;run for 8 times till end of data at r12 (pattern register)
			BRCS RET		;finish draw_pattern once all 8 data points are drawn, also leaves drawing location alone (doesn't change it back)

			ADD r7, 0x02	;increment y location
			CMP r7, 0x1b
			BRCC maze_pattern_loop
			MOV r7, 0x02
			ADD r8, 0x02	;increment x location
			CMP r8, 0x26
			BRCC maze_pattern_loop
			
			RET

draw_maze_pattern:
			MOV r8,0x02   ; starting x coordinate
			MOV r7,0x03   ; starting y coordinate
			
			;blocks of code grouped into every 8 columns
			MOV r13, 0x90
			CALL draw_pattern
			MOV r13, 0x80
			CALL draw_pattern
			MOV r13, 0xDD
			CALL draw_pattern
			MOV r13, 0x70
			CALL draw_pattern
			MOV r13, 0xC9
			CALL draw_pattern
			MOV r13, 0x85
			CALL draw_pattern
			MOV r13, 0x74
			CALL draw_pattern
			MOV r13, 0x2A
			CALL draw_pattern
			MOV r13, 0xA2
			CALL draw_pattern
			MOV r13, 0xAD
			CALL draw_pattern
			MOV r13, 0x2C
			CALL draw_pattern
			MOV r13, 0x5A
			CALL draw_pattern
			MOV r13, 0x62
			CALL draw_pattern

			MOV r13, 0x90
			CALL draw_pattern
			MOV r13, 0x80
			CALL draw_pattern
			MOV r13, 0xDD
			CALL draw_pattern
			MOV r13, 0x70
			CALL draw_pattern
			MOV r13, 0xC9
			CALL draw_pattern
			MOV r13, 0x85
			CALL draw_pattern
			MOV r13, 0x74
			CALL draw_pattern
			MOV r13, 0x2A
			CALL draw_pattern
			MOV r13, 0xA2
			CALL draw_pattern
			MOV r13, 0xAD
			CALL draw_pattern
			MOV r13, 0x2C
			CALL draw_pattern
			MOV r13, 0x5A
			CALL draw_pattern
			MOV r13, 0x62
			CALL draw_pattern

			

black_or_white:
			BRCS	draw_black
			CALL draw_white
	draw_black:
			MOV r6, BLACK
			RET
	draw_white:
			MOV r6, WHITE
			RET

initialize_location:
			MOV r8,0x00   ; starting x coordinate
			MOV r7,0x00   ; starting y coordinate
			RET

draw_block: MOV r6, YELLOW

			MOV r10,0x00
			MOV r11,0x02
			CALL draw_dot
			RET

move_block: IN r15,button
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

			RET

move_right:
		
		;maze boundary check
		CMP	   r8, 0x25
		BREQ	RET
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		ADD	   r8, 0x01
		MOV    r6, YELLOW
		CALL   draw_dot

		;change to new location
		MOV		r11, r8

		;draw background at previous location
		CALL erase
		RET

move_left:
		
		;maze boundary check
		CMP	   r8, 0x01
		BREQ	RET
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		SUB	   r8, 0x01
		MOV    r6, YELLOW
		CALL   draw_dot

		;change to new location
		MOV		r11, r8

		;draw background at previous location
		CALL erase
		RET

move_up:
		
		;maze boundary check
		CMP	   r7, 0x01
		BREQ	RET
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		ADD	   r7, 0x01
		MOV    r6, YELLOW
		CALL   draw_dot

		;change to new location
		MOV		r10, r7

		;draw background at previous location
		CALL erase
		RET

move_down:
		
		;maze boundary check
		CMP	   r7, 0x1b
		BREQ	RET
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		SUB	   r7, 0x01
        MOV    r6, YELLOW
		CALL   draw_dot

		;change to new location
		MOV		r10, r7

		;draw background at previous location
		CALL erase
		RET

erase:
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, BG_COLOR
		CALL   draw_dot
		RET


