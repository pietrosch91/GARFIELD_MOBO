-------------------------------------------------------------------------------
-- Title      : Testbench for design "data_assembly_wrapper"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : data_assembly_wrapper_tb.vhd
-- Author     : Antonio Bergnoli  <antonio@nbbergnoli.pd.infn.it>
-- Company    : 
-- Created    : 2019-02-26
-- Last update: 2019-02-26
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-02-26  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity data_assembly_wrapper_tb is

end entity data_assembly_wrapper_tb;

-------------------------------------------------------------------------------

architecture test of data_assembly_wrapper_tb is

  constant DATA_WIDTH            : integer                                  := 32;
  constant PRE_TRIG_D_A_ADDR     : std_logic_vector(DATA_WIDTH -1 downto 0) := X"000000F4";
  constant SAMPLE_COUNT_D_A_ADDR : std_logic_vector(DATA_WIDTH -1 downto 0) := X"000000F1";
  -- component generics

  constant fmc_reg_width             : integer                                            := 3;
  -- component ports
  signal adc_raw_data                : std_logic_vector(127 downto 0);
  signal adc_user_clk                : std_logic                                          := '0';
  signal init_rst                    : std_logic                                          := '0';
  signal trig_in                     : std_logic;
  signal config_din_valid            : std_logic                                          := '0';
  signal config_din_addr             : std_logic_vector(31 downto 0)                      := (others => '0');
  signal config_din_data             : std_logic_vector(31 downto 0)                      := (others => '0');
  signal init_clk                    : std_logic                                          := '0';
  signal data_channel_fifo_rd_en     : std_logic_vector(1 downto 0)                       := (others => '1');
  signal trig_out                    : std_logic;
  signal config_dout_valid           : std_logic;
  signal config_dout_addr            : std_logic_vector(31 downto 0);
  signal config_dout_data            : std_logic_vector(31 downto 0);
  signal data_channel_fifo_out       : std_logic_vector(255 downto 0);
  signal data_channel_fifo_out_valid : std_logic_vector(1 downto 0);
  signal data_channel_fifo_full      : std_logic_vector(1 downto 0);
  signal data_channel_fifo_empty     : std_logic_vector(1 downto 0);
  signal windows_cnt                 : std_logic_vector(15 downto 0);
  signal start_out                   : std_logic                                          := '1';
  signal fmc_reg                     : std_logic_vector(2**fmc_reg_width*32 - 1 downto 0) := (others => '0');


-------------------------------------------------------------------------------
-- components
-------------------------------------------------------------------------------



  component data_assembly_wrapper is
    generic (
      fmc_reg_width : integer);
    port (
      adc_raw_data                : in  std_logic_vector(127 downto 0);
      adc_user_clk                : in  std_logic;
      init_rst                    : in  std_logic;
      trig_in                     : in  std_logic;
      config_din_valid            : in  std_logic;
      config_din_addr             : in  std_logic_vector(31 downto 0);
      config_din_data             : in  std_logic_vector(31 downto 0);
      init_clk                    : in  std_logic;
      data_channel_fifo_rd_en     : in  std_logic_vector(1 downto 0);
      trig_out                    : out std_logic;
      config_dout_valid           : out std_logic;
      config_dout_addr            : out std_logic_vector(31 downto 0);
      config_dout_data            : out std_logic_vector(31 downto 0);
      data_channel_fifo_out       : out std_logic_vector(255 downto 0);
      data_channel_fifo_out_valid : out std_logic_vector(1 downto 0);
      data_channel_fifo_full      : out std_logic_vector(1 downto 0);
      data_channel_fifo_empty     : out std_logic_vector(1 downto 0);
      windows_cnt                 : out std_logic_vector(15 downto 0);
      start_out                   : in  std_logic;
      fmc_reg                     : in  std_logic_vector(2**fmc_reg_width*32 - 1 downto 0));
  end component data_assembly_wrapper;
begin  -- architecture test

  -- component instantiation
  DUT : data_assembly_wrapper
    generic map (
      fmc_reg_width => fmc_reg_width)
    port map (
      adc_raw_data                => adc_raw_data,
      adc_user_clk                => adc_user_clk,
      init_rst                    => init_rst,
      trig_in                     => trig_in,
      config_din_valid            => config_din_valid,
      config_din_addr             => config_din_addr,
      config_din_data             => config_din_data,
      init_clk                    => init_clk,
      data_channel_fifo_rd_en     => data_channel_fifo_rd_en,
      trig_out                    => trig_out,
      config_dout_valid           => config_dout_valid,
      config_dout_addr            => config_dout_addr,
      config_dout_data            => config_dout_data,
      data_channel_fifo_out       => data_channel_fifo_out,
      data_channel_fifo_out_valid => data_channel_fifo_out_valid,
      data_channel_fifo_full      => data_channel_fifo_full,
      data_channel_fifo_empty     => data_channel_fifo_empty,
      windows_cnt                 => windows_cnt,
      start_out                   => start_out,
      fmc_reg                     => fmc_reg);

  -- clock generation
  init_clk     <= not init_clk     after 16 ns;
  adc_user_clk <= not adc_user_clk after 4 ns;

  configure_windows_and_global_reset : process
  begin  -- process configure_windows
    init_rst <= '0';
    wait for 5 us;
    init_rst <= '1';
    wait for 100 ns;
    init_rst <= '0';

    config_din_valid <= '0';
    config_din_addr  <= PRE_TRIG_D_A_ADDR;
    config_din_data  <= X"00000002";
    config_din_valid <= '1';
    wait for 1 us;
    config_din_valid <= '0';
    config_din_addr  <= SAMPLE_COUNT_D_A_ADDR;
    config_din_data  <= X"00000100";
    config_din_valid <= '1';
    wait for 1 us;
    config_din_valid <= '0';
    wait;
  end process configure_windows_and_global_reset;


  -- waveform generation
  WaveGen_Proc : process
  begin
    -- insert signal assignments here
    wait until adc_user_clk = '1';
    wait until adc_user_clk = '0';
    adc_raw_data <= (others => '1');
    wait until adc_user_clk = '1';
    wait until adc_user_clk = '0';
    adc_raw_data <= (others => '0');

  end process WaveGen_Proc;

  slow_trigger : process is
  begin  -- process slow_trigger
    trig_in <= '0';
    wait for 10 us;
    trig_in <= '1';
    wait for 5 ns;
    trig_in <= '0';
  end process slow_trigger;

end architecture test;

-------------------------------------------------------------------------------

configuration data_assembly_wrapper_tb_test_cfg of data_assembly_wrapper_tb is
  for test
  end for;
end data_assembly_wrapper_tb_test_cfg;

-------------------------------------------------------------------------------
