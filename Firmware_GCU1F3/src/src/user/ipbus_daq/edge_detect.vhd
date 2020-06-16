-------------------------------------------------------------------------------
-- Title      : edge detector
-- Project    : 
-------------------------------------------------------------------------------
-- File       : edge_detect.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    : 
-- Created    : 2019-04-29
-- Last update: 2019-04-29
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-29  1.0      antonio Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
entity edge_detector is
  port (
    clk   : in  std_logic;
    rst   : in  std_logic;
    input : in  std_logic;
    pulse : out std_logic);
end edge_detector;
architecture rtl of edge_detector is
  signal r0_input : std_logic;
  signal r1_input : std_logic;
begin
  p_rising_edge_detector : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
       r0_input <= '0';
      r1_input <= '0';
    end if;
    r0_input <= input;
    r1_input <= r0_input;
  end if;
end process p_rising_edge_detector;
pulse <= not r1_input and r0_input;
end rtl;
