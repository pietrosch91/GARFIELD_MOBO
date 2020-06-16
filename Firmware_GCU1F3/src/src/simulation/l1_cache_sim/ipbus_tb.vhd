-- This testbench allows users to exercise the ipbus in a purely VHDL environment
-- as opposed to using the ModelSim Foreign Language Interface (FLI).  The FLI 
-- offers a more comprehensive test enevironment, particularly for exercising 
-- the UDP/IP aspects and the concatention of ipbus requests. However, the FLI is
-- complex to setup and it is a proprietary standard of ModelSim.
--
-- The test bench is built upon the "ipbus_simulation" package that provides the 
-- read/writes procedures that would normsally be executed by a CPU. 
--
-- Greg Iles, July 2013


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

library work;
use work.ipbus.all;
use work.ipbus_trans_decl.all;
use work.ipbus_simulation.all;
use work.txtutils.all;
use work.str.all;
entity ipbus_tb is
end ipbus_tb;

architecture behave of ipbus_tb is

  -- The number of Out-Of-Band interfaces to the ipbus master (i.e. not from the Ethernet MAC)   
  constant N_OOB : natural  := 1;
  -- The number of ipbus slaves used in this example. 
  constant NSLV  : positive := 9;

  -- Base addreses of ipbus slaves.  THis is defined in package "ipbus_addr_decode"
  constant BASE_ADD_CTRL_REG  : std_logic_vector(31 downto 0) := x"00000000";
  constant BASE_ADD_REG       : std_logic_vector(31 downto 0) := x"00000002";
  constant BASE_ADD_RAM       : std_logic_vector(31 downto 0) := x"00001000";
  constant BASE_ADD_JTAG_CTRL : std_logic_vector(31 downto 0) := x"00003000";
  constant BASE_ADD_JTAG_TDI  : std_logic_vector(31 downto 0) := x"00003003";
  constant BASE_ADD_JTAG_TDO  : std_logic_vector(31 downto 0) := x"00003004";



  -----------------------------------------------------------------------------
  -- DAQ addresses
  -----------------------------------------------------------------------------
  constant BASE_ADDR_DAQ : std_logic_vector(31 downto 0) := x"00000810";


  constant CTRL_ADDR_DAQ     : std_logic_vector(31 downto 0) := x"00000811";
  constant STATUS_ADDR_DAQ   : std_logic_vector(31 downto 0) := x"00000812";
  constant OCCUPIED_ADDR_DAQ : std_logic_vector(31 downto 0) := x"00000813";


  constant L1_CACHE_HEAD_MK_GCU_ID_ADDR : std_logic_vector(31 downto 0) := X"00000830";
  constant L1_CACHE_CTRL_REG_ADDR       : std_logic_vector(31 downto 0) := X"00000831";
  constant L1_CACHE_PRE_TRIGGER_ADDR    : std_logic_vector(31 downto 0) := X"00000832";
  constant L1_CACHE_TRG_WINDOW_ADDR     : std_logic_vector(31 downto 0) := X"00000833";
  constant L1_CACHE_TRG_NUM_ADDR        : std_logic_vector(31 downto 0) := X"00000834";

  constant L1_CACHE_TIMESTAMP01_ADDR : std_logic_vector(31 downto 0) := X"00000835";
  constant L1_CACHE_TIMESTAMP23_ADDR : std_logic_vector(31 downto 0) := X"00000836";

  constant L1_CACHE_TRAILER0_ADDR : std_logic_vector(31 downto 0) := X"00000837";
  constant L1_CACHE_TRAILER1_ADDR : std_logic_vector(31 downto 0) := X"00000838";
  constant L1_CACHE_TRAILER2_ADDR : std_logic_vector(31 downto 0) := X"00000839";
  constant L1_CACHE_TRAILER3_ADDR : std_logic_vector(31 downto 0) := X"0000083A";

  constant TRIG_GEN_THRESH : std_logic_vector(31 downto 0) := X"00000840";


