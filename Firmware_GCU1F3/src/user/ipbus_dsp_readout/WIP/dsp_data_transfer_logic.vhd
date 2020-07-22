 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity dsp_data_transfer_logic is
    generic(
		NDSP:positive:= 2;
	);
    port (
		clk					:in std_logic;
		nReset				:in std_logic;
		--readyevnt cntr clk
		latch_ready			:in std_logic;
				
		--input from channel fifo FIFO
		data_in_CH0			:in std_logic_vector(15 donwto 0);
		rd_strobe_CH0		:out std_logic;
		data_valid_CH0		:in std_logic;
		
		data_in_CH1			:in std_logic_vector(15 donwto 0);
		rd_strobe_CH1		:out std_logic;
		data_valid_CH1		:in std_logic;
		
		data_in_CH2			:in std_logic_vector(15 donwto 0);
		rd_strobe_CH2		:out std_logic;
		data_valid_CH2		:in std_logic;
		
		data_in_CH3			:in std_logic_vector(15 donwto 0);
		rd_strobe_CH3		:out std_logic;
		data_valid_CH3		:in std_logic;
		
		data_in_CH4			:in std_logic_vector(15 donwto 0);
		rd_strobe_CH4		:out std_logic;
		data_valid_CH4		:in std_logic;
		
		data_in_CH5			:in std_logic_vector(15 donwto 0);
		rd_strobe_CH5		:out std_logic;
		data_valid_CH5		:in std_logic;
		
		data_in_CH6			:in std_logic_vector(15 donwto 0);
		rd_strobe_CH6		:out std_logic;
		data_valid_CH6		:in std_logic;
		
		data_in_CH7			:in std_logic_vector(15 donwto 0);
		rd_strobe_CH7		:out std_logic;
		data_valid_CH7		:in std_logic;
		
		--evnt_header
		evnt_header			:in std_logic_vector(31 downto 0);
		read_header			:out std_logic;
		header_valid		: in std_logic;
		
		--output to fifo			
		data_out			:out std_logic_vector(31 downto 0);
		wr_strobe_out		:out std_logic;
		
		--FIFO control
		mainfifo_full		:in std_logic;
		header_ff			:in std_logic
	);	
end dsp_data_transfer_logic;


architecture wordcounter of dsp_data_transfer_logic is
	constant DSP_EOE                : std_logic_vector(15 downto 0) := "FFFF";
	constant DSP_MAX =unsigned(2 downto 0) :=to_unsigned(NDSP-1,3);
	signal DSP_index : unsigned(2 downto 0);
	signal WordCounter : unsigned(8 downto 0);
	
	signal rd_strobe_int :std_logic;
	signal data_in :std_logic_vector(15 downto 0);
	signal data_out_int :std_logic_vector(31 downto 0);
	signal data_valid: std_logic;
	
	signal ready_cntr : unsigned(9 downto 0);
	signal read_cntr : unsigned(9 downto 0);
	
	signal latch_ready_del : std_logic;
	
	
	type state_t is(IDLE,READ_HEADER_ST,CHECK_HEADER,START_RO,SELECT_DSP,WAIT1,READ_DATO,WRITE_DATO,WRITE_EOE,ABORTED_EVENT,ABORTED_EOE,WRITE_ABORTED_EOE);
	signal state : state_t;
	
	
