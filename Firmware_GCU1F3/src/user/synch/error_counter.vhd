----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:51:23 09/21/2018 
-- Design Name: 
-- Module Name:    error_counter - rtl 
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
use work.GCUpack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity error_counter is
    Port ( clk_i : in  STD_LOGIC;
           rst_i : in  STD_LOGIC;
           error_1bit_pulse_i : in  STD_LOGIC;
           error_2bit_pulse_i : in  STD_LOGIC;
           error_comm_pulse_i : in  STD_LOGIC;
           counter_1bit_error_o : out  STD_LOGIC_VECTOR (47 downto 0);
           counter_2bit_error_o : out  STD_LOGIC_VECTOR (47 downto 0);
           counter_comm_error_o : out  STD_LOGIC_VECTOR (47 downto 0));
end error_counter;

architecture rtl of error_counter is

signal sv_error_vector,
		 sv_error_vector_sync		: std_logic_vector(2 downto 0);
signal u_1bit_err_counter,
		 u_2bit_err_counter,
		 u_comm_err_counter			: unsigned(47 downto 0);

begin
	
	counter_1bit_error_o <= std_logic_vector(u_1bit_err_counter);
	counter_2bit_error_o <= std_logic_vector(u_2bit_err_counter);
	counter_comm_error_o <= std_logic_vector(u_comm_err_counter);

	sv_error_vector <= error_1bit_pulse_i & error_2bit_pulse_i & error_comm_pulse_i;
	
	Inst_error_counter_double_flop : entity work.double_flop
		generic map(
			 g_width => 3,
			 g_clk_rise  => "TRUE"
			 )
		port map(
			 clk_i => clk_i,   
			 sig_i => sv_error_vector,
			 sig_o => sv_error_vector_sync
			 );

	Proc_counting : process(clk_i, rst_i)
	begin
		if rst_i = '1' then
			u_1bit_err_counter <= (others => '0');
			u_2bit_err_counter <= (others => '0');
			u_comm_err_counter <= (others => '0');
		else
			if rising_edge(clk_i) then
				case sv_error_vector_sync is
					when "001"	=>
						u_comm_err_counter <= u_comm_err_counter + 1;
					when "010"	=>
						u_2bit_err_counter <= u_2bit_err_counter + 1;
					when "100"	=>
						u_1bit_err_counter <= u_1bit_err_counter + 1;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;
		
		
		
		
		
		
		


end rtl;

