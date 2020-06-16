----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:12:35 09/19/2018 
-- Design Name: 
-- Module Name:    stop_fsm - rtl 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.TTCtestpack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stop_fsm is
    Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           stop_i : in  STD_LOGIC;
           error_1bit_i : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           error_2bit_i : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           error_comm_i : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           numbers_o : out  TTCtest_rx_results);
end stop_fsm;

architecture rtl of stop_fsm is

signal sv_stop_and_errors : std_logic_vector(3 downto 0);
signal u_stop_counter	: unsigned(47 downto 0);

begin

	fsm_process : process(clk_i, rst_i)
	begin
		if (rst_i = '1') then
			u_stop_counter <= (others => '0');
		else
			if rising_edge(clk_i) then
				if (stop_i = '1') then
					u_stop_counter <= u_stop_counter + 1;
				end if;
			end if;
		end if;
	end process;
			
	numbers_o.stop <= std_logic_vector(u_stop_counter);
	numbers_o.error_1bit <= error_1bit_i(15 downto 0);
	numbers_o.error_2bit <= error_2bit_i(15 downto 0);
	numbers_o.error_comm <= error_comm_i(15 downto 0);


end rtl;

