-------------------------------------------------------------------------------
-- Title      : ipbus adu manager
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ipbus_adu_manager.vhd
-- Author     : Antonio Bergnoli  <antonio@dhcp-39.pd.infn.it>
-- Company    : 
-- Created    : 2019-03-15
-- Last update: 2019-03-18
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description:enable and control ADUs behavior 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-03-15  1.0      antonio Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.ipbus.all;


entity ipbus_adu_manager is
  port (
    clk               : in  std_logic;
    reset             : in  std_logic;
    ipbus_in          : in  ipb_wbus;
    ipbus_out         : out ipb_rbus;
    --
    adu_enables       : out std_logic_vector(2 downto 0);
    adu_clock_enables : out std_logic_vector(2 downto 0)
    );

end entity ipbus_adu_manager;


architecture str of ipbus_adu_manager is

  constant GCU_FW_VERSION : std_logic_vector(15 downto 0) := X"0001";
  constant DATA_WIDTH     : integer                       := 32;
  -- Address space is 2 bits wide 
  alias reg_address       : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);

  constant CONTROL_IP_BUS_ADDR : std_logic_vector(1 downto 0)             := "00";
  constant STATUS_IP_BUS_ADDR  : std_logic_vector(1 downto 0)             := "01";
  -- control register
  signal s_ctrl_reg            : std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');
  alias threshold              : std_logic_vector(15 downto 0) is s_ctrl_reg(31 downto 16);
  alias trigger_selector       : std_logic is s_ctrl_reg(15);
  alias trigger_enable         : std_logic is s_ctrl_reg(14);
  alias force_trigger          : std_logic is s_ctrl_reg(13);
  alias enable_adu_0           : std_logic is s_ctrl_reg(12);
  alias enable_adu_1           : std_logic is s_ctrl_reg(11);
  alias enable_adu_2           : std_logic is s_ctrl_reg(10);
  alias enable_clock_adu_0     : std_logic is s_ctrl_reg(9);
  alias enable_clock_adu_1     : std_logic is s_ctrl_reg(8);
  alias enable_clock_adu_2     : std_logic is s_ctrl_reg(7);
  -- status register
  signal s_status_reg          : std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');
  alias fw_version             : std_logic_vector(15 downto 0) is s_status_reg(31 downto 16);
  alias config_ok_adu_0        : std_logic is s_status_reg(15);
  alias config_ok_adu_1        : std_logic is s_status_reg(14);
  alias config_ok_adu_2        : std_logic is s_status_reg(13);

  signal ack : std_logic;
begin  -- architecture str

  fw_version <= GCU_FW_VERSION;

  ipbus_write : process (clk) is
  begin  -- process ipbus_manager
    if rising_edge(clk) then
      if reset = '1' then               -- synchronous reset (active high)
        null;
      elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
        case reg_address is
          when CONTROL_IP_BUS_ADDR =>
            s_ctrl_reg <= ipbus_in.ipb_wdata;
            null;
          when others =>
            null;
        end case;
      end if;
    end if;
  end process ipbus_write;

  ipbus_read : process (reg_address, s_ctrl_reg, s_status_reg, ipbus_in.ipb_strobe) is
  begin  -- process ipbus_read
    case reg_address is
      when CONTROL_IP_BUS_ADDR =>
        ipbus_out.ipb_rdata <= s_ctrl_reg;
      when STATUS_IP_BUS_ADDR =>
        ipbus_out.ipb_rdata <= s_status_reg;
      when others =>
        ipbus_out.ipb_rdata <= (others => '0');
    end case;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

  -- port assignments
  adu_enables(0) <= enable_adu_0;
  adu_enables(1) <= enable_adu_1;
  adu_enables(2) <= enable_adu_2;
  adu_clock_enables(0) <= enable_clock_adu_0;
  adu_clock_enables(1) <= enable_clock_adu_1;
  adu_clock_enables(2) <= enable_clock_adu_2;
end architecture str;
