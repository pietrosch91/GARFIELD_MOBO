
--IPBUS DSP INTERFACE SLAVE




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;
   

entity ipbus_dsp_iface_slave is
    port (
    -- ip bus interface
        clk                 : in  std_logic;
        reset               : in  std_logic;
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
        --CtrlReg
        data_out            : out std_logic_vector(15 downto 0);
        op_code             : out std_logic_vector(3 downto 0);
        op_valid            : out std_logic;
        xfer_len            : out std_logic_vector(7 downto 0);
        --Options
        iack_resync         : out std_logic;
        --Status
        DSP_busy            : in std_logic;
        DSP_dataready       : in std_logic;
        --Data
        DSP_DATA            : in std_logic_vector(15 downto 0);
        --dsp reset
        rest_out            : out std_logic
    );
end ipbus_dsp_iface_slave;



architecture rtl of ipbus_dsp_iface_slave is

--internal registers
signal Ctrl_Reg : std_logic_vector(31 downto 0);
signal Opt_Reg  : std_logic_vector(15 downto 0);
signal Status_Reg: std_logic_vector(15 downto 0);

alias reg_address                    : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);
  constant CONTROLS                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(0, 2));
  constant OPTIONS               : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(1, 2));
  constant STATUS                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(2, 2));
  constant DATAREAD                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(3, 2));
  
begin
   data_out<=Ctrl_Reg(15 downto 0);
   op_code<=Ctrl_Reg(19 downto 16);
   op_valid<=Ctrl_Reg(20);
   xfer_len<=Ctrl_Reg(28 downto 21);
   iack_resync<=Opt_Reg(0);
   rest_out<=Opt_Reg(1);
   Status_Reg(0)<=DSP_busy;
   Status_Reg(1)<=DSP_dataready;
   Status_Reg(15 downto 2)<=(others=>'0');
   
   
    
    ipbus_write : process (clk) is
    begin  -- process ipbus_manager
        if rising_edge(clk) then            -- rising clock edge
            if reset = '1' then               -- synchronous reset (active high)
                Ctrl_Reg<=(others=>'0');
                Opt_Reg<=(others=>'0');
            elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
                case reg_address is
                    when CONTROLS=>
                        Ctrl_Reg<= ipbus_in.ipb_wdata(31 downto 0);
                    when OPTIONS =>
                        Opt_Reg<=ipbus_in.ipb_wdata(15 downto 0);
                    when others => null;
                end case;
            end if;
        end if;
    end process ipbus_write;

    
  ipbus_read : process (Ctrl_Reg,Opt_Reg,Status_Reg,DSP_DATA) is
  begin  -- process ipbus_read
        ipbus_out.ipb_rdata<= (others =>'0');
        case reg_address is
            when CONTROLS =>
                ipbus_out.ipb_rdata(31 downto 0) <= Ctrl_Reg;
            when OPTIONS =>
                ipbus_out.ipb_rdata(15 downto 0) <= Opt_Reg;
            when STATUS =>
                ipbus_out.ipb_rdata(15 downto 0) <= Status_Reg;
            when DATAREAD =>
                ipbus_out.ipb_rdata(15 downto 0) <= DSP_DATA;
           when others => null;
        end case;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

end architecture rtl;
