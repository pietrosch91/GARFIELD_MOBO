-------------------------------------------------------------------------------
-- Title      : ipbus data assembly interface
-- Project    : Juno GCU
-------------------------------------------------------------------------------
-- File       : ipbus_data_assembly.vhd
-- Author     : Antonio Bergnoli  <antonio.bergnoli@dwave.it>
-- Company    : dwave studio associato
-- Created    : 2017-03-08
-- Last update: 2019-03-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: ipbus register bridge between data assembly and the gcu
-- configuration space
-------------------------------------------------------------------------------
-- Copyright (c) 2017 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2017-03-08  1.0      antonio Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.ipbus.all;

entity ipbus_data_assembly is
  port (
    clk               : in  std_logic;
    reset             : in  std_logic;
    ipbus_in          : in  ipb_wbus;
    ipbus_out         : out ipb_rbus;
    -- data assembly inteface
    init_clk          : in  std_logic;
    config_dout_valid : out std_logic;
    config_dout_addr  : out std_logic_vector(31 downto 0);
    config_dout_data  : out std_logic_vector(31 downto 0)
    );

end entity ipbus_data_assembly;

architecture rtl of ipbus_data_assembly is

  constant DATA_WIDTH : integer := 32;

  alias reg_address              : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);
  constant PRE_TRIG_IPB_ADDR     : std_logic_vector(1 downto 0) := "00";
  constant SAMPLE_COUNT_IPB_ADDR : std_logic_vector(1 downto 0) := "01";
  constant CONTROL_IP_BUS_ADDR   : std_logic_vector(1 downto 0) := "10";
  constant STATUS_IP_BUS_ADDR    : std_logic_vector(1 downto 0) := "11";

  constant PRE_TRIG_D_A_ADDR     : std_logic_vector(DATA_WIDTH -1 downto 0) := X"000000F4";
  constant SAMPLE_COUNT_D_A_ADDR : std_logic_vector(DATA_WIDTH -1 downto 0) := X"000000F1";

  signal s_pre_trig_reg      : std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');
  signal s_pre_trig_addr     : std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');
  signal s_sample_count_reg  : std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');
  signal s_sample_count_addr : std_logic_vector(DATA_WIDTH -1 downto 0) := (others => '0');


  signal ack : std_logic;
begin  -- architecture rtl
  ipbus_write : process (clk) is
  begin  -- process ipbus_manager
    if rising_edge(clk) then
      if reset = '1' then               -- synchronous reset (active high)
        null;
      elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
        case reg_address is
          when PRE_TRIG_IPB_ADDR =>
            config_dout_data  <= ipbus_in.ipb_wdata;
            config_dout_addr  <= PRE_TRIG_D_A_ADDR;
            config_dout_valid <= '1';
          when SAMPLE_COUNT_IPB_ADDR =>
            config_dout_data  <= ipbus_in.ipb_wdata;
            config_dout_addr  <= SAMPLE_COUNT_D_A_ADDR;
            config_dout_valid <= '1';
          when others =>
            config_dout_valid <= '0';
        end case;
      else
        config_dout_valid <= '0';
      end if;
--      ack <= ipbus_in.ipb_strobe and not ack;
    end if;
  end process ipbus_write;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';
end architecture rtl;
