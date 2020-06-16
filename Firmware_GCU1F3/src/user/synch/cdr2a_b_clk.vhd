--=================================================================================================--
--==================================== Module Information =========================================--
--=================================================================================================--
--                                                                                         
-- Company:                CERN (PH-ESE-BE)                                                         
-- Engineer:               Sophie Baron (sophie.baron@cern.ch)                                                                                                                                     
--                                                                                                 
-- Language:               VHDL'93                                                                  
--                                                                                                   
-- Target Device:          Kintex7 - KC705                                                         
-- Tool version:           ISE 14.7                                                                
-- Versions history:           		         								
--
--	DATE:        30/06/2011
--	VERSION:	    0.01	  	
-- AUTHOR:      Eric Hazen et al,EDF Boston University	
-- DESCRIPTION: initial vhdl module: cdr2ttc - behavioral 
--
-- DATE:        18/07/2013
-- VERSION:     1.0
-- AUTHOR:      Sophie BARON, CERN
-- DESCRIPTION: extraction of part of the cdr2ttc to have only Trigger, chb_o and Clock as outputs  
--         
-- DATE:        24/11/2016
-- VERSION:     2.0
-- AUTHOR:      Davide Pedretti, INFN LNL
-- DESCRIPTION: changed vhdl coding style, design architecture review + design minimization for 
--              optimal resources utilization.
--=================================================================================================--
--=================================================================================================--
--==================================== Additional Comments ========================================--
--=================================================================================================-- 
	-- Biphase Mark Decoder + Time Division Demultiplexing.
	-- this core extracts from the 250 MHz clock and the datastream of the TTC CDR the following signals:
	-- A channel (L1A pulse) 
	-- B channel serial stream.
	-- All processes are kept in reset state until "g_pll_locked_delay" clock cycles after the 
	-- MMCM tile is locked

--=================================================================================================--
--=================================================================================================--
--=================================================================================================--
-- These signals are used for channel alignment purpose:
												-----B-------------A------------B-------------A------------B-------
-- A_channel_time_domain				_____________--------------_____________--------------_____________
-- toggle_channel							______-------_______-------______-------_______-------______-------

--=================================================================================================--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.GCUpack.all;

--=================================================================================================--
--======================================= Module Body =============================================-- 
--=================================================================================================--

entity cdr2a_b_clk is
generic(
     g_max_trigg_len   : natural := 30
     );
port 
(   
	cdrclk_x4_i			: in   std_logic;				-- CDR 250MHz clock output from MMCM
	cdrdata_i 			: in   std_logic;				-- ADN2812 CDR Serial Data output
	reset_n_i		   : in   std_logic;				-- from MMCM
	l1a_o					: out  std_logic;				-- A channel = Trigger
	chb_o				   : out  std_logic;				-- B serial stream	
	chb_strobe_o		: out  std_logic;				-- selects B channel	
	toggle_shift_o    : out  std_logic;
	cha_time_domain_o : out  std_logic;
	-- debug
	toggle_channel_debug			: out std_logic;
	toggle_shift_debug			: out std_logic;
	bmc_data_toggle_debug		: out std_logic;
	cdr_data_debug					: out std_logic_vector(1 downto 0)
);
end cdr2a_b_clk;

architecture rtl of cdr2a_b_clk is 
  
   --========================= Signal Declarations ==========================--
	signal s_bmc_data_toggle : std_logic := '0';
	signal s_cdrdata_q : std_logic_vector(1 downto 0) := (others =>'0');
	signal s_toggle_shift : std_logic := '0';
	signal s_toggle_channel : std_logic := '1';
	signal s_a_channel_time_domain : std_logic := '1';
	signal s_l1a : std_logic := '0';
	signal s_strng_length : std_logic_vector(f_log2(g_max_trigg_len) - 1 downto 0) := (others =>'0');
   signal s_max_l1a_len : std_logic_vector(f_log2(g_max_trigg_len) - 1 downto 0);
	
	component chipscope_ila_ttc_rx
  PORT (
    CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    CLK : IN STD_LOGIC;
    TRIG0 : IN STD_LOGIC_VECTOR(0 TO 0);
    TRIG1 : IN STD_LOGIC_VECTOR(0 TO 0);
    TRIG2 : IN STD_LOGIC_VECTOR(0 TO 0);
    TRIG3 : IN STD_LOGIC_VECTOR(0 TO 0);
    TRIG4 : IN STD_LOGIC_VECTOR(0 TO 0);
    TRIG5 : IN STD_LOGIC_VECTOR(0 TO 0));
  end component;


begin

------
-- debug
------
toggle_shift_debug <= s_toggle_shift;
toggle_channel_debug <= s_toggle_channel;
bmc_data_toggle_debug <= s_bmc_data_toggle;
cdr_data_debug	<= s_cdrdata_q;
--


