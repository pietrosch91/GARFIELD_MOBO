----------------------------------------------------------------------------------
-- Company:        INFN - LNL
-- Create Date:    18:29:47 02/22/2017  
-- Module Name:    GCU_1588_ptp - rtl 
-- Project Name:   GCU
-- Tool versions:  ISE 14.7
-- Revision 0.01 - File Created
-- Description:
----------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.GCUpack.all;

entity GCU_1588_ptp is
     port (clk_i        : in  std_logic;   -- 62.5MHz
           rst_i        : in  std_logic;   -- not(ttcrx and ttctx ready)
           enable_i     : in  std_logic;
           byte_5_i     : in  std_logic;
           synch_req_i  : in  std_logic;
           chb_grant_i  : in  std_logic;
           period_i     : in  std_logic_vector(31 downto 0);
           local_time_i : in  std_logic_vector(47 downto 0);
			  trwt         : in  std_logic_vector(31 downto 0);
           synch_i      : in  std_logic_vector(47 downto 0);
           delay_i      : in  std_logic_vector(47 downto 0);
           chb_req_o    : out std_logic;
			  debug_fsm_o  : out std_logic_vector(3 downto 0);
			  control_i    : inout  std_logic_vector(35 downto 0);
			  ttc_long_o   : out t_ttc_long_frame;
           offset_o     : out signed(47 downto 0);
			  --debug
			  rx_time_debug_o		: out std_logic_vector(47 downto 0);
			  tx_time_debug_o		: out std_logic_vector(47 downto 0);
			  catch_tx_time_debug_o		: out std_logic;
			  catch_rx_time_debug_o		: out std_logic
			  );
end GCU_1588_ptp;

architecture rtl of GCU_1588_ptp is

signal s_catch_rx_time : std_logic;
signal s_catch_tx_time : std_logic;
signal s_compute1      : std_logic;
signal s_en_output     : std_logic;
signal s_compute2      : std_logic;
signal s_compute3      : std_logic;
signal s_compute4      : std_logic;
signal s_bomb          : std_logic;
signal s_rst_fsm       : std_logic;
signal s_rst_counter   : std_logic;
signal s_strobe        : std_logic;
signal s_en_count      : std_logic;
signal s_tx_time       : std_logic_vector(47 downto 0);
signal s_rx_time       : std_logic_vector(47 downto 0);
signal t5_trwt         : signed(47 downto 0);
signal t1_g            : signed(47 downto 0);
signal t2_l            : signed(47 downto 0);
signal t3_l            : signed(47 downto 0);
signal t4_g            : signed(47 downto 0);
signal sub1            : signed(47 downto 0);
signal sub2            : signed(47 downto 0);
signal offset_x2       : signed(47 downto 0);
signal offset          : signed(47 downto 0);
signal time_correction : signed(47 downto 0);
signal u_count         : unsigned(31 downto 0);

component chipscope_ila3
  PORT (
    CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    CLK : IN STD_LOGIC;
    TRIG0 : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    TRIG1 : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
    TRIG2 : IN STD_LOGIC_VECTOR(0 TO 0));

end component;


type t_GCU_1588 is (st0_idle,           -- 0x0
                    st1_rx_time,        -- 0x1
		    st2_wait,           -- 0x2
                    st3_chb_req,        -- 0x3
                    st4_tx_time,	       -- 0x4
                    st5_delay_req,      -- 0x5
                    st6_wait_for_delay, -- 0x6				  
                    st7_compute1,       -- 0x7
		    st8_compute2,       -- 0x8
		    st9_compute3,       -- 0x9
			 st10_compute4,      -- 0xa
		    st11_output_offset  -- 0xb
		    );
						  
signal s_state : t_GCU_1588;

constant c_diff : signed(47 downto 0) := x"000000000000";

attribute TIG : string;
attribute TIG of s_rst_fsm : signal is "TRUE"; -- treated as asynchronous reset

begin

-----debug
rx_time_debug_o <= s_rx_time;
tx_time_debug_o <= s_tx_time;
catch_tx_time_debug_o <= s_catch_tx_time;
catch_rx_time_debug_o <= s_catch_rx_time;
---

