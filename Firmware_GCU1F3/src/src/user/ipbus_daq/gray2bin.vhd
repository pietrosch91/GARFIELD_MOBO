library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;

entity gray2bin is
  generic (width : integer := 4);
  port (
    in_gray : in  std_logic_vector(width-1 downto 0);
    out_bin : out std_logic_vector(width-1 downto 0));
end gray2bin;

architecture behavior of gray2bin is

  signal out_bin_int : std_logic_vector(width-1 downto 0);
begin  -- behavior

  out_bin <= out_bin_int;

  -- Sequence: 0,1,3,2,6,7,5,4,C,D,F,E,A,B,9,8
  --* convert gray input vector to binary
  gray2bin_proc : process(in_gray, out_bin_int)
  begin
    out_bin_int(width-1) <= in_gray(width-1);
    -- out_gray(3) <= in_gray(3);
    for i in 1 to width-1 loop
      out_bin_int(width-1-i) <= out_bin_int(width-i) xor in_gray(width-1-i);
    end loop;  -- i
  end process gray2bin_proc;
end behavior;
