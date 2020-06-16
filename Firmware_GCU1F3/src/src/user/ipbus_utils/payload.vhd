-------------------------------------------------------------------------------
-- Title      : ipbus payload
-- Project    :
-------------------------------------------------------------------------------
-- File       : payload.vhd
-- Author     : Antonio Bergnoli  <antonio@dhcp-39.pd.infn.it>
-- Company    :
-- Created    : 2019-03-15
-- Last update: 2019-07-05
-- Platform   :
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description:contains the ipbus slaves subsystems and the related custom logic
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-03-15  1.0      antonio Created
-------------------------------------------------------------------------------

---------------------------------------------------------------------------------
--
--   Copyright 2017 - Rutherford Appleton Laboratory and University of Bristol
--
--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.
--
--                                     - - -
--
--   Additional information about ipbus-firmare and the list of ipbus-firmware
--   contacts are available at
--
--       https://ipbus.web.cern.ch/ipbus
--
---------------------------------------------------------------------------------

-- payload_simple_example
--
-- selection of different IPBus slaves without actual function,
-- just for performance evaluation of the IPbus/uhal system
--
-- Alessandro Thea, September 2018

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library unisim;
use unisim.vcomponents.all;
use work.ipbus.all;
use work.ipbus_reg_types.all;
use work.utils_package.all;
entity payload is
  port(
    board_clk         : in  std_logic;
    ipb_clk           : in  std_logic;
    ipb_rst           : in  std_logic;
    ipb_in            : in  ipb_wbus;
    ipb_out           : out ipb_rbus;
    clk               : in  std_logic;
    rst               : in  std_logic;
    nuke              : out std_logic;
    soft_rst          : out std_logic;
    userled           : out std_logic;
    ext_trigger       : in  std_logic;
    adc_raw_data      : in  T_SLVV_128(2 downto 0);
    adc_user_clk      : in  std_logic_vector(2 downto 0);
    adu_enables       : out std_logic_vector(2 downto 0);
    adu_clock_enables : out std_logic_vector(2 downto 0);
    gcu_id            : in  std_logic_vector(15 downto 0);
    bec_connected     : out std_logic;
    local_time        : in  std_logic_vector(47 downto 0);
    -- debug
    l1a_time          : in  std_logic_vector(47 downto 0);
    l1a_time_ready    : in  std_logic_vector(2 downto 0);
    trig_request      : out std_logic_vector(2 downto 0);
    time_to_send      : in  std_logic_vector(31 downto 0);
    aligned_i         : in  std_logic;
    dlyctrl_ready     : in  std_logic;
    dlyctrl_reset     : in  std_logic
    );

end payload;

architecture rtl of payload is

  signal init_rst : std_logic;          -- active high generate a pulse

  signal trig_in : std_logic;           -- connect to slow clock

  -- connect to ipbus fifo WriteEn_in
  signal data_channel_fifo_rd_en       : T_SLVV_2(2 downto 0);
  -- attribute dont_touch                            : string;
  -- attribute dont_touch of data_channel_fifo_rd_en : signal is "true";
  signal data_channel_fifo_rd_en_adu_a : std_logic_vector(2 downto 0);
  signal data_channel_fifo_rd_en_adu_b : std_logic_vector(2 downto 0);
  signal time_cnt_s                    : std_logic_vector(63 downto 0);
  signal time_cnt_s_flop_1             : T_SLVV_64(2 downto 0);
  signal time_cnt_s_flop_2             : T_SLVV_64(2 downto 0);
  signal local_time_adu                : T_SLVV_48(2 downto 0);
  -- output from packager
  -- connect to ipbus fifo Data_in only first 128 bit in  the case of ADU a )
  signal data_channel_fifo_out         : T_SLVV_256(2 downto 0);
  signal data_channel_fifo_out_adu_a   : T_SLVV_128(2 downto 0);
  signal data_channel_fifo_out_adu_b   : T_SLVV_128(2 downto 0);

  signal data_channel_fifo_out_valid       : T_SLVV_2(2 downto 0);
  signal data_channel_fifo_out_valid_adu_a : std_logic_vector(2 downto 0);
  signal data_channel_fifo_out_valid_adu_b : std_logic_vector(2 downto 0);

  signal data_channel_fifo_full       : T_SLVV_2(2 downto 0);
  signal data_channel_fifo_full_adu_a : std_logic_vector(2 downto 0);
  signal data_channel_fifo_full_adu_b : std_logic_vector(2 downto 0);

  signal data_channel_fifo_empty       : T_SLVV_2(2 downto 0);
  -- attribute dont_touch of data_channel_fifo_empty : signal is "true";
  signal data_channel_fifo_empty_adu_a : std_logic_vector(2 downto 0);
  signal data_channel_fifo_empty_adu_b : std_logic_vector(2 downto 0);


  signal clk_cdr_s                   : std_logic;
  signal local_time_graycoded        : std_logic_vector(47 downto 0);
  signal local_time_graycoded_flop_1 : T_SLVV_48(2 downto 0);
  signal local_time_graycoded_flop_2 : T_SLVV_48(2 downto 0);
  constant ref_clk_period_ns         : integer := 8;  -- input clock period width in nanoseconds
  constant output_pulse_period_ms    : integer := 1000;  -- output period in ms.
  constant n_pulse_up                : integer := 5;  -- number of input clock periods that
