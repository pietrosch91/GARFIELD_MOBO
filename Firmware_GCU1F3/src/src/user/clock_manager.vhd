-------------------------------------------------------------------------------
-- Title      : main clock manager
-- Project    : 
-------------------------------------------------------------------------------
-- File       : clock_manager.vhd
-- Author     : Antonio Bergnoli  <antonio@Air-di-Antonio.homenet.telecomitalia.it>
-- Company    : 
-- Created    : 2018-08-20
-- Last update: 2019-03-07
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-08-20  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.VComponents.all;
-------------------------------------------------------------------------------

entity clock_manager is

  port (
    board_clk     : in  std_logic;
    sys_clk       : out std_logic;
    slow_clk      : out std_logic;
    baud_rate_gen : out std_logic);
end clock_manager;

-------------------------------------------------------------------------------

architecture str of clock_manager is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
  signal dcm_locked            : std_logic;
  signal baud_rate_gen_s       : std_logic := '0';
  constant HALF_PERIOD_DIVISOR : integer   := 53;  -- magic number!!
                                                   -- (sys_clk /( baudrate * 16)-1)

  signal sys_clk_s     : std_logic;
  constant CLK_MANAGER : boolean := false;
  -----------------------------------------------------------------------------
  -- Component declarations
  -----------------------------------------------------------------------------

begin  -- str

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------
  insert_clk_manager : if CLK_MANAGER = true generate

    dcm0 : DCM_CLKGEN
      generic map(
        CLKIN_PERIOD   => 8.0,          -- 125 Mhz clock in from oscillator
        CLKFX_MULTIPLY => 47,
        CLKFX_DIVIDE   => 50,
        CLKFXDV_DIVIDE => 8
        )
      port map (
        clkin   => board_clk,
        clkfx   => sys_clk_s,
        clkfxdv => slow_clk,
        locked  => dcm_locked,
        rst     => '0'
        );
  end generate insert_clk_manager;

  disconnect_clk_manager : if CLK_MANAGER = false generate
    clock_man_1 : entity work.clock_man
      port map (
        CLK_IN1  => board_clk,
        CLK_OUT1 => sys_clk_s);
  end generate disconnect_clk_manager;
-- purpose: generates the 1/16 baudrate signal for the uart module
-- type   : sequential
-- inputs : sys_clk,
-- outputs: baud_rate_gen
  baud_rate_gen_p : process (sys_clk_s)
    variable cnt : integer := 0;
  begin  -- process baud_rate_gen_p

    if rising_edge(sys_clk_s) then      -- rising clock edge
      if cnt = HALF_PERIOD_DIVISOR then
        cnt             := 0;
        baud_rate_gen_s <= '1';
      else
        baud_rate_gen_s <= '0';
      end if;
      cnt := cnt + 1;
    end if;
  end process baud_rate_gen_p;
  baud_rate_gen <= baud_rate_gen_s;
  sys_clk       <= sys_clk_s;
end str;

-------------------------------------------------------------------------------
