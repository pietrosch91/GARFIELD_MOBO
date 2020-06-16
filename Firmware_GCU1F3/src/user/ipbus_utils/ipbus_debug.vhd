-------------------------------------------------------------------------------
-- Title      : IPBus Debug
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ipbus_debug.vhd
-- Author     : Filippo Marini   <filippo.marini@pd.infn.it>
-- Company    : Universita degli studi di Padova
-- Created    : 2019-05-03
-- Last update: 2019-05-06
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Ipbus debug slave 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 Universita degli studi di Padova
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-03  1.0      filippo	Created
-------------------------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all;
use work.ipbus.all;

entity ipbus_debug is

  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    ipbus_in      : in  ipb_wbus;
    ipbus_out     : out ipb_rbus;
    debug_signal  : in  std_logic_vector(31 downto 0));

end entity ipbus_debug;

architecture str of ipbus_debug is 

 constant DATA_WIDTH     : integer                       := 32;
  signal s_register        : std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');


begin  -- architecture str

  s_register <= debug_signal;

 ipbus_read: process (s_register, ipbus_in.ipb_strobe) is
  begin  -- process ipbus_read
    ipbus_out.ipb_rdata <= s_register;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

  

end architecture str;