begin

  ipbus_subsys_i : entity work.ipbus_subsys
    port map(
      ipb_clk => ipb_clk,
      ipb_rst => ipb_rst,
      ipb_in  => ipb_in,
      ipb_out => ipb_out,

      -- L1 cache ports
      gcu_id     => gcu_id,             -- OK
      adc_data_i => adc_raw_data,
      adc_clk_i  => adc_user_clk,
      local_time   => local_time_adu,
      ext_trig_i => ext_trigger,

      Clear_in          => ipb_rst,
      adu_enables       => adu_enables,
      adu_clock_enables => adu_clock_enables,
      -- gpio ports
      bec_connected     => bec_connected,
      -- debug signals
      l1a_time          => l1a_time,
      l1a_time_ready    => l1a_time_ready,
      trig_request      => trig_request,
      time_to_send      => time_to_send,
      aligned_i         => aligned_i,
      dlyctrl_ready     => dlyctrl_ready,
      dlyctrl_reset     => dlyctrl_reset
      );

-------------------------------------------------------------------------------
-- Local time cross domain: Gray code conv. -> double flop -> Binary code conv.
-------------------------------------------------------------------------------


  -- Binary to gray                   Double flop        Gray to bin
  -- +-----------------+              +----------+      +-----------+
  -- |                 +-------------->          +------>           |
  -- |                 |              +----------+      +-----------+
  -- |                 |
  -- |                 |              +----------+      +-----------+
  -- |                 +-------------->          +------>           |
  -- |                 |              +----------+      +-----------+
  -- |                 |
  -- |                 |              +----------+      +-----------+
  -- |                 +-------------->          +------>           |
  -- +-----------------+              +----------+      +-----------+

  -- convert local time to gray code
  bin2gray_1 : entity work.bin2gray
    generic map (
      width => local_time'length)       -- input and output data width
    port map (
      binary_in => local_time,          -- 125 Mhz
      gray_out  => local_time_graycoded);

  local_time_cross_domain : for adu_number in 0 to 2 generate

    -- Double flopping master clock ( gray code )

    double_flop_master_clock : process (adc_user_clk(adu_number)) is
    begin  -- process double_flop_master_clock
      if rising_edge(adc_user_clk(adu_number)) then  -- rising clock edge
        local_time_graycoded_flop_1(adu_number) <= local_time_graycoded;
        local_time_graycoded_flop_2(adu_number) <= local_time_graycoded_flop_1(adu_number);
      end if;
    end process double_flop_master_clock;

    -- convert to binary for timestamping frames
    gray2bin_i : entity work.gray2bin
      generic map (
        width => 48)
      port map (
        in_gray => local_time_graycoded_flop_2(adu_number),
        out_bin => local_time_adu(adu_number));

  end generate local_time_cross_domain;
end rtl;