s_max_l1a_len <= std_logic_vector(to_unsigned(g_max_trigg_len + 1,s_max_l1a_len'length));
--===================================================--
-- Biphase Mark Decoder

process(cdrclk_x4_i, reset_n_i)
begin
   if reset_n_i = '0' then
	   s_cdrdata_q <= (others => '0');
   elsif rising_edge(cdrclk_x4_i) then
	   s_cdrdata_q <= s_cdrdata_q(0) & cdrdata_i;
   end if;
end process;

s_bmc_data_toggle <= s_cdrdata_q(0) xor s_cdrdata_q(1);

--===================================================--
-- Shift toggle channel signal
-- ttc signal should always toggle at a/b channel crossing, 
-- otherwise toggle_channel is at wrong position. These wrong bits are discarded.

s_toggle_shift <= (not s_bmc_data_toggle) and (not s_toggle_channel);

--===================================================--	
-- Toggle channel signal
-- toggle channel is '1' during the second part of each time domain (A or B channel)

process(cdrclk_x4_i, reset_n_i)
begin
   if reset_n_i = '0' then
	   s_toggle_channel <= '1';
   elsif rising_edge(cdrclk_x4_i) then
	   if s_toggle_shift = '0' then
	      s_toggle_channel <= not s_toggle_channel;
		end if;
   end if;
end process;

--===================================================--	
-- Channel alignment 
-- ensured by the fact that A = '1' is not able to have more than 
-- 5 consecutive '1's:
-- if illegal l1a='1' sequence reaches 6 then resync the phase
process(cdrclk_x4_i, reset_n_i)
begin
   if reset_n_i = '0' then
	   s_a_channel_time_domain <= '1';
   elsif rising_edge(cdrclk_x4_i) then
	   if s_toggle_channel = '1' and s_strng_length /= s_max_l1a_len then  -- x"6"
	      s_a_channel_time_domain <= not s_a_channel_time_domain;
		end if;
   end if;
end process;
cha_time_domain_o <= s_a_channel_time_domain;
toggle_shift_o <= s_toggle_shift;
-- channel alignment detection
process(cdrclk_x4_i, reset_n_i)
begin
   if reset_n_i = '0' then
	   s_strng_length	<= (others => '0');
   elsif rising_edge(cdrclk_x4_i) then
	   if s_toggle_channel = '1' then
		   if s_strng_length = s_max_l1a_len or (s_a_channel_time_domain = '0' and s_l1a = '0') then
			   s_strng_length <= (others => '0');
		   elsif s_a_channel_time_domain = '0' then
				s_strng_length <= s_strng_length + 1;
			end if;
		end if;
	end if;
end process;


--===================================================--	
-- L1A channel extraction
-- l1a generation: if the data toggles during the l1a_o time domain, L1A=1, else L1A=0
-- s_l1a is a cdrclk_i width pulse (16 ns pulse)
process(cdrclk_x4_i, reset_n_i)
begin
   if reset_n_i = '0' then
	   s_l1a <= '0';
   elsif rising_edge(cdrclk_x4_i) then
	   if s_a_channel_time_domain = '1' and s_toggle_channel = '1' then
			s_l1a <= s_bmc_data_toggle;
		end if;
   end if;
end process;

l1a_o <= s_l1a;

--===================================================--	
-- CHB extraction
-- if the data toggles during the chb time domain, chb=1, else chb=0
process(cdrclk_x4_i, reset_n_i)
begin
   if reset_n_i = '0' then
	   chb_o <= '0';
   elsif rising_edge(cdrclk_x4_i) then
	   if s_a_channel_time_domain = '0' and s_toggle_channel = '1' then
		   chb_o <= s_bmc_data_toggle;
		end if;
   end if;
end process;

-- chb strobe:
process(cdrclk_x4_i, reset_n_i)
begin
   if reset_n_i = '0' then
	   chb_strobe_o <= '0';
   elsif rising_edge(cdrclk_x4_i) then
	   chb_strobe_o <= s_toggle_channel and (not s_a_channel_time_domain);
   end if;
end process;
-- - = 1ns
-- chb        _____----------------_____ ....
-- chb_strobe _____----_________________ ....

---- debug
--your_ila_ttc_rx  : chipscope_ila_ttc_rx
--  port map (
--    CONTROL => debug_control,
--    CLK => cdrclk_x4_i,
--    TRIG0(0) => cdrdata_i,
--    TRIG1(0) => s_bmc_data_toggle,
--    TRIG2(0) => s_a_channel_time_domain,
--    TRIG3(0) => s_toggle_channel,
--    TRIG4(0) => reset_n_i,
--    TRIG5(0) => s_toggle_shift
--	 );


end rtl;

