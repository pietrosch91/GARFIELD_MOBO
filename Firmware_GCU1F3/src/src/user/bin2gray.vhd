-------------------------------------------------------------------------------
-- Title      : bin2gray
-- Project    : 
-------------------------------------------------------------------------------
-- File       : bin2gray.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    : 
-- Created    : 2019-03-30
-- Last update: 2019-03-31
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: binary to gray encoder
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-03-30  1.0      abergnol  Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity bin2gray is

  generic (
    width : integer := 64);             -- input and output data width

  port (
    binary_in : in  std_logic_vector(width - 1 downto 0);
    gray_out  : out std_logic_vector(width - 1 downto 0));

end entity bin2gray;


architecture str of bin2gray is
  signal binary2gray : std_logic_vector(width - 1 downto 0);
  signal value       : std_logic_vector(width - 1 downto 0);
begin  -- architecture str
  main : process (binary_in) is
  begin  -- process main
    value <= binary_in;
    for i in width - 1 downto 1 loop
      binary2gray(i - 1)     <= value(i) xor value (i - 1);
      binary2gray(width - 1) <= value (width - 1);
    end loop;  -- i
  end process main;
  gray_out <= binary2gray;

end architecture str;
