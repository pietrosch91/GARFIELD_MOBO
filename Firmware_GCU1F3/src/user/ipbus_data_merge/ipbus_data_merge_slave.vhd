
--IPBUS DATA MERGE SLAVE




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;
   

entity ipbus_data_merge_slave is
    port (
    -- ip bus interface
        clk                 : in  std_logic;
        reset               : in  std_logic;
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
        FIFO_DATA_rd        : in std_logic_vector(31 downto 0);
        FIFO_DATA_wr        : out std_logic_vector(31 downto 0);
        fifo_rd             : out std_logic;
        fifo_wr             : out std_logic
    );
end ipbus_data_merge_slave;



architecture rtl of ipbus_data_merge_slave is



alias reg_address                    : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);
  constant FIFOREAD                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(0, 2));
  constant FIFOWRITE               : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(1, 2));

attribute mark_debug : string;
attribute mark_debug of fifo_wr     : signal is "true";
attribute mark_debug of FIFO_DATA_wr: signal is "true";

begin
    
    ipbus_write : process (clk) is
    begin  -- process ipbus_manager
        if rising_edge(clk) then            -- rising clock edge
            ------------default----------
                fifo_wr       <= '0';
            -----------------------------

            if reset = '1' then               -- synchronous reset (active high)
                FIFO_DATA_wr    <= (others=>'0');
                fifo_wr         <= '0';
                
            elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
                case reg_address is
                    when FIFOWRITE=>
                        fifo_wr   <= '1';
                        FIFO_DATA_wr<= ipbus_in.ipb_wdata(31 downto 0);
                    when others => null;
                end case;
            end if;
        end if;
    end process ipbus_write;

    
  ipbus_read : process (FIFO_DATA_rd,reg_address) is
  begin  -- process ipbus_read
        ipbus_out.ipb_rdata<= (others =>'0');
        fifo_rd<='0';

        case reg_address is
            when FIFOREAD =>
                ipbus_out.ipb_rdata(31 downto 0) <= FIFO_DATA_rd;
                fifo_rd           <= ipbus_in.ipb_strobe;
            when others => null;
        end case;
  end process ipbus_read;
  
  

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

  
end architecture rtl;
