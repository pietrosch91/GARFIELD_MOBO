----------------------------------------------------------------------------------
-- Company:        INFN - LNL
-- Create Date:    18:03:42 01/06/2017 
-- Design Name:    TTC Test
-- Module Name:    command_vector_generator - Behavioral 
-- Project Name:   GCU
-- Tool versions:  ISE 14.7
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.GCUpack.all;

entity command_vector_generator is
    Port ( clk_i        : in  std_logic;
           rst_i        : in  std_logic;
           trigg_i      : in  std_logic;
			  chb_grant1_i : in  std_logic;
			  chb_req1_o   : out  std_logic;
           vector_o     : out  t_brd_command;
			  l1a_o        : out std_logic;
           start_o      : out  std_logic
			  );
end command_vector_generator;

architecture rtl of command_vector_generator is
signal s_start : std_logic;
signal s_chb_req : std_logic;
signal s_set : std_logic;
signal s_trigg : std_logic;
signal s_l1a_i : std_logic; 
signal s_l1a : std_logic;
signal s_sell  : std_logic_vector(3 downto 0);
type t_fsm is (st1, st2, st3, st4, st5, st6, st7, st8, st9, st10, st11);
signal s_state : t_fsm;
type t_cha_fsm is (st0_idle, 
                   st1_cha, 
					    st2_cha, 
                   st3_cha,
					    st4_cha
				       );
signal s_state_cha : t_cha_fsm;
begin

Inst_trigg_rise_edge_detect : entity work.r_edge_detect
	generic map(
	    g_clk_rise  => "TRUE"
	    )
	port map(
	    clk_i => clk_i,   
       sig_i => trigg_i,
       sig_o => s_trigg
	    );
		 
Inst_SR_flip_flop : entity work.set_reset_ffd
  generic map(
	    g_clk_rise  => "TRUE"
	    )
	port map(
	    clk_i   => clk_i,   
  		 set_i   => s_set,
		 reset_i => chb_grant1_i,
       q_o     => s_chb_req
	    );

s_set <= '0' when s_sell = "0000" else s_trigg;
chb_req1_o <= s_chb_req;

Inst_chb_req_edge_detect : entity work.f_edge_detect
	generic map(
	    g_clk_rise  => "TRUE"
	    )
	port map(
	    clk_i => clk_i,   
       sig_i => s_chb_req,
       sig_o => s_start
	    );

start_o <= s_trigg when s_sell = "0000" else s_start;

p_update_state : process(clk_i,rst_i)  
  begin  
    if rst_i = '1' then
	    s_state <= st1;
    elsif rising_edge(clk_i) then 
       case s_state is
				 
          when st1 =>
             if s_trigg = '1' then
               s_state <= st2;
             end if;       
          
          when st2 =>
			    if s_start = '1' then
               s_state <= st3;
             end if;
				 
			 when st3 =>
			    if s_start = '1' then
               s_state <= st4;
             end if;
				 
			 when st4 =>
			    if s_start = '1' then
               s_state <= st5;
             end if;
				 
			when st5 =>
			    if s_start = '1' then
               s_state <= st6;
             end if;
			
          when st6 =>
			    if s_start = '1' then
               s_state <= st7;
             end if;			
			
          when st7 =>
			    if s_start = '1' then
               s_state <= st8;
             end if;
			
			 when st8 =>
			    if s_start = '1' then
               s_state <= st9;
             end if;
				 
			 when st9 =>
			    if s_start = '1' then
               s_state <= st10;
             end if;	 
				 
			 when st10 =>
			    if s_start = '1' then
               s_state <= st11;
             end if;
				 
			 when st11 =>
			    if s_start = '1' then
               s_state <= st1;
             end if;
				 
		    -------
          when others =>               
              s_state <= st1;
			 -------  
       end case;
    end if;
end process;

p_update_sell : process(s_state)  
  begin  
     case s_state is
		    -------
          when st1 =>
			    s_sell <= "0000";
				 
			 -------
          when st2 =>
			    s_sell <= "0001";
				 
			 -------
			 when st3 =>
			    s_sell <= "0010";
				 
			 -------
			 when st4 =>
			    s_sell <= "0011";
				 
			 -------
          when st5 =>
			    s_sell <= "0100";
				 
			 -------
          when st6 =>
			    s_sell <= "0101";
				 
			 -------
			 when st7 =>
			    s_sell <= "0110";
				 
			 -------
			 when st8 =>
			    s_sell <= "0111";
				 
			 -------
          when st9 =>
			    s_sell <= "1000";
				 
			 -------
          when st10 =>
			    s_sell <= "1001";
				 
			 -------
			 when st11 =>
			    s_sell <= "1010";
				 
          when others =>               
             s_sell <= "0000";
				
			 -------  
       end case;
			 
end process;  

-- demux

s_l1a_i                 <= s_trigg when s_sell = "0000" else '0';
vector_o.idle           <= s_start when s_sell = "0001" else '0';
vector_o.rst_time       <= s_start when s_sell = "0010" else '0';
vector_o.rst_event      <= s_start when s_sell = "0011" else '0';
vector_o.rst_time_event <= s_start when s_sell = "0100" else '0';
vector_o.supernova      <= s_start when s_sell = "0101" else '0';
vector_o.test_pulse     <= s_start when s_sell = "0110" else '0';
vector_o.time_request   <= s_start when s_sell = "0111" else '0';
vector_o.rst_errors     <= s_start when s_sell = "1000" else '0';
vector_o.autotrigger    <= s_start when s_sell = "1001" else '0';
vector_o.en_acquisition <= s_start when s_sell = "1010" else '0';

------------------------------cha 4 tclk pulse generator--------------------------
p_update_state_cha : process(clk_i, rst_i)  
  begin  
    if rst_i = '1' then
	    s_state_cha <= st0_idle;
    elsif rising_edge(clk_i) then 
       case s_state_cha is
		    -------
          when st0_idle =>
			    if s_l1a_i = '1' then 
				    s_state_cha <= st1_cha;
             end if; 
			 -------
			 when st1_cha =>		    
				 s_state_cha <= st2_cha;
			 -------
			 when st2_cha =>
			    s_state_cha <= st3_cha;
			 -------
			 when st3_cha =>
				 s_state_cha <= st4_cha;
			 -------
			 when st4_cha =>
				 s_state_cha <= st0_idle;
	       -------
			 when others =>               
             s_state_cha <= st0_idle;
			 -------  
       end case;
    end if;
end process;
p_update_fsm_out_cha : process(s_state_cha)  
  begin  
     case s_state_cha is
		    -------
          when st0_idle =>
			    s_l1a <= '0';
			 -------
			 when st1_cha =>
			    s_l1a <= '1';
			 -------
			 when st2_cha =>
			    s_l1a <= '1';
			 -------
			 when st3_cha =>
			    s_l1a <= '1';
			 -------
			 when st4_cha =>
			    s_l1a <= '1';
			 -------
          when others =>               
             s_l1a <= '0';
			 -------  
       end case;		 
end process; 
l1a_o <= s_l1a;
end rtl;

