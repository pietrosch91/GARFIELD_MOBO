library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ipbus.all;
use work.ipbus_reg_types.all;
use work.utils_package.all;
entity ipbus_counter is
  port (
    -- ip bus interface
    clk                 : in  std_logic;
    reset               : in  std_logic;
    ipbus_in            : in  ipb_wbus;
    ipbus_out           : out ipb_rbus
    );
end entity ipbus_counter;

architecture rtl of ipbus_counter is

  -----------------------------------------------------------------------------
  -- IPBUS registers address  definition
  -----------------------------------------------------------------------------
  alias reg_address                    : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);
  constant READ_COUNTER                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(0, 2));
  constant RESET_COUNTER                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(1, 2));
  constant INC_COUNTER                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(2, 2));
  constant DEC_COUNTER                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(3, 2));
  --constant AUTO_TRIGGER_MODE_ADDR      : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(0, 2));
  -- constant _ADDR             : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(1, 2));
  -- constant _ADDR             : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(2, 2));
  -- constant _ADDR             : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(3, 2));
  --signal auto_trigger_mode             : std_logic_vector(31 downto 0);
  signal counter                 : unsigned (15 downto 0);
 
  --alias force_trigger_ch0              : std_logic is auto_trigger_mode(0);
  --alias force_trigger_ch1              : std_logic is auto_trigger_mode(1);
  --alias force_trigger_ch2              : std_logic is auto_trigger_mode(2);
  --alias force_trigger                  : std_logic_vector(2 downto 0) is auto_trigger_mode(2 downto 0);
  --alias trigger_source_selection       : std_logic is auto_trigger_mode(3);
  --alias trigger_path_selection         : std_logic is auto_trigger_mode(4);
  -- alias external_trigger_enable       : std_logic is auto_trigger_mode(5);
  -- alias trigger_on_threshold_enable   : std_logic is auto_trigger_mode(6);
  -- alias global_trigger_request_enable : std_logic is auto_trigger_mode(7);
  --signal internal_trigger              : std_logic_vector(2 downto 0);
  --signal trigger_source                : std_logic_vector(2 downto 0);
  --signal l1a_time_from_ttc_with_offset : std_logic_vector(47 downto 0);
  --constant l1a_time_offset             : unsigned(47 downto 0)        := X"000000000200";

begin  -- architecture rtl
   

  -- trigger logic
--  l1a_time_from_ttc_with_offset <= std_logic_vector(unsigned(l1a_time_from_ttc) - l1a_time_offset);
-- 
--   process (ext_trigger_i, force_trigger, internal_trigger,
--            l1a_time_from_ttc, local_time, trig_accept, trig_in,
--            trigger_path_selection, trigger_source, trigger_source_selection) is
--   begin  -- process
--     if trigger_source_selection = '0' then
--       trigger_source <= trig_in;
--     else
--       trigger_source <= ext_trigger_i &
--                         ext_trigger_i &
--                         ext_trigger_i;
-- 
--     end if;
--                                         -- biwise or
--     for i in internal_trigger'range loop
--       internal_trigger(i) <= trigger_source(i) or force_trigger(i);
--     end loop;  -- internal_trigger'range
-- 
--     if trigger_path_selection = '0' then
--       trig_request <= (others => '0');
--       trigger_time <= local_time;
--       trig_out     <= internal_trigger;
--     else
--       trig_request <= internal_trigger;
--       trigger_time <= ((l1a_time_from_ttc),
--                        (l1a_time_from_ttc),
--                        (l1a_time_from_ttc));
--       trig_out <= trig_accept;
--     end if;
--   end process;
-- 

                                        -- -----------------------------------------------------------------------------
                                        -- IPBus engine
                                        -----------------------------------------------------------------------------

  ipbus_write : process (clk) is
  begin  -- process ipbus_manager
    if rising_edge(clk) then            -- rising clock edge
      if reset = '1' then               -- synchronous reset (active high)
        counter<=(others=>'0');
      elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
        case reg_address is
            when READ_COUNTER=>
                counter<= unsigned(ipbus_in.ipb_wdata(15 downto 0));
            when RESET_COUNTER =>
                counter<=(others=>'0');
            when INC_COUNTER =>
                counter<=counter + unsigned(ipbus_in.ipb_wdata(15 downto 0));
            when DEC_COUNTER =>
                counter<=counter - unsigned(ipbus_in.ipb_wdata(15 downto 0));
            when others => null;
        end case;
      end if;
                                        -- auto restore to zero for force trigger bits
--       if force_trigger_ch0 = '1' then
--         force_trigger_ch0 <= '0';
--       end if;
--       if force_trigger_ch1 = '1' then
--         force_trigger_ch1 <= '0';
--       end if;
--       if force_trigger_ch2 = '1' then
--         force_trigger_ch2 <= '0';
--       end if;
    end if;
  end process ipbus_write;

-- purpose: pure combinatorial readback process
-- type   : combinational
-- inputs : all
-- outputs: ipbus_out
  ipbus_read : process (counter) is
  begin  -- process ipbus_read
    case reg_address is
      when READ_COUNTER =>
        ipbus_out.ipb_rdata(15 downto 0) <= std_logic_vector(counter);
        ipbus_out.ipb_rdata(31 downto 16) <= (others =>counter(15));
      when others => null;
    end case;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

end architecture rtl;
