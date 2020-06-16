-------------------------------------------------------------------------------
-- Title      : fifp funnel
-- Project    : 
-------------------------------------------------------------------------------
-- File       : funnel.vhd
-- Author     : Antonio Bergnoli  <antonio.bergnoli@dwave.it>
-- Company    : 
-- Created    : 2017-02-08
-- Last update: 2019-03-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: double fifo funnel
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-02-08  1.0      antonio Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity funnel is
  generic (
    g_dsize_in  : integer := 8 * 16;
    g_dsize_out : integer := 16;
    g_a_size_a  : integer := 8;
    g_a_size_b  : integer := 8;
    big_endian  : boolean := true);
  port (
    -- write port 
    wdata_i          : in  std_logic_vector(g_dsize_in -1 downto 0);
    winc_i           : in  std_logic;
    wfull_o          : out std_logic;
    wclk_i           : in  std_logic;
    wrst_i           : in  std_logic;
    -- read port
    rdata_o          : out std_logic_vector(g_dsize_out - 1 downto 0);
    rcount_o         : out std_logic_vector(g_a_size_b downto 0);
    rempty_o         : out std_logic;
    rvalid_o         : out std_logic;
    rlock_i          : in  std_logic;
    rfifo_occupied_o : out std_logic_vector(g_a_size_b - 1 downto 0);
    rinc_i           : in  std_logic;
    rclk_i           : in  std_logic;
    rrst_i           : in  std_logic);

end entity funnel;

architecture rtl of funnel is

  type state_t is (idle_st, extract_st, count_st);
  signal state : state_t := idle_st;

  constant funnel_ratio        : integer                       := g_dsize_in / g_dsize_out;
  constant ratio_rem           : integer                       := g_dsize_in mod g_dsize_out;
  signal s_intermediate_in     : std_logic_vector(g_dsize_in - 1 downto 0);
  signal s_intermediate_out    : std_logic_vector(g_dsize_out - 1 downto 0);
  signal s_intermediate_buf    : std_logic_vector(g_dsize_out - 1 downto 0);
  signal s_intermediate_clk    : std_logic;
  signal s_intermediate_rvaild : std_logic                     := '0';
  signal s_intermediate_rempty : std_logic;
  signal s_intermediate_rinc_i : std_logic                     := '0';
  signal s_intermediate_winc_i : std_logic                     := '0';
  signal s_intermediate_wfull  : std_logic;
  signal s_rvaild              : std_logic                     := '0';
  signal counter               : unsigned(7 downto 0)          := (others => '0');
  signal s_rdata               : std_logic_vector(g_dsize_out - 1 downto 0);
  signal s_valid_data_counter  : unsigned(g_a_size_b downto 0) := (others => '0');
  signal was_empty             : boolean                       := true;
  -----------------------------------------------------------------------------
  -- debug
  -----------------------------------------------------------------------------
  signal CONTROL               : std_logic_vector(35 downto 0) := (others => '0');
  signal CLK                   : std_logic                     := '0';
  signal TRIG0                 : std_logic_vector(47 downto 0) := (others => '0');
  signal TRIG1                 : std_logic_vector(31 downto 0) := (others => '0');
  signal TRIG2                 : std_logic_vector(31 downto 0) := (others => '0');
  signal TRIG3                 : std_logic_vector(31 downto 0) := (others => '0');
  signal TRIG4                 : std_logic_vector(31 downto 0) := (others => '0');
  signal TRIG5                 : std_logic_vector(0 to 0)      := (others => '0');
  signal TRIG6                 : std_logic_vector(0 to 0)      := (others => '0');
  signal TRIG7                 : std_logic_vector(0 to 0)      := (others => '0');
  signal TRIG8                 : std_logic_vector(0 to 0)      := (others => '0');
  signal TRIG9                 : std_logic_vector(0 to 0)      := (others => '0');
  signal TRIG10                : std_logic_vector(9 downto 0)  := (others => '0');
  signal TRIG11                : std_logic_vector(0 to 0)      := (others => '0');
  signal TRIG12                : std_logic_vector(0 to 0)      := (others => '0');
  signal TRIG13                : std_logic_vector(31 downto 0) := (others => '0');
  signal TRIG14                : std_logic_vector(15 downto 0) := (others => '0');

  signal s_winc  : std_logic;
  signal s_wdata : std_logic_vector(g_dsize_in -1 downto 0);