-------------------------------------------------------------------------------
  signal clk, rst : std_logic := '1';

  -- The ipbus interface to the ipbus master.
  -- The record type "ipb_wbus" contains elements ipb_addr, ipb_wdata, ipb_strobe, ipb_write
  -- The record type "ipb_rbus" contains elements ipb_rdata, ipb_ack, ipb_err
  signal ipb_out_m, ipbus_shim_out : ipb_wbus;
  signal ipb_in_m, ipbus_shim_in   : ipb_rbus;

  -- The following should be ignored by the user.  They simply provide a communication 
  -- path from the read/write procedures into the ibus master for ipbus transactions.
  signal oob_in  : ipbus_trans_in  := ('0', X"00000000", '0');
  signal oob_out : ipbus_trans_out := (X"000", '0', '0', X"000", X"00000000");

  -- Array of ipbus records for communication to the ipbus slaves. 
  signal ipbw : ipb_wbus_array(NSLV - 1 downto 0);
  signal ipbr : ipb_rbus_array(NSLV - 1 downto 0);

  -- A register...
  signal ctrl       : std_logic_vector(31 downto 0);
  signal clk_enable : boolean := true;

-------------------------------------------------------------------------------
-- Slaves signals
------------------------------------------------------------------------------- 

  signal wclock_period     : time                          := 8 ns;
  constant g_cs_wonly_deep : natural                       := 2;  -- configuration space number of write only registers;
  constant g_cs_ronly_deep : natural                       := 6;  -- configuration space number of read only registers;
  constant g_NSLV          : positive                      := 13;
  signal ipb_clk           : std_logic;
  signal ipb_rst           : std_logic;
  signal ipb_in            : ipb_wbus;
  signal ipb_out           : ipb_rbus;
  signal rst_out           : std_logic;
  signal eth_err_ctrl      : std_logic_vector(35 downto 0);
  signal eth_err_stat      : std_logic_vector(47 downto 0) := X"000000000000";
  signal cs_data_o         : std_logic_vector(g_cs_wonly_deep*32-1 downto 0);
  signal cs_data_i         : std_logic_vector(g_cs_ronly_deep*32-1 downto 0);
  signal pkt_rx            : std_logic                     := '0';
  signal pkt_tx            : std_logic                     := '0';
  signal Full_out          : std_logic;
  signal Data_in           : std_logic_vector(127 downto 0);
  signal WriteEn_in        : std_logic;
  signal WClk              : std_logic                     := '0';
  signal config_dout_valid : std_logic;
  signal config_dout_addr  : std_logic_vector(31 downto 0);
  signal config_dout_data  : std_logic_vector(31 downto 0);
  signal tdc_cs_o          : std_logic;
  signal tdc_sclk_o        : std_logic;
  signal tdc_mosi_o        : std_logic;
  signal tdc_miso_i        : std_logic;
  signal i2c_scl_o         : std_logic;
  signal i2c_sda_i         : std_logic;
  signal i2c_sda_o         : std_logic;
  signal backpressure_o    : std_logic;
  signal uart_rx_i         : std_logic;
  signal uart_tx_o         : std_logic;
  signal tx_en_o           : std_logic;

  signal Trig_time        : std_logic_vector(47 downto 0) := (others => '0');
  signal abs_time         : std_logic_vector(47 downto 0) := (others => '0');
  signal Validated_trig_s : std_logic                     := '0';
