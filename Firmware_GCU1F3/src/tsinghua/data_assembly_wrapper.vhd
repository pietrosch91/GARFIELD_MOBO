-------------------------------------------------------------------------------
-- Title      : data assembly vhdl wrapper
-- Project    : 
-------------------------------------------------------------------------------
-- File       : data_assembly.vhd
-- Author     : Antonio Bergnoli  <antonio@nbbergnoli.pd.infn.it>
-- Company    : 
-- Created    : 2019-02-26
-- Last update: 2019-05-02
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

entity data_assembly_wrapper is

  generic (
    fmc_reg_width : integer;
    channel_num   : integer);

  port (
    adc_raw_data                : in  std_logic_vector(127 downto 0);
    adc_user_clk                : in  std_logic;
    init_rst                    : in  std_logic;
    trig_in                     : in  std_logic;
    gcu_id                      : in  std_logic_vector(15 downto 0);
    time_cnt                    : in  std_logic_vector(63 downto 0);
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

end entity data_assembly_wrapper;

architecture wrap of data_assembly_wrapper is

  component data_assembly is
    generic (
      fmc_reg_width : integer;
      channel_num   : integer);
    port (
      adc_raw_data                : in  std_logic_vector(127 downto 0);
      adc_user_clk                : in  std_logic;
      init_rst                    : in  std_logic;
      trig_in                     : in  std_logic;
      gcu_id                      : in  std_logic_vector(15 downto 0);
      time_cnt                    : in  std_logic_vector(63 downto 0);
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
  end component data_assembly;

begin  -- architecture wrap
  old_packager : if  false generate

    data_assembly_1 : data_assembly
      generic map (
        fmc_reg_width => fmc_reg_width,
        channel_num   => channel_num)
      port map (
        adc_raw_data                => adc_raw_data,
        adc_user_clk                => adc_user_clk,
        init_rst                    => init_rst,
        trig_in                     => trig_in,
        gcu_id                      => gcu_id,
        time_cnt                    => time_cnt,
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
  end generate old_packager;

  new_packager : if true generate

    l1_cache_1 : entity work.l1_cache
      generic map (
        channel_number => channel_num,
        g_d_size       => 16,
        g_a_size       => 12)
      port map (
        clk              => init_clk,
        reset            => init_rst,
        gcu_id           => gcu_id,
        adc_data_i       => adc_raw_data,
        adc_clk_i        => adc_user_clk,
        pkg_data_o       => data_channel_fifo_out(127 downto 0),
        valid_data_o     => data_channel_fifo_out_valid (0),
        Trig_time        => time_cnt(47 downto 0),
        abs_time         => time_cnt(47 downto 0),
        Validated_trig_i => trig_in);
  end generate new_packager;
end architecture wrap;



