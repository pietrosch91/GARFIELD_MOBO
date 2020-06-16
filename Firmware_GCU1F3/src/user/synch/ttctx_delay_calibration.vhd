----------------------------------------------------------------------------------
-- INFN LNL
-- Engineer: Davide Pedretti
-- Create Date:    11:29:09 10/06/2017  
-- Module Name:    ttctx_delay_control - rtl 
-- Project Name:   JUNO
-- Target Devices: any
-- Description: this module controls the 4 IDELAY tiles instantiated in the 
--              TTC encoder. The total amount of delay achievable ranges
--              from 0 to 128x78ps ~ 8ns. The BEC card at power-up orders 
--              tap increments and decrements in order to calculate the RX 
--              eye and to sample the incoming data in the middle of the eye.
--
-- Revision: 
-- Revision 0.01 - File Created
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ttctx_delay_control is
    port ( clk_i              : in  std_logic;  -- 62.5 MHz
           ttc_tap_incr_i     : in  std_logic;
           ttc_tap_decr_i     : in  std_logic;
			  ttc_tap_reset_i    : in  std_logic;
           ttc_tx_ready_i     : in  std_logic;
           delay_calibrated_i : in  std_logic;
           chb_grant1_i       : in  std_logic;
           chb_req1_o         : out  std_logic;
           rst_errors_o       : out  std_logic;
           idle_o             : out  std_logic;
			  load_o             : out  std_logic;
           tap_incr_o         : out  std_logic;
			  debug_fsm_o        : out  std_logic_vector(2 downto 0);
           tap_en_o           : out  std_logic_vector(3 downto 0));
end ttctx_delay_control;

architecture rtl of ttctx_delay_control is
signal s_rst_n       : std_logic;
signal u_tap_count   : unsigned(6 downto 0);
signal s_tap_count   : std_logic_vector(6 downto 0);
signal s_sel_delay1  : std_logic;
signal s_sel_delay2  : std_logic;
signal s_sel_delay3  : std_logic;
signal s_sel_delay4  : std_logic;
signal s_tap_en      : std_logic;
signal s_rst_errors  : std_logic;
signal s_idle        : std_logic;
signal s_zero        : std_logic;
signal s_thirtyone   : std_logic;
signal s_sixtythree  : std_logic;
signal s_ninetyfive  : std_logic;

signal s_debug_fsm   : std_logic_vector(2 downto 0);

type t_fsm is (st1_idle, 
               st2_tap_incr, 
					st2_tap_decr, 
               st3_chb_req,
					st4_rst_errors,
					st5_chb_req,
					st6_idle
				   );

signal s_state : t_fsm;

begin

s_rst_n <= ttc_tx_ready_i and delay_calibrated_i;

--------------------------------tap counter---------------------------------------
  p_tap_counter : process(clk_i, s_rst_n, ttc_tap_reset_i)
  begin
    if s_rst_n = '0' or ttc_tap_reset_i = '1' then 
	    u_tap_count <= (others => '0');
    elsif rising_edge(clk_i) then
      if (ttc_tap_incr_i = '1' or s_thirtyone = '1' or s_sixtythree = '1' or s_ninetyfive = '1') and ttc_tap_decr_i = '0' then
        u_tap_count <= u_tap_count + 1;
      elsif ttc_tap_incr_i = '0' and ttc_tap_decr_i = '1' then
        u_tap_count <= u_tap_count - 1;
      end if;
    end if;
  end process p_tap_counter;
  
  s_tap_count <= std_logic_vector(u_tap_count);
  
--------------------------------tap decoder---------------------------------------
  s_sel_delay1 <= (not s_tap_count(6)) and (not s_tap_count(5));
  s_sel_delay2 <= (not s_tap_count(6)) and (s_tap_count(5));
  s_sel_delay3 <= (s_tap_count(6)) and (not s_tap_count(5));
  s_sel_delay4 <= s_tap_count(6) and s_tap_count(5);
  tap_en_o(0)  <= s_tap_en and s_sel_delay1;
  tap_en_o(1)  <= s_tap_en and s_sel_delay2;
  tap_en_o(2)  <= s_tap_en and s_sel_delay3;
  tap_en_o(3)  <= s_tap_en and s_sel_delay4;
  s_zero       <= '1' when u_tap_count = 0 else '0';
  s_thirtyone  <= '1' when u_tap_count = 31 else '0';
  s_sixtythree <= '1' when u_tap_count = 63 else '0';
  s_ninetyfive <= '1' when u_tap_count = 95 else '0';
  load_o       <= (s_zero and s_tap_en) or ttc_tap_reset_i;
