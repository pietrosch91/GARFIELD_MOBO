----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2020 02:13:58 PM
-- Design Name: 
-- Module Name: FIFO_control - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- use work.ipbus.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FIFO_control is
    Port ( clk : in STD_LOGIC;
           nReset : in STD_LOGIC;
           fifo_rd  : in STD_LOGIC;
           fifo_wr_en  : in STD_LOGIC;
           rd_fifo_clk  : in STD_LOGIC;
           wr_fifo_clk  : in STD_LOGIC;
           fifo_data_in : in STD_LOGIC_VECTOR (31 downto 0);
           fifo_data_out : out STD_LOGIC_VECTOR (31 downto 0)
           );           
end FIFO_control;

architecture Behavioral of FIFO_control is



COMPONENT global_fifo
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END COMPONENT;



signal fifo_rst : std_logic;
signal fifo_full : std_logic;
signal fifo_rst_cnt : integer;


begin



global_fifo_inst : global_fifo
  PORT MAP (
    rd_clk => rd_fifo_clk,
    wr_clk => wr_fifo_clk,
    rst => fifo_rst,
    din => fifo_data_in,
    wr_en => fifo_wr_en ,
    rd_en => fifo_rd,
    dout => fifo_data_out,
    full => fifo_full,
    empty => open
  );
  

    

fifo_rst_prcs: process(clk,nReset)
begin

if nReset = '0' then

    fifo_rst        <= '0';
    fifo_rst_cnt    <= 0;

elsif clk'event and clk = '1' then

    if fifo_rst_cnt = 5 then
        fifo_rst        <= '0';
    else 
        fifo_rst        <= '1';
        fifo_rst_cnt    <= fifo_rst_cnt + 1; 
    end if;
end if;

end process fifo_rst_prcs;



end Behavioral;
