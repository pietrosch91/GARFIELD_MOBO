






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
        
        --external controls from dsp_readout
        EVENT_READY: in std_logic;
        EXT_TRIGGER: in std_logic;
        EXT_VALID: in std_logic;
        READOUT_LOCK: in std_logic;
        READOUT_CMD_VALID:in std_logic;
        TRANSFER_LOCK: in std_logic;
        FIFO_RDEN: in std_logic;
        FIFO_RDCLK: in std_logic;
        
        
        
        --external interface to dsp
        nIACK: in std_logic;
        nWR: out std_logic;
        nRD: out std_logic;
        nIAL: out std_logic;
        nIS: out std_logic;
        IAD_to_DSP: out std_logic_vector(15 downto 0);
        IAD_from_DSP: in std_logic_vector(15 downto 0);
        CLR: out std_logic;
        EVNT: in std_logic;
        REQ: in std_logic;   
        DSP_VALID: out std_Logic;
        DSP_TRIG: out std_Logic;
        bus_ctrl : in std_logic;
        
        --FEEDBACK SIGNALS TO READOUT LOGIC
        DSP_DATAREADY: out std_logic;
        DSP_BUSY: out std_logic;
        DSP_FIFODATA: out std_logic_vector(15 downto 0)
    );
end dsp_interface;





architecture rtl of dsp_interface is

signal Data_To_DSP : std_logic_vector(15 downto 0);
signal Data_From_DSP : std_logic_vector(15 downto 0);
signal opcode_ipbus : std_logic_vector(3 downto 0);
signal opcode_in : std_logic_vector(3 downto 0);
signal cmd_val_ipbus : std_logic;
signal cmd_val : std_logic;

signal dsp_busy_in :std_logic;
signal res_dsp:std_logic;
signal xfer_length: std_logic_vector(7 downto 0);
signal DSP_fifo_data : std_logic_vector(15 downto 0);

signal fifo_rd : std_logic;
signal fifo_rd_ipbus : std_logic;

signal fifo_clk : std_logic;
--signal fifo_clk_ipbus : std_logic;



signal dready_int:std_logic;
signal eready_ipbus:std_logic;
signal eready_int:std_logic;

signal xfer_len_feedback : std_Logic_vector(7 downto 0);



begin
    DSP_VALID<=EXT_VALID;
    DSP_TRIG<=EXT_TRIGGER;
    DSP_DATAREADY<=dready_int;
    DSP_BUSY<=dsp_busy_in;
    DSP_FIFODATA<=DSP_fifo_data;
    
    --opcode control
    process(READOUT_LOCK) is
    begin
        if READOUT_LOCK='0' then
            opcode_in<=opcode_ipbus;
        else
            opcode_in<=x"9";
        end if;
    end process;
    
    --cmd_val
    process(READOUT_LOCK) is
    begin
        if READOUT_LOCK='0' then
            cmd_val<=cmd_val_ipbus;
        else
            cmd_val<=READOUT_CMD_VALID;
        end if;
    end process;
    
    --fifo signals
    process(TRANSFER_LOCK) is
    begin
        if TRANSFER_LOCK='0' then
            fifo_rd<=fifo_rd_ipbus;
            fifo_clk<=ipb_clk;
        else
            fifo_rd<=FIFO_RDEN;
            fifo_clk<=FIFO_RDCLK;
        end if;
    end process;
        
    --event_ready
    process(READOUT_LOCK) is
    begin
        if READOUT_LOCK='0' then
            eready_int<=eready_ipbus;
        else
            eready_int<=EVENT_READY;
        end if;
    end process;

     --IPBUS ALLOCATION
    ipbus_slave_1 : entity work.ipbus_dsp_iface_slave
       port map (
        clk                 => ipb_clk,
        reset               => ipb_rst,
        ipbus_in            => ipbus_in,
        ipbus_out           => ipbus_out,
        --CtrlReg
        data_out            =>Data_to_dsp,
        op_code             =>opcode_ipbus,
        op_valid            =>cmd_val_ipbus,
--        xfer_len            =>open,
        xfer_len            =>xfer_length,
        evnt_ready          =>eready_ipbus,
        --Options
        iack_resync         =>open,
        --Status
        DSP_busy            =>dsp_busy_in,
        DSP_dataready       =>dready_int,
        DSP_xfer_len        => xfer_len_feedback,
        --Data
        DSP_DATA            =>Data_From_DSP,
        DSP_FIFO_DATA       => DSP_fifo_data,
        fifo_rd             => fifo_rd_IPBUS,
        rest_out            =>res_dsp
    );      
    
    
    dsp_cntrl : entity work.DSP_control
        port map (
            clk => ipb_clk,
           nReset => not res_dsp,
           op_code =>opcode_in,
           cmd_valid =>cmd_val,
           DSP_AD_bus =>Data_to_dsp,
--           xfer_length =>(others=>'0'),
           xfer_length => xfer_length,
           IAD_to_DSP=>IAD_to_DSP,
           IAD_from_DSP=>IAD_from_DSP,
           EVNT => EVNT,
           EVNT_READY => eready_int,
           REQ => REQ,
--           DSP_busctr=>bus_ctrl,
           nIACK =>nIACK,
           CLR =>CLR,
           nIS =>nIS,
           nIRD =>nRD,
           niWR =>nWR,
           nIAL =>nIAL,
           nSPE =>open,
           nBOOT =>open,
           nEND =>open,
           DATA_READY =>dready_int,
           busy =>dsp_busy_in,
           fifo_rd => fifo_rd,
           rd_fifo_clk=>fifo_clk,
           wr_fifo_clk=>fifo_clk,
           DSP_fifo_out => DSP_fifo_data,  
           DSP_data_out =>Data_From_DSP,
           xfer_length_out=>xfer_len_feedback
        );
end architecture rtl;
