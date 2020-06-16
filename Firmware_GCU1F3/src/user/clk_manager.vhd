-------------------------------------------------------------------------------
-- Title      : clk manager
-- Project    : 
-------------------------------------------------------------------------------
-- File       : clk_manager.vhd
-- Author     : Filippo Marini   <filippo.marini@pd.infn.it>
-- Company    : Universita degli studi di Padova
-- Created    : 2019-05-03
-- Last update: 2019-10-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Clock manager 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 Universita degli studi di Padova
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-03  1.0      filippo Created
-------------------------------------------------------------------------------

library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;

entity clk_manager is
  port (
    board_clk      : in  std_logic;
    cdr_clk        : in  std_logic;
    clkin_sel      : in  std_logic;
    glbl_rst       : in  std_logic;
    locked         : out std_logic;
    clk_out_125    : out std_logic;
    clk_out_250    : out std_logic;
    clk_out_200    : out std_logic;
    clk_out_100   : out std_logic;
    clk_out_125_90 : out std_logic;
    clk_out_3125 : out std_logic);
end entity clk_manager;

architecture rtl of clk_manager is

  ------------------------------------------------------------------------------
  -- Component declaration for the synchroniser
  ------------------------------------------------------------------------------
  component tri_mode_ethernet_mac_0_sync_block
    port (
      clk      : in  std_logic;
      data_in  : in  std_logic;
      data_out : out std_logic
      );
  end component;

  -----------------------------------------------------------------------------
  -- Component declaration for MMCM
  -----------------------------------------------------------------------------
  component clk_wiz is
    port (
      clk_in1   : in  std_logic;
      clk_in2   : in  std_logic;
      clkin_sel : in  std_logic;
      reset     : in  std_logic;
      clk_out0  : out std_logic;
      clk_out1  : out std_logic;
      clk_out2  : out std_logic;
      clk_out3  : out std_logic;
      clk_out4  : out std_logic;
      clk_out5  : out std_logic;
      locked    : out std_logic);
  end component clk_wiz;

  -- signal declaration
  signal locked_int    : std_logic;
  signal locked_sync   : std_logic;
  signal locked_edge   : std_logic;
  signal locked_reg    : std_logic;
  signal mmcm_reset_in : std_logic;


begin  -- architecture rtl

  -- detect a falling edge on locked (after resyncing to this domain)
  -- lock_sync : tri_mode_ethernet_mac_0_sync_block
  --   port map (
  --     clk      => board_clk,
  --     data_in  => locked_int,
  --     data_out => locked_sync
  --     );

  -- for the falling edge detect we want to force this at power on so init the flop to 1
  -- dcm_lock_detect_p : process(board_clk)
  -- begin
  --   if board_clk'event and board_clk = '1' then
  --     locked_reg  <= locked_sync;
  --     locked_edge <= locked_reg and not locked_sync;
  --   end if;
  -- end process dcm_lock_detect_p;

  -- mmcm_reset_in <= glbl_rst or locked_edge;

  -----------------------------------------------------------------------------
  -- MMCM Clock generator
  -----------------------------------------------------------------------------
  clock_generator : clk_wiz
    port map (
      clk_in1   => board_clk,
      clk_in2   => cdr_clk,
      clkin_sel => clkin_sel,
      reset     => glbl_rst,
      clk_out0  => clk_out_125,
      clk_out1  => clk_out_250,
      clk_out2  => clk_out_200,
      clk_out3  => clk_out_100,
      clk_out4  => clk_out_125_90,
      clk_out5  => clk_out_3125,
      locked    => locked_int);

  locked <= locked_int;

end architecture rtl;
 
