-------------------------------------------------------------------------------
-- Title      : 
-- Project    : 
-------------------------------------------------------------------------------
-- File       : erlang.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    : 
-- Created    : 2018-03-15
-- Last update: 2019-04-18
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-03-15  1.0      antonio Created
-------------------------------------------------------------------------------

use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-------------------------------------------------------------------------------

entity erlang is
  port (
    clk      : in  std_logic;
    data_out : out std_logic_vector(127 downto 0);
    clk_out  : out std_logic);
end erlang;

-------------------------------------------------------------------------------

architecture str of erlang is

  -----------------------------------------------------------------------------
  -- Internal signal declarations
  -----------------------------------------------------------------------------
  type data_out_vector_t is array(7 downto 0) of std_logic_vector(15 downto 0);
  signal x                : real                          := 0.01;
  constant K              : real                          := 8.0;
  constant K_1fact        : real                          := 40320.0;
  constant lambda         : real                          := 0.9;
  constant gain           : real                          := 90000.0;
  constant base_line      : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(natural(gain), 16));
  signal data_out_vector  : data_out_vector_t             := (others => base_line);
  signal erl              : real                          := gain;
  signal erl_value_vector : unsigned(31 downto 0)         := to_unsigned(natural(erl), 32);
  signal a1               : unsigned(15 downto 0)         := (others => '0');
  signal a2               : unsigned(15 downto 0)         := X"0004";
  signal r2               : unsigned(15 downto 0);
-----------------------------------------------------------------------------
-- Component declarations
-----------------------------------------------------------------------------
begin  -- str

  -----------------------------------------------------------------------------
  -- Component instantiations
  -----------------------------------------------------------------------------
  gen : process(clk)
    variable counter    : integer := 0;
    variable big_endian : boolean := true;
    variable l : line;
  begin  -- process gen
    if rising_edge(clk) then
      x <= x + 0.05;
      if x >= 180.0 then
        x <= 0.5;
      end if;
      erl                      <= gain * (1.0 - ((lambda **K) * (x ** (K - 1.0)) * exp(-lambda * x)) /K_1fact);
      erl_value_vector         <= to_unsigned(natural(erl), erl_value_vector'length);
      data_out_vector(counter) <= std_logic_vector(erl_value_vector(15 downto 0));
      counter                  := counter + 1;
      if counter = 4 then
        clk_out <= '1';
      end if;
      if counter = 8 then
        clk_out <= '0';
        counter := 0;
        if big_endian = true then
          data_out <= data_out_vector(7) &
                      data_out_vector(6) &
                      data_out_vector(5) &
                      data_out_vector(4) &
                      data_out_vector(3) &
                      data_out_vector(2) &
                      data_out_vector(1) &
                      data_out_vector(0);
        else
          data_out <= data_out_vector(0) &
                      data_out_vector(1) &
                      data_out_vector(2) &
                      data_out_vector(3) &
                      data_out_vector(4) &
                      data_out_vector(5) &
                      data_out_vector(6) &
                      data_out_vector(7);

        end if;
      end if;
--      report integer'image(integer(erl));
    end if;
  end process gen;
end str;

-------------------------------------------------------------------------------
