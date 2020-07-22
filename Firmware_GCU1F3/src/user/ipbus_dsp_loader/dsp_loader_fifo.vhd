--SIMULATION OF ADSP-2181 IDMA MEMORY ACCESS 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity EEPROM_FIFO is
    generic(
        EEPROM_ADDR_WIDTH: positive :=7;
        EEPROM_DATA_WIDTH : positive :=8
    );
    port(        
        nreset: in std_logic;
        D_IN: in std_logic_vector(EEPROM_DATA_WIDTH-1 downto 0);
        D_OUT: out std_logic_vector(EEPROM_DATA_WIDTH-1 downto 0);
        RD_str :in std_logic;
        WR_str :in std_logic;
        nDATA : out std_logic_vector(EEPROM_ADDR_WIDTH downto 0)
    );
end EEPROM_FIFO;



architecture rtl of EEPROM_FIFO is
	type fifo_mem is array(2 ** EEPROM_ADDR_WIDTH - 1 downto 0) of std_logic_vector(EEPROM_DATA_WIDTH - 1 downto 0);
	
    signal rd_address: unsigned(EEPROM_ADDR_WIDTH downto 0);
    signal wr_address: unsigned(EEPROM_ADDR_WIDTH downto 0);
    signal wr_int: integer range 0 to 2 ** EEPROM_ADDR_WIDTH - 1 := 0;
    signal rd_int: integer range 0 to 2 ** EEPROM_ADDR_WIDTH - 1 := 0;
    
    shared variable thefifo: fifo_mem;
    
    
begin
    wr_int<=to_integer(wr_address(EEPROM_ADDR_WIDTH-1 downto 0));
    rd_int<=to_integer(rd_address(EEPROM_ADDR_WIDTH-1 downto 0));
	
	D_OUT<=thefifo(rd_int);
	
	--read process
	process (rd_address,RD_Str,nreset)
	begin
		if(nreset='0') then
			rd_address<=(others=>'0');
		elsif RD_Str'event and RD_Str='0' then --read request
			--D_OUT<=thefifo(integer(rd_address(EEPROM_ADDR_WIDTH-1 downto 0)));
			rd_address<=rd_address+to_unsigned(1,EEPROM_ADDR_WIDTH+1);
		end if;
	end process;
	
	--write
	process (wr_address,WR_Str,nreset,D_IN)
	begin
		if(nreset='0') then
			wr_address<=(others=>'0');
		elsif WR_Str'event and WR_Str='0' then --write request
			thefifo(wr_int):=D_IN;
			wr_address<=wr_address+to_unsigned(1,EEPROM_ADDR_WIDTH+1);
		end if;
	end process;
			
	--nDATA
	process (wr_address,rd_address)
	begin
		if(wr_address(EEPROM_ADDR_WIDTH-1 downto 0)=rd_address(EEPROM_ADDR_WIDTH-1 downto 0)) then
			if(wr_address(EEPROM_ADDR_WIDTH)=rd_address(EEPROM_ADDR_WIDTH)) then --empty
				nData<=(others=>'0');
			else
				nData(EEPROM_ADDR_WIDTH)<='1';
				nData(EEPROM_ADDR_WIDTH-1 downto 0)<=(others=>'0');
			end if;
		else
			nData(EEPROM_ADDR_WIDTH)<='0';
			nDATA(EEPROM_ADDR_WIDTH-1 downto 0)<=std_logic_vector(wr_address(EEPROM_ADDR_WIDTH-1 downto 0)-rd_address(EEPROM_ADDR_WIDTH-1 downto 0));		
		end if;
	end process;
end architecture RTL;
    
    
    
 
