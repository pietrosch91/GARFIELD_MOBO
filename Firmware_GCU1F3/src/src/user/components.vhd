-------------------------------------------------------------------------------
-- Title      : components package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : components.vhd
-- Author     : Antonio Bergnoli  <a.bergnoli@gmail.com>
-- Company    : 
-- Created    : 2018-08-20
-- Last update: 2018-08-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-08-20  1.0      antonio	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
package components is


  component rom is
    generic (
      C_FAMILY             : string;
      C_RAM_SIZE_KWORDS    : integer;
      C_JTAG_LOADER_ENABLE : integer);
    port (
      address     : in  std_logic_vector(11 downto 0);
      instruction : out std_logic_vector(17 downto 0);
      enable      : in  std_logic;
      rdl         : out std_logic;
      clk         : in  std_logic);
  end component rom;

--
-- UART Transmitter with integral 16 byte FIFO buffer
--

  component uart_tx6 
    Port (             data_in : in std_logic_vector(7 downto 0);
                  en_16_x_baud : in std_logic;
                    serial_out : out std_logic;
                  buffer_write : in std_logic;
           buffer_data_present : out std_logic;
              buffer_half_full : out std_logic;
                   buffer_full : out std_logic;
                  buffer_reset : in std_logic;
                           clk : in std_logic);
  end component;

--
-- UART Receiver with integral 16 byte FIFO buffer
--

  component uart_rx6 
    Port (           serial_in : in std_logic;
                  en_16_x_baud : in std_logic;
                      data_out : out std_logic_vector(7 downto 0);
                   buffer_read : in std_logic;
           buffer_data_present : out std_logic;
              buffer_half_full : out std_logic;
                   buffer_full : out std_logic;
                  buffer_reset : in std_logic;
                           clk : in std_logic);
  end component;

end package components;
