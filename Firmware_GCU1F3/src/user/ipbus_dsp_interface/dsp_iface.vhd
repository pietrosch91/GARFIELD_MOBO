






library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity dsp_interface is
    port(
        -- ip bus interface
        ipb_clk             : in std_logic;
        ipb_rst             : in  std_logic;        
        ipbus_in            : in  ipb_wbus;
        ipbus_out           : out ipb_rbus;
        --external interface
        nIACK: in std_logic;
        nWR: out std_logic;
        nRD: out std_logic;
        nIAL: out std_logic;
        nIS: out std_logic;
        IAD: inout std_logic_vector(15 downto 0);
        bus_ctrl : in std_logic
    );
end dsp_interface;





architecture rtl of dsp_interface is

signal Data_To_DSP : std_logic_vector(15 downto 0);
signal Data_From_DSP : std_logic_vector(15 downto 0);
signal opcode_in : std_logic_vector(3 downto 0);
signal cmd_val : std_logic;

signal dsp_busy_in :std_logic;
signal res_dsp:std_logic;






begin
     --IPBUS ALLOCATION
    ipbus_slave_1 : entity work.ipbus_dsp_iface_slave
       port map (
        clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbus_in,
        ipbus_out           => ipbus_out,
        --CtrlReg
        data_out            =>Data_to_dsp,
        op_code             =>opcode_in,
        op_valid            =>cmd_val,
        xfer_len            =>open,
        --Options
        iack_resync         =>open,
        --Status
        DSP_busy            =>dsp_busy_in,
        DSP_dataready       =>'0',
        --Data
        DSP_DATA            =>Data_From_DSP,
        rest_out            =>res_dsp
    );      
    
    
    dsp_cntrl : entity work.DSP_control
        port map (
            clk => ipb_clk,
           nReset => not res_dsp,
           op_code =>opcode_in,
           cmd_valid =>cmd_val,
           DSP_AD_bus =>Data_to_dsp,
           xfer_length =>(others=>'0'),
           IAD =>IAD,
           DSP_busctr=>bus_ctrl,
           nIACK =>nIACK,
           CLR =>open,
           nIS =>nIS,
           nIRD =>nRD,
           niWR =>nWR,
           nIAL =>nIAL,
           nSPE =>open,
           nBOOT =>open,
           nEND =>open,
           busy =>dsp_busy_in,
           DSP_data_out =>Data_From_DSP);
end architecture rtl;
