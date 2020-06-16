-------------------------------------------------------------------------------
-- Title      : global types ports
-- Project    : 
-------------------------------------------------------------------------------
-- File       : global_wire_package.vhd
-- Author     : Antonio Bergnoli  <bergnoli@.pd.infn.it>
-- Company    : 
-- Created    : 2019-02-21
-- Last update: 2019-02-21
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: contains the definitions of aggregate types useful to "escape"
-- wires from deep levels of code to the top entity module
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-02-21  1.0      antonio Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
package global_types is
  constant DAQ_IN_PORTS_N  : integer := 16;
  constant DAQ_OUT_PORTS_N : integer := 16;

  constant I2C_IN_PORTS_N  : integer := 16;
  constant I2C_OUT_PORTS_N : integer := 16;

  type nested is record
    e_1 : std_logic;
    e_2 : std_logic;
  end record nested;
  type wirebus_in is record
    daq_ports : std_logic_vector(DAQ_IN_PORTS_N - 1 downto 0);
    i2c_ports : std_logic_vector(I2C_IN_PORTS_N - 1 downto 0);
    n         : nested;
  end record wirebus_in;

  type wirebus_out is record
    daq_ports : std_logic_vector(DAQ_OUT_PORTS_N - 1 downto 0);
    i2c_ports : std_logic_vector(I2C_OUT_PORTS_N - 1 downto 0);
  end record wirebus_out;
end package global_types;
