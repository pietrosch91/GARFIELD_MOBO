
	delay_1ms:
	  LOAD s2, 00
	  LOAD s1, 18
	  LOAD s0, 6A
	  JUMP software_delay
	                    ;
	                    ;20ms is 1,000,000 clock cycles requiring 125,000 delay iterations
	                    ;
	delay_20ms:
	  LOAD s2, 01
	  LOAD s1, E8
	  LOAD s0, 48
	  JUMP software_delay
	                                ;
	                    ;1s is 50,000,000 clock cycles requiring 6,250,000 delay iterations
	                    ;
	delay_1s:
	  LOAD s2, 5F
	  LOAD s1, 5E
	  LOAD s0, 10
	  JUMP software_delay
	                                ;
	                    ; The delay loop decrements [s2,s1,s0] until it reaches zero
	                    ; Each decrement cycle is 4 instructions which is 8 clock cycles (160ns at 50MHz)
	                    ;
	software_delay:
	  SUB s0, 1'd
	  SUBCY s1, 0'd
	  SUBCY s2, 0'd
	  JUMP NZ, software_delay
	  RETURN
