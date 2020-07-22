






library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity merge_top is
    port(
        -- ip bus interface
        ipb_clk             : in std_logic;
        ipb_rst             : in  std_logic;        
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus
        
    );
end merge_top;





architecture rtl of merge_top is

signal fifo_data_in : std_logic_vector(31 downto 0);
signal fifo_data_out : std_logic_vector(31 downto 0);
signal fifo_rd : std_logic;
signal fifo_rd_ipbus : std_logic;
signal fifo_wr_ipbus : std_logic;



begin


      --IPBUS ALLOCATION
    ipbus_slave_1 : entity work.ipbus_data_merge_slave
       port map (
        clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbus_in,
        ipbus_out           => ipbus_out,
        FIFO_DATA_wr        => fifo_data_in,
        FIFO_DATA_rd        => fifo_data_out,
        fifo_rd             => fifo_rd_IPBUS,
        fifo_wr             => fifo_wr_IPBUS
    );      
    
    
    
    fifo_cntrl : entity work.fifo_control
        port map (
            clk => ipb_clk,
           nReset => not ipb_rst,
           fifo_rd => fifo_rd_IPBUS,
           fifo_wr_en => fifo_wr_IPBUS,
           rd_fifo_clk=>ipb_clk,
           wr_fifo_clk=>ipb_clk,
           fifo_data_in => fifo_data_in,  
           fifo_data_out => fifo_data_out
           );

end architecture rtl;
