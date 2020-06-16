-------------------------------------------------------------------------------
-- Title      : fifo memory
-- Project    : 
-------------------------------------------------------------------------------
-- File       : fifomem.vhd
-- Author     : Antonio Bergnoli  <antonio.bergnoli@dwave.it>
-- Company    : 
-- Created    : 2017-01-31
-- Last update: 2019-04-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: inferred fifo memory
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-01-31  1.0      antonio Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity fifomem is

  generic (
    g_dsize  : integer := 8;
    g_a_size : integer := 4);

  port (
    rdata_o  : out std_logic_vector(g_dsize - 1 downto 0);
    wdata_i  : in  std_logic_vector(g_dsize - 1 downto 0);
    waddr_i  : in  std_logic_vector(g_a_size - 1 downto 0);
    raddr_i  : in  std_logic_vector(g_a_size - 1 downto 0);
    wclken_i : in  std_logic;
    rclken_i : in  std_logic;
    wfull_i  : in  std_logic; 
   rclk_i   : in  std_logic;
    wclk_i   : in  std_logic);

end entity fifomem;

architecture rtl of fifomem is

  constant FIFO_DEPTH : integer                 := 2**g_a_size;
  type RAM is array (integer range <>)of std_logic_vector (g_dsize - 1 downto 0);
  signal mem          : RAM(0 to FIFO_DEPTH -1) := (others => (others => '0'));
begin  -- architecture rtl


  read_ram : process (rclk_i) is
  begin  -- process write_ram
    if rising_edge(rclk_i) then         -- rising clock edge
      if rclken_i ='1' then
--      rdata_o <= mem(to_integer(unsigned(raddr_i)));
      rdata_o <= mem(conv_integer(raddr_i));
      end if;
    end if;
  end process read_ram;
-- purpose: main write process
-- type   : sequential
-- inputs : wclk_i, mem
-- outputs: rdata_o
  write_ram : process (wclk_i) is
  begin  -- process write_ram
    if rising_edge(wclk_i) then         -- rising clock edge
      if wclken_i = '1' and wfull_i = '0' then
--        mem(to_integer(unsigned(waddr_i))) <= wdata_i;
        mem(conv_integer(waddr_i)) <= wdata_i;
      end if;
    end if;
  end process write_ram;
end architecture rtl;
