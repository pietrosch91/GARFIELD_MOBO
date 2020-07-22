 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;



entity trigger_managment is
	port(
		nReset : in std_logic;
		clk	   : in std_logic;
		
		--trigger input
		ext_trigger_in : in std_logic;
		ext_valid_in : in std_logic;
		
		ext_trigger_out : out std_logic; 
		ext_valid_out : out std_logic;
		
		valid_out_pulse: out std_logic;
		
		local inhibit : in std_logic;
		
		evnt_header			:out std_logic_vector(31 downto 0);
		write_header			:out std_logic;
		
		
	);
end trigger_managment; 




architecture rtl of trigger_managment is
	signal nRes_tpulse: std_logic;
	signal trigger_in_pulse: std_logic;
	signal trigger_out_pulse: std_logic;
	signal trigger_in_pulse_clk: std_logic;
	signal trigger_in_pulse_clk_del: std_logic;
	signal trigger_in_pulse_1clk: std_logic;
	signal trigger_pulse_counter: unsigned(2 downto 0);
	signal rejected_trigger:std_logic;
	
	signal nRes_vpulse: std_logic;
	
	signal valid_in_pulse: std_logic;
	signal valid_in_pulse_clk: std_logic;
	signal valid_in_pulse_clk_del: std_logic;
	signal valid_in_pulse_1clk:std_logic;
	
	signal trigger_counter: unsigned(15 downto 0);
	

begin
	ext_valid_out<=ext_valid_in;
	
	
	trigger_in_pulser: process(ext_trigger_in,nRes_tpulse) is
		begin
			if nRes_tpulse='0' then
				trigger_in_pulse<='0';
			elsif ext_trigger_in'event and ext_trigger_in='1' then
				trigger_in_pulse<='1';
			end if;
		end process;
		
	trigger_out_pulser: process(ext_trigger_in,nRes_tpulse) is
		begin
			if nRes_tpulse='0' then
				trigger_out_pulse<='0';
			elsif ext_trigger_in'event and ext_trigger_in='1' then
				if local_inhibit='0' then
					trigger_out_pulse<='1';
				end if;
			end if;
		end process;
			
	trigger_pulse_reset: process(clk,trigger_in_pulse,nReset) is
		begin
			if nReset='0' then
				nRes_tpulse<='0';
				trigger_pulse_counter<="000";
				trigger_in_pulse_clk<='1';
				trigger_in_pulse_clk_del<='1';
			elsif clk'event and clk<='1' then
				trigger_in_pulse_clk<=trigger_in_pulse;
				trigger_in_pulse_clk_Del<=trigger_in_pulse_clk;
				nRes_tpulse<='1';
				if trigger_in_pulse='1' then
					if trigger_pulse_counter="111" then
						nRes_tpulse<='0';
						trigger_pulse_counter<="000";
					else
						trigger_pulse_counter<=trigger_pulse_counter+to_unsigned(1,3);
					end if;
				end if;
			end if;
		end process;

	trigger_in_pulse_1clk<=trigger_in_pulse_clk and not trigger_in_pulse_clk_del;
	rejected_trigger<=trigger_in_pulse and not trigger_out_pulse;
	
	latch_reject:process(trig_in_pulse_clk,trigger_in_pulse_clk_Del,clk,nreset) is
		begin
			if nReset='0' then
				evnt_header(31)<='0';
			elsif clk'event and clk='1' then
				if trigger_in_pulse_1clk='1' then
					evnt_header(31)<=rejected_trigger;
				end if;
			end if;			
		end process;
	ext_trigger_out<=trigger_out_pulse;
	
	--validation handling	
	nRes_vpulse<=nReset and not trigger_in_pulse_1clk;
	
	valid_in_pulser: process(ext_valid_in,nRes_vpulse) is
		begin
			if nRes_vpulse='0' then
				valid_in_pulse<='0';
			elsif ext_valid_in'event and ext_valid_in='1' then
				valid_in_pulse<='1';
			end if;
		end process;
	
	valid_delayer:process (clk,nReset,valid_in_pulse) is
		begin
			if nReset='0' then
				valid_in_pulse_clk<='1';
				valid_in_pulse_clk_del<='1';
			elsif clk'event and clk<='1' then
				valid_in_pulse_clk<=valid_in_pulse;
				valid_in_pulse_clk_del<=valid_in_pulse_clk;				
			end if;
		end process;

	valid_in_pulse_1clk<=valid_in_pulse_clk and not valid_in_pulse_clk_del;
	
	count_valids: process(valid_in_pulse_1clk,nReset) is
		begin
			if nReset='0' then
				trigger_counter<=(others=>'0');
				evnt_header(30 downto 16)<=(others=>'0');
			elsif valid_in_pulse_1clk'event and valid_in_pulse_1clk='1' then
				evnt_header(30 downto 16) <=(others=>'0');
				trigger_counter<=trigger_counter+to_unsigned(1,16);
			end if;
		end process;
	
	valid_out_pulse<=valid_in_pulse_1clk;
	evnt_header(15 downto 0) <=std_logic_vector(trigger_counter);
	write_header<=valid_in_pulse_1clk;
end architecture rtl;
