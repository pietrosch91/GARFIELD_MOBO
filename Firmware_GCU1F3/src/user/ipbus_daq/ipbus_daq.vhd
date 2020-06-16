-------------------------------------------------------------------------------
-- Title      : ipbus asynchronus fifo
-- Project    : Juno GCU
-------------------------------------------------------------------------------
-- File       : ipbus_fifo.vhd
-- Author     : Antonio Bergnoli  <antonio.bergnoli@dwave.it>
-- Company    :
-- Created    : 2016-12-16
-- Last update: 2019-04-30
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:ipbus wrapper of  a dual clock fifo
-------------------------------------------------------------------------------
-- Copyright (c) 2016
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2016-12-16  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ipbus.all;

entity ipbus_daq is

  generic (
    addr_width : positive := 8);

  port (
    clk        : in  std_logic;
    reset      : in  std_logic;
    ipbus_in   : in  ipb_wbus;
    ipbus_out  : out ipb_rbus;
    Full_out   : out std_logic;
    Data_in    : in  std_logic_vector (127 downto 0);
    WriteEn_in : in  std_logic;
    WClk       : in  std_logic;
    Clear_in   : in  std_logic);


end entity ipbus_daq;

architecture rtl of ipbus_daq is
  constant DATA_WIDTH         : integer                                   := 32;
  constant FUNNEL_D_OUT_WIDTH : integer                                   := DATA_WIDTH;
  constant FIFO_IN_WIDTH      : integer                                   := 12;
  constant FIFO_OUT_WIDTH     : integer                                   := 12;
  constant FIFO_ADDR          : std_logic_vector(1 downto 0)              := "00";
  constant CTRL_ADDR          : std_logic_vector(1 downto 0)              := "01";
  constant STATUS_ADDR        : std_logic_vector(1 downto 0)              := "10";
  constant OCCUPIED_ADDR      : std_logic_vector(1 downto 0)              := "11";
  signal Data_out             : std_logic_vector (FUNNEL_D_OUT_WIDTH - 1 downto 0);
  constant Zeroes             : std_logic_vector(DATA_WIDTH -1 downto 0)  := (others => '0');
  signal Empty_out            : std_logic;
  signal ReadEn_in            : std_logic;
  signal RClk                 : std_logic;
  signal sel                  : integer;
  signal ack                  : std_logic;
  signal s_write_enable       : std_logic;
  signal s_rlock              : std_logic                                 := '0';
  signal s_rcount             : std_logic_vector(FIFO_OUT_WIDTH downto 0) := (others => '0');
  signal s_occupied_fifo      : std_logic_vector(FIFO_OUT_WIDTH - 1 downto 0);
  -----------------------------------------------------------------------------
  -- internal registrers
  -----------------------------------------------------------------------------
  signal s_ctrl_reg           : std_logic_vector(DATA_WIDTH -1 downto 0)  := (others => '0');
  signal s_status_reg         : std_logic_vector(DATA_WIDTH -1 downto 0)  := (others => '0');
  signal s_occupied_reg       : std_logic_vector(DATA_WIDTH -1 downto 0)  := (others => '0');
  alias lock                  : std_logic is s_ctrl_reg(0);
  alias empty                 : std_logic is s_status_reg(0);
  alias valid                 : std_logic is s_status_reg(1);
  alias reg_address           : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);
  -----------------------------------------------------------------------------
  -- debug
  -----------------------------------------------------------------------------

  signal s_clk        : std_logic;
  signal s_reset      : std_logic;
  signal s_ipbus_in   : ipb_wbus;
  signal s_ipbus_out  : ipb_rbus;
  signal s_Full_out   : std_logic;
  signal s_Data_in    : std_logic_vector (127 downto 0);
  signal s_WriteEn_in : std_logic;
  signal s_WClk       : std_logic;
 signal s_Clear_in   : std_logic;

begin  -- architecture rtl

  s_clk        <= clk;
  s_reset      <= reset;
  s_ipbus_in   <= ipbus_in;
  s_Data_in    <= Data_in;
  s_WriteEn_in <= WriteEn_in;

  ipbus_out <= s_ipbus_out;
  Full_out  <= s_Full_out;

  funnel_1 : entity work.funnel
    generic map (
      g_dsize_in  => 128,
      g_dsize_out => FUNNEL_D_OUT_WIDTH,
      g_a_size_a  => FIFO_IN_WIDTH,
      g_a_size_b  => FIFO_OUT_WIDTH,
      big_endian  => false)
    port map (
      wdata_i          => Data_in,
      winc_i           => WriteEn_in,
      wfull_o          => s_Full_out,
      wclk_i           => Wclk,
      wrst_i           => reset,
      rdata_o          => Data_out,
      rcount_o         => s_rcount,
      rempty_o         => empty,
      rvalid_o         => valid,
      rlock_i          => s_rlock,
      rfifo_occupied_o => s_occupied_fifo,
      rinc_i           => ReadEn_in and not empty,
      rclk_i           => clk,
      rrst_i           => reset);

  synch : process (clk) is
  begin  -- process synch
    if rising_edge(clk) then            -- rising clock edge
      s_occupied_reg(FIFO_OUT_WIDTH - 1 downto 0) <= s_occupied_fifo;
    end if;
  end process synch;
  s_status_reg(FIFO_OUT_WIDTH + 2 downto 2) <= s_rcount;
  s_rlock                                   <= lock;

-------------------------------------------------------------------------------
-- ipbus write process (synchronous with ipb clk )
-------------------------------------------------------------------------------
  ipbus_write : process (clk) is
  begin  -- process ipbus_manager
    if rising_edge(clk) then            -- rising clock edge
      if reset = '1' then               -- synchronous reset (active high)
        null;
      elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
        case reg_address is
          when CTRL_ADDR =>
            s_ctrl_reg <= ipbus_in.ipb_wdata;
          when others => null;
        end case;
      end if;
    end if;
  end process ipbus_write;

-------------------------------------------------------------------------------
-- ipbus read process ( pure combinatorial )
-------------------------------------------------------------------------------
  ipbus_read : process (ReadEn_in, Data_out, reg_address, s_ctrl_reg, s_status_reg, s_occupied_reg, ipbus_in.ipb_strobe) is
  begin  -- process ipbus_read
    case reg_address is
      when FIFO_ADDR =>
        s_ipbus_out.ipb_rdata <= Zeroes(DATA_WIDTH - 1 downto FUNNEL_D_OUT_WIDTH) & Data_out;
        ReadEn_in             <= ipbus_in.ipb_strobe;
      when CTRL_ADDR =>
        s_ipbus_out.ipb_rdata <= s_ctrl_reg;
        ReadEn_in             <= '0';
      when STATUS_ADDR =>
        s_ipbus_out.ipb_rdata <= s_status_reg;
        ReadEn_in             <= '0';
      when OCCUPIED_ADDR =>
        s_ipbus_out.ipb_rdata <= s_occupied_reg;
        ReadEn_in             <= '0';
      when others =>
        s_ipbus_out.ipb_rdata <= (others => '0');
        ReadEn_in             <= '0';
    end case;
  end process ipbus_read;


  s_ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  s_ipbus_out.ipb_err <= '0';

end rtl;
