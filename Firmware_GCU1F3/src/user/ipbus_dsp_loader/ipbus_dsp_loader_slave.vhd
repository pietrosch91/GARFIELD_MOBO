


--SIMULATION OF ADSP-2181 IDMA MEMORY ACCESS 







library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;
   
    
    
entity ipbus_dsp_loader_slave is
    generic(
        EEPROM_DATA_WIDTH : positive :=8;
        EEPROM_ADDR_WIDTH : positive :=7        
    );
    port (
    -- ip bus interface
        clk                 : in  std_logic;
        reset               : in  std_logic;
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
    --idma interface
        D_IN                : in std_logic_vector(EEPROM_DATA_WIDTH-1 downto 0);
        D_OUT               : out std_logic_vector(EEPROM_DATA_WIDTH-1 downto 0);
        fifo_reset			: out std_logic;
        fifo_RD_str			: out std_logic;
        fifo_WR_str			: out std_logic;
        nDATA				: in std_logic_Vector(EEPROM_ADDR_WIDTH downto 0)
    );
end ipbus_dsp_loader_slave;

architecture rtl of ipbus_dsp_loader_slave is

signal fres_i: std_logic;


alias reg_address                    : std_logic_vector(1 downto 0) is ipbus_in.ipb_addr(1 downto 0);
  constant fifo_rst                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(0, 2));
  constant fifo_WR               : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(1, 2));
  constant fifo_RD                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(2, 2));
  constant fifo_ndata                : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(3, 2));
  
  signal wr_enable: std_logic;
  signal rd_enable: std_logic;
  
  signal wr_str_i: std_logic;
  signal rd_str_i: std_logic;
  
begin
	fifo_reset<=fres_i;
	D_OUT<=ipbus_in.ipb_wdata(EEPROM_DATA_WIDTH-1 downto 0);
	
	--FIFO WRITE
	process (reset) is
	begin --gestione write-enable
        if reset='1' or ipbus_in.ipb_strobe='0' or ipbus_in.ipb_write='0' then
            wr_enable<='0';
        elsif falling_edge(clk) then
            wr_enable<='1';
        end if;
    end process;
    
    process (reset) is 
    begin --gestione write-strobe
        if reset='1' then
            wr_str_i<='0';
        else
            if reg_address=fifo_WR and ipbus_in.ipb_strobe='1' and ipbus_in.ipb_write='1' then
                wr_str_i<=not clk;
            else
                wr_str_i<='0';
            end if;
        end if;
    end process;
    
    fifo_WR_str<=wr_str_i and WR_enable;
    
	--FIFO READ
	process (reset) is
	begin --gestione write-enable
        if reset='1' or ipbus_in.ipb_strobe='0' or ipbus_in.ipb_write='1' then
            rd_enable<='0';
        elsif falling_edge(clk) then
            rd_enable<='1';
        end if;
    end process;
    
    process (reset) is
    begin --gestione write-strobe
        if reset='1' then
            rd_str_i<='0';
        else
            if reg_address=fifo_RD and ipbus_in.ipb_strobe='1' and ipbus_in.ipb_write='0' then
                rd_str_i<=not clk;
            else
                rd_str_i<='0';
            end if;
        end if;
    end process;
    
    fifo_RD_str<=rd_str_i and RD_enable;

	
   
    ipbus_write : process (clk) is
    begin  -- process ipbus_manager
        if rising_edge(clk) then            -- rising clock edge
            if reset = '1' then               -- synchronous reset (active high)
                fres_i<='0';
            elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
                case reg_address is
                    when fifo_rst =>
                        fres_i<=ipbus_in.ipb_wdata(0);
                    when others => null;
                end case;
            end if;
        end if;
    end process ipbus_write;

    
  ipbus_read : process (reg_address) is
  begin  -- process ipbus_read
        ipbus_out.ipb_rdata<= (others =>'0');
        case reg_address is
            when fifo_RD =>
                ipbus_out.ipb_rdata(EEPROM_DATA_WIDTH-1 downto 0) <= D_IN;
                --ipbus_out.ipb_rdata(31 downto 1) <= (others =>'0');
            when fifo_rst =>
                ipbus_out.ipb_rdata(0) <= fres_i;
               -- ipbus_out.ipb_rdata(31 downto 4) <= (others =>'0');     
			when fifo_ndata =>
                ipbus_out.ipb_rdata(EEPROM_ADDR_WIDTH downto 0) <= nDATA;
            when others => null;
        end case;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

end architecture rtl;
