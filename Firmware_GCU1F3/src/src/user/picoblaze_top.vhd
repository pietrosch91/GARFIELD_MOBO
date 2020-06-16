-------------------------------------------------------------------------------
-- Title      : top level picoblaze soc
-- Project    : 
-------------------------------------------------------------------------------
-- File       : picoblaze_top.vhd
-- Author     : Antonio Bergnoli  <a.bergnoli@gmail.com>
-- Company    : 
-- Created    : 2018-08-20
-- Last update: 2019-07-10
-- Platform   : 
-- Standard   : VHDL'87
-----------------------------------------------------------------------------
-- Description: 
-----------------------------------------------------------------------------
-- Copyright (c) 2018 
-----------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-08-20  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.components.all;
-------------------------------------------------------------------------------

entity picoblaze_top is

  port (
    board_clk : in  std_logic;
    rst       : in  std_logic;
    uart_tx   : out std_logic;
    uart_rx   : in  std_logic;
    spi_clk   : out std_logic;
    spi_miso  : in  std_logic;
    spi_mosi  : out std_logic;
    spi_cs_n  : out std_logic;
    sja_rst_n : out std_logic;
    led       : out std_logic);

end picoblaze_top;

-------------------------------------------------------------------------------

architecture str of picoblaze_top is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
  signal address        : std_logic_vector(11 downto 0);
  signal instruction    : std_logic_vector(17 downto 0);
  signal bram_enable    : std_logic;
  signal in_port        : std_logic_vector(7 downto 0);
  signal out_port       : std_logic_vector(7 downto 0);
  signal port_id        : std_logic_vector(7 downto 0);
  signal write_strobe   : std_logic;
  signal k_write_strobe : std_logic;
  signal read_strobe    : std_logic;
  signal interrupt      : std_logic;
  signal interrupt_ack  : std_logic;
  signal sleep          : std_logic;
  signal reset          : std_logic;
  signal sys_clk        : std_logic;
  --signal board_clk_s    : std_logic;
-------------------------------------------------------------------------------
  signal en_16_x_baud   : std_logic;

  signal uart_tx_data_in             : std_logic_vector(7 downto 0);
  signal uart_tx_buffer_write        : std_logic;
  signal uart_tx_buffer_data_present : std_logic;
  signal uart_tx_buffer_half_full    : std_logic;
  signal uart_tx_buffer_full         : std_logic;
  signal uart_tx_buffer_reset        : std_logic;

  signal uart_rx_data_out            : std_logic_vector(7 downto 0);
  signal uart_rx_buffer_read         : std_logic;
  signal uart_rx_buffer_data_present : std_logic;
  signal uart_rx_buffer_half_full    : std_logic;
  signal uart_rx_buffer_full         : std_logic;
  signal uart_rx_buffer_reset        : std_logic;

  signal read_from_uart_rx : std_logic;
  signal write_to_uart_tx  : std_logic;

  constant C_FAMILY             : string  := "7S";
  constant C_RAM_SIZE_KWORDS    : integer := 1;
  constant C_JTAG_LOADER_ENABLE : integer := 0;
-------------------------------------------------------------------------------
-- chipscope section
-------------------------------------------------------------------------------
  signal CLK                    : std_logic;
  signal DATA                   : std_logic_vector(3 downto 0);
  signal TRIG0                  : std_logic_vector(0 to 0);

  signal CONTROL0   : std_logic_vector(35 downto 0);
-------------------------------------------------------------------------------
  signal spi_clk_s  : std_logic;
  signal spi_miso_s : std_logic;
  signal spi_mosi_s : std_logic;
  signal spi_cs_n_s : std_logic;

begin  -- str
  sys_clk <= board_clk;
  -----------------------------------------------------------------------------
  -- Bauderate generator
  -----------------------------------------------------------------------------
  baudrate_gen_1 : entity work.baudrate_gen
    port map (
      sys_clk       => sys_clk,
      baud_rate_gen => en_16_x_baud);

  -----------------------------------------------------------------------------
  -- CPU instance
  -----------------------------------------------------------------------------
  kcpsm6_1 : entity work.kcpsm6
    port map (
      address        => address,
      instruction    => instruction,
      bram_enable    => bram_enable,
      in_port        => in_port,
      out_port       => out_port,
      port_id        => port_id,
      write_strobe   => write_strobe,
      k_write_strobe => k_write_strobe,
      read_strobe    => read_strobe,
      interrupt      => '0',
      interrupt_ack  => open,
      sleep          => '0',
      reset          => reset,
      clk            => sys_clk);

