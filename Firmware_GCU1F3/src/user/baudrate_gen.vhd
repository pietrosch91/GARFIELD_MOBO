-------------------------------------------------------------------------------
-- Title      : baudrate generator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : baudrate_gen.vhd
-- Author     : Filippo Marini   <filippo.marini@pd.infn.it>
-- Company    : Universita degli studi di Padova
-- Created    : 2019-05-02
-- Last update: 2019-05-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: bauderate generator for picoblaze 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 Universita degli studi di Padova
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-02  1.0      filippo	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.VComponents.all;

entity baudrate_gen is
  port (
    sys_clk       : in  std_logic;
    baud_rate_gen : out std_logic);
end baudrate_gen;

architecture str of baudrate_gen is 

  signal baud_rate_gen_s       : std_logic := '0';
  constant HALF_PERIOD_DIVISOR : integer   := 53;  -- magic number!!
                                                   -- (sys_clk /( baudrate * 16)-1)

begin  -- architecture str

  baud_rate_gen_p : process (sys_clk)
    variable cnt : integer := 0;
  begin  -- process baud_rate_gen_p
    if rising_edge(sys_clk) then      -- rising clock edge
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


end architecture str;
