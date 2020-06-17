


--SIMULATION OF ADSP-2181 IDMA MEMORY ACCESS 







library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity dsp_simulator is
    generic(
        IDMA_ADDR_WIDTH : positive;
        IDMA_DATA_WIDTH : positive :=16
    );
    port(
        dsp_rst             : in  std_logic;
        dsp_clk             : in  std_logic;
        -- ip bus interface
        ipb_clk             : in std_logic;
        ipb_rst             : in  std_logic;        
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
        --bus dir
        bus_ctrl            :out std_logic;
        --external interface
        nIACK: out std_logic;
        nWR: in std_logic;
        nRD: in std_logic;
        nIAL: in std_logic;
        nIS: in std_logic;
        IAD: inout std_logic_vector(IDMA_DATA_WIDTH-1 downto 0)
    );
end dsp_simulator;

architecture rtl of dsp_simulator is
    --bus control and internal bus
    signal addr_ii:std_logic_vector(IDMA_ADDR_WIDTH-1 downto 0);
    signal DIN_EXT:std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
    
    signal DOUT_DSP:std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
    signal DSP_busctrl:std_logic;
    
    --device locking
    signal dev_lock:std_logic;
    
    signal CTRL_IP:std_logic_vector(3 downto 0);
    signal CTRL_EXT:std_logic_vector(3 downto 0);
    signal CTRL:std_logic_vector(3 downto 0);
    
    signal DIN_IP:std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
    signal DIN:std_logic_vector(IDMA_DATA_WIDTH-1 downto 0);
    
    --dsp
    signal nIACK_i: std_logic;
    
    signal dsp_res : std_logic;
    
begin
    bus_ctrl<=DSP_busctrl;
    --IPBUS ALLOCATION
    ipbus_slave_1 : entity work.ipbus_dsp_slave
    generic map (
        IDMA_ADDR_WIDTH => IDMA_ADDR_WIDTH,
        IDMA_DATA_WIDTH => IDMA_DATA_WIDTH)
    port map (
        clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbus_in,
        ipbus_out           => ipbus_out,
    --idma interface
        IDMA_CTRL           =>CTRL_IP,
        D_IN                =>DOUT_DSP,
        D_OUT               =>DIN_IP,
        IDMA_LOCK           =>dev_lock,
        IDMA_ADDR           =>addr_ii,
        nIACK               =>nIACK_i,
        IDMA_BUS_DEBUG      =>IAD,
        reset_sim           =>dsp_res
    );      
    
    --IAD bus direction
    IAD_control: process
    begin
        if(nRD='1') then
            DIN_EXT<=IAD;
            IAD<=(others=>'Z');
        else
            DIN_EXT<=(others=>'0');
            IAD<=DOUT_DSP;
        end if;
    end process IAD_control;
        
    --Device Locking
    CTRL_EXT(0)<=nWR;
    CTRL_EXT(1)<=nRD;
    CTRL_EXT(2)<=nIAL;
    CTRL_EXT(3)<=nIS;
    
    Dev_Lock_p: process
    begin
        if(dev_lock='1') then 
            --ipbus is master
            DIN<=DIN_IP;
            CTRL<=CTRL_IP;
        else
            DIN<=DIN_EXT;
            CTRL<=CTRL_EXT;
        end if;
    end process Dev_Lock_p;
    
    --DSP_IDMA ALLOCATION
    idma_sim: entity work.IDMA_mem
    generic map (
        IDMA_ADDR_WIDTH => IDMA_ADDR_WIDTH,
        IDMA_DATA_WIDTH => IDMA_DATA_WIDTH)
    port map(
        clk =>dsp_clk,
        reset => dsp_res,
        D_IN =>DIN,
        D_OUT=>DOUT_DSP,
        nIACK=>nIACK_i,
        nWR=>CTRL(0),
        nRD=>CTRL(1),
        nIAL=>CTRL(2),
        nIS=>CTRL(3),
        ADDR_OUT=>addr_ii,
        bus_ctr=> DSP_busctrl
    );
end architecture rtl;
    
    
