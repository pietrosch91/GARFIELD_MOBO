






library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity dsp_loader is
	generic(
        EEPROM_ADDR_WIDTH: positive :=7;
        EEPROM_DATA_WIDTH : positive :=8
    );
    port(
        -- ip bus interface
        ipb_clk             : in std_logic;
        ipb_rst             : in  std_logic;        
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus
       
    );
end dsp_loader;





architecture rtl of dsp_loader is


signal DataIn:std_logic_vector(EEPROM_DATA_WIDTH-1 downto 0);
signal DataOut:std_logic_vector(EEPROM_DATA_WIDTH-1 downto 0);
signal f_res:std_logic;
signal f_rd:std_logic;
signal f_wr:std_logic;
signal f_nd:std_logic_vector(EEPROM_ADDR_WIDTH downto 0);



begin
     --IPBUS ALLOCATION
    ipbus_slave_1 : entity work.ipbus_dsp_loader_slave
		generic map(
			EEPROM_DATA_WIDTH=>EEPROM_DATA_WIDTH,
			EEPROM_ADDR_WIDTH=>EEPROM_ADDR_WIDTH
		)
       port map (
        clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbus_in,
        ipbus_out           => ipbus_out,
        D_IN                =>DataOut,
        D_OUT               =>DataIn,
        fifo_reset			=>f_res,
        fifo_RD_str			=>f_rd,
        fifo_WR_str			=>f_wr,
        nDATA				=>f_nd        
    );      
    
    
    loader_fifo : entity work.EEPROM_fifo
		generic map(
			EEPROM_ADDR_WIDTH=>EEPROM_ADDR_WIDTH,
			EEPROM_DATA_WIDTH=>EEPROM_DATA_WIDTH
		)
        port map (
			nreset => not f_res,
			D_IN=>DataIn,
			D_OUT=>DataOut,
			RD_str=>f_rd,
			WR_str=>f_wr,
			nDATA =>f_nd
		);
end architecture rtl;
