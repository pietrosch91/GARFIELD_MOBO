-------------------------------------------------------------------------------
-- Title      : write pointer and full generation
-- Project    : 
-------------------------------------------------------------------------------
-- File       : wptr_full.vhd
-- Author     : Antonio Bergnoli  <>ntonio.bergnoli@dwave.it
-- Company    : 
-- Created    : 2017-01-31
-- Last update: 2017-02-02
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: generates gray style write pointer and full signal
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


entity wptr_full is

  generic (
    g_a_size : integer := 4);

  port (
    wfull_o  : out std_logic;
    wcount_o: out std_logic_vector(g_a_size -1 downto 0);
    waddr_o  : out std_logic_vector(g_a_size - 1 downto 0);
    wptr_o   : out std_logic_vector(g_a_size downto 0);
    wq2_rptr : in  std_logic_vector(g_a_size downto 0);
    winc_i   : in  std_logic;
    wclk_i   : in  std_logic;
    wrst_i   : in  std_logic);

end entity wptr_full;
architecture rtl of wptr_full is

  signal s_wbin      : unsigned(g_a_size downto 0):= (others => '0');
  signal s_wgraynext : unsigned(g_a_size downto 0):= (others => '0');
  signal s_wbinnext  : unsigned(g_a_size downto 0):= (others => '0');
  signal s_wptr      : unsigned(g_a_size downto 0):= (others => '0');
  signal s_wfull_val : std_logic := '0';

  signal s_wfull : std_logic:='0';

  constant width : integer := g_a_size + 1;
  signal out_bin : std_logic_vector(width-1 downto 0);
  signal fifo_count : unsigned(g_a_size   downto 0):=(others => '0');

begin  -- architecture rtl


  -----------------------------------------------------------------------------
  -- gray to binary converter
  -----------------------------------------------------------------------------
  gray2bin_1: entity work.gray2bin
    generic map (
      width => g_a_size + 1)
    port map (
      in_gray => wq2_rptr,
      out_bin => out_bin);
fifo_count <=  unsigned(s_wbin) -  unsigned(out_bin) ;
-------------------------------------------------------------------------------
-- gray style pointer
-------------------------------------------------------------------------------
  gray_gen_sm : process (wclk_i) is
  begin  -- process gray_gen_sm
    if rising_edge(wclk_i) then         -- rising clock edge
      s_wbin <= s_wbinnext;
      s_wptr <= s_wgraynext;
    end if;
  end process gray_gen_sm;
  s_wbinnext  <= s_wbin +  1 when (winc_i and (not s_wfull)) ='1'
                 else s_wbin;
  s_wgraynext <= (s_wbinnext srl 1) xor s_wbinnext;

  s_wfull_val <= '1' when std_logic_vector(s_wgraynext) = (not wq2_rptr(g_a_size downto g_a_size -1)) &
                 wq2_rptr(g_a_size -2 downto 0)
                 else '0';

  full_gen : process (wclk_i) is
  begin  -- process full_gen
    if rising_edge(wclk_i) then         -- rising clock edge
      s_wfull <= s_wfull_val;
    end if;
  end process full_gen;
  -----------------------------------------------------------------------------
  -- port out assignments
  -----------------------------------------------------------------------------
  waddr_o <= std_logic_vector(s_wbin(g_a_size -1 downto 0));
  wfull_o <= s_wfull;
  wptr_o <=std_logic_vector(s_wptr) ;
  wcount_o <= std_logic_vector(fifo_count(fifo_count'left - 1 downto 0)); 
end architecture rtl;
