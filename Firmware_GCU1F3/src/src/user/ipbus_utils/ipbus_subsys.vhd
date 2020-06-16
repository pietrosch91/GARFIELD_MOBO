-------------------------------------------------------------------------------
-- Title      : ipbus subsystem
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ipbus_subsys.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    : infn
-- Created    : 2017
-- Last update: 2019-07-05
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: ipbus slaves subsytem
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author                            Description
-- 2017        1.0      Rutherford Appleton Laboratory    created
-- 2019-02-25  1.1      antonio                           added custom slaves
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


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.ipbus.all;
use work.ipbus_reg_types.all;
use work.ipbus_decode_gcu1f3.all;
use work.utils_package.all;

entity ipbus_subsys is
  port(
    ipb_clk : in  std_logic;
    ipb_rst : in  std_logic;
    ipb_in  : in  ipb_wbus;
    ipb_out : out ipb_rbus;
    --

    Clear_in          : in  std_logic;
    gcu_id            : in  std_logic_vector(15 downto 0);
    adc_data_i        : in  T_SLVV_128(2 downto 0);
    adc_clk_i         : in  std_logic_vector(2 downto 0);
    local_time        : in  T_SLVV_48(2 downto 0);  -- already synchronized
                                                    -- with correspoinding adc_clk
    ext_trig_i        : in  std_logic;
    -- adu_manager ports
    adu_enables       : out std_logic_vector(2 downto 0);
    adu_clock_enables : out std_logic_vector(2 downto 0);
    -- gpios
    bec_connected     : out std_logic;
    -- debug
    l1a_time          : in  std_logic_vector(47 downto 0);
    l1a_time_ready    : in  std_logic_vector(2 downto 0);
    trig_request      : out std_logic_vector(2 downto 0);
    time_to_send      : in  std_logic_vector(31 downto 0);
    aligned_i         : in  std_logic;
    dlyctrl_ready     : in  std_logic;
    dlyctrl_reset     : in  std_logic
    );
end ipbus_subsys;

architecture rtl of ipbus_subsys is

  signal ipbw         : ipb_wbus_array(N_SLAVES - 1 downto 0);
  signal ipbr         : ipb_rbus_array(N_SLAVES - 1 downto 0);
  signal ctrl, stat   : ipb_reg_v(0 downto 0);
  signal trig_in      : std_logic_vector(2 downto 0);
  signal trig_out     : std_logic_vector(2 downto 0);
  signal trig_time_s  : T_SLVV_48(2 downto 0);
-------------------------------------------------------------------------------
-- DAQ constants
-------------------------------------------------------------------------------
  constant addr_width : positive := 6;
  type ipbus_addr_index_t is array (natural range 0 to 2) of integer;
  constant ipbus_daq_addr_index : ipbus_addr_index_t := (N_SLV_IPBUS_FIFO_0,
                                                         N_SLV_IPBUS_FIFO_1,
                                                         N_SLV_IPBUS_FIFO_2);
  constant ipbus_l1_cache_addr_index : ipbus_addr_index_t := (N_SLV_L1_CACHE_0,
                                                              N_SLV_L1_CACHE_1,
                                                              N_SLV_L1_CACHE_2);
  -----------------------------------------------------------------------------
  signal pkg_data_o   : T_SLVV_128(2 downto 0);
  signal valid_data_o : std_logic_vector(2 downto 0);
begin

-- ipbus address decode

  fabric : entity work.ipbus_fabric_sel
    generic map(
      NSLV      => N_SLAVES,
      SEL_WIDTH => IPBUS_SEL_WIDTH)
    port map(
      ipb_in          => ipb_in,
      ipb_out         => ipb_out,
      sel             => ipbus_sel_gcu1f3(ipb_in.ipb_addr),
      ipb_to_slaves   => ipbw,
      ipb_from_slaves => ipbr
      );

