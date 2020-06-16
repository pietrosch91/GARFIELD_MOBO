-------------------------------------------------------------------------------
-- Title      : ipbus gpio
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ipbus_gpio.vhd
-- Author     : filippo  <filippo@Dell-Precision-3520>
-- Company    : 
-- Created    : 2019-04-23
-- Last update: 2019-06-25
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-23  1.0      filippo Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.ipbus.all;


entity ipbus_gpio is
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    ipbus_in      : in  ipb_wbus;
    ipbus_out     : out ipb_rbus;
    --
    aligned_i     : in  std_logic;
    bec_connected : out std_logic;
    dlyctrl_ready : in  std_logic;
    dlyctrl_reset : in  std_logic
    );

end entity ipbus_gpio;

architecture str of ipbus_gpio is

  constant DATA_WIDTH     : integer                                  := 32;
  signal s_register_write : std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');
  alias s_bec_connected   : std_logic is s_register_write(0);

  signal s_register_read : std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '0');
  alias s_dlyctrl_ready  : std_logic is s_register_read(0);
  alias s_dlyctrl_reset  : std_logic is s_register_read(1);
  alias s_aligned        : std_logic is s_register_read(2);

begin  -- architecture str

  s_dlyctrl_ready <= dlyctrl_ready;
  s_dlyctrl_reset <= dlyctrl_reset;

  s_aligned <= aligned_i;
  ipbus_write : process (clk) is
  begin  -- process
    if rising_edge(clk) then            -- rising clock edge
      if reset = '1' then               -- synchronous reset (active high)
        null;
      elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
        s_register_write <= ipbus_in.ipb_wdata;
      end if;
    end if;
  end process ipbus_write;

  ipbus_read : process (s_register_read, ipbus_in.ipb_strobe) is
  begin  -- process ipbus_read
    ipbus_out.ipb_rdata <= s_register_read;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

--port assignment
  bec_connected <= s_bec_connected;


end architecture str;
