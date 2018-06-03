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

;r6 is used for color
;r7 is used for Y
;r8 is used for X
;r9 is used for ending X or Y draw point
;r10 is used for current X location
;r11 is used for current Y location

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
      
		CALL	draw_maze_background
		
main:   AND    r0, r0                  ; nop
		

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
draw_maze_background:
		;black
		MOV    r6, BLACK

		MOV    r8,0x00                 ; starting x coordinate
        MOV    r7,0x00                 ; start y coordinate
        MOV    r9,0x27                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x00                 ; starting x coordinate
        MOV    r7,0x1d                 ; start y coordinate
        MOV    r9,0x27                 ; ending x coordinate
        CALL   draw_horizontal_line

		MOV    r8,0x00                 ; starting x coordinate
        MOV    r7,0x00                 ; start y coordinate
        MOV    r9,0x1d                 ; ending y coordinate
        CALL   draw_vertical_line

		MOV    r8,0x27                 ; starting x coordinate
        MOV    r7,0x00                 ; start y coordinate
        MOV    r9,0x1d                 ; ending y coordinate
        CALL   draw_vertical_line

		RET

move_right:
		
		;maze boundary check
		CMP	   r8, 0x25
		BREQ	end
		
		;draw pixel at new location
		MOV    r7, r10
		MOV    r8, r11
		ADD	   r8, 0x01
		MOV    r6, YELLOW
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
		MOV    r6, YELLOW
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
		MOV    r6, YELLOW
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
        MOV    r6, YELLOW
		CALL   draw_dot

		;draw background at previous location
		MOV    r7, r10
		MOV    r8, r11
		MOV    r6, BG_COLOR
		CALL   draw_dot
		
		BRN 	end

end:	RET