begin


  wclk <= not wclk after wclock_period / 2 when clk_enable = true else
          '0';
  clk <= not clk after 16 ns when clk_enable = true else
         '0';
  absolute_time : process(clk)
  begin  -- process absolute_time
    if clk_enable = true then
      abs_time <= std_logic_vector(unsigned(abs_time) + 1);
    end if;
  end process absolute_time;
  -----------------------------------------------------------------------
  -- Stage 1: CPU Simulator 
  --
  -- The following mimics a CPU executing a series of writes & reads.
  -- At present it just verifies that the following procedures behave 
  -- as expected.  The user should replace these reads & writes with 
  -- whatever they wish to test.
  --
  -- ipbus_write & ipbus_read
  -- ipbus_block_write & ipbus_block_read
  -- ipbus_read_modify_write
  ----------------------------------------------------------------------- 

  cpu : process
    constant BUF_LEN              : integer                                := 255;
    variable rdata, wdata         : std_logic_vector(31 downto 0)          := x"00000000";
    variable rdata_buf, wdata_buf : type_ipbus_buffer(BUF_LEN -1 downto 0) := (others => x"00000000");
    variable mask                 : std_logic_vector(31 downto 0)          := x"00000000";
    variable l                    : line;
  begin

    -- Wait for 1ns to get rid of all those pesky warnings at startup
    wait for 100 ns;

    report
      " " & CR & LF &
      "----------------------------------------------------------------" & CR & LF &
      "Starting Simulation " & CR & LF &
      "----------------------------------------------------------------" & CR & LF &
      " ";

    wait for 1 ns;
    rst   <= '0';
    report "### Exiting reset" & CR & LF;
    -- Allow end of reset to propagate
    wait for 3 us;
    ----------------------------------------------------------------------------
    --  IPBUS readout simulation cycle
    ---------------------------------------------------------------------------- 
    wdata := x"ABCDEF01";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_HEAD_MK_GCU_ID_ADDR, wdata);

    wdata := x"00000014";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_TRG_NUM_ADDR, wdata);

    wdata := x"ABABABAB";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_TIMESTAMP01_ADDR, wdata);

    wdata := x"DCDCDCDC";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_TIMESTAMP23_ADDR, wdata);

    wdata := x"01234567";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_TRAILER0_ADDR, wdata);

    wdata := x"DEADBEEF";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_TRAILER1_ADDR, wdata);

    wdata := x"A5A5A5A5";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_TRAILER2_ADDR, wdata);

    wdata := x"FEA5BADE";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_TRAILER3_ADDR, wdata);

    wdata := x"0000007F";
    ipbus_write(clk, oob_in, oob_out, L1_CACHE_TRG_WINDOW_ADDR, wdata);

    wdata := x"A5A5A5A5";
    ipbus_write(clk, oob_in, oob_out, TRIG_GEN_THRESH, wdata);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_HEAD_MK_GCU_ID_ADDR, rdata);
    write (l, string'("L1_CACHE_HEAD_MK_GCU_ID_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_TRG_NUM_ADDR, rdata);
    write (l, string'("L1_CACHE_TRG_NUM_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_TIMESTAMP01_ADDR, rdata);
    write (l, string'("L1_CACHE_TIMESTAMP01_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_TIMESTAMP23_ADDR, rdata);
    write (l, string'("L1_CACHE_TIMESTAMP23_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_TRAILER0_ADDR, rdata);
    write (l, string'("L1_CACHE_TRAILER0_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_TRAILER1_ADDR, rdata);
    write (l, string'("L1_CACHE_TRAILER1_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_TRAILER2_ADDR, rdata);
    write (l, string'("L1_CACHE_TRAILER2_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_TRAILER3_ADDR, rdata);
    write (l, string'("L1_CACHE_TRAILER3_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, L1_CACHE_TRG_WINDOW_ADDR, rdata);
    write (l, string'("L1_CACHE_TRG_WINDOW_ADDR:"));
    write(l, hstr(rdata));
    writeline (output, l);

    ipbus_read(clk, oob_in, oob_out, TRIG_GEN_THRESH, rdata);
    write (l, string'("TRIG_GEN_THRESH:"));
    write(l, hstr(rdata));
    writeline (output, l);

    for i in 0 to 30 loop
      wait for 20 us;
      wait until rising_edge(WClk);
      Validated_trig_s <= '1';
      Trig_time        <= X"000000000000";
      wait until rising_edge(WClk);
      Validated_trig_s <= '0';
    end loop;  -- i

    for i in 0 to 10 loop
      -- Acquire FIFO Lock

      wdata := x"00000001";
      ipbus_write(clk, oob_in, oob_out, CTRL_ADDR_DAQ, wdata);
      -- Block Read

      ipbus_read(clk, oob_in, oob_out, OCCUPIED_ADDR_DAQ, rdata);
      write (l, string'("FiFO Occupation::"));
      write(l, hstr(rdata));
      writeline (output, l);

      ipbus_block_read(clk, oob_in, oob_out, BASE_ADDR_DAQ, rdata_buf, false);
      for i in 0 to rdata_buf'left loop
        write (l, string'("Data::"));
        write(l, hstr(rdata_buf(i)));
        writeline (output, l);
      end loop;
      -- Read fifo count valid data

      ipbus_read(clk, oob_in, oob_out, STATUS_ADDR_DAQ, rdata);
      write (l, string'("FiFO Count::"));
      write(l, hstr(rdata(rdata'left downto 2)));
      writeline (output, l);
      -- Release FIFO Lock

      wdata := x"00000000";
      ipbus_write(clk, oob_in, oob_out, CTRL_ADDR_DAQ, wdata);
      wait for 2 us;
    end loop;  -- i


    report
      " " & CR & LF &
      "----------------------------------------------------------------" & CR & LF &
      "Ending Simulation" & CR & LF &
      "----------------------------------------------------------------" & CR & LF &
      " ";

    -- Following stops modelsim restarting....
    clk_enable <= false;
    wait;
  end process;


  -----------------------------------------------------------------------
  -- Stage 2: The ipbus master.  
  --
  -- The bus master processes the ipbus requests generated in the 
  -- read/write procedures and passed into the master via "oob_in".  
  -- The ipbus read/write cycles take place on the bus and the result 
  -- is returned via "oob_out".  The user should not touch "oob_in" or
  -- "oob_out" - they are just the communication channel from the 
  -- read/write procedures to the ipbus bus master.
  -----------------------------------------------------------------------


  -- MAC input must have clock, even if usused, to avoid undefined signals (reset clocked).
  ipbus : entity work.ipbus_ctrl
    generic map(
      N_OOB => N_OOB)
    port map(
      mac_clk      => clk,
      rst_macclk   => '1',
      ipb_clk      => clk,
      rst_ipb      => rst,
      mac_rx_data  => x"00",
      mac_rx_valid => '0',
      mac_rx_last  => '0',
      mac_rx_error => '0',
      mac_tx_data  => open,
      mac_tx_valid => open,
      mac_tx_last  => open,
      mac_tx_error => open,
      mac_tx_ready => '0',
      ipb_out      => ipb_out_m,
      ipb_in       => ipb_in_m,
      mac_addr     => x"000000000000",
      ip_addr      => x"00000000",
      pkt_rx_led   => open,
      pkt_tx_led   => open,
      oob_in(0)    => oob_in,
      oob_out(0)   => oob_out);

  -----------------------------------------------------------------------
  -- Stage 2a: IPbus shim 
  --
  -- Splits back to back transactions apart (i.e. strobe will go low between transactions)
  -- Waits for acknowledge to go low before starting another transaction
  -- Will slow bus down, which can be compensated with a faster bus if req.
  -----------------------------------------------------------------------
  -- data_gen_1 : entity work.data_gen

  --   port map (
  --     clk          => wclk,
  --     rst          => rst,
  --     Data_out     => Data_in,
  --     write_en_out => WriteEn_in);

  erlang_1 : entity work.erlang
    port map (
      clk      => wclk,
      data_out => Data_in,
      clk_out  => open);

  WriteEn_in <= '1';

  shim : entity work.ipbus_shim
    generic map(
      enable => false)
    port map(
      clk            => clk,
      reset          => rst,
      ipbus_in       => ipb_out_m,
      ipbus_out      => ipb_in_m,
      ipbus_shim_out => ipbus_shim_out,
      ipbus_shim_in  => ipbus_shim_in);

  slaves_1 : entity work.slaves
    generic map (
      g_cs_wonly_deep => g_cs_wonly_deep,  -- configuration space number of write only registers;
      g_cs_ronly_deep => g_cs_ronly_deep,  -- configuration space number of read only registers;
      g_NSLV          => g_NSLV)
    port map (
      ipb_clk           => clk,
      ipb_rst           => rst,
      ipb_in            => ipbus_shim_out,
      ipb_out           => ipbus_shim_in,
      rst_out           => rst_out,
      eth_err_ctrl      => eth_err_ctrl,
      eth_err_stat      => eth_err_stat,
      cs_data_o         => cs_data_o,
      cs_data_i         => cs_data_i,
      pkt_rx            => pkt_rx,
      pkt_tx            => pkt_tx,
      -------------------------------------------------------------------------
      --  DAQ ports
      -------------------------------------------------------------------------
      Full_out          => Full_out,
      Data_in           => Data_in,
      WriteEn_in        => WriteEn_in,
      WClk              => WClk,
      backpressure_o    => backpressure_o,
      Trig_time         => Trig_time,
      abs_time          => Abs_time,
      Validated_trig_i  => Validated_trig_s,
      trig_req          => open,
      -------------------------------------------------------------------------
      config_dout_valid => config_dout_valid,
      config_dout_addr  => config_dout_addr,
      config_dout_data  => config_dout_data,
      tdc_cs_o          => tdc_cs_o,
      tdc_sclk_o        => tdc_sclk_o,
      tdc_mosi_o        => tdc_mosi_o,
      tdc_miso_i        => tdc_miso_i,
      i2c_scl_o         => i2c_scl_o,
      i2c_sda_i         => i2c_sda_i,
      i2c_sda_o         => i2c_sda_o,
      uart_rx_i         => uart_rx_i,
      uart_tx_o         => uart_tx_o,
      tx_en_o           => tx_en_o);

end behave;
