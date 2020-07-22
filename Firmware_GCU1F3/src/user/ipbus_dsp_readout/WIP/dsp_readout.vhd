 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;



entity dsp_readout is
	generic(
		NDSP : positive := 2;
	);
	port(
		 -- ip bus interface
        ipb_clk             : in std_logic;
        ipb_rst             : in  std_logic;        
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
		
		nReset : in std_logic;
		clk	   : in std_logic;
		
		--trigger input
		trigger_in : in std_logic;
		valid_in: in std_logic;
		
		--Signal to dsp interfaces
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
		evnt_ready: out std_logic;
		
		--input from channel fifo FIFO
		data_in_CH0			:in std_logic_vector(15 donwto 0);
		data_valid_CHO		:in std_logic;
		rd_strobe_CH0		:out std_logic;
		
		data_in_CH1			:in std_logic_vector(15 donwto 0);
		data_valid_CH1		:in std_logic;
		rd_strobe_CH1		:out std_logic;
		
		data_in_CH2			:in std_logic_vector(15 donwto 0);
		data_valid_CH2		:in std_logic;
		rd_strobe_CH2		:out std_logic;
		
		data_in_CH3			:in std_logic_vector(15 donwto 0);
		data_valid_CH3		:in std_logic;
		rd_strobe_CH3		:out std_logic;
		
		data_in_CH4			:in std_logic_vector(15 donwto 0);
		data_valid_CH4		:in std_logic;
		rd_strobe_CH4		:out std_logic;
		
		data_in_CH5			:in std_logic_vector(15 donwto 0);
		data_valid_CH5		:in std_logic;
		rd_strobe_CH5		:out std_logic;
		
		data_in_CH6			:in std_logic_vector(15 donwto 0);
		data_valid_CH6		:in std_logic;
		rd_strobe_CH6		:out std_logic;
		
		data_in_CH7			:in std_logic_vector(15 donwto 0);
		data_valid_CH7		:in std_logic;
		rd_strobe_CH7		:out std_logic;
		
		--evnt_header
		
		
		--output to fifo			
		data_out			:out std_logic_vector(31 downto 0);
		wr_strobe_out		:out std_logic;
				
		--FIFO control
		mainfifo_full		:in std_logic
	);
end dsp_readout; 



architecture RTL of dsp_readout is
signal local_inhibit_int:std_logic;
signal evnt_ready_int: std_logic;
signal validated_trigger_in:std_logic; 
signal evnt_header_out		: std_logic_vector(31 downto 0);
signal evnt_header_in		: std_logic_vector(31 downto 0);
signal write_header			: std_logic;
signal evnt_header_in		: std_logic_vector(31 downto 0);
signal read_header			: std_logic;
signal header_full			:std_logic;
signal header_valid			:std_logic;
signal valid_out_readout: : std_logic; --starts readout sm

signal valid_int:std_logic;
signal trig_int:std_logic;
signal SM_int:std_logic_Vector(7 downto 0);


begin
	evnt_ready<=evnt_ready_int;
	local_inhibit<=local_inhibit_int;
	
	ipbus_slave_1 : entity work.ipbus_dsp_readout_slave
    generic map (
        IDMA_ADDR_WIDTH => IDMA_ADDR_WIDTH,
        IDMA_DATA_WIDTH => IDMA_DATA_WIDTH)
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
    
	header_fifo: entity work.trig_header_fifo
		port map(
			full=>open,
			din=>evnt_header_out,
			wr_en=>write_header,
			empty=>open,
			dout=>evnt_header_in,
			rd_en=>read_header,
			clk=>clk,
			srst=>not nReset,
			valid=>header_valid,
			prog_full=> header_full
	);

	trigger_logic: entity work.trigger_managment
		port map(
		nReset=>nReset,
		clk=>clk,
		ext_trigger_in=>trig_int,
		ext_valid_in=>valid_int,
		ext_trigger_out=>trigger_dsp, 
		ext_valid_out=>valid_dsp,
		valid_out_pulse=>valid_out_readout
		local inhibit=>local_inhibit_int,
		evnt_header=>evnt_header_out,
		write_header=>write_header
	);
  --IPBUS ALLOCATION
    readout_logic : entity work.dsp_readout_logic
		generic map(
			NDSP=>NDSP
		)
		port map(
			nReset=>nReset,
			clk=>clk,
			trigger_in=>valid_out_readout,
			dsp_dataready=>dsp_dataready,
			dsp_busy=>dsp_busy,
			trigger_out=>dsp_startro,
			local_inhibit=>local_inhibit_int,
			evnt_ready=>evnt_ready_int,
			SM_state=>SM_int
	);
	
	data_transfer: entity work.dsp_data_transfer_logic
		generic map(
			NDSP=>NDSP
		)
		port map (
			clk=>clk,
			nReset=>nReset,
			latch_ready=>evnt_ready_int,
			data_in_CH0=>data_in_CH0,
			data_valid_CH0=>data_valid_CH0,
			rd_strobe_CH0=>rd_strobe_CH0,
			data_in_CH1=>data_in_CH1,
			data_valid_CH1=>data_valid_CH1,
			rd_strobe_CH1=>rd_strobe_CH1,
			data_in_CH2=>data_in_CH2,
			data_valid_CH2=>data_valid_CH2,
			rd_strobe_CH2=>rd_strobe_CH2,
			data_in_CH3=>data_in_CH3,
			data_valid_CH3=>data_valid_CH3,
			rd_strobe_CH3=>rd_strobe_CH3,
			data_in_CH4=>data_in_CH4,
			data_valid_CH4=>data_valid_CH4,
			rd_strobe_CH4=>rd_strobe_CH4,
			data_in_CH5=>data_in_CH5,
			data_valid_CH5=>data_valid_CH5,
			rd_strobe_CH5=>rd_strobe_CH5,
			data_in_CH6=>data_in_CH6,
			data_valid_CH6=>data_valid_CH6,
			rd_strobe_CH6=>rd_strobe_CH6,
			data_in_CH7=>data_in_CH7,
			data_valid_CH7=>data_valid_CH7,
			rd_strobe_CH7=>rd_strobe_CH7,
			evnt_header=>evnt_header_in,
		    read_header=>read_header,
		    header_valid=>header_valid,
			data_out=>data_out,
			wr_strobe_out=>wr_strobe_out,
			mainfifo_full=>mainfifo_full,
			header_ff=>header_full
	);	

end architecture;