begin
	--COMPOSITION of data_out
	--data_out(15 downto 0)<=data_in;
	--data_out(23 downto 16)<=WordCounter;
	data_out<=data_out_int;
	
	countready : process (nReset,clk,latch_ready) is
		begin
			if nReset='0' then
				ready_cntr<=(others=>'0');
			elsif clk'event and clk='1' then
				if latch_ready='1' and latch_ready_del='0' then
					ready_cntr<=ready_cntr+to_unsigned(1,10);
				end if;
			end if;
		end process;
		
	
	strobe_manager: process 
		begin
			rd_strobe_CH0<='0';
			rd_strobe_CH1<='0';
			rd_strobe_CH2<='0';
			rd_strobe_CH3<='0';
			rd_strobe_CH4<='0';
			rd_strobe_CH5<='0';
			rd_strobe_CH6<='0';
			rd_strobe_CH7<='0';
			case DSP_index is
				when "000"=>
					data_in<=data_in_CH0;
					data_valid<=data_valid_CH0;
					rd_strobe_CH0<=rd_strobe_int;
				when "001"=>
					data_in<=data_in_CH1;
					data_valid<=data_valid_CH1;
					rd_strobe_CH1<=rd_strobe_int;
				when "010"=>
					data_in<=data_in_CH2;
					data_valid<=data_valid_CH2;
					rd_strobe_CH2<=rd_strobe_int;
				when "011"=>
					data_in<=data_in_CH3;
					data_valid<=data_valid_CH3;
					rd_strobe_CH3<=rd_strobe_int;
				when "100"=>
					data_in<=data_in_CH4;
					data_valid<=data_valid_CH4;
					rd_strobe_CH4<=rd_strobe_int;
				when "101"=>
					data_in<=data_in_CH5;
					data_valid<=data_valid_CH5;
					rd_strobe_CH5<=rd_strobe_int;
				when "110"=>
					data_in<=data_in_CH6;
					data_valid<=data_valid_CH6;
					rd_strobe_CH6<=rd_strobe_int;
				when "111"=>
					data_in<=data_in_CH7;
					data_valid<=data_valid_CH7;
					rd_strobe_CH7<=rd_strobe_int;			
			end case;	
		end process;
		
	input_pulser : process(nReset,clk) is
		begin
			if (nReset='0') then
				latch_ready_del<='1';
			elsif clk='1' and clk'event then
				latch_ready_del<=latch_ready;
			end if;
		end process;
		
	
	state_machine :process(nReset,clk) is
		begin
			if(nReset='0') then
				state<=IDLE;
				DSP_index<="000";
				WordCounter<=(others=>'0');
				rd_strobe_int<='0';
				wr_strobe_out<='0';
				data_out_int<=(others=>'0');
				read_cntr<=(others=>'0');
				read_header<='0';
			elsif clk='1' and clk'event then
				read_header<='0';
				rd_strobe_int<='0';
				wr_strobe_out<='0';
				case state is
					when IDLE=>
						read_header<='0';
						if read_cntr!=ready_cntr or header_ff='1' then
							read_header<='1';
							state<=READ_HEADER_ST;
						end if;
					when READ_HEADER_ST=>
						read_header<='0';
						state<=LATCH_HEADER;
					when LATCH_HEADER=>
						data_out_int<=evnt_header;
						state<=CHECK_HEADER;
					when CHECK_HEADER=>
						if mainfifo_full='0' then
							wr_strobe_out<='1';
							if  data_out_int(31)='1' then 
								state<=ABORTED_EVENT;
							else
								state<=START_RO;
							end if;							
						end if;
					when START_RO=> --waits until fifo has space 
						DSP_index<="'000";
						WordCounter<=(others=>'0');
						wr_strobe_out<='0'; --write EVT_HEADER to FIFO
						state<=SELECT_DSP;						
					when SELECT_DSP=> --transitory
						data_out_int(31 downto 16)<="AAAA";
						--data_out_int(23 downto 16)<=std_logic_vector(WordCounter);
						data_out_int(15 downto 3)<=(others=>'0');
						data_out_int(2 downto 0)<=std_logic_vector(DSP_index);
						if mainfifo_full='0' then
							wr_strobe_out<='1';						
							state<=WRITE_DSP_HEADER;
							--rd_strobe_int<='1'; 
						end if;
					when WRITE_DSP_HEADER=> --waits until fifo not full
						wr_strobe_out<='0'; --write data
						rd_strobe_int<='1'; --start read cycle from ch fifo
						WordCounter<=WordCounter+to_unsigned(1,8);
						state<=READ_DATO;						
					when READ_DATO=>
						if data_in=DSP_EOE then
							if DSP_index=DSP_MAX then --end of readout
								data_out_int(31 downto 0)<=(others=>'1');
								rd_strobe_int<='0';
								--wr_strobe_out<='1';
								state<=WRITE_EOE;
							else
								rd_strobe_int<='0';
								DSP_index<=DSP_index+to_unsigned(1,3);
								WordCounter<=(others=>'0');
								state<=SELECT_DSP;
							end if;
						else
							--prepare dato next
							rd_strobe_int<='0';
							data_out_int(31 downto 24)<=(others=>'0');
							data_out_int(23 downto 16)<=std_logic_vector(WordCounter);
							--if data_valid='1' then
							data_out_int(15 downto 0)<=data_in;
							--end if;
							if mainfifo_full='0' then
								wr_strobe_out<='1';
								rd_strobe_int<='1';
								state<=WRITE_DATO;
							else
								state<=WAIT_FF;
							end if;							
						end if;
					when WAIT_FF=>
						if mainfifo_full='0' then
							wr_strobe_out<='1';
							--rd_strobe_int<='1';
							state<=WRITE_DATO;
						end if;
					when WRITE_DATO=>--waits until fifo not full
						wr_strobe_out<='0'; --write data
						rd_strobe_int<='1'; --start read cycle from ch fifo
						WordCounter<=WordCounter+to_unsigned(1,8);
						state<=READ_DATO;						
					when WRITE_EOE=>
						if mainfifo_full='0' then
							read_cntr<=read_cntr+to_unsigned(1,10);
							wr_strobe_out<='1';
							state<=IDLE;
						end if;
					when ABORTED_EVENT=> --waits until fifo has space 
						wr_strobe_out<='0'; --write EVT_HEADER to FIFO	
						state<=ABORTED_EOE;						
					when ABORTED_EOE=>
						data_out(31 downto 0)<=(others=>'1');
						wr_strobe_out<='0';
						state<=WRITE_ABORTED_EOE;
					when WRITE_ABORTED_EOE=>
						if mainfifo_full='0' then
							wr_strobe_out<='1';
							state<=IDLE;
						end if;	
					when OTHERS=>
						state<=IDLE;
				end case;
			end if;
		end process;
