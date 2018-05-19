; --  AUTHOR:     DOUG BRANDT & JAMES GILSTRAP
; --  DATE:       FEB 24, 2011
; --  CLASS:      CPE 233
; --  INSTRUCTOR: GERFEN
; -- 
; --  PURPOSE:    THIS PROGRAM WAS BUILT TO TEST SEVERAL DIFFERENT INSTRUCTIONS OF THE RAT PROCESSOR
; --              THE TEST CASE NUMBER FOR THIS PROGRAM IS #6 (THIS INCLUDES ADD(REG,IMM), ADDC(REG,IMM), SUB(REG,IMM), SUBC(REG,IMM))
; --              THE PROGRAM PERFORMS THE OPERATION, CHECKS THAT THE OPERATION PERFORMED CORRECTLY, AND THEN UPDATES THE OUTPUT(LED) VALUES


; INPUT AND OUTPUT PORTS
; -----------------------------
.EQU SWITCHES = 0x20
.EQU BUTTONS = 0xFF
.EQU LEDS = 0x40
; -----------------------------

; CONSTANTS
.EQU INSIDE_FOR_COUNT    = 0xBE
.EQU MIDDLE_FOR_COUNT    = 0xBE
.EQU OUTSIDE_FOR_COUNT   = 0xBE
;--------------------------------

; DATA SEG
; -----------------------------
.DSEG
.ORG 0x00
; -----------------------------

; CODE SEG
; -----------------------------
.CSEG
.ORG 0x10
; -----------------------------

MAIN:
       MOV R1,0x00      ; register 1 is used to hold the status of the operations completed
       MOV R4,0x00      ; register 4 is used to hold the bit locator/updater
       CALL waste_time
       OR  R4,0x01
       MOV R2,0x01
       ADD R2,0x02
       CMP R2,0x03
       BREQ IF2         ; if correct, go to correct section
       BRN END_IF2      ; else continue past it

IF2:
       OR R1,R4         ; update the status bit -- this lights up led 1 only
       OUT  R1,LEDS
       BRN END_IF2

END_IF2:
       CALL waste_time
       OR   R4,0x02     ; change the bit updater value so that the next bit will be updated
       SEC              ; set carry to 1
       ADDC R2,0x03
       CMP  R2,0x07
       BREQ IF3         ; if correct, go to the correct section
       BRN END_IF3      ; else continue past it

IF3:                    ; THE PROCESS CONTINUES IN A SIMILAR WAY FOR THE REMAINDER OF THE FUNCTIONS BEING TESTED
       OR R1,R4
       OUT R1,LEDS
       BRN END_IF3

END_IF3:
       CALL waste_time
       OR  R4,0x04
       SUB R2,0x02
       CMP R2,0x05
       BREQ IF4
       BRN END_IF4

IF4:
       OR R1,R4
       OUT R1,LEDS
       BRN END_IF4

END_IF4:
       CALL waste_time
       OR  R4,0x08
       SEC
       SUBC R2,0x03
       CMP  R2,0x01
       BREQ IF5
       BRN END_IF5

IF5:
       OR R1,R4
       OR R1,0xF0
       OUT R1,LEDS
       BRN END_IF5

END_IF5:
       OUT R1,LEDS
       BRN END



.CSEG
.ORG         0x80

waste_time:
             MOV     R5,OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for:
             SUB     R5,0x01
             MOV     R6,MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for:
             SUB     R6,0x01
             MOV     R7,INSIDE_FOR_COUNT   ;set inside for loop count
inside_for:
             SUB     R7,0x01
             BRNE    inside_for

             OR      R6,0x00               ;load flags for middle for counter
             BRNE    middle_for

             OR      R5,0x00               ;load flags for outsde for counter value
             BRNE    outside_for
             RET

END:
       MOV R1,R1
       BRN END