-------------------------------------------------------------------------------
-- Memory instance 
-------------------------------------------------------------------------------
  rom_1 : entity work.rom
    -- generic map (
    --   C_FAMILY             => C_FAMILY,
    --   C_RAM_SIZE_KWORDS    => C_RAM_SIZE_KWORDS,
    --   C_JTAG_LOADER_ENABLE => C_JTAG_LOADER_ENABLE)
    port map (
      address     => address,
      instruction => instruction,
      enable      => bram_enable,
      --rdl         => reset,
      clk         => sys_clk);

-------------------------------------------------------------------------------
-- UART MODULES
-------------------------------------------------------------------------------
  uart_rx6_1 : entity work.uart_rx6
    port map (
      serial_in           => uart_rx,
      en_16_x_baud        => en_16_x_baud,
      data_out            => uart_rx_data_out,
      buffer_read         => read_from_uart_rx,
      buffer_data_present => uart_rx_buffer_data_present,
      buffer_half_full    => uart_rx_buffer_half_full,
      buffer_full         => uart_rx_buffer_full,
      buffer_reset        => uart_rx_buffer_reset,
      clk                 => sys_clk);
-------------------------------------------------------------------------------

  uart_tx6_1 : entity work.uart_tx6
    port map (
      data_in             => uart_tx_data_in,
      en_16_x_baud        => en_16_x_baud,
      serial_out          => uart_tx,
      buffer_write        => write_to_uart_tx,
      buffer_data_present => uart_tx_buffer_data_present,
      buffer_half_full    => uart_tx_buffer_half_full,
      buffer_full         => uart_tx_buffer_full,
      buffer_reset        => uart_tx_buffer_reset,
      clk                 => sys_clk);
-------------------------------------------------------------------------------
-- UART interconnections to the CPU and GPIO ( SPI ) 

  input_ports : process(sys_clk)
  begin
    if sys_clk'event and sys_clk = '1' then
      case port_id(1 downto 0) is

        -- Read UART status at port address 00 hex
        when "00" => in_port(0) <= uart_tx_buffer_data_present;
                     in_port(1) <= uart_tx_buffer_half_full;
                     in_port(2) <= uart_tx_buffer_full;
                     in_port(3) <= uart_rx_buffer_data_present;
                     in_port(4) <= uart_rx_buffer_half_full;
                     in_port(5) <= uart_rx_buffer_full;

        -- Read UART_RX6 data at port address 01 hex
        -- (see 'buffer_read' pulse generation below) 
        when "01" => in_port <= uart_rx_data_out;


                     -- Unused port address 02 hex
                     -- when "10" =>       in_port <= ????;

                     -- Read SPI serial data MISO at address 03 hex
                     -- Bit7 used to help with MSB first nature of SPI communication

        when "11" => in_port <= spi_miso_s & "0000000";


                     -- Don't Care for unsued case(s) ensures minimum logic implementation  

        when others => in_port <= "XXXXXXXX";

      end case;

      -- Generate 'buffer_read' pulse following read from port address 01

      if (read_strobe = '1') and (port_id(1 downto 0) = "01") then
        read_from_uart_rx <= '1';
      else
        read_from_uart_rx <= '0';
      end if;

    end if;
  end process input_ports;

  output_ports : process(sys_clk)
  begin
    if sys_clk'event and sys_clk = '1' then
      -- 'write_strobe' is used to qualify all writes to general output ports.
      if write_strobe = '1' then

        -- Signals to SPI Flash Memory at address 04 hex.
        -- Bit7 used for MOSI to help with MSB first nature of SPI communication

        if port_id(2) = '1' then
          spi_clk_s  <= out_port(0);
          spi_cs_n_s <= out_port(1);
          spi_mosi_s <= out_port(7);
        end if;

      end if;
    end if;
  end process output_ports;

  uart_tx_data_in <= out_port;

  write_to_uart_tx <= '1' when (write_strobe = '1') and (port_id(0) = '1')
                      else '0';
  constant_output_ports : process(sys_clk)
  begin
    if sys_clk'event and sys_clk = '1' then
      if k_write_strobe = '1' then

        if port_id(0) = '1' then
          uart_tx_buffer_reset <= out_port(0);
          uart_rx_buffer_reset <= out_port(1);
        end if;

      end if;
    end if;
  end process constant_output_ports;
  blink : process (sys_clk)
    variable cnt : integer := 0;
  begin  -- process blink
    if rising_edge(sys_clk) then        -- rising clock edge
      cnt := cnt + 1;
      if cnt = 50000000 then
        led <= '1';
      elsif cnt = 100000000 then
        cnt := 0;
        led <= '0';
      end if;
    end if;
  end process blink;

  sja_rst_n <= '1';

-------------------------------------------------------------------------------
-- port assignment
-------------------------------------------------------------------------------
  spi_clk    <= spi_clk_s;
  spi_mosi   <= spi_mosi_s;
  spi_miso_s <= spi_miso;
  spi_cs_n   <= spi_cs_n_s;
end str;