end architecture;

architecture twoworlds of dsp_data_transfer_logic is
	constant DSP_EOE                : std_logic_vector(15 downto 0) := "FFFF";
	constant DSP_MAX =unsigned(2 downto 0) :=to_unsigned(NDSP-1,3);
	signal DSP_index : unsigned(2 downto 0);
	--signal WordCounter : unsigned(8 downto 0);
	
	signal rd_strobe_int :std_logic;
	signal data_in :std_logic_vector(15 downto 0);
	
	signal ready_cntr : unsigned(9 downto 0);
	signal read_cntr : unsigned(9 downto 0);
	
	
	signal latch_ready_del : std_logic;
	
	signal wordid: std_logic;
	
	
	type state_t is(IDLE,START_RO,SELECT_DSP,WAIT1,READ_DATO,WRITE_DATO,WRITE_EOE,ABORTED_EVENT,ABORTED_EOE,WRITE_ABORTED_EOE);
	signal state : state_t;
	
	
begin
	--COMPOSITION of data_out
	--data_out(15 downto 0)<=data_in;
	--data_out(23 downto 16)<=WordCounter;
	
	countready : process (nReset,clk,latch_ready) is
		begin
			if nReset='0' then
				ready_cntr<=(others=>'0');
			elsif clk'event and clk='1' then
				if latch_ready='1' and latch_ready_del='0' then
					ready_cntr<=ready_cntr+to_unsigned(1,10);
				end if;
			end if;
		end process;
		
	
	strobe_manager: process 
		begin
			rd_strobe_CH0<='0';
			rd_strobe_CH1<='0';
			rd_strobe_CH2<='0';
			rd_strobe_CH3<='0';
			rd_strobe_CH4<='0';
			rd_strobe_CH5<='0';
			rd_strobe_CH6<='0';
			rd_strobe_CH7<='0';
			case DSP_index is
				when "000"=>
					data_in<=data_in_CH0;
					rd_strobe_CH0<=rd_strobe_int;
				when "001"=>
					data_in<=data_in_CH1;
					rd_strobe_CH1<=rd_strobe_int;
				when "010"=>
					data_in<=data_in_CH2;
					rd_strobe_CH2<=rd_strobe_int;
				when "011"=>
					data_in<=data_in_CH3;
					rd_strobe_CH3<=rd_strobe_int;
				when "100"=>
					data_in<=data_in_CH4;
					rd_strobe_CH4<=rd_strobe_int;
				when "101"=>
					data_in<=data_in_CH5;
					rd_strobe_CH5<=rd_strobe_int;
				when "110"=>
					data_in<=data_in_CH6;
					rd_strobe_CH6<=rd_strobe_int;
				when "111"=>
					data_in<=data_in_CH7;
					rd_strobe_CH7<=rd_strobe_int;			
			end case;	
		end process;
		
	input_pulser : process(nReset,clk) is
		begin
			if (nReset='0') then
				latch_ready_del<='1';
			elsif clk='1' and clk'event then
				latch_ready_del<=latch_ready;
			end if;
		end process;
		
	
	state_machine :process(nReset,clk) is
		begin
			if(nReset='0') then
				state<=IDLE;
				DSP_index<="000";
				--WordCounter<=(others=>'0');
				rd_strobe_int<='0';
				wr_strobe_out<='0';
				data_out<=(others=>'0');
				read_cntr<=(others=>'0');
				read_header<='0';
				wordid<='0';
			elsif clk='1' and clk'event then
				case state is
					when IDLE=>
						read_header<='0';
						if read_cntr!=ready_cntr or header_ff='1' then
							read_header<='1';
							state<=READ_HEADER_ST;
						end if;
					when READ_HEADER_ST=>
						read_header<='0';
						state<=LATCH_HEADER;
					when LATCH_HEADER=>
						data_out_int<=evnt_header;
						state<=CHECK_HEADER;
					when CHECK_HEADER=>
						if mainfifo_full='0' then
							wr_strobe_out<='1';
							if evnt_header(31) or data_out_int(31)='1' then 
								state<=ABORTED_EVENT;
							else
								state<=START_RO;
							end if;							
						end if;
					--ABORTED event managment
					when ABORTED_EVENT=> --waits until fifo has space 
						wr_strobe_out<='0'; --write EVT_HEADER to FIFO	
						state<=ABORTED_EOE;						
					when ABORTED_EOE=>
						data_out_int(31 downto 0)<=(others=>'1');
						wr_strobe_out<='0';
						state<=WRITE_ABORTED_EOE;
					when WRITE_ABORTED_EOE=>
						if mainfifo_full='0' then
							wr_strobe_out<='1';
							state<=IDLE;
						end if;	
					--GOOD event managment
					when START_RO=> --waits until fifo has space 
						DSP_index<="'000";
						wr_strobe_out<='0'; --write EVT_HEADER to FIFO
						state<=SELECT_DSP;						
					when SELECT_DSP=> --transitory
						data_out_int(31 downto 16)<="AAAA";
						data_out_int(15 downto 3)<=(others=>'0');
						data_out_int(2 downto 0)<=std_logic_vector(DSP_index);
						if mainfifo_full='0' then
							wr_strobe_out<='1';						
							state<=WRITE_DSP_HEADER;
						--	rd_strobe_int<='1'; 
						end if;
					when WRITE_DSP_HEADER=> --waits until fifo not full
						wr_strobe_out<='0'; --write data
						rd_strobe_int<='1'; --start read cycle from ch fifo
						state<=READ_DATO;						
						wordid<='0';
					when READ_DATO=>
						if data_in=DSP_EOE then
							if wordid='0' then
								rd_strobe_int<='0';
								--DSP_index<=DSP_index+to_unsigned(1,3);
								state<=CHECK_EOE;
							else
								dataout(15 downto 0)<="AAAA";
								if mainfifo_full='0' then
									rd_strobe_int<='0';
									wr_strobe_out<='1';
									state<=WRITE_DATO_DISPARI;
								else
									rd_strobe_int<='0';
									state<=WAIT_FF_DISPARI;
								end if;
							end if;									
						else
							if wordid='0' then
								data_out_int(31 downto 16)<=data_in;
								wr_strobe_out<='0';
								rd_strobe_int<='0';
								state<=WRITE_DATO;
							else
								data_out_int(15 downto 0)<=data_in;
								if mainfifo_full='0' then
									wr_strobe_out<='1';
									rd_strobe_int<='0';
									state<=WRITE_DATO;
								else
