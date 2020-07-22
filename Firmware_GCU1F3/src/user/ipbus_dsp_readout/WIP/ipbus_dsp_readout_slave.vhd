
--IPBUS DSP INTERFACE SLAVE




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;
   

entity ipbus_dsp_readout_slave is
    port (
    -- ip bus interface
        clk                 : in  std_logic;
        reset               : in  std_logic;
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
        --CtrlReg
        valid_out			:out std_logic;
        trig_out			:out std_logic;
        --SM status
        SM_State			:in std_logic_vector(7 downto 0)
    );
end ipbus_dsp_readout_slave;



architecture rtl of ipbus_dsp_readout_slave is

--internal registers
signal valint:std_Logic;
signal trigint:std_Logic;

alias reg_address                    : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);
  constant CTRIG                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(0, 2));
  constant CVALID               : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(1, 2));
  constant CSTATE                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(2, 2));
  
begin
     trig_out<=trigint;
     valid_out<=valint;
    ipbus_write : process (clk) is
    begin  -- process ipbus_manager
        if rising_edge(clk) then            -- rising clock edge
            if reset = '1' then               -- synchronous reset (active high)
                valint<='0';
                trigint<='0';
            elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
                case reg_address is
                    when CTRIG=>
                        trigint<= ipbus_in.ipb_wdata(0);
                    when CVALID =>
                        valint<=ipbus_in.ipb_wdata(0);
                    when others => null;
                end case;
            end if;
        end if;
    end process ipbus_write;

    
  ipbus_read : process () is
  begin  -- process ipbus_read
        ipbus_out.ipb_rdata<= (others =>'0');
        case reg_address is
            when CTRIG =>
                ipbus_out.ipb_rdata(0) <= trigint;
            when CVALID =>
                ipbus_out.ipb_rdata(0) <= valint;
            when CSTATE =>
                ipbus_out.ipb_rdata(7 downto 0) <= SM_State;
            when others => null;
        end case;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

end architecture rtl;
