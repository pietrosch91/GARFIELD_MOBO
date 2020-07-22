


--SIMULATION OF ADSP-2181 IDMA MEMORY ACCESS 







library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;
   
    
    
entity ipbus_dsp_slave is
    generic(
        IDMA_ADDR_WIDTH : positive;
        IDMA_DATA_WIDTH : positive :=16
    );
    port (
    -- ip bus interface
        clk                 : in  std_logic;
        reset               : in  std_logic;
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
    --idma interface
        IDMA_CTRL           : out std_logic_vector(3 downto 0);
        D_IN                : in std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
        D_OUT               : out std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
        IDMA_LOCK           : out std_logic;
        IDMA_ADDR           : in std_logic_vector(IDMA_ADDR_WIDTH-1 downto 0);
        nIACK               : in std_logic;
        IDMA_BUS_DEBUG      : in std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
    --other
        set_evnt            : out std_logic;
        set_req             : out std_logic;
        reset_sim           : out std_logic
    );
end ipbus_dsp_slave;

architecture rtl of ipbus_dsp_slave is

signal IDMA_CTRL_i : std_logic_vector(3 downto 0);
signal IDMA_LOCK_i  : std_logic;


alias reg_address                    : std_logic_vector(3 downto 0) is ipbus_in.ipb_addr(3 downto 0);
  constant IDMA_DATA                : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(0, 4));
  constant IDMA_CNTRL               : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(1, 4));
  constant IACK                : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(2, 4));
  constant LOCK                : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(3, 4));
  constant ADDR                : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(4, 4));
  constant IDMA_BUS                : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(5, 4));
  constant RESET_C                : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(6, 4));
  constant SET_EVNTC                : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(7, 4));
  constant SET_REQC                : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(8, 4));

begin
    IDMA_CTRL<=IDMA_CTRL_i;
    IDMA_LOCK<=IDMA_LOCK_i;
    
    ipbus_write : process (clk) is
    begin  -- process ipbus_manager
        if rising_edge(clk) then            -- rising clock edge
            set_evnt<='0';
            set_req<='0';
            if reset = '1' then               -- synchronous reset (active high)
                IDMA_CTRL_i<=(others=>'1');
                D_OUT<=(others=>'0');
                IDMA_LOCK_i<='0';
            elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
                case reg_address is
                    when LOCK=>
                        IDMA_LOCK_i<= ipbus_in.ipb_wdata(0);
                    when IDMA_CNTRL =>
                        IDMA_CTRL_i<=ipbus_in.ipb_wdata(3 downto 0);
                    when IDMA_DATA =>
                        D_OUT<=ipbus_in.ipb_wdata(IDMA_DATA_WIDTH-1 downto 0);
                    when RESET_C =>
                        reset_sim<=ipbus_in.ipb_wdata(0);
                    when SET_EVNTC =>
                        set_evnt<='1';
                    when SET_REQC =>
                        set_req<='1';
                    when others => null;
                end case;
            end if;
        end if;
    end process ipbus_write;

    
  ipbus_read : process (IDMA_CTRL_i,D_IN,IDMA_LOCK_i,nIACK) is
  begin  -- process ipbus_read
        ipbus_out.ipb_rdata<= (others =>'0');
        case reg_address is
            when LOCK =>
                ipbus_out.ipb_rdata(0) <= IDMA_LOCK_i;
                --ipbus_out.ipb_rdata(31 downto 1) <= (others =>'0');
            when IDMA_CNTRL =>
                ipbus_out.ipb_rdata(3 downto 0) <= IDMA_CTRL_i;
               -- ipbus_out.ipb_rdata(31 downto 4) <= (others =>'0');
            when ADDR =>
                ipbus_out.ipb_rdata(IDMA_ADDR_WIDTH-1 downto 0) <= IDMA_ADDR;
            when IDMA_DATA =>
                ipbus_out.ipb_rdata(IDMA_DATA_WIDTH-1 downto 0) <= D_IN;
               -- ipbus_out.ipb_rdata(31 downto IDMA_DATA_WIDTH) <= (others =>'0');
            when IDMA_BUS =>
                ipbus_out.ipb_rdata(IDMA_DATA_WIDTH-1 downto 0) <= IDMA_BUS_DEBUG;
            when IACK =>
                ipbus_out.ipb_rdata(0) <= nIACK;
               -- ipbus_out.ipb_rdata(31 downto 1) <= (others =>'0');
            when others => null;
        end case;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

end architecture rtl;