-- 									rd_strobe_int<='0';
									state<=WAIT_FF;
								end if;
							end if;		
						end if;
					when WAIT_FF=>
						if mainfifo_full='0' then
							wr_strobe_out<='1';
						--	rd_strobe_int<='1';
							state<=WRITE_DATO;
						end if;
					when WRITE_DATO=>--waits until fifo not full
						if wordid='0' then
							rd_strobe_int<='1';
							wr_strobe_out<='0';
							wordid<='1';
							state<=READ_DATO;
						else
							wordid<='0';
							wr_strobe_out<='0'; --write data
							rd_strobe_int<='1'; --start read cycle from ch fifo
							state<=READ_DATO;
						end if;
					when WAIT_FF_DISPARI=>
						if mainfifo_full='0' then
							wr_strobe_out<='1';
							state<=WRITE_DATO_DISPARI;
						end if;
					when WRITE_DATO_DISPARI=>
						wr_strobe_out<='0';
						--DSP_index<=DSP_index+to_unsigned(1,3);
						state<=CHECK_EOE;
					when CHECK_EOE=>
						if DSP_index=DSP_MAX then
							data_out_int(31 downto 0) <=(others=>'1');
							rd_strobe_int<='0';
							if mainfifo_full='0' then
								wr_strobe_out<='1';
								state<=WRITE_EOE;
							end if;
						else
							DSP_index<=DSP_index+to_unsigned(1,3);
							state<=SELECT_DSP;
						end if;
					when WRITE_EOE=>
						read_cntr<=read_cntr+to_unsigned(1,10);
						wr_strobe_out<='0';
						state<=IDLE;
					when OTHERS=>
						state<=IDLE;
				end case;
			end if;
		end process;
end architecture;

