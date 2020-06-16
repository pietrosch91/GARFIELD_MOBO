----------------------------------------------------------------------------------
-- Company:        INFN - LNL
-- Create Date:    11:39:47 01/11/2017 
-- Design Name:    TTC Test
-- Module Name:    command_vector_receiver - rtl 
-- Project Name:   GCU
-- Tool versions:  ISE 14.7
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.GCUpack.all;

entity command_vector_receiver is
    Port ( clk_i        : in  std_logic;
           rst_i        : in  std_logic;
           stop_o       : out  std_logic;
			  l1a_i        : in  std_logic;
           cmd_vector_i : in  t_brd_command
			  );
end command_vector_receiver;

architecture rtl of command_vector_receiver is

type t_fsm is (st1, st2, st3, st4, st5, st6, st7, st8, st9, st10, st11);
signal s_state : t_fsm;

begin
p_update_state : process(clk_i,rst_i)  
  begin  
    if rst_i = '1' then
	    s_state <= st1;
		 stop_o  <= '0';
    elsif rising_edge(clk_i) then 
	    stop_o  <= '0';
       case s_state is
				 
          when st1 =>
             if l1a_i = '1' then --l1a
               s_state <= st2;
					stop_o  <= '1';
             end if;       
          
          when st2 =>
			    if cmd_vector_i.idle = '1' then -- idle
               s_state <= st3;
					stop_o  <= '1';
             end if;  
				 
			 when st3 =>
			    if cmd_vector_i.rst_time = '1' then -- rst local time
               s_state <= st4;
					stop_o  <= '1';
             end if;  
				 
			 when st4 =>
			    if cmd_vector_i.rst_event = '1' then -- rst event
               s_state <= st5;
					stop_o  <= '1';
             end if;  
				 
			when st5 =>
			    if cmd_vector_i.rst_time_event = '1' then -- rst time + event
               s_state <= st6;
					stop_o  <= '1';
             end if;  
			
          when st6 =>
			   if cmd_vector_i.supernova = '1' then -- supernova
               s_state <= st7;
					stop_o  <= '1';
             end if;  		
			
          when st7 =>
			    if cmd_vector_i.test_pulse = '1' then -- test pulse
               s_state <= st8;
					stop_o  <= '1';
             end if;  
			
			 when st8 =>
			    if cmd_vector_i.time_request = '1' then -- time request
               s_state <= st9;
					stop_o  <= '1';
             end if;  
				 
			 when st9 =>
			    if cmd_vector_i.rst_errors = '1' then -- rst comm errors
               s_state <= st10;
					stop_o  <= '1';
             end if;  	 
				 
			 when st10 =>
			    if cmd_vector_i.autotrigger = '1' then -- autotrigger
               s_state <= st11;
					stop_o  <= '1';
             end if;  
				 
			 when st11 =>     
			    if cmd_vector_i.en_acquisition = '1' then -- en acquisition
               s_state <= st1;
					stop_o  <= '1';
             end if; 
				 
		    -------
          when others =>               
              s_state <= st1;
			 -------  
       end case;
    end if;
end process;

end rtl;