t5_trwt <= resize(signed(trwt),48);

--===================================================--	
--                     TX TIME SAMPLE
--===================================================--
p_tx_time_sample : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_rst_counter = '1' then
         s_tx_time <= (others => '0');
      elsif s_catch_tx_time = '1' then
         s_tx_time <= local_time_i;
      end if;
   end if;
end process p_tx_time_sample;

t3_l <= signed(s_tx_time);

--===================================================--	
--                     RX TIME SAMPLE
--===================================================--
p_rx_time_sample : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_rst_counter = '1' then
         s_rx_time <= (others => '0');
      elsif s_catch_rx_time = '1' then
         s_rx_time <= local_time_i;
      end if;
   end if;
end process p_rx_time_sample;

t2_l <= signed(s_rx_time);

--===================================================--	
--                     TIMEOUT COUNTER
--===================================================--

p_timeout_counter : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_rst_counter = '1' then
         u_count <= (others => '0');
      elsif s_en_count = '1' then
         u_count <= u_count + 1;
      end if;
   end if;
end process p_timeout_counter;

process(clk_i)
begin
   if rising_edge(clk_i) then
      if u_count = unsigned(period_i) then
         s_bomb <= '1';
      else
         s_bomb <= '0';
      end if;
   end if;
end process;

s_rst_fsm <= s_bomb or rst_i;

--===================================================--	
--                STROBE PULSE GENERATOR
--===================================================--

Inst_strobe_rise_edge_detect : entity work.r_edge_detect
	generic map(
	    g_clk_rise  => "TRUE"
	    )
	port map(
	    clk_i => clk_i,
       sig_i => s_strobe,
       sig_o => ttc_long_o.long_strobe
	    );

--===================================================--	
--                     MOORE FSM
--===================================================--
p_update_state : process(clk_i,s_rst_fsm)  
  begin  
    if s_rst_fsm = '1' then
	    s_state <= st0_idle;
    elsif rising_edge(clk_i) then 
	    if enable_i = '1' then
          case s_state is
		    
             when st0_idle =>
                if synch_req_i = '1' then
                   s_state <= st1_rx_time;
                end if; 
				 
			    when st1_rx_time =>
			       s_state <= st2_wait;
				 
             when st2_wait =>
			       if byte_5_i = '1' then
                   s_state <= st3_chb_req;
                end if;
			 
			    when st3_chb_req =>
			       if chb_grant_i = '1' then
                   s_state <= st4_tx_time;
                end if;
			 
			    when st4_tx_time =>
                s_state <= st5_delay_req;
            
			    when st5_delay_req =>
			       if chb_grant_i = '0' then
                   s_state <= st6_wait_for_delay;
                end if;
			 
			    when st6_wait_for_delay =>
			       if byte_5_i = '1' then
                   s_state <= st7_compute1;
                end if;
			 
             when st7_compute1 =>
                s_state <= st8_compute2;
				 
             when st8_compute2 =>
                s_state <= st9_compute3;
				 
			    when st9_compute3 =>
                s_state <= st10_compute4;
				
				 when st10_compute4 =>
                s_state <= st11_output_offset;
			 
			    when st11_output_offset =>
                s_state <= st0_idle;
				 
             when others =>               
                s_state <= st0_idle;
				 
          end case;
		 end if;
    end if;
end process p_update_state;

