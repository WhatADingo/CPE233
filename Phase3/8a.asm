; **************************************************************************************
; Updated on 2-23-2017
; This program tests the SEI, CLI, RETIE, and RETID instructions and uses OUT, MOV, 
; ADD, SUB, AND, OR, CMP, BRN, and BRNE.
;
; How you initiate the inturrupt is up to the user.
; 
; LED7 is used to indicate of interrupts are enabled.  The program cycles between
; interrupts being enabled and not, with LED7 flashing on and off.  
;
; Normal program operation is to watch LED7, generate interrupts when LED7 is
; illuminated, and see those interrupts counted on the 7 Segment Display. Once the   
; 20th interrupt (interrupt 0x14) is received, LD1 will come on to signify finished 
; counting. Interrupts will also be disabled to prevent further counting.
; **************************************************************************************


.DSEG
.ORG 0x00

.equ loop_count = 0xFF     ; extend the loop count
.equ led_port   = 0x40
.equ ssg_port	= 0x81

.CSEG
.ORG 0x10
            MOV  R1, 0x00   	;R1 is used to count interrupts and drive the SSG
            MOV  R2, 0x00   	;Set flag to allow interrupts to be enabled
            OUT  R1, ssg_port   ;Initialize Sev Seg to 0

MAIN:       SEI
	        MOV  R3, 0x80           ;illuminate LD7 when interrupts on
	        OUT  R3, led_port
	        MOV  R11, loop_count    ;set outside for loop count
	        BRN  FOR1
	        
BACK1:      CMP  R2, 0xFF            ;check flag if done counting interrupts
            BREQ DONE
            CLI                                       
            AND  R3,  0x7F          ;extinguish LD7 when interrupts disabled
	        OUT  R3,  led_port
	        MOV  R11, loop_count    ;set outside for loop count
            BRN  FOR2
            BRN  MAIN               ;should never be needed

FOR1:
out_for1:   SUB  R11, 0x01
            MOV  R12, loop_count   ;set middle for loop count

mid_for1:   SUB  R12, 0x01
            MOV  R13, loop_count   ;set inside for loop count

in_for1:    SUB  R13, 0x01
            MOV  R31, 0xFF          ;empty instructions to slow things down
	        MOV  R31, 0xFF          ;when interrupts are enabled to allow
            MOV  R31, 0xFF          ;button presses
            MOV  R31, 0xFF
            MOV  R31, 0xFF
            MOV  R31, 0xFF
            BRNE in_for1
             
            OR   R12, 0x00         ;load flags for middle for counter
            BRNE mid_for1
             
            OR   R11, 0x00         ;load flags for outsde for counter value
            BRNE out_for1
            BRN  BACK1

FOR2:
out_for2:   SUB  R11, 0x01
            MOV  R12, loop_count ;set middle for loop count

mid_for2:   SUB  R12, 0x01
            MOV  R13, loop_count ;set inside for loop count

in_for2:    SUB  R13, 0x01
            BRNE in_for2
             
            OR   R12, 0x00       ;load flags for middle for counter
            BRNE mid_for2
             
            OR   R11, 0x00       ;load flags for outsde for counter value
            BRNE out_for2
            BRN  MAIN

ISR:        ADD  R1, 0x01           ;count interrupts and update SSG
            OUT  R1, ssg_port         
            CMP  R1, 0x14           ;After 20 presses disable interrupts
            BREQ DISABLE_INTS       ;and finish up
	        RETIE

DISABLE_INTS:
            MOV  R3, 0x01           ;illuminate LD1 indicating done
            OUT  R3, led_port
            MOV  R2, 0xFF           ;set flag to indicate done 
            RETID                   ;return without enabling interrupts

DONE:       BRN  DONE               ;ALL DONE, NO MORE INTERRUPTS!

.CSEG
.ORG 0x3FF  ;interrupt vector
VECTOR:     BRN ISR
