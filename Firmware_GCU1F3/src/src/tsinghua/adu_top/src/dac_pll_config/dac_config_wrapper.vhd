-------------------------------------------------------------------------------
-- Title      : dac config wrapper
-- Project    : 
-------------------------------------------------------------------------------
-- File       : dac_config_wrapper.vhd
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
-- 2019-02-27  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity dac_config_wrapper is
  generic (
    CONFIG_BASE_ADDR : std_logic_vector(31 downto 0) := X"00000010");
  port (
    clk               : in  std_logic;
    rst               : in  std_logic;
    config_done       : out std_logic;
    config_din_valid  : in  std_logic;
    config_din_addr   : in  std_logic_vector(31 downto 0);
    config_din_data   : in  std_logic_vector(31 downto 0);
    config_dout_valid : out std_logic;
    config_dout_addr  : out std_logic_vector(31 downto 0);
    config_dout_data  : out std_logic_vector(31 downto 0);
    dac_spi_ck        : out std_logic;
    dac_spi_mosi      : out std_logic;
    dac_spi_miso      : in  std_logic;
    dac_spi_syncn     : out std_logic;
    dac_ldac          : out std_logic);
end entity dac_config_wrapper;

-------------------------------------------------------------------------------

architecture str of dac_config_wrapper is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
  component dac_config is
    generic (
      CONFIG_BASE_ADDR : std_logic_vector(31 downto 0));
    port (
      clk               : in  std_logic;
      rst               : in  std_logic;
      config_done       : out std_logic;
      config_din_valid  : in  std_logic;
      config_din_addr   : in  std_logic_vector(31 downto 0);
      config_din_data   : in  std_logic_vector(31 downto 0);
      config_dout_valid : out std_logic;
      config_dout_addr  : out std_logic_vector(31 downto 0);
      config_dout_data  : out std_logic_vector(31 downto 0);
      dac_spi_ck        : out std_logic;
      dac_spi_mosi      : out std_logic;
      dac_spi_miso      : in  std_logic;
      dac_spi_syncn     : out std_logic;
      dac_ldac          : out std_logic);
  end component dac_config;
begin  -- architecture str

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------



  dac_config_wrapper_1: dac_config
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
end architecture str;

-------------------------------------------------------------------------------
