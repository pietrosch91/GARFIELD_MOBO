 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;



entity dsp_readout_logic is
	generic(
		NDSP : positive := 2;
	);
	port(
		nReset : in std_logic;
		clk	   : in std_logic;
		
		--trigger input
		trigger_in : in std_logic;
		
		--feedback from dsp interfaces
		dsp_dataready: in std_logic_vector(7 downto 0);
		dsp_busy: in std_logic_vector(7 downto 0);
		
		--trigger output
		trigger_out : out std_logic; --starts the acq
		
		--local inhibit
		local_inhibit : out std_logic;
		
		--event ready strobe
		evnt_ready: out std_logic;
		
		SM_state: out std_logic_Vector(7 downto 0)
		
	);
end dsp_readout_logic;
		
		
		
architecture rtl of dsp_readout_logic is
	--inhibit management
	signal inhibit_reset: std_logic;
	signal inhibit_int: std_logic;
	signal eoe: std_logic; --positive pulse clears local inhibit
	
	--dataready management
   	signal reset_dr:std_logic;
	signal dataready_latch: std_logic_vector(7 downto 0);
	
	--statemachine
	type state_t is (WAITING_TRIGGER,START,WAIT_DATAREADY,GENERATE_EVENT_READY,WAIT_BUSY);
	signal state : state_t;
	
	--internal busy
	signal busy_int: std_Logic_vector(7 downto 0);
begin
	busy: process
	begin
		for i in 0 to (NDSP-1) loop
			busy_int(i)<=dsp_busy(i);
		end loop;
		for i in NDSP to 7 loop
			busy_int(i)<='0';
		end loop;
	end process;
	
	local_inhibit<=inhibit_int or eoe;
	
	sinhibit_reset<=nReset and not eoe;

	inhibit_res: process(inhibit_reset,trigger_in) is
		begin
			if inhibit_reset='0' then
				inhibit_int<='0';
			elsif trigger_in'event and trigger_in<='1' 
				inhibit_int<='1';
			end if;
		end process;
		
		
   			
	reset_dr<=nReset and inhibit_int;			
	
	dataready_latching: process (reset_dr,dsp_dataready) is
		begin
			if reset_dr='0' then
				dataready_latch(NDSP-1 downto 0)<=(others=>'0');
				dataready_latch(7 downto NDSP)<=(others=>'1');
			else
				dataready_latch(7 downto NDSP)<=(others=>'1');
				for i in 0 to NDSP-1 loop
					if dsp_dataready(i)'event and dsp_dataready(i)='1' then
						dataready_latch(i)<='1';
					end if;				
				end loop;			
			end if;	
		end process;
		
	sm: process(nReset,clk) is
		begin
			if nReset='0' then
				evnt_ready<='0';
				trigger_out<='0';
				eoe<='0';
				state<=WAITING_TRIGGER;
				SM_state<=x"00";
			elsif clk'event and clk='1' then
				evnt_ready<='0';
				trigger_out<='0';
				eoe<='0';
				case state is
					when WAITING_TRIGGER=>
						SM_state<=x"00";
						if inhibit_int='1' then -->Received trigger
							trigger_out<='1';
							state<=START;
						end if;
					when START=>
						SM_state<=x"01";
						trigger_out<='1';
						state<=WAIT_DATAREADY;
					when WAIT_DATAREADY=>
						SM_state<=x"02";
						if dataready_latch =x"FF" then --end of event
							evnt_ready<='1';
							state<=GENERATE_EVENT_READY;
						end if;
					when GENERATE_EVENT_READY=>
						SM_state<=x"03";
						evnt_ready<='1';
						state<=WAIT_BUSY;
					when WAIT_BUSY=>
						SM_state<=x"04";
						if dsp_busy=x"00" then --DSP ENDED function
							eoe<='1';
							state<=WAITING_TRIGGER;
						end if;
					when others=>
						state<=WAITING_TRIGGER;
				end case;
			end if;
		end process;
end architecture;