begin  -- architecture rtl


  -- initial check
  assert ratio_rem = 0 report "data size not multiple of data out" severity failure;

  -----------------------------------------------------------------------------
  -- intermediate clk selection
  -----------------------------------------------------------------------------
  s_intermediate_clk <= rclk_i;
  s_winc             <= winc_i;
  s_wdata            <= wdata_i;
-------------------------------------------------------------------------------
-- Input Fifo
-------------------------------------------------------------------------------
  c_fifo_1 : entity work.c_fifo
    generic map (
      g_dsize  => g_dsize_in,           -- data size
      g_a_size => g_a_size_a)           -- address depth
    port map (
      wfull            => wfull_o,
      wdata_i          => s_wdata,
      winc_i           => s_winc,
      wclk_i           => wclk_i,
      wrst_i           => wrst_i,
--
      rdata_o          => s_intermediate_in,
      rvalid_o         => s_intermediate_rvaild,
      rempty_o         => s_intermediate_rempty,
      rfifo_occupied_o => open,
      rinc_i           => s_intermediate_rinc_i,
      rclk_i           => s_intermediate_clk,
      rrst_i           => rrst_i);


-------------------------------------------------------------------------------
--  Data Mover
-------------------------------------------------------------------------------
  data_mover : process (s_intermediate_clk) is
  begin  -- process data_mover
    if rising_edge(s_intermediate_clk) then  -- rising clock edge
      case state is
        when idle_st =>
          s_intermediate_winc_i <= '0';
          if rlock_i = '0' then
            if s_intermediate_rempty = '0' then
              state   <= extract_st;
              counter <= (others => '0');
            else
              was_empty <= true;
            end if;
          else
            state <= idle_st;
          end if;
        when extract_st =>
          s_intermediate_winc_i <= '0';
          s_intermediate_rinc_i <= '1';
          if was_empty = true then
            was_empty <= false;
          else
            state <= count_st;
          end if;
        when count_st =>
          s_intermediate_rinc_i <= '0';
          if counter > 0 and s_intermediate_wfull = '0' then
            s_intermediate_winc_i <= '1';
            if big_endian = true then
              s_intermediate_out <= s_intermediate_in((g_dsize_out * to_integer(counter)) - 1 downto (g_dsize_out * to_integer(counter - 1)));
            else
              s_intermediate_out <= s_intermediate_in((g_dsize_out * ( funnel_ratio + 1 - to_integer(counter))) - 1 downto (g_dsize_out *(funnel_ratio - to_integer( counter))));
            end if;
          else
            s_intermediate_winc_i <= '0';
          end if;
          counter <= counter + 1;
          if counter = to_unsigned(funnel_ratio, counter'length) then
            counter <= (others => '0');
            state   <= idle_st;
          end if;
        when others =>
          state <= idle_st;
      end case;
    end if;
  end process data_mover;

-------------------------------------------------------------------------------
-- Valid data counter
-------------------------------------------------------------------------------
  Valid_data_counter : process (s_intermediate_clk) is
  begin  -- process Valid_data_counter
    if rising_edge(s_intermediate_clk) then  -- rising clock edge
      if rlock_i = '0' then
        s_valid_data_counter <= (others => '0');
      end if;
      if s_rvaild = '1' then
        s_valid_data_counter <= s_valid_data_counter + 1;
--        report "Valid Data  counter: " & integer'image(to_integer(s_valid_data_counter));
      end if;
      rcount_o <= std_logic_vector(s_valid_data_counter);
    end if;
  end process Valid_data_counter;
-------------------------------------------------------------------------------
-- Output Fifo
-------------------------------------------------------------------------------
  c_fifo_2 : entity work.c_fifo
    generic map (
      g_dsize  => g_dsize_out,               -- data size
      g_a_size => g_a_size_b)                -- address depth
    port map (
      wfull            => s_intermediate_wfull,
      wdata_i          => s_intermediate_out,
      winc_i           => s_intermediate_winc_i,
      wclk_i           => s_intermediate_clk,
      wrst_i           => wrst_i,
      --
      rdata_o          => s_rdata,
      rvalid_o         => s_rvaild,
      rempty_o         => rempty_o,
      rfifo_occupied_o => rfifo_occupied_o,
      rinc_i           => rinc_i,
      rclk_i           => rclk_i,
      rrst_i           => rrst_i);
  rvalid_o <= s_rvaild;
  rdata_o  <= s_rdata;

------------------------------------------------------------------------------------
end architecture rtl;
