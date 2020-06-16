-------------------------------------------------------------------------------
-- Title      : Testbench for design "dac_config_wrapper"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : dac_config_wrapper_tb.vhd
-- Author     : Antonio Bergnoli  <antonio@nbbergnoli.pd.infn.it>
-- Company    : 
-- Created    : 2019-02-27
-- Last update: 2019-02-27
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-02-27  1.0      antonio	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity dac_config_wrapper_tb is

end entity dac_config_wrapper_tb;

-------------------------------------------------------------------------------

architecture test of dac_config_wrapper_tb is

  -- component generics
  constant CONFIG_BASE_ADDR : std_logic_vector(31 downto 0) := X"00000010";

  -- component ports
  signal rst               : std_logic;
  signal config_done       : std_logic;
  signal config_din_valid  : std_logic:='0';
  signal config_din_addr   : std_logic_vector(31 downto 0):= (others => '0');
  signal config_din_data   : std_logic_vector(31 downto 0):= (others => '0');
  signal config_dout_valid : std_logic;
  signal config_dout_addr  : std_logic_vector(31 downto 0);
  signal config_dout_data  : std_logic_vector(31 downto 0);
  signal dac_spi_ck        : std_logic;
  signal dac_spi_mosi      : std_logic;
  signal dac_spi_miso      : std_logic :='0';
  signal dac_spi_syncn     : std_logic;
  signal dac_ldac          : std_logic;

  -- clock
  signal Clk : std_logic := '1';

begin  -- architecture test

  -- component instantiation
  DUT: entity work.dac_config_wrapper
    generic map (
      CONFIG_BASE_ADDR => CONFIG_BASE_ADDR)
    port map (
      clk               => clk,
      rst               => rst,
      config_done       => config_done,
      config_din_valid  => config_din_valid,
      config_din_addr   => config_din_addr,
      config_din_data   => config_din_data,
      config_dout_valid => config_dout_valid,
      config_dout_addr  => config_dout_addr,
      config_dout_data  => config_dout_data,
      dac_spi_ck        => dac_spi_ck,
      dac_spi_mosi      => dac_spi_mosi,
      dac_spi_miso      => dac_spi_miso,
      dac_spi_syncn     => dac_spi_syncn,
      dac_ldac          => dac_ldac);

  -- clock generation
  Clk <= not Clk after 4 ns;            -- 125 Mhzx

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
    rst <='0';
    wait for 1 us;
    rst <= '1';
    wait for 1 us;
    rst <='0';
    wait;
  end process WaveGen_Proc;

end architecture test;
