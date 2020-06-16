-------------------------------------------------------------------------------
-- Title      : Testbench for design "l1_cache"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : l1_cache_tb.vhd
-- Author     : Antonio Bergnoli  <antonio@MacBook-Air-di-Antonio.local>
-- Company    : 
-- Created    : 2019-04-05
-- Last update: 2019-05-23
-- Platform   : 
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-04-05  1.0      antonio Created
-------------------------------------------------------------------------------

use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ipbus.all;
use work.ipbus_reg_types.all;


use ieee.math_real.all;
-------------------------------------------------------------------------------

entity l1_cache_tb is

end entity l1_cache_tb;

-------------------------------------------------------------------------------

architecture test of l1_cache_tb is

  -- component generics
  constant g_a_size : integer := 11;

  -- component ports
  signal clk                     : std_logic                       := '1';
  signal reset                   : std_logic;
  signal gcu_id                  : std_logic_vector(15 downto 0)   := X"BABE";
  signal adc_data_i              : std_logic_vector (127 downto 0) := (others => '0');
  signal adc_clk_i_1Ghz          : std_logic;
  signal adc_clk_i_125Mhz        : std_logic;
  signal pkg_data_o              : std_logic_vector(127 downto 0);
  signal stream                  : std_logic_vector(15 downto 0);
  signal valid_data_o            : std_logic;
  signal Trig_time               : std_logic_vector(47 downto 0);
  signal abs_time                : std_logic_vector(47 downto 0);
  signal abs_time_numeric        : unsigned(47 downto 0)           := (others => '0');
  signal Validated_trig_i        : std_logic;
  signal ip_wbus_zero            : ipb_wbus;
  -- clock
  constant adc_clk_period_125Mhz : time                            := 8 ns;
  constant adc_clk_period_1ghz   : time                            := 1 ns;
  signal simulation_running      : boolean                         := false;
begin  -- architecture test
  -- component instantiation
  ip_wbus_zero.ipb_addr    <= (others => '0');
  ip_wbus_zero.ipb_wdata  <= (others => '0');
  ip_wbus_zero.ipb_strobe <= '0';
  ip_wbus_zero.ipb_write  <= '0';
  DUT : entity work.l1_cache
    generic map (
      channel_number => 1,
      g_a_size       => g_a_size)
    port map (
      clk              => clk,
      reset            => reset,
      ipbus_in         => ip_wbus_zero,
      ipbus_out        => open,
      gcu_id           => gcu_id,
      adc_data_i       => adc_data_i,
      adc_clk_i        => adc_clk_i_125Mhz,
      pkg_data_o       => pkg_data_o,
      valid_data_o     => valid_data_o,
      Trig_time        => Trig_time,
      abs_time         => abs_time,
      Validated_trig_i => Validated_trig_i,
      Trig_o           => open);


  abs_time <= std_logic_vector(abs_time_numeric);
  -- clock generation

  -- waveform generation

  pulse_generator : if true generate

    adc_clk_i_1Ghz <= not adc_clk_i_1Ghz after adc_clk_period_1ghz / 2 when simulation_running else
                      '0';
    erlang_1 : entity work.erlang
      port map (
        clk      => adc_clk_i_1Ghz,
        data_out => adc_data_i,
        clk_out  => adc_clk_i_125Mhz);

    local_time_counter_1 : process (adc_clk_i_125Mhz) is
      variable re1 : integer := 0;
    begin  -- process local_time_counter
      if rising_edge(adc_clk_i_125Mhz) then  -- rising clock edge
        abs_time_numeric <= abs_time_numeric + 1;
      end if;
    end process local_time_counter_1;
  end generate pulse_generator;

  pattern_generator : if false generate
    adc_clk_i_125Mhz <= not adc_clk_i_125Mhz after adc_clk_period_125Mhz / 2 when simulation_running else
                        '0';
    local_time_counter : process (adc_clk_i_125Mhz) is
      variable re1 : integer := 0;
    begin  -- process local_time_counter
      if rising_edge(adc_clk_i_125Mhz) then  -- rising clock edge
        abs_time_numeric <= abs_time_numeric + 1;
        re1              := re1 + 3;
        for idx in 1 to 8 loop
          adc_data_i((idx * 16) - 1 downto (idx * 16) - 16) <= std_logic_vector (to_unsigned (re1, 16));
        end loop;  -- idx  
      end if;
    end process local_time_counter;

  end generate pattern_generator;
  stream <= pkg_data_o (15 downto 0);
  WaveGen_Proc : process

  begin
    simulation_running <= true;
    -- insert signal assignments here
    validated_trig_i   <= '0';
    reset              <= '0';
    wait for 10 ns;
    reset              <= '1';
    wait for 10 ns;
    reset              <= '0';
    wait for 1 us;

    wait for 10 us;
    wait until rising_edge(adc_clk_i_125Mhz);
    validated_trig_i   <= '1';
    Trig_time          <= X"000000000002";
    wait until rising_edge(adc_clk_i_125Mhz);
    wait for 1 us;
    validated_trig_i   <= '0';
    wait for 1 us;
    wait for 10 us;
    wait until rising_edge(adc_clk_i_125Mhz);
    validated_trig_i   <= '1';
    Trig_time          <= X"00000000FFF2";
    wait until rising_edge(adc_clk_i_125Mhz);
    wait for 1 us;
    validated_trig_i   <= '0';
    wait for 40 us;
    simulation_running <= false;
    wait;
  end process WaveGen_Proc;

  display_output : process (adc_clk_i_125Mhz) is
    variable l : line;
  begin  -- process display_output
    if rising_edge(adc_clk_i_125Mhz) then  -- rising clock edge
      if valid_data_o = '1' then
        write(l, to_hstring(pkg_data_o));
        writeline(output, l);
      end if;
    end if;
  end process display_output;

end architecture test;

-------------------------------------------------------------------------------

configuration l1_cache_tb_test_cfg of l1_cache_tb is
  for test
  end for;
end l1_cache_tb_test_cfg;

-------------------------------------------------------------------------------
