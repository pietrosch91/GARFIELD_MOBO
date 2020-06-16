-------------------------------------------------------------------------------
-- Title      : shaper
-- Project    : 
-------------------------------------------------------------------------------
-- File       : shaper.vhd
-- Author     : Antonio Bergnoli  <antonio@nbbergnoli.pd.infn.it>
-- Company    : 
-- Created    : 2019-05-30
-- Last update: 2019-06-03
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: configurable pulse shaper  
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-30  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------------------------------

entity shaper is
  generic (
    N_PULSES : integer := 4);
  port (
    clk_in     : in  std_logic;
    sig_in     : in  std_logic;
    shaped_out : out std_logic);
end entity shaper;

-------------------------------------------------------------------------------

architecture rtl of shaper is 

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
begin  -- architecture str
  main : process (clk_in) is
    variable counter : integer := n_pulses;
    type state_t is (idle_st, counting_st);
    variable state   : state_t := idle_st;
  begin  -- process main
    if rising_edge(clk_in) then         -- rising clock edge
      case state is
        when idle_st =>
          counter    := n_pulses;
          shaped_out <= '0';
          if sig_in = '1' then
            state      := counting_st;
            shaped_out <= '1';
          end if;
        when counting_st =>
          counter    := counter - 1;
          shaped_out <= '1';
          if counter = 0 then
            state := idle_st;
          end if;
        when others => null;
      end case;
    end if;
  end process main;
end architecture rtl;

-------------------------------------------------------------------------------
