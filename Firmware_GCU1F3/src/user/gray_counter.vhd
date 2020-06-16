library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

entity gray_counter is
  generic (
    width : integer := 4);
port(clk: in std_logic;
  rst: in std_logic;
  gray_code: out std_logic_vector (width - 1 downto 0));
end gray_counter;

architecture beh of gray_counter is
signal count : unsigned(width - 1  downto 0) := (others => '0');
begin
 process(clk)
 begin
  if (rst='1') then
   count <= (others => '0');
  elsif (rising_edge(clk)) then
   count <= count + 1;
  end if;
 end process;
    gray_code <= std_logic_vector( count xor ('0' & count(width -1  downto 1)));
end beh;