-------------------------------------------------------------------------------
-- ipbus slaves
-------------------------------------------------------------------------------

  dspsim1: entity work.dsp_simulator
    generic map(
        IDMA_ADDR_WIDTH => 8,
        IDMA_DATA_WIDTH => 16)
    port map(
        dsp_rst           =>  ipb_rst,
        dsp_clk           => ipb_clk,
        ipb_clk           => ipb_clk,
        ipb_rst            =>  ipb_rst,   
        ipbus_in           =>ipbw(N_SLV_DSP_SIM),
        ipbus_out          => ipbr(N_SLV_DSP_SIM),
        --nIACK: out std_logic;
        nWR => '1',
        nRD => '1',
        nIAL => '1',
        nIS => '1',
        IAD => open
    );
  
  
  
  
  
  
  
  ipbus_ram_1 : entity work.ipbus_ram
    generic map (
      ADDR_WIDTH => 4)
    port map (
      clk       => ipb_clk,
      reset     => ipb_rst,
      ipbus_in  => ipbw(N_SLV_RAM),
      ipbus_out => ipbr(N_SLV_RAM)
      );
      
  ipbus_test_1 : entity work.ipbus_test
    port map (
         clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbw(N_SLV_TEST_REG),
        ipbus_out           => ipbr(N_SLV_TEST_REG)
    );

   ipbus_counter_1 : entity work.ipbus_counter
    port map (
         clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbw(N_SLV_COUNTER),
        ipbus_out           => ipbr(N_SLV_COUNTER)
   );
   
    ipbus_memblk_1 : entity work.ipbus_memblk    port map (
         clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbw(N_SLV_MEM_BLK),
        ipbus_out           => ipbr(N_SLV_MEM_BLK)
   );

  ipbus_trigger_manager_1 : entity work.ipbus_trigger_manager
    port map (
      clk                 => ipb_clk,
      reset               => ipb_rst,
      ipbus_in            => ipbw(N_SLV_TRIGGER_MANAGER),
      ipbus_out           => ipbr(N_SLV_TRIGGER_MANAGER),
      ext_trigger_i       => ext_trig_i,
      trig_in             => trig_in,
      trig_out            => trig_out,
      trig_accept         => l1a_time_ready,
      trig_request        => trig_request,
      local_time          => local_time,
      trigger_time        => trig_time_s,
      l1a_time_from_ttc   => l1a_time,
      l1a_time_to_l1cache => open
      );
  daq_instances : for adu_number in 0 to 2 generate

    l1_cache_i : entity work.l1_cache
      generic map (
        channel_number => adu_number,
        g_d_size       => 16,
        g_a_size       => 11)           -- 16 us on L1 cache
      port map (
        clk              => ipb_clk,
        reset            => ipb_rst,
        ipbus_in         => ipbw(ipbus_l1_cache_addr_index(adu_number)),
        ipbus_out        => ipbr(ipbus_l1_cache_addr_index(adu_number)),
        -- to port
        gcu_id           => gcu_id,
        adc_data_i       => adc_data_i(adu_number),
        adc_clk_i        => adc_clk_i(adu_number),
        -- connect to DAQ
        pkg_data_o       => pkg_data_o(adu_number),
        valid_data_o     => valid_data_o(adu_number),
        -- Timing signals
        Trig_time        => trig_time_s(adu_number),
        local_time       => local_time(adu_number),
        Trig_o           => trig_in(adu_number),
        Validated_trig_i => trig_out(adu_number));

    ipbus_daq_i : entity work.ipbus_daq
      generic map (
        addr_width => addr_width)
      port map (
        clk        => ipb_clk,
        reset      => ipb_rst,
        ipbus_in   => ipbw(ipbus_daq_addr_index(adu_number)),
        ipbus_out  => ipbr(ipbus_daq_addr_index(adu_number)),
        Full_out   => open,
        Data_in    => pkg_data_o(adu_number),
        WriteEn_in => valid_data_o(adu_number),
        WClk       => adc_clk_i(adu_number),
        Clear_in   => Clear_in);

  end generate daq_instances;

  ipbus_adu_manager_1 : entity work.ipbus_adu_manager
    port map (
      clk               => ipb_clk,
      reset             => ipb_rst,
      ipbus_in          => ipbw(N_SLV_ADU_MANAGER),
      ipbus_out         => ipbr(N_SLV_ADU_MANAGER),
      adu_enables       => adu_enables,
      adu_clock_enables => adu_clock_enables);


  ipbus_fw_data_1 : entity work.ipbus_fw_data
    port map (
      clk       => ipb_clk,
      reset     => ipb_rst,
      ipbus_in  => ipbw(N_SLV_USER_DATA),
      ipbus_out => ipbr(N_SLV_USER_DATA));

  ipbus_gpio_1 : entity work.ipbus_gpio
    port map (
      clk           => ipb_clk,
      reset         => ipb_rst,
      ipbus_in      => ipbw(N_SLV_GPIO),
      ipbus_out     => ipbr(N_SLV_GPIO),
      aligned_i     => aligned_i,
      bec_connected => bec_connected,
      dlyctrl_ready => dlyctrl_ready,
      dlyctrl_reset => dlyctrl_reset
      );

  ipbus_debug_1 : entity work.ipbus_debug
    port map (
      clk          => ipb_clk,
      reset        => ipb_rst,
      ipbus_in     => ipbw(N_SLV_DEBUG1),
      ipbus_out    => ipbr(N_SLV_DEBUG1),
      debug_signal => l1a_time(31 downto 0)
      );

  ipbus_debug_2 : entity work.ipbus_debug
    port map (
      clk          => ipb_clk,
      reset        => ipb_rst,
      ipbus_in     => ipbw(N_SLV_DEBUG2),
      ipbus_out    => ipbr(N_SLV_DEBUG2),
      debug_signal => time_to_send
      );

end rtl;
