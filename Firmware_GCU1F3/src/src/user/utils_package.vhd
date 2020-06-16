-------------------------------------------------------------------------------
-- Title      : utility package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : utils_package.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    : 
-- Created    : 2019-02-28
-- Last update: 2019-03-01
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: various type definitions and small utilities
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-02-28  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


package utils_package is
  subtype T_SLV_2 is std_logic_vector(1 downto 0);
  subtype T_SLV_3 is std_logic_vector(2 downto 0);
  subtype T_SLV_4 is std_logic_vector(3 downto 0);
  subtype T_SLV_8 is std_logic_vector(7 downto 0);
  subtype T_SLV_12 is std_logic_vector(11 downto 0);
  subtype T_SLV_14 is std_logic_vector(13 downto 0);
  subtype T_SLV_16 is std_logic_vector(15 downto 0);
  subtype T_SLV_24 is std_logic_vector(23 downto 0);
  subtype T_SLV_32 is std_logic_vector(31 downto 0);
  subtype T_SLV_36 is std_logic_vector(35 downto 0);
  subtype T_SLV_48 is std_logic_vector(47 downto 0);
  subtype T_SLV_64 is std_logic_vector(63 downto 0);
  subtype T_SLV_96 is std_logic_vector(95 downto 0);
  subtype T_SLV_128 is std_logic_vector(127 downto 0);
  subtype T_SLV_256 is std_logic_vector(255 downto 0);
  
  type T_SLVV_2 is array(natural range <>) of T_SLV_2;
  type T_SLVV_3 is array(natural range <>) of T_SLV_3;
  type T_SLVV_4 is array(natural range <>) of T_SLV_4; 
  type T_SLVV_8 is array(natural range <>) of T_SLV_8;
  type T_SLVV_12 is array(natural range <>) of T_SLV_12;
  type T_SLVV_14 is array(natural range <>) of T_SLV_14;
  type T_SLVV_16 is array(natural range <>) of T_SLV_16;
  type T_SLVV_24 is array(natural range <>) of T_SLV_24;
  type T_SLVV_32 is array(natural range <>) of T_SLV_32;
  type T_SLVV_36 is array(natural range <>) of T_SLV_36;
  type T_SLVV_48 is array(natural range <>) of T_SLV_48;
  type T_SLVV_64 is array(natural range <>) of T_SLV_64;
  type T_SLVV_128 is array(natural range <>) of T_SLV_128;
  type T_SLVV_256 is array(natural range <>) of T_SLV_256;

  type bidim_std_logic_vector is array (natural range <>) of std_logic_vector;
  type tridim_std_logic_vector is array (natural range <>) of bidim_std_logic_vector;

end package utils_package;

