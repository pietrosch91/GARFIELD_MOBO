-------------------------------------------------------------------------------
-- Title      : synchronizer
-- Project    :
-------------------------------------------------------------------------------
-- File       : sychronizer.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    :
-- Created    : 2019-05-30
-- Last update: 2019-05-31
-- Platform   :
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description: simple n-flops synchronizer
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-30  1.0      antonio	Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity synchronizer is
  generic (
    NUM_FLIP_FLOPS : natural := 2  -- number of flip-flops in the synchronizer chain
    );
  port(
    rst      : in  std_logic;           -- asynchronous, high-active
    clk      : in  std_logic;           -- destination clock
    data_in  : in  std_logic;
    data_out : out std_logic
    );
end synchronizer;

architecture arch of synchronizer is
  constant RESET_VALUE : std_logic                                   := '0';
  signal sync_chain    : std_logic_vector(NUM_FLIP_FLOPS-1 downto 0) := (others => RESET_VALUE);

begin

  main : process(clk, rst)
  begin
    if rst = '1' then
      sync_chain <= (others => RESET_VALUE);
    elsif rising_edge(clk) then
      sync_chain <= sync_chain(sync_chain'high-1 downto 0) & data_in;
    end if;
  end process;

  data_out <= sync_chain(sync_chain'high);

end architecture;
