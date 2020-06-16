	;== PREAMBLE
	jump main
	jump main
	jump main
	jump main
  INCLUDE "uart_interface_routines.asm"
  INCLUDE "spi_routines.asm"
  INCLUDE "software_delays.asm"
  INCLUDE "scratchpad_manager.asm"
  INCLUDE "sja_config.asm"

  STRING welcome_str$, "<* GCU 1F3 SJA1150 switch programming terminal *>"
  STRING command_sel_str$, "CMD>"

welcome_message:
  LOAD&RETURN s5, welcome_str$
  LOAD&RETURN s5, CR
  LOAD&RETURN s5, NUL

command_sel_message:
  	LOAD&RETURN s5, command_sel_str$
	  LOAD&RETURN s5, CR
	  LOAD&RETURN s5, NUL

SPI_send_32_bit:
  load sE, 8                     ; 8 digits to acquire
	call obtain_value
  call SPI_32_bit_tx_rx
  call store_reg_in_first_slot
  call send_CR
	call send_NL
  load s5, "R"
  call UART_TX
  call send_32_bit
  return

write_clock_registers:
  ;; 	w81 00 02 40 0B 00 00 00
  load sD, 81
	load sC, 00
	load sB, 02
	load sA, 40
	call store_reg_in_first_slot
	load sD, 0B
	load sC, 00
	load sB, 00
	load sA, 00
	call store_reg_in_second_slot
  call SPI_send_64bit_nouart

  	;; 	w81 00 02 B0 0B 00 00 00
	load sD, 81
	load sC, 00
	load sB, 02
	load sA, B0
	call store_reg_in_first_slot
	load sD, 0B
	load sC, 00
	load sB, 00
	load sA, 00
	call store_reg_in_second_slot
	call SPI_send_64bit_nouart

  ;; 	w81 00 03 20 0B 00 00 00
	load sD, 81
	load sC, 00
	load sB, 03
	load sA, 20
	call store_reg_in_first_slot
	load sD, 0B
	load sC, 00
	load sB, 00
	load sA, 00
	call store_reg_in_second_slot
	call SPI_send_64bit_nouart
  return


SPI_send_64bit_nouart:
	call fetch_reg_in_first_slot
	CALL SPI_enable
	delay_cycles(20)
	delay_cycles(20)
	delay_cycles(20)
	call SPI_32_bit_tx_rx
	call fetch_reg_in_second_slot
	delay_cycles(20)
	delay_cycles(20)
	delay_cycles(20)
	call SPI_32_bit_tx_rx
	delay_cycles(20)
	delay_cycles(20)
	delay_cycles(20)
	CALL SPI_disable
	return

SPI_send_64bit:
  load sE, 8                     ; 8 digits to acquire
  call obtain_value
  call store_reg_in_first_slot
  load sE, 8                    ; 8 digits to acquire
  call obtain_value
  call store_reg_in_second_slot
  ;;  prepare Register set to be sent via SPI
  call fetch_reg_in_first_slot
  CALL SPI_enable
  delay_cycles(20)
  delay_cycles(20)
  delay_cycles(20)
  call SPI_32_bit_tx_rx
  call store_reg_in_first_slot
  call fetch_reg_in_second_slot
  delay_cycles(20)
  delay_cycles(20)
  delay_cycles(20)
  call SPI_32_bit_tx_rx
  call store_reg_in_second_slot
  delay_cycles(20)
  delay_cycles(20)
  delay_cycles(20)
  CALL SPI_disable
  call send_CR
  call send_NL
  load s5, "r"
  call UART_TX
  call send_64_bit
  call send_CR
	call send_NL
  return

dummy_routine:
	return

cold_start:
  CALL delay_1s                   ;
  CALL reset_UART_macros          ;Reset buffers in UART macros

	;=============================
	;== MAIN APPLICATION CODE
main:
  CALL delay_1s
  call clear_screen
  call cursor_home
  LOAD sB, welcome_message'upper
  LOAD sA, welcome_message'lower
  CALL send_message
  call send_CR
	call send_NL
  CALL SPI_disable
  ;;  sja1105 send configuration to ..
  call sja_config
  ;; write clock registers
  call delay_60
  call  write_clock_registers

main_loop:
  call send_CR
	call send_NL
  LOAD sB, command_sel_message'upper
	LOAD sA, command_sel_message'lower
	CALL send_message
  call send_CR
	call send_NL

  ;;  SPI operation selection



  call obtain_char
  compare s5, "["
  call z, SPI_enable

  compare s5, "W"
  call z, SPI_send_32_bit

  compare s5, "]"
	call z, SPI_disable

  compare s5,"w"
  call z, SPI_send_64bit

  compare s5, "g"
	call z, sja_config

 ;; compare s5, "r"
;;	call z, sja_prog_regs
  
  JUMP main_loop
	JUMP main
  ;; ------------------------------------


  ;;  acquire 8 chars from uart
  ;;  tx echo of each one
  ;;  send to spi the 32 bit
;;;



	;=============================
	;== SPECIAL CODE

	; Guard to avoid falling into the ISR code.
	; All unused memory jumps into this loop.
	; You could also try to recover or restart.
	default_jump fatal_error
	fatal_error: jump fatal_error  ; Infinite loop