p_update_fsm_output : process(s_state)  
  begin  
     case s_state is
		    -------
          when st0_idle =>
             chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '1';
				 s_en_count             <= '0';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
				 s_en_output            <= '0';
				 debug_fsm_o            <= b"0000";
				 
          when st1_rx_time =>
			    chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '1';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
			    s_en_output            <= '0';
				 debug_fsm_o            <= b"0001";
				 
			 when st2_wait =>
			    chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
			    s_en_output            <= '0';
				 debug_fsm_o            <= b"0010";
				 
			 when st3_chb_req =>
			    chb_req_o              <= '1';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
			    s_en_output            <= '0';
				 debug_fsm_o            <= b"0011";
				 
			 when st4_tx_time =>
             chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '1';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
             s_en_output            <= '0';
				 debug_fsm_o            <= b"0100";
				 
			 when st5_delay_req =>
			    chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"19";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '1';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
			    s_en_output            <= '0';
				 debug_fsm_o            <= b"0101";
				 
			 when st6_wait_for_delay =>
			    chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
			    s_en_output            <= '0';
				 debug_fsm_o            <= b"0110";
				 
          when st7_compute1 =>
             chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '1';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
				 s_en_output            <= '0';
				 debug_fsm_o            <= b"0111";
				 
          when st8_compute2 =>
             chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '1';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
			    s_en_output            <= '0';
				 debug_fsm_o            <= b"1000";
				 
			  when st9_compute3 =>
             chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '1';
				 s_compute4             <= '0';
			    s_en_output            <= '0';	 
				 debug_fsm_o            <= b"1001";
				 
			 when st10_compute4 =>
             chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '1';
			    s_en_output            <= '0';	 
				 debug_fsm_o            <= b"1010";
				 
			 when st11_output_offset =>
             chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '1';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
				 s_en_output            <= '1';
				 debug_fsm_o            <= b"1011";
				 
          when others =>               
             chb_req_o              <= '0';
				 ttc_long_o.long_subadd <= x"00";
				 ttc_long_o.long_data   <= x"00";
				 s_catch_rx_time        <= '0';
				 s_catch_tx_time        <= '0';
				 s_rst_counter          <= '0';
				 s_en_count             <= '0';
				 s_strobe               <= '0';
				 s_compute1             <= '0';
				 s_compute2             <= '0';
				 s_compute3             <= '0';
				 s_compute4             <= '0';
				 s_en_output            <= '0';
				 debug_fsm_o            <= b"1111";
			 -------  
       end case;

end process p_update_fsm_output; 

--!! TO SEND A LONG FRAME FROM THE GCU TO THE BEC WE MUST USE x"0000" AS ADDRESS!!
ttc_long_o.long_address   <= x"0000";

--===================================================--	
--                 COMPUTE CLOCKS OFFSET
--===================================================--
t1_g <= signed(synch_i);
t4_g <= signed(delay_i);

-- compute t1_g - t2_l = clock offset - downstream link delay
p_compute_sub1 : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_rst_counter = '1' then
         sub1 <= (others => '0');
      elsif s_compute1 = '1' then
         sub1 <= t1_g - t2_l;
      end if;
   end if;
end process p_compute_sub1;

-- compute t4_g - t3_l = clock offset + upstream link delay
p_compute_sub2 : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_rst_counter = '1' then
         sub2 <= (others => '0');
      elsif s_compute1 = '1' then
         sub2 <= t4_g - t3_l;
      end if;
   end if;
end process p_compute_sub2;

-- compute sub1 + sub2 = 2 x clock offset assuming upstream link delay = downstream link delay (c_diff = 0)
p_compute_offset : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_rst_counter = '1' then
         offset_x2 <= (others => '0');
      elsif s_compute2 = '1' then
         offset_x2 <= sub1 + sub2;
      end if;
   end if;
end process p_compute_offset;

-- right shift /2
p_right_shift : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_rst_counter = '1' then
         offset <= (others => '0');
      elsif s_compute3 = '1' then
         offset <= offset_x2 srl 1;
      end if;
   end if;
end process p_right_shift;

-- BEC postponed time
p_BEC_postponed : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_rst_counter = '1' then
          time_correction <= (others => '0');
      elsif s_compute4 = '1' then
          time_correction <= offset - t5_trwt;
      end if;
   end if;
end process p_BEC_postponed;


-- update offset output; please note that the offset must be
-- not zero only for 1 TCLK.

p_update_output : process(clk_i)
begin
   if rising_edge(clk_i) then
      if s_en_output = '1' then
         offset_o <= time_correction;
      else
         offset_o <= (others => '0');
      end if;
   end if;
end process p_update_output;

-- debug
--
--your_instance_name : chipscope_ila3
--  port map (
--    CONTROL => control_i,
--    CLK => clk_i,
--    TRIG0 => std_logic_vector(sub1),
--    TRIG1 => std_logic_vector(sub2),
--    TRIG2(0) => s_compute2);
	 
	 
end rtl;

