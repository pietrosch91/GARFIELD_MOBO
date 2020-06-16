-------------------------------------------------------------------------------
-- Title      : Testbench for design "adu_top_wrapper"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : adu_top_wrapper_tb.vhd
-- Author     : Antonio Bergnoli  <antonio@nbbergnoli.pd.infn.it>
-- Company    : 
-- Created    : 2019-02-27
-- Last update: 2019-03-04
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

entity adu_top_wrapper_tb is

end entity adu_top_wrapper_tb;

-------------------------------------------------------------------------------

architecture test of adu_top_wrapper_tb is

  -- component ports
  signal init_clk          : std_logic                     := '0';
  signal init_rst          : std_logic                     := '0';
  signal test_pulse        : std_logic                     := '0';
  signal init_done_out     : std_logic;
  signal adca_dclkp        : std_logic                     := '0';
  signal adca_dclkn        : std_logic                     := '1';
  signal adca_dp           : std_logic_vector(13 downto 0) := (others => '0');
  signal adca_dn           : std_logic_vector(13 downto 0) := (others => '0');
  signal adca_syncp        : std_logic                     := '0';
  signal adca_syncn        : std_logic                     := '0';
  signal adca_scsb         : std_logic;
  signal adcb_dclkp        : std_logic                     := '0';
  signal adcb_dclkn        : std_logic                     := '1';
  signal adcb_dp           : std_logic_vector(13 downto 0) := (others => '0');
  signal adcb_dn           : std_logic_vector(13 downto 0) := (others => '0');
  signal adcb_syncp        : std_logic                     := '0';
  signal adcb_syncn        : std_logic                     := '0';
  signal adcb_scsb         : std_logic;
  signal pll_le            : std_logic;
  signal spi_clk           : std_logic;
  signal spi_en            : std_logic;
  signal spi_mosi          : std_logic;
  signal spi_miso          : std_logic                     := '0';
  signal cal_ctrl          : std_logic;
  signal config_din_valid  : std_logic                     := '0';
  signal config_din_addr   : std_logic_vector(31 downto 0) := (others => '0');
  signal config_din_data   : std_logic_vector(31 downto 0) := (others => '0');
  signal config_dout_valid : std_logic;
  signal config_dout_addr  : std_logic_vector(31 downto 0);
  signal config_dout_data  : std_logic_vector(31 downto 0);
  signal adca_user_clk     : std_logic;
  signal adca_raw_data     : std_logic_vector(127 downto 0);
  signal adcb_user_clk     : std_logic;
  signal adcb_raw_data     : std_logic_vector(127 downto 0);
  signal cs_control        : std_logic_vector(35 downto 0) := (others => '0');

begin  -- architecture test

  -- component instantiation
  DUT : entity work.adu_top_wrapper
    generic map (
      N => 0)
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

  -- clock generation
  init_clk <= not init_clk after 4 ns;
  adca_dclkp <= not  adca_dclkp after 1 ns;
  adca_dclkn <= not  adca_dclkp after 1 ns;
  adcb_dclkp <= not  adca_dclkp after 1 ns;
  adcb_dclkn <= not  adca_dclkp after 1 ns;
  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    wait;
  end process WaveGen_Proc;



end architecture test;

-------------------------------------------------------------------------------

configuration adu_top_wrapper_tb_test_cfg of adu_top_wrapper_tb is
  for test
  end for;
end adu_top_wrapper_tb_test_cfg;

-------------------------------------------------------------------------------
