-------------------------------------------------------------------------------
-- Title      : clock divider by 2
-- Project    : 
-------------------------------------------------------------------------------
-- File       : clock_div_2.vhd
-- Author     : antonio  <bergnoli@pd.infn.it>
-- Company    : 
-- Created    : 2019-05-29
-- Last update: 2019-05-29
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: divide clock by factor 2 using a BUFCE Xilinx resource
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-29  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity clock_div_2 is

  port (
    clk_in  : in  std_logic;
    clk_out : out std_logic);

end entity clock_div_2;

architecture str of clock_div_2 is
  signal ce : std_logic := '0';
begin  -- architecture str

  ce_generator : process (clk_in) is
  begin  -- process ce_generator
    if rising_edge(clk_in) then
      ce <= not ce;
    end if;
  end process ce_generator;

  BUFGCE_inst : BUFGCE
    port map (
      I  => clk_in,
      O  => clk_out,
      CE => ce);

end architecture str;
