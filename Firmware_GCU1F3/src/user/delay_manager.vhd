-------------------------------------------------------------------------------
-- Title      : Delay control manager
-- Project    : 
-------------------------------------------------------------------------------
-- File       : delay_manager.vhd
-- Author     : Filippo Marini   <filippo.marini@pd.infn.it>
-- Company    : Universita degli studi di Padova
-- Created    : 2019-05-07
-- Last update: 2019-05-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 Universita degli studi di Padova
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-07  1.0      filippo Created
-------------------------------------------------------------------------------

library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;

entity delay_manager is
  port (
    ref_clk       : in  std_logic;
    gtx_clk       : in  std_logic;
    mmcm_locked   : in  std_logic;
    dlyctrl_ready : out std_logic;
   -- debug
    dlyctrl_reset_dbg : out std_logic
    );
end entity delay_manager;

architecture rtl of delay_manager is

  component tri_mode_ethernet_mac_0_support_resets is
    port (
      glbl_rstn            : in  std_logic;
      refclk               : in  std_logic;
      idelayctrl_ready     : in  std_logic;
      idelayctrl_reset_out : out std_logic;
      gtx_clk              : in  std_logic;
      gtx_dcm_locked       : in  std_logic;
      gtx_mmcm_rst_out     : out std_logic);
  end component tri_mode_ethernet_mac_0_support_resets;

  signal dlyctrl_reset : std_logic;
  signal s_dlyctrl_ready : std_logic;


begin  -- architecture rtl

  dlyctrl_ready <= s_dlyctrl_ready;
  dlyctrl_reset_dbg <= dlyctrl_reset;

  gcu_idelayctrl_common_i : IDELAYCTRL
    generic map (
      SIM_DEVICE => "7SERIES"
      )
    port map (
      RDY    => s_dlyctrl_ready,
      REFCLK => ref_clk,
      RST    => not mmcm_locked
      );


  -- support_resets_i : tri_mode_ethernet_mac_0_support_resets
  --   port map(
  --     glbl_rstn            => '1',  -- active low, not necessary
  --     refclk               => ref_clk,
  --     idelayctrl_ready     => s_dlyctrl_ready,
  --     idelayctrl_reset_out => dlyctrl_reset,
  --     gtx_clk              => gtx_clk,
  --     gtx_dcm_locked       => mmcm_locked,
  --     gtx_mmcm_rst_out     => open 
  --     );

end architecture rtl;
