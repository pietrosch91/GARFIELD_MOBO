
  CONSTANT SPI_output_port, 04  ; Write controls and data to SPI Flash Memory
	CONSTANT SPI_data_in_port, 03 ; Read serial data from SPI Flash
	CONSTANT spi_clk, 00000001'b  ;   spi_clk - bit0 (SPI_output_port)
	CONSTANT spi_clk_n, 11111110'b  ;   spi_clk - bit0 (SPI_output_port)
	CONSTANT spi_cs_b, 00000010'b ;  spi_cs_b - bit1 (SPI_output_port)
	CONSTANT spi_cs, 00000000'b ;  spi_cs     - bit1 (SPI_output_port)
	CONSTANT spi_mosi, 10000000'b ;  spi_mosi - bit7 (SPI_output_port)
	CONSTANT spi_mosi_n, 01111111'b ;  spi_mosi - bit7 (SPI_output_port)
	CONSTANT spi_miso, 10000000'b ;  spi_miso - bit7 (SPI_data_in_port)
  
SPI_disable:
  OR s0, spi_cs_b
  OUTPUT s0, SPI_output_port
  RETURN

SPI_enable:
  AND s0, spi_cs
	OUTPUT s0, SPI_output_port
	RETURN
                       ;
                       ;
                       ;--------------------------------------------------------------------------------------
                       ; Routine to Transmit and Receive One Byte
                       ;--------------------------------------------------------------------------------------
                       ;
                       ; SPI communication is full duplex meaning that data can be simultaneously transmitted
                       ; and received but in practice this capability is not widely exploited. As such, this
                       ; routine will often be invoked only to transmit a byte or only to receive a byte; the
                       ; fact that it actually always does both at the same time is generally ignored!
                       ;
                       ; This routine will be invoked as part of a complete transaction so the 'SPI_disable'
                       ; routine should have been used at some point prior to this routine being called and
                       ; therefore the states of the SPI signals and 's0' register contents are known. This
                       ; routine will always drive the 'spi_cs_b' signal Low to enable communication to take
                       ; place with the one slave device so there is no requirement to specifically enable
                       ; the N25Q128 device at the start of a transaction but it will be necessary to
                       ; disable it at the end.
                       ;
                       ; The instruction, address or data to be transmitted should be supplied in register
                       ; 's2' and any received information will be returned in 's2' when the routine completes.
                       ;
                       ; The transmission and reception of each bit with an associated 'spi_clk' pulse
                       ; is implemented by 14 instructions that take 28 clock cycles to execute. Hence the
                       ; serial data rate is the KCPSM6 clock frequency divided by 24 (e.g. 3.57 Mbit/s with a
                       ; 100MHz clock ). This is generally a much lower data rate than an SPI device can
                       ; support so no special timing considerations are required. For higher data rates a
                       ; hardware peripheral consisting of a shift register and pulse generator should be
                       ; investigated.
                       ;
                       ; As a KCPSM6 is the SPI master the signal sequence implemented is as follows..
                       ;
                       ;   Receive data bit from spi_miso line (Flash transmits on previous falling edge)
                       ;   Transmit data bit on spi_mosi line (data set up before rising edge of spi_clk)
                       ;   Drive spi_clk transition from low to high (Flash captures data bit)
                       ;   Drive spi_clk transition from high to low (Flash outputs next data bit)
                       ;
SPI_FLASH_tx_rx:
  LOAD s1, 32                   ;8-bits to transmit and receive
next_SPI_FLASH_bit:
  LOAD s0, s2                   ;prepare next bit to transmit
  AND s0, spi_mosi              ;isolates data bit and spi_cs_b = 0
  OUTPUT s0, SPI_output_port    ;output data bit ready to be used on rising clock edge
  INPUT s3, SPI_data_in_port    ;read input bit
  TEST s3, spi_miso             ;carry flag becomes value of received bit
  SLA s2                        ;shift new data into result and move to next transmit bit
  CALL SPI_clock_pulse          ;pulse spi_clk High
  SUB s1, 01                    ;count bits
  JUMP NZ, next_SPI_FLASH_bit   ;repeat until last bit
  RETURN                     ;
                       ;
                       ;--------------------------------------------------------------------------------------
                       ; Routine to Generate One 'spi_clk' Pulse
                       ;--------------------------------------------------------------------------------------
                       ;
                       ; This routine will generate one positive pulse on the 'spi_clk' line.
                       ;
                       ; Register 's0' is used and bit1 and bit7 must previously define the required states
                       ; of 'spi_cs_b' and 'spi_mosi' which will remain unchanged.
                       ;
SPI_clock_pulse:
  OR s0, spi_clk                ;clock High (bit0)
  OUTPUT s0, SPI_output_port    ;drive clock High
  AND s0, ~spi_clk              ;clock Low (bit0)
  OUTPUT s0, SPI_output_port    ;drive clock Low
  RETURN
                       ;
                       ;
  ;; data to shift out must be loaded into sA, sB, sC, sD
SPI_32_bit_tx_rx:
  ;; first register:
  ;; shift out sA
  load s1, 0x21 
spi_loop:
  sub s1, 1
  JUMP Z, end_spi_routine
  sl0 sA
  sla sB
  sla sC
  sla sD
  jump C, send_one
send_zero:
  or s0, spi_clk                ; rising edge
	and s0, spi_mosi_n            ; set to zero mosi bit
	output s0, SPI_output_port    ;
	;;; half period delay
  delay_cycles(10)
	and s0, spi_clk_n             ; falling edge
	output s0, SPI_output_port    ;
	input s3, SPI_data_in_port    ; capture from slave sdo
  jump capture_miso
send_one:
  or s0, spi_clk                ; rising edge
  or s0, spi_mosi               ; set to one the mosi bit
  output s0, SPI_output_port    ;
;; half period delay
  delay_cycles(10)
  and s0, spi_clk_n             ; falling edge
  output s0, SPI_output_port    ;
  input s3, SPI_data_in_port    ; capture from slave sdo
	and s0, spi_clk_n             ; falling edge
capture_miso:
  sr0(S3,7)
  OR sA, s3
  jump  spi_loop
end_spi_routine:
  return
