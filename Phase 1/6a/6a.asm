.EQU SWITCHPORT = 0x20			;Input Ports
.EQU BUTTON_PORT = 0xFF			;
.EQU LED_PORT = 0x40			;Output Ports
.EQU SEV_SEG_Cathodes = 0x81		;
.EQU SEV_SEG_Anodes = 0x82		;
.EQU Top_Counter = 0xBF			;
.EQU Mid_Counter = 0xFF			;
.EQU Lower_Counter = 0xFF		;
.EQU test1_mask = 0x01			;
.EQU test2_mask = 0x02			;
.EQU test3_mask = 0x04			;
.EQU test4_mask = 0x08			;
.EQU test5_mask = 0x10			;
.EQU test6_mask = 0x20			;
.EQU test7_mask = 0x40			;
.EQU test8_mask = 0x80			;
.DSEG
.ORG		0X00
.CSEG
.ORG		0X40			;
		
		MOV  R4,0x80		;Add test1 Overflow
		ADD  R4,0xDB
		CMP  R4,0x5B
		BREQ if_stuff1

		BRN  end_if1		;else

if_stuff1:	OR   R31,test1_mask

end_if1:	OUT  R31,LED_PORT
		MOV  R1,Top_Counter
Top_loop1:	SUB  R1,0x01
		
		MOV  R2,Mid_Counter
Mid_loop1:	SUB  R2,0x01

		MOV  R3,Lower_Counter	
Lower_loop1:	SUB  R3,0x01
		BRNE Lower_loop1

		OR   R2,0x00
		BRNE Mid_loop1	

		OR   R1,0x00
		BRNE Top_loop1	

		MOV  R6,0x5D		;Add test2
		ADD  R6,0x69
		CMP  R6,0xC6
		BREQ if_stuff2

		BRN  end_if2		;else

if_stuff2:	OR   R31,test2_mask

end_if2:	OUT  R31,LED_PORT
		MOV  R1,Top_Counter
Top_loop2:	SUB  R1,0x01
		
		MOV  R2,Mid_Counter
Mid_loop2:	SUB  R2,0x01

		MOV  R3,Lower_Counter	
Lower_loop2:	SUB  R3,0x01
		BRNE Lower_loop2

		OR   R2,0x00
		BRNE Mid_loop2

		OR   R1,0x00
		BRNE Top_loop2		

		MOV  R8,0x01		;Sub test3 Underflow
		SUB  R8,0x03
		CMP  R8,0xFE
		BREQ if_stuff3

		BRN  end_if3		;else

if_stuff3:	OR   R31,test3_mask

end_if3:	OUT  R31,LED_PORT
		MOV  R1,Top_Counter
Top_loop3:	SUB  R1,0x01
		
		MOV  R2,Mid_Counter
Mid_loop3:	SUB  R2,0x01

		MOV  R3,Lower_Counter	
Lower_loop3:	SUB  R3,0x01
		BRNE Lower_loop3

		OR   R2,0x00
		BRNE Mid_loop3	

		OR   R1,0x00
		BRNE Top_loop3	

		MOV  R10,0xE5		;Sub test4
		SUB  R10,0x96
		CMP  R10,0x4F
		BREQ if_stuff4

		BRN  end_if4		;else

if_stuff4:	OR   R31,test4_mask

end_if4:	OUT  R31,LED_PORT
		MOV  R1,Top_Counter
Top_loop4:	SUB  R1,0x01
		
		MOV  R2,Mid_Counter
Mid_loop4:	SUB  R2,0x01

		MOV  R3,Lower_Counter	
Lower_loop4:	SUB  R3,0x01
		BRNE Lower_loop4

		OR   R2,0x00
		BRNE Mid_loop4	

		OR   R1,0x00
		BRNE Top_loop4	

		MOV  R12,0x48		;AddC test5 C high
		SEC  
		ADDC R12,0x67
		CMP  R12,0xB0
		BREQ if_stuff5

		BRN  end_if5		;else

if_stuff5:	OR   R31,test5_mask

end_if5:	OUT  R31,LED_PORT
		MOV  R1,Top_Counter
Top_loop5:	SUB  R1,0x01
		
		MOV  R2,Mid_Counter
Mid_loop5:	SUB  R2,0x01

		MOV  R3,Lower_Counter	
Lower_loop5:	SUB  R3,0x01
		BRNE Lower_loop5

		OR   R2,0x00
		BRNE Mid_loop5	

		OR   R1,0x00
		BRNE Top_loop5

		MOV  R14,0x48		;AddC test6 C low
		CLC  
		ADDC R14,0x67
		CMP  R14,0xAF
		BREQ if_stuff6

		BRN  end_if6		;else

if_stuff6:	OR   R31,test6_mask

end_if6:	OUT  R31,LED_PORT
		MOV  R1,Top_Counter
Top_loop6:	SUB  R1,0x01
		
		MOV  R2,Mid_Counter
Mid_loop6:	SUB  R2,0x01

		MOV  R3,Lower_Counter	
Lower_loop6:	SUB  R3,0x01
		BRNE Lower_loop6

		OR   R2,0x00
		BRNE Mid_loop6	

		OR   R1,0x00
		BRNE Top_loop6

		MOV  R16,0x80		;SubC test7 C high
		SEC  
		SUBC R16,0x00
		CMP  R16,0x7F
		BREQ if_stuff7

		BRN  end_if7		;else

if_stuff7:	OR   R31,test7_mask

end_if7:	OUT  R31,LED_PORT
		MOV  R1,Top_Counter
Top_loop7:	SUB  R1,0x01
		
		MOV  R2,Mid_Counter
Mid_loop7:	SUB  R2,0x01

		MOV  R3,Lower_Counter	
Lower_loop7:	SUB  R3,0x01
		BRNE Lower_loop7

		OR   R2,0x00
		BRNE Mid_loop7	

		OR   R1,0x00
		BRNE Top_loop7

		MOV  R18,0x80		;SubC test8 C low
		CLC  
		SUBC R18,0x01
		CMP  R18,0x7F
		BREQ if_stuff8

		BRN  end_if8		;else

if_stuff8:	OR   R31,test8_mask

end_if8:	OUT  R31,LED_PORT
		MOV  R1,Top_Counter
Top_loop8:	SUB  R1,0x01
		
		MOV  R2,Mid_Counter
Mid_loop8:	SUB  R2,0x01

		MOV  R3,Lower_Counter	
Lower_loop8:	SUB  R3,0x01
		BRNE Lower_loop8

		OR   R2,0x00
		BRNE Mid_loop8	

		OR   R1,0x00
		BRNE Top_loop8


