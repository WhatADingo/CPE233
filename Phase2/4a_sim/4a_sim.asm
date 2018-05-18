.EQU time_INSIDE_FOR_COUNT    = 0x01
.EQU time_MIDDLE_FOR_COUNT    = 0x01
.EQU time_OUTSIDE_FOR_COUNT   = 0x01

.EQU led_port = 0x40

.CSEG
.ORG 0x40

;This tests PUSH, POP, WSP, CALL, RET
;This assumes MOV, LD, ST, CMP, OUT, SUB, BRNE, BREQ, OR, ADD all work

;requires simulator 0.52 or greater to simulate test case 8

Main: 	MOV R31, 0x00
	OUT R31, led_port
	
	;--------- test 1 ---------------------------------------------------------------
	;this tests only the push command by pushing a value and then loading directly.
	;it does not initialize the stack pointer to test stack pointer initialization
	;--------------------------------------------------------------------------------
	MOV R0, 0x50
	PUSH R0
	LD R1, 0xFF
	CMP R1, 0x50
	BRNE endtest1
	OR R31, 0x01
	
	endtest1: OUT R31, led_port

	;--------------------- Pause 1/2 second ----------------------------------------       
		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
	outside_for1: SUB     R1, 0x01

		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
	middle_for1:  SUB     R2, 0x01
		     
		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
	inside_for1:  SUB     R3, 0x01
		     BRNE    inside_for1
		     
		     OR      R2, 0x00               ;load flags for middle for counter
		     BRNE    middle_for1
		     
		     OR      R1, 0x00               ;load flags for outsde for counter value
		     BRNE    outside_for1
	;------------------------------- end Pause -----------------------------------------------
	 
	;--------- test 2 ---------------------------------------------------------------
	;this tests the push command by pushing a value and then loading directly.
	;this tests the wsp command by changing the stack to point at a random location in the memory
	;--------------------------------------------------------------------------------
	MOV R1, 0xD1
	WSP R1
	MOV R0, 0x11
	PUSH R0
	LD R1, 0xD0
	CMP R1, 0x11
	BRNE endtest2
	OR R31, 0x02
	
	endtest2: OUT R31, led_port

	;--------------------- Pause 1/2 second ----------------------------------------       
		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
	outside_for2: SUB     R1, 0x01

		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
	middle_for2:  SUB     R2, 0x01
	     
		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
	inside_for2:  SUB     R3, 0x01
		     BRNE    inside_for2
		     
		     OR      R2, 0x00               ;load flags for middle for counter
		     BRNE    middle_for2
		     
		     OR      R1, 0x00               ;load flags for outsde for counter value
		     BRNE    outside_for2
	;------------------------------- end Pause -----------------------------------------------

	;--------- test 3 ---------------------------------------------------------------
	;this tests only the pop command by storing a variable directly and then popping it
	;--------------------------------------------------------------------------------
	MOV R1, 0xFF
	WSP R1
	MOV R0, 0x22
	ST R0, 0xFF
	POP R1
	CMP R1, 0x22
	BRNE endtest3
	OR R31, 0x04
	
	endtest3: OUT R31, led_port

	;--------------------- Pause 1/2 second ----------------------------------------       
		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
	outside_for3: SUB     R1, 0x01

		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
	middle_for3:  SUB     R2, 0x01
		     
		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
	inside_for3:  SUB     R3, 0x01
		     BRNE    inside_for3
	     
		     OR      R2, 0x00               ;load flags for middle for counter
		     BRNE    middle_for3
		     
		     OR      R1, 0x00               ;load flags for outsde for counter value
		     BRNE    outside_for3
	;------------------------------- end Pause -----------------------------------------------

	;--------- test 4 ---------------------------------------------------------------
	;this tests both the push and pop commands
	;--------------------------------------------------------------------------------
	MOV R1, 0x00
	WSP R1
	MOV R0, 0x42
	PUSH R0
	POP R1
	CMP R1, 0x42
	BRNE endtest4
	OR R31, 0x08

	endtest4: OUT R31, led_port

	;--------------------- Pause 1/2 second ----------------------------------------       
		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
	outside_for4: SUB     R1, 0x01

		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
	middle_for4:  SUB     R2, 0x01
	     
		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
	inside_for4:  SUB     R3, 0x01
		     BRNE    inside_for4
		     
		     OR      R2, 0x00               ;load flags for middle for counter
		     BRNE    middle_for4
		     
		     OR      R1, 0x00               ;load flags for outsde for counter value
		     BRNE    outside_for4
	;------------------------------- end Pause -----------------------------------------------	

	;--------- test 5 ---------------------------------------------------------------
	;this tests multiple pushes with multiple pops
	;--------------------------------------------------------------------------------
	MOV R0, 0x11
	PUSH R0
	MOV R0, 0x22
	PUSH R0
	MOV R0, 0x33
	PUSH R0
	MOV R0, 0x44
	PUSH R0
	MOV R0, 0x55
	PUSH R0

	POP R1
	CMP R1, 0x55
	BRNE endtest5
	POP R1
	CMP R1, 0x44
	BRNE endtest5
	POP R1
	CMP R1, 0x33
	BRNE endtest5
	POP R1
	CMP R1, 0x22
	BRNE endtest5
	POP R1
	CMP R1, 0x11
	BRNE endtest5
	
	OR R31, 0x10
	
	endtest5: OUT R31, led_port

	;--------------------- Pause 1/2 second ----------------------------------------       
		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
	outside_for5: SUB     R1, 0x01

		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
	middle_for5:  SUB     R2, 0x01
		     
		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
	inside_for5:  SUB     R3, 0x01
		     BRNE    inside_for5
		     
		     OR      R2, 0x00               ;load flags for middle for counter
		     BRNE    middle_for5
		     
		     OR      R1, 0x00               ;load flags for outsde for counter value
		     BRNE    outside_for5
	;------------------------------- end Pause -----------------------------------------------

	;--------- test 6 ---------------------------------------------------------------
	;this tests a simple function call (call/ret)
	;see bottom for all functions
	;--------------------------------------------------------------------------------
	CALL test6Func
	CMP R1, 0x77
	BRNE endtest6
	OR R31, 0x20
	
	endtest6: OUT R31, led_port

	;--------------------- Pause 1/2 second ----------------------------------------       
		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
	outside_for6: SUB     R1, 0x01

		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
	middle_for6:  SUB     R2, 0x01
		     
		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
	inside_for6:  SUB     R3, 0x01
		     BRNE    inside_for6
	     
		     OR      R2, 0x00               ;load flags for middle for counter
		     BRNE    middle_for6
	     
		     OR      R1, 0x00               ;load flags for outsde for counter value
		     BRNE    outside_for6
	;------------------------------- end Pause -----------------------------------------------
	
	;--------- test 7 ---------------------------------------------------------------
	;this tests a function which calls another function
	;--------------------------------------------------------------------------------
	CALL test7Func
	CMP R1, 0x88
	BRNE endtest7
	OR R31, 0x40
	
	endtest7: OUT R31, led_port

	;--------------------- Pause 1/2 second ----------------------------------------       
		     MOV     R1, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
	outside_for7: SUB     R1, 0x01

		     MOV     R2, time_MIDDLE_FOR_COUNT   ;set middle for loop count
	middle_for7:  SUB     R2, 0x01
		     
		     MOV     R3, time_INSIDE_FOR_COUNT   ;set inside for loop count
	inside_for7:  SUB     R3, 0x01
		     BRNE    inside_for7
		     
		     OR      R2, 0x00               ;load flags for middle for counter
		     BRNE    middle_for7
		     
		     OR      R1, 0x00               ;load flags for outsde for counter value
		     BRNE    outside_for7
	;------------------------------- end Pause -----------------------------------------------

	;--------- test 8 ---------------------------------------------------------------
	;this tests recursive functions by computing the 10th fibonacci number.
	;--------------------------------------------------------------------------------
	CALL test8Func
	CMP R0, 0x59
	BRNE endtest8
	OR R31, 0x80
	
	endtest8: OUT R31, led_port

	;--------- wait indefinitely ------------------------------------------------------------
	end: BRN end 

	;----------------functions -------------------------------------------------------------------
	test6Func: MOV R1, 0x77
		   RET
	
	test7Func: MOV R1, 0x30
		   CALL test7Func2
	           RET
	
	test7Func2: MOV R1, 0x88
		    RET
	
	test8Func: MOV R0, 0x01
		   MOV R1, 0x01
		   MOV R3, 0x0A
		   CALL test8Func2
		   RET

	test8Func2: ADD R0,R1
		    MOV R4, R1
		    MOV R1, R0
		    MOV R0, R4
		    SUB R3, 0x01
		    BREQ endtest8Func2
		    CALL test8Func2
	endtest8Func2: RET







