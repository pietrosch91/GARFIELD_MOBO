-------------------------------------------------------------------------------
-- Title      : cunnings style fifo
-- Project    : 
-------------------------------------------------------------------------------
-- File       : fifo.vhd
-- Author     : Antonio Bergnoli  <antonio.bergnoli@dwave.it>
-- Company    : 
-- Created    : 2017-01-31
-- Last update: 2017-02-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: cunnings style fifo frpm sunburst design application Note  
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

entity c_fifo is

  generic (
    g_dsize  : integer := 8;            -- data size
    g_a_size : integer := 4);           -- address depth

  port (
    rdata_o       : out std_logic_vector(g_dsize - 1 downto 0);
    wfull         : out std_logic;
    rvalid_o      : out std_logic;
    rempty_o      : out std_logic;
    wdata_i       : in  std_logic_vector(g_dsize -1 downto 0);
    winc_i        : in  std_logic;
    wclk_i        : in  std_logic;
    wrst_i        : in  std_logic;
    rfifo_occupied_o : out std_logic_vector(g_a_size - 1 downto 0) := (others => '0');
    rinc_i        : in  std_logic;
    rclk_i        : in  std_logic;
    rrst_i        : in  std_logic);

end entity c_fifo;

architecture rtl of c_fifo is

  signal s_waddr     : std_logic_vector(g_a_size -1 downto 0)  := (others => '0');
  signal s_raddr     : std_logic_vector(g_a_size -1 downto 0)  := (others => '0');
  signal s_wptr      : std_logic_vector(g_a_size downto 0)     := (others => '0');
  signal s_rptr      : std_logic_vector(g_a_size downto 0)     := (others => '0');
  signal s_rq2_wptr  : std_logic_vector(g_a_size downto 0)     := (others => '0');
  signal s_wq2_rptr  : std_logic_vector(g_a_size downto 0)     := (others => '0');
  signal wfifo_count : std_logic_vector(g_a_size - 1 downto 0) := (others => '0');
  signal rfifo_count : std_logic_vector(g_a_size - 1 downto 0) := (others => '0');
  signal s_wfull     : std_logic;
  signal s_rvalid    : std_logic;
  signal s_rempty    : std_logic;
  signal s_buf_out   : std_logic_vector(g_dsize - 1 downto 0);
  --constant style     : string                                  := "ALFKE";
  constant style     : string                                  := "CUNNINGS";
begin  -- architecture rtl

  cunnings_style : if style = "CUNNINGS" generate

    -----------------------------------------------------------------------------
    -- double flop for r2w and w2r
    -----------------------------------------------------------------------------

    -----------------------------------------------------------------------------
    -- Read -> Write
    -----------------------------------------------------------------------------

    double_flop_w2r : entity work.double_flop
      generic map (
        g_width    => g_a_size + 1,
        g_clk_rise => "TRUE")
      port map (
        clk_i => wclk_i,
        sig_i => s_rptr,
        sig_o => s_wq2_rptr);

    double_flop_r2q : entity work.double_flop
      generic map (
        g_width    => g_a_size + 1,
        g_clk_rise => "TRUE")
      port map (
        clk_i => rclk_i,
        sig_i => s_wptr,
        sig_o => s_rq2_wptr);

-------------------------------------------------------------------------------
-- fifo memory
-------------------------------------------------------------------------------

    fifomem_1 : entity work.fifomem
      generic map (
        g_dsize  => g_dsize,
        g_a_size => g_a_size)
      port map (
        rdata_o  => s_buf_out,
        wdata_i  => wdata_i,
        waddr_i  => s_waddr,
        raddr_i  => s_raddr,
        wclken_i => winc_i,
        rclken_i => rinc_i,
        wfull_i  => s_wfull,
        rclk_i   => rclk_i,
        wclk_i   => wclk_i);


    -----------------------------------------------------------------------------
    --  full and empty machines
    -----------------------------------------------------------------------------

    rptr_empty_1 : entity work.rptr_empty
      generic map (
        g_a_size => g_a_size)
      port map (
        rempty_o => s_rempty,
        rcount_o => rfifo_occupied_o,
        raddr_o  => s_raddr,
        rptr_o   => s_rptr,
        rq2_wptr => s_rq2_wptr,
        rinc_i   => rinc_i,
        rclk_i   => rclk_i,
        rrst_i   => rrst_i);

    wptr_full_1 : entity work.wptr_full
      generic map (
        g_a_size => g_a_size)
      port map (
        wfull_o  => s_wfull,
        wcount_o => wfifo_count,
        waddr_o  => s_waddr,
        wptr_o   => s_wptr,
        wq2_rptr => s_wq2_rptr,
        winc_i   => winc_i,
        wclk_i   => wclk_i,
        wrst_i   => wrst_i);
    wfull    <= s_wfull;
    rvalid_o <= s_rvalid;
    rempty_o <= s_rempty;
    -- purpose: generation of r_valid signal
    -- type   : sequential
    -- inputs : rclk_i,rinc_i
    -- outputs: r_valid
    r_valid_generation : process (rclk_i) is
    begin  -- process r_valid_generation
      if rising_edge(rclk_i) then       -- rising clock edge
        if s_rempty = '0' and rinc_i = '1' then
          s_rvalid <= '1';
          rdata_o  <= s_buf_out;
        else
          s_rvalid <= '0';
        end if;
      end if;
    end process r_valid_generation;
  end generate cunnings_style;
  alfke : if style = "ALFKE" generate
    aFifo_1 : entity work.aFifo
      generic map (
        DATA_WIDTH => g_dsize,
        ADDR_WIDTH => g_a_size)
      port map (
        Data_out   => rdata_o,
        Empty_out  => rempty_o,
        ReadEn_in  => rinc_i,
        RClk       => rclk_i,
        Data_in    => wdata_i,
        Full_out   => wfull,
        WriteEn_in => winc_i,
        WClk       => wclk_i,
        Clear_in   => rrst_i);
    rvalid_o <= '0';
  end generate alfke;
end architecture rtl;

