----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:14:15 09/21/2018 
-- Design Name: 
-- Module Name:    start_fsm_cont - rtl 
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
use ieee.numeric_std.all;
use work.GCUpack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity start_fsm_cont is
	 Generic ( 
		waiting_time : integer := 150
		);
    Port ( 
		clk_i : in  STD_LOGIC;
		rst_i : in  STD_LOGIC;
		send_brd_i	: in STD_LOGIC;
		pulse_sent_i	: in STD_LOGIC;
		trigg_o : out  STD_LOGIC;			  
		start_number_o : out  STD_LOGIC_VECTOR (15 downto 0);
		eff_start_number_o : out STD_LOGIC_VECTOR(47 downto 0)
		);
end start_fsm_cont;

architecture rtl of start_fsm_cont is

signal sv_starting_time,
		 sv_time					: std_logic_vector(7 downto 0);
signal s_trigg					: std_logic;
signal s_send_brd				: std_logic;
signal s_load_countdown		: std_logic;
signal s_enable_countdown	: std_logic;
signal u_start_number	: unsigned(15 downto 0);
signal u_eff_start_number	: unsigned(47 downto 0);
signal s_pulse_sent			: std_logic;

begin
	
	sv_starting_time 		<= std_logic_vector(to_unsigned(waiting_time,8));
	start_number_o 		<= std_logic_vector(u_start_number);
	eff_start_number_o 	<= std_logic_vector(u_eff_start_number);
	trigg_o 					<= s_trigg;

	Inst_trigg_double_flop : entity work.double_flop
		generic map(
			 g_width => 1,
			 g_clk_rise  => "TRUE"
			 )
		port map(
			 clk_i => clk_i,   
			 sig_i(0) => send_brd_i,
			 sig_o(0) => s_send_brd
			 );
			 
	Inst_eff_start_double_flop : entity work.double_flop
		generic map(
			 g_width => 1,
			 g_clk_rise  => "TRUE"
			 )
		port map(
			 clk_i => clk_i,   
			 sig_i(0) => pulse_sent_i,
			 sig_o(0) => s_pulse_sent
			 );
			 
	Inst_countdown : entity work.countdown
		generic map (
			g_width => 8,
			g_clk_rise => "TRUE"
			)
		port map (
			clk_i			=> clk_i,
			reset_i		=> rst_i,	
			load_i		=> s_load_countdown,
			enable_i		=> s_enable_countdown,
			p_i			=> sv_starting_time,
			p_o			=> sv_time
			);
			
	Proc_pulse_counting : process(clk_i, rst_i)
	begin
		if rst_i = '1' then
			u_eff_start_number <= (others => '0');
		else
			if rising_edge(clk_i) then
				if s_pulse_sent = '1' then
					u_eff_start_number <= u_eff_start_number + 1;
				end if;
			end if;
		end if;
	end process;
			 
	Proc_fsm_main : process(clk_i, rst_i)
	type sm_state is (idle, sending, waiting);
	variable state : sm_state := idle;
	begin
		if rst_i = '1' then
			u_start_number <= (others => '0');
			state := idle;
		else
			if rising_edge(clk_i) then
				case state is 
					when idle =>
						s_trigg <= '0';
						s_load_countdown <= '1';
						s_enable_countdown <= '0';
						if s_send_brd = '1' then
							state := sending;
						else
							state := idle;
						end if;
					when sending =>
						s_trigg <= '1';
						s_load_countdown <= '1';
						s_enable_countdown <= '0';
						u_start_number <= u_start_number + 1;
						state := waiting;
					when waiting => 
						s_trigg <= '0';
						s_load_countdown <= '0';
						s_enable_countdown <= '1';
						if s_send_brd = '0' then
							state := idle;
						elsif sv_time = x"00" then
							state := sending;
						else
							state := waiting;
						end if;
				end case;
			end if;
		end if;
	end process;
							
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

end rtl;

