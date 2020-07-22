 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;



entity dsp_readout is
	generic(
		NDSP : positive := 2
	);
	port(
		 -- ip bus interface
        ipb_clk             : in std_logic;
        ipb_rst             : in  std_logic;        
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
		
		nReset : in std_logic;
		clk	   : in std_logic;
				
		--Signal to dsp interfaces
		dsp_readout_lock: out std_logic;
		dsp_startro : out std_logic;
		
		--feedback from dsp interfaces
		dsp_dataready: in std_logic_vector(7 downto 0);
		dsp_busy: in std_logic_vector(7 downto 0);		
		
		--DSP signals
		trigger_dsp: out std_logic;
		valid_dsp: out std_logic;		
		
		--local inhibit
		local_inhibit : out std_logic;
		
		--event ready strobe
		evnt_ready: out std_logic
	);
end dsp_readout; 



architecture RTL of dsp_readout is
signal local_inhibit_int:std_logic;
signal evnt_ready_int: std_logic;

signal valid_out_readout:  std_logic; --starts readout sm

signal valid_int:std_logic;
signal trig_int:std_logic;
signal SM_int:std_logic_Vector(7 downto 0);


begin
	evnt_ready<=evnt_ready_int;
	local_inhibit<=local_inhibit_int;
	valid_dsp<=valid_int;
	
	ipbus_slave_1 : entity work.ipbus_dsp_readout_slave
    port map (
        clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbus_in,
        ipbus_out           => ipbus_out,
		valid_out			=> valid_int,
        trig_out			=> trig_int,
        --SM status
        SM_State			=>SM_int
    );      
    
    readout_logic : entity work.dsp_readout_logic
		generic map(
			NDSP=>NDSP
		)
		port map(
			nReset=>nReset,
			clk=>clk,
			trigger_in=>valid_int,
			dsp_dataready=>dsp_dataready,
			dsp_busy=>dsp_busy,
			trigger_out=>dsp_startro,
			readout_lock=>dsp_readout_lock,
			local_inhibit=>local_inhibit_int,
			evnt_ready=>evnt_ready_int,
			SM_state=>SM_int
	);
	

end architecture;