----------------------------------------fsm---------------------------------------
p_update_state : process(clk_i,s_rst_n)  
  begin  
    if s_rst_n = '0' or ttc_tap_reset_i = '1' then
	    s_state <= st1_idle;
    elsif rising_edge(clk_i) then 
       case s_state is
		    -------
          when st1_idle =>
			    if ttc_tap_reset_i = '1' then 
				    s_state <= st3_chb_req;
             elsif ttc_tap_incr_i = '1' and ttc_tap_decr_i = '0' and ttc_tap_reset_i = '0' then
                s_state <= st2_tap_incr;
             elsif ttc_tap_incr_i = '0' and ttc_tap_decr_i = '1' and ttc_tap_reset_i = '0' then
                s_state <= st2_tap_decr;
             end if; 
			 -------
			 when st2_tap_incr =>
			    s_state <= st3_chb_req;
			 -------
			 when st2_tap_decr =>
			    s_state <= st3_chb_req;
			 -------
			 when st3_chb_req =>
			    if chb_grant1_i = '1' then
				    s_state <= st4_rst_errors;
				 end if;
			 -------
			 when st4_rst_errors =>
			    if chb_grant1_i = '0' then
				    s_state <= st5_chb_req;
				 end if;
			 -------
			 when st5_chb_req =>
			    if chb_grant1_i = '1' then
				    s_state <= st6_idle;
				 end if;
			 -------
			 when st6_idle =>
			    if chb_grant1_i = '0' then
				    s_state <= st1_idle;
				 end if;
	       -------
			 when others =>               
             s_state <= st1_idle;
			 -------  
       end case;
    end if;
end process;

p_update_fsm_out : process(s_state)  
  begin  
     case s_state is
		    -------
          when st1_idle =>
			    chb_req1_o    <= '0';
				 s_rst_errors  <= '0';
				 s_idle        <= '0';
				 tap_incr_o    <= '0';
				 s_tap_en      <= '0';
				 s_debug_fsm   <= b"000";
			 -------
			 when st2_tap_incr =>
			    chb_req1_o    <= '0';
				 s_rst_errors  <= '0';
				 s_idle        <= '0';
				 tap_incr_o    <= '1';
				 s_tap_en      <= '1';
				 s_debug_fsm   <= b"001";
			 -------
			 when st2_tap_decr =>
			    chb_req1_o    <= '0';
				 s_rst_errors  <= '0';
				 s_idle        <= '0';
				 tap_incr_o    <= '0';
				 s_tap_en      <= '1';
				 s_debug_fsm   <= b"010";
			 -------
			 when st3_chb_req =>
			    chb_req1_o    <= '1';
				 s_rst_errors  <= '0';
				 s_idle        <= '0';
				 tap_incr_o    <= '0';
				 s_tap_en      <= '0';
				 s_debug_fsm   <= b"011";
			 -------
			 when st4_rst_errors =>
			    chb_req1_o    <= '0';
				 s_rst_errors  <= '1';
				 s_idle        <= '0';
				 tap_incr_o    <= '0';
				 s_tap_en      <= '0';
				 s_debug_fsm   <= b"100";
			 -------
			 when st5_chb_req =>
			    chb_req1_o    <= '1';
				 s_rst_errors  <= '0';
				 s_idle        <= '0';
				 tap_incr_o    <= '0';
				 s_tap_en      <= '0';
				 s_debug_fsm   <= b"101";
			 -------
			 when st6_idle =>
			    chb_req1_o    <= '0';
				 s_rst_errors  <= '0';
				 s_idle        <= '1';
				 tap_incr_o    <= '0';
				 s_tap_en      <= '0';
				 s_debug_fsm   <= b"110";
			 -------
          when others =>               
             chb_req1_o    <= '0';
				 s_rst_errors  <= '0';
				 s_idle        <= '0';
				 tap_incr_o    <= '0';
				 s_tap_en      <= '0';
				 s_debug_fsm   <= b"111";
			 -------  
       end case;		 
end process; 

Inst_brd_reset_rise_edge_detect : entity work.r_edge_detect
	generic map(
	    g_clk_rise  => "TRUE"
	    )
	port map(
	    clk_i => clk_i,  
       sig_i => s_rst_errors,
       sig_o => rst_errors_o
	    );
		 
Inst_brd_idle_rise_edge_detect : entity work.r_edge_detect
	generic map(
	    g_clk_rise  => "TRUE"
	    )
	port map(
	    clk_i => clk_i,  
       sig_i => s_idle,
       sig_o => idle_o
	    );
debug_fsm_o <= s_debug_fsm;
end rtl;

