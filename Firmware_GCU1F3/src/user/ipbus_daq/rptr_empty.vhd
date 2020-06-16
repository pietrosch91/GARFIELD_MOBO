-------------------------------------------------------------------------------
-- Title      : read pointer, empty generation
-- Project    : 
-------------------------------------------------------------------------------
-- File       : rptr_empty.vhd
-- Author     : Antonio Bergnoli  <antonio.bergnoli@dwave.it>
-- Company    : 
-- Created    : 2017-01-31
-- Last update: 2019-03-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: generates gray style read pointer and empty signal
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


entity rptr_empty is

  generic (
    g_a_size : integer := 4);

  port (
    rempty_o : out std_logic;
    rcount_o : out std_logic_vector(g_a_size -1 downto 0);
    raddr_o  : out std_logic_vector(g_a_size -1 downto 0);
    rptr_o   : out std_logic_vector(g_a_size downto 0);
    rq2_wptr : in  std_logic_vector(g_a_size downto 0);
    rinc_i   : in  std_logic;
    rclk_i   : in  std_logic;
    rrst_i   : in  std_logic);

end entity rptr_empty;

architecture rtl of rptr_empty is
  signal s_rbin      : unsigned(g_a_size downto 0) := (others => '0');
  signal s_rptr      : unsigned(g_a_size downto 0) := (others => '0');
  signal s_rgraynext : unsigned(g_a_size downto 0) := (others => '0');
  signal s_rbinnext  : unsigned(g_a_size downto 0) := (others => '0');

  signal s_rempty     : std_logic := '1';
  signal s_rempty_val : std_logic := '1';

  constant numeric_zero : unsigned(g_a_size - 1 downto 0) := (others => '0');

  constant width : integer := g_a_size + 1;

  signal out_bin    : std_logic_vector(width-1 downto 0);
  signal fifo_count : unsigned(g_a_size downto 0) := (others => '0');
begin  -- architecture rtl


  -----------------------------------------------------------------------------
  -- gray to binary converter
  -----------------------------------------------------------------------------
  gray2bin_1 : entity work.gray2bin
    generic map (
      width => g_a_size + 1)
    port map (
      in_gray => rq2_wptr,
      out_bin => out_bin);

  fifo_count <= unsigned(out_bin) - unsigned(s_rbin);
-------------------------------------------------------------------------------
-- gray style pointer
-------------------------------------------------------------------------------
  gray_gen_sm : process (rclk_i) is
  begin  -- process gray_gen_sm
    if rising_edge(rclk_i) then         -- rising clock edge
      s_rbin <= s_rbinnext;
      s_rptr <= s_rgraynext;
    end if;
  end process gray_gen_sm;
  s_rbinnext <= (s_rbin + 1) when (rinc_i and (not s_rempty)) = '1'
                else s_rbin;
  s_rgraynext <= (s_rbinnext srl 1) xor s_rbinnext;

  s_rempty_val <= '1' when (std_logic_vector(s_rgraynext) = rq2_wptr)
                  else '0';

  empty_gen : process (rclk_i) is
  begin  -- process empty_gen
    if rising_edge(rclk_i) then         -- rising clock edge
      s_rempty <= s_rempty_val;
    end if;
  end process empty_gen;
  -----------------------------------------------------------------------------
  -- port out assignments
  -----------------------------------------------------------------------------
  rptr_o   <= std_logic_vector(s_rptr);
  raddr_o  <= std_logic_vector(s_rbin(g_a_size - 1 downto 0));
  rempty_o <= s_rempty;
  rcount_o <= std_logic_vector(fifo_count(fifo_count'left - 1 downto 0));
end architecture rtl;
