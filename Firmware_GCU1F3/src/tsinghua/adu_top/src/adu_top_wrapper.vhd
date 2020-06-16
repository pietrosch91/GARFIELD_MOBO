-------------------------------------------------------------------------------
-- Title      : adu top wrapper
-- Project    : 
-------------------------------------------------------------------------------
-- File       : adu_top_wrapper.vhd
-- Author     : Antonio Bergnoli  <antonio@nbbergnoli.pd.infn.it>
-- Company    : 
-- Created    : 2019-02-27
-- Last update: 2019-03-12
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
use ieee.std_logic_1164.all ;

-------------------------------------------------------------------------------

entity adu_top_wrapper is
  generic (
    N : integer := 0);
  port (
    init_clk      : in  std_logic;
    init_rst      : in  std_logic;      -- not dac_config_done
    test_pulse    : in  std_logic;      -- test pulse  input
    init_done_out : out std_logic;      -- left open or check manually
-- connected to i/o pins
    adca_dclkp    : in  std_logic;
    adca_dclkn    : in  std_logic;
    adca_dp       : in  std_logic_vector(13 downto 0);
    adca_dn       : in  std_logic_vector(13 downto 0);
    adca_syncp    : in  std_logic;
    adca_syncn    : in  std_logic;
    adca_scsb     : out std_logic;

    adcb_dclkp : in  std_logic;
    adcb_dclkn : in  std_logic;
    adcb_dp    : in  std_logic_vector(13 downto 0);
    adcb_dn    : in  std_logic_vector(13 downto 0);
    adcb_syncp : in  std_logic;
    adcb_syncn : in  std_logic;
    adcb_scsb  : out std_logic;

    pll_le : out std_logic;

    spi_clk  : out std_logic;
    spi_en   : out std_logic;
    spi_mosi : out std_logic;
    spi_miso : in  std_logic;

    cal_ctrl         : out std_logic;
-- optional configuration bus
    config_din_valid : in  std_logic;
    config_din_addr  : in  std_logic_vector(31 downto 0);
    config_din_data  : in  std_logic_vector(31 downto 0);

    config_dout_valid : out std_logic;
    config_dout_addr  : out std_logic_vector(31 downto 0);
    config_dout_data  : out std_logic_vector(31 downto 0);
-- 
    --connected to  user logic 
    adca_user_clk     : out std_logic;
    adca_raw_data     : out std_logic_vector(127 downto 0);
    adcb_user_clk     : out std_logic;
    adcb_raw_data     : out std_logic_vector(127 downto 0);

    cs_control : inout std_logic_vector(35 downto 0)  -- left open
    );
-------------------------------------------------------------------------------
end entity adu_top_wrapper;
architecture str of adu_top_wrapper is 

  component adu_top_wrapper is
    generic (
      N : integer);
    port (
      init_clk          : in    std_logic;
      init_rst          : in    std_logic;  -- not dac_config_done
      test_pulse        : in    std_logic;  -- test pulse  input
      init_done_out     : out   std_logic;  -- left open or check manually
      adca_dclkp        : in    std_logic;
      adca_dclkn        : in    std_logic;
      adca_dp           : in    std_logic_vector(13 downto 0);
      adca_dn           : in    std_logic_vector(13 downto 0);
      adca_syncp        : in    std_logic;
      adca_syncn        : in    std_logic;
      adca_scsb         : out   std_logic;
      adcb_dclkp        : in    std_logic;
      adcb_dclkn        : in    std_logic;
      adcb_dp           : in    std_logic_vector(13 downto 0);
      adcb_dn           : in    std_logic_vector(13 downto 0);
      adcb_syncp        : in    std_logic;
      adcb_syncn        : in    std_logic;
      adcb_scsb         : out   std_logic;
      pll_le            : out   std_logic;
      spi_clk           : out   std_logic;
      spi_en            : out   std_logic;
      spi_mosi          : out   std_logic;
      spi_miso          : in    std_logic;
      cal_ctrl          : out   std_logic;
      config_din_valid  : in    std_logic;
      config_din_addr   : in    std_logic_vector(31 downto 0);
      config_din_data   : in    std_logic_vector(31 downto 0);
      config_dout_valid : out   std_logic;
      config_dout_addr  : out   std_logic_vector(31 downto 0);
      config_dout_data  : out   std_logic_vector(31 downto 0);
      adca_user_clk     : out   std_logic;
      adca_raw_data     : out   std_logic_vector(127 downto 0);
      adcb_user_clk     : out   std_logic;
      adcb_raw_data     : out   std_logic_vector(127 downto 0);
      cs_control        : inout std_logic_vector(35 downto 0));  -- left open
  end component adu_top_wrapper;


  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------

begin  -- architecture str

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------
  adu_top_1 : adu_top
  generic map (
    N => N)
    port map (
      init_clk          => init_clk,
      init_rst          => init_rst,
      test_pulse        => test_pulse,
      init_done_out     => init_done_out,
      adca_dclkp        => adca_dclkp,
      adca_dclkn        => adca_dclkn,
      adca_dp           => adca_dp,
      adca_dn           => adca_dn,
      adca_syncp        => adca_syncp,
      adca_syncn        => adca_syncn,
      adca_scsb         => adca_scsb,
      adcb_dclkp        => adcb_dclkp,
      adcb_dclkn        => adcb_dclkn,
      adcb_dp           => adcb_dp,
      adcb_dn           => adcb_dn,
      adcb_syncp        => adcb_syncp,
      adcb_syncn        => adcb_syncn,
      adcb_scsb         => adcb_scsb,
      pll_le            => pll_le,
      spi_clk           => spi_clk,
      spi_en            => spi_en,
      spi_mosi          => spi_mosi,
      spi_miso          => spi_miso,
      cal_ctrl          => cal_ctrl,
      config_din_valid  => config_din_valid,
      config_din_addr   => config_din_addr,
      config_din_data   => config_din_data,
      config_dout_valid => config_dout_valid,
      config_dout_addr  => config_dout_addr,
      config_dout_data  => config_dout_data,
      adca_user_clk     => adca_user_clk,
      adca_raw_data     => adca_raw_data,
      adcb_user_clk     => adcb_user_clk,
      adcb_raw_data     => adcb_raw_data,
      cs_control        => cs_control);
end architecture str;
