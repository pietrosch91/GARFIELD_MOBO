-------------------------------------------------------------------------------
-- Title      : firmware data
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ipbus_fw_data.vhd
-- Author     : Antonio Bergnoli  <bergnoli@ps.infn.it>
-- Company    : 
-- Created    : 2019-04-08
-- Last update: 2019-04-08
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: red only register banks with firmware release number and other
--  static data
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-08  1.0      antonio Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ipbus.all;

entity ipbus_fw_data is

  port (
    clk       : in  std_logic;
    reset     : in  std_logic;
    ipbus_in  : in  ipb_wbus;
    ipbus_out : out ipb_rbus
    );

end entity ipbus_fw_data;


architecture rtl of ipbus_fw_data is

  alias reg_address    : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);
  constant FW_V_ADDR   : std_logic_vector(1 downto 0)  := "00";
  constant USER_D_ADDR : std_logic_vector(1 downto 0)  := "01";
  constant fw_version  : std_logic_vector(31 downto 0) := X"ABCDEF01";
  constant user_data   : std_logic_vector(31 downto 0) := X"DEADBEEF";
  signal ack           : std_logic                     := '0';
begin  -- architecture str

  process(clk)
  begin
    if rising_edge(clk) then

      case reg_address is
        when FW_V_ADDR =>
          ipbus_out.ipb_rdata <= fw_version;
        when USER_D_ADDR =>
          ipbus_out.ipb_rdata <= user_data;
        when others  =>
          ipbus_out.ipb_rdata <= fw_version;
      end case;
      ack <= ipbus_in.ipb_strobe and not ack;
    end if;
  end process;

  ipbus_out.ipb_ack <= ack;
  ipbus_out.ipb_err <= '0';


end architecture rtl;
