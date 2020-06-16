----------------------------------------------------------------------------------
-- Company:        INFN - LNL
-- Create Date:    14:50:38 02/10/2017 
-- Design Name:    GCU ReadOut
-- Module Name:    chb_traffic_light - rtl 
-- Project Name:   GCU
-- Tool versions:  ISE 14.7
-- Revision: 
-- Revision 0.01 - File Created
-- Description:
-- this fsm grants access to the chb. The priority is handled like this:
-- lower number = higher priority.
-- IDLE = chb is free.
-- state other than IDLE = chb is taken.
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity chb_traffic_light is
    port ( clk_i          : in  std_logic;
           rst_i          : in  std_logic;
           chb_released_i : in  std_logic;
			  synch_i        : in std_logic;
           chb_req1_i     : in  std_logic;
           chb_req2_i     : in  std_logic;
           chb_req3_i     : in  std_logic;
			  chb_req4_i     : in  std_logic;
           chb_grant1_o   : out  std_logic;
           chb_grant2_o   : out  std_logic;
           chb_grant3_o   : out  std_logic;
			  chb_grant4_o   : out  std_logic;
           chb_busy_o     : out  std_logic
			  );
end chb_traffic_light;

architecture rtl of chb_traffic_light is

type t_chb_grant is (idle, 
                   grant1, 
						 grant2, 
                   grant3,
						 grant4
						 );
						 
signal s_state : t_chb_grant;
signal s_chb_busy : std_logic;

signal u_timeout       : unsigned(27 downto 0);
signal s_timeout       : std_logic_vector(27 downto 0);

begin

p_update_state : process(clk_i,rst_i)  
  begin  
    if rst_i = '1' or s_timeout(27) = '1' then
	    s_state <= idle;
    elsif rising_edge(clk_i) then 
       case s_state is
		    
          when idle =>
             if chb_req1_i = '1' and synch_i = '1' then
                s_state <= grant1;
             elsif chb_req2_i = '1' and synch_i = '1' then
                s_state <= grant2;
				 elsif chb_req3_i = '1' and synch_i = '1' then
                s_state <= grant3; 
				 elsif chb_req4_i = '1' and synch_i = '1' then
                s_state <= grant4;
             end if; 
				 
          when grant1 =>
			    if chb_released_i = '1' then
                s_state <= idle;
				 end if;
				 
			 when grant2 =>
			    if chb_released_i = '1' then
                s_state <= idle;
				 end if;	 
				 
			 when grant3 =>
			    if chb_released_i = '1' then
                s_state <= idle;
				 end if;
				 
			 when grant4 =>
			    if chb_released_i = '1' then
                s_state <= idle;
				 end if;

          when others =>               
             s_state <= idle;
				 
       end case;
    end if;
end process;

p_update_fsm_out : process(s_state)  
  begin  
     case s_state is
		    -------
          when idle =>
				 s_chb_busy   <= '0';
				 chb_grant1_o <= '0';
				 chb_grant2_o <= '0';
				 chb_grant3_o <= '0';
				 chb_grant4_o <= '0';
			 -------
          when grant1 =>
				 s_chb_busy <= '1';
				 chb_grant1_o <= '1';
				 chb_grant2_o <= '0';
				 chb_grant3_o <= '0';
				 chb_grant4_o <= '0';
			 -------
			 when grant2 =>
				 s_chb_busy <= '1';
				 chb_grant1_o <= '0';
				 chb_grant2_o <= '1';
				 chb_grant3_o <= '0';
				 chb_grant4_o <= '0';
			 -------
			 when grant3 =>
				 s_chb_busy <= '1';
				 chb_grant1_o <= '0';
				 chb_grant2_o <= '0';
				 chb_grant3_o <= '1';
				 chb_grant4_o <= '0';
			 -------
			 when grant4 =>
				 s_chb_busy <= '1';
				 chb_grant1_o <= '0';
				 chb_grant2_o <= '0';
				 chb_grant3_o <= '0';
				 chb_grant4_o <= '1';
		    -------
          when others =>               
				 s_chb_busy <= '1';
				 chb_grant1_o <= '0';
				 chb_grant2_o <= '0';
				 chb_grant3_o <= '0';
				 chb_grant4_o <= '0';
			 -------  
       end case;
			 
end process;  

chb_busy_o <= s_chb_busy;

p_timeout_counter : process(clk_i)  
begin
   if rising_edge(clk_i) then
      if s_chb_busy = '1' then 
		   u_timeout <= u_timeout + 1;
      else
         u_timeout <= (others => '0');
      end if;
   end if;
end process p_timeout_counter;
s_timeout <= std_logic_vector(u_timeout);


end rtl;

