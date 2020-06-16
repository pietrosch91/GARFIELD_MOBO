-------------------------------------------------------------------------------
-- Title      : multicicle path block
-- Project    : 
-------------------------------------------------------------------------------
-- File       : mcp_block.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    : 
-- Created    : 2019-06-03
-- Last update: 2019-06-14
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: manage the CDC for vectors 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-03  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity mcp_block is

  generic (
    DATA_WIDTH : integer := 8);

  port (
    a_clk             : in  std_logic;
    a_rst             : in  std_logic;
    a_data_in         : in  std_logic_vector(DATA_WIDTH - 1 downto 0);
    a_pulse_valid_in  : in  std_logic;
    --
    b_clk             : in  std_logic;
    b_rst             : in  std_logic;
    b_data_out        : out std_logic_vector(DATA_WIDTH - 1 downto 0);
    b_pulse_valid_out : out std_logic
    );

end entity mcp_block;

architecture rtl of mcp_block is

  constant NUM_FLIP_FLOPS : natural := 2;  -- number of flip-flops in the synchronizer chain
  constant N_PULSES       : natural := 10;


  signal a_pulse_valid_in_shaped      : std_logic;
  signal a_pulse_valid_in_shaped_sync : std_logic;
  signal a_pulse_valid_in_sync_flag   : std_logic;

begin  -- architecture rtl

  -- a side: 
  -----------------------------------------------------------------------------
  -- shaper + synchronizer + edge detect
  -----------------------------------------------------------------------------
  -- N_PULSES must accomodate the differences between the two clock domain
  shaper_1 : entity work.shaper
    generic map (
      N_PULSES => N_PULSES)
    port map (
      clk_in     => a_clk,
      sig_in     => a_pulse_valid_in,
      shaped_out => a_pulse_valid_in_shaped);

  synchronizer_1 : entity work.synchronizer
    generic map (
      NUM_FLIP_FLOPS => NUM_FLIP_FLOPS)  -- number of flip-flops in the synchronizer chain
    port map (
      rst      => b_rst,                -- asynchronous, high-active
      clk      => b_clk,                -- destination clock
      data_in  => a_pulse_valid_in_shaped,
      data_out => a_pulse_valid_in_shaped_sync);

  edge_detector_1 : entity work.edge_detector
    port map (
      clk   => b_clk,
      rst   => b_rst,
      input => a_pulse_valid_in_shaped_sync,
      pulse => a_pulse_valid_in_sync_flag);

  b_pulse_valid_out <= a_pulse_valid_in_shaped;
  b_data_out        <= a_data_in;

end architecture rtl;
