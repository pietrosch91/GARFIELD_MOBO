-------------------------------------------------------------------------------
-- Title      : GCU 1F3 top level
-- Project    :
-------------------------------------------------------------------------------
-- File       : top_gcu1f3.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    :
-- Created    : 2018-09-26
-- Last update: 2020-02-19
-- Platform   :
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: GCU 1F3 Top level
-------------------------------------------------------------------------------
-- Copyright (c) 2018
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-09-26  1.0      antonio Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

use work.utils_package.all;
use work.GCUpack.all;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

entity top_gcu1f3 is

  port (
    board_clk : in std_logic;
    rst       : in std_logic;

    rgmii_txd    : out std_logic_vector(3 downto 0);
    rgmii_tx_ctl : out std_logic;
    rgmii_txc    : out std_logic;
    rgmii_rxd    : in  std_logic_vector(3 downto 0);
    rgmii_rx_ctl : in  std_logic;
    rgmii_rxc    : in  std_logic;

--    phy_resetn : out std_logic;
    -- ADUs->DAQ selection
    DIP2 : in std_logic;
    DIP3 : in std_logic;

    -- LED0 and LED1
    led          : out std_logic;
    activity_led : out std_logic;

    -- Picoblaze UART interface
    uart_tx : out std_logic;
    uart_rx : in  std_logic;

    -- SJA1105 configuration port
    sja1105_spi_clk   : out std_logic;
    sja1105_spi_miso  : in  std_logic;
    sja1105_spi_mosi  : out std_logic;
    sja1105_spi_cs_n  : out std_logic;
    sja1105_sja_rst_n : out std_logic;

    -- DAC configuration machine
    dac_spi_ck   : out std_logic;
    dac_spi_mosi : out std_logic;

    -- dac_spi_miso  : in  std_logic;
    dac_spi_syncn : out std_logic;
    dac_ldac      : out std_logic;
    dac_clr       : out std_logic;
    dac_por       : out std_logic;

    -- front end configuration
    adc_gcl : out std_logic;
    adc_gcm : out std_logic;
    adc_gch : out std_logic;

    -- ADC pinout
    adca_dclkp : in  std_logic_vector(2 downto 0);
    adca_dclkn : in  std_logic_vector(2 downto 0);
    adca_dp    : in  T_SLVV_14(2 downto 0);
    adca_dn    : in  T_SLVV_14(2 downto 0);
    adca_syncp : in  std_logic_vector(2 downto 0);
    adca_syncn : in  std_logic_vector(2 downto 0);
    adca_scsb  : out std_logic_vector(2 downto 0);

    adcb_dclkp : in  std_logic_vector(2 downto 0);
    adcb_dclkn : in  std_logic_vector(2 downto 0);
    adcb_dp    : in  T_SLVV_14(2 downto 0);
    adcb_dn    : in  T_SLVV_14(2 downto 0);
    adcb_syncp : in  std_logic_vector(2 downto 0);
    adcb_syncn : in  std_logic_vector(2 downto 0);
    adcb_scsb  : out std_logic_vector(2 downto 0);

    -- ADC and PLL configuration
    pll_le : out std_logic_vector(2 downto 0);

    adc_spi_clk  : out std_logic_vector(2 downto 0);
    adc_spi_en   : out std_logic_vector(2 downto 0);
    adc_spi_mosi : out std_logic_vector(2 downto 0);
    adc_spi_miso : in  std_logic_vector(2 downto 0);

    cal_ctrl         : out std_logic_vector(2 downto 0);
    -- clocks @125Mhz sent to the ADUs
    ext_clk          : out std_logic_vector(2 downto 0);
    -- global external trigger
    ext_trigger      : in  std_logic;   --- removed only for debug
    --CDR
    cdr1_dataout_n_i : in  std_logic;   -- 250 Mhz recovered clock
    cdr1_dataout_p_i : in  std_logic;   -- 250 Mhz recovered clock
    cdr1_en_n_o      : out std_logic;
    cdr1_in_n_o      : out std_logic;
    cdr1_in_p_o      : out std_logic;
    cdr1_lol_i       : in  std_logic;
    clk_cdr1_n_i     : in  std_logic;
    clk_cdr1_p_i     : in  std_logic;
    -- debug clock output
    xc7k_coax_n_o    : out std_logic;
    -- synch link
    slink1_rx_n_i    : in  std_logic;
    slink1_rx_p_i    : in  std_logic;
    slink1_tx_n_o    : out std_logic;
    slink1_tx_p_o    : out std_logic
    );

end top_gcu1f3;

architecture str of top_gcu1f3 is
-------------------------------------------------------------------------------
-- configuration of subcomponents
-------------------------------------------------------------------------------

-----------------------------------------------------------------------------
  component network_interface is
    port (
      glbl_rst          : in  std_logic;
      refclk            : in  std_logic;
      ipb_gtx_pay_clk   : in  std_logic;
      gtx_clk_90        : in  std_logic;
      s_axi_aclk        : in  std_logic;
      dcm_locked        : in  std_logic;
      phy_resetn        : out std_logic;
      rgmii_txd         : out std_logic_vector(3 downto 0);
      rgmii_tx_ctl      : out std_logic;
      rgmii_txc         : out std_logic;
      rgmii_rxd         : in  std_logic_vector(3 downto 0);
      rgmii_rx_ctl      : in  std_logic;
      rgmii_rxc         : in  std_logic;
      reset_error       : in  std_logic;
      gcu_id_o          : out std_logic_vector(15 downto 0);
      ext_trigger       : in  std_logic;
      adc_raw_data      : in  T_SLVV_128(2 downto 0);
      adc_user_clk      : in  std_logic_vector(2 downto 0);
      adu_enables       : out std_logic_vector(2 downto 0);
      adu_clock_enables : out std_logic_vector(2 downto 0);
      bec_connected     : out std_logic;
      local_time        : in  std_logic_vector(47 downto 0);
      -- debug

      l1a_time       : in std_logic_vector(47 downto 0);
      l1a_time_ready : in std_logic_vector(2 downto 0);
      aligned_i      : in std_logic;

      trig_request  : out std_logic_vector(2 downto 0);
      time_to_send  : in  std_logic_vector(31 downto 0);
      dlyctrl_ready : in  std_logic;
      dlyctrl_reset : in  std_logic
      );
  end component network_interface;

  for network_interface_i : network_interface
    use entity work.network_interface(wrapper);
  signal dlyctrl_reset    : std_logic;
  signal board_clk_s      : std_logic;
  signal board_clk_s_bufg : std_logic;
  signal bec_connected    : std_logic;
  signal l1a_time         : std_logic_vector(47 downto 0);

  signal l1a_time_mcp       : T_SLVV_48(2 downto 0);
  signal l1a_time_ready_mcp : std_logic_vector(2 downto 0);

  signal l1a_time_ready             : std_logic;
  signal l1a_time_ready_shaped      : std_logic;
  signal l1a_time_ready_shaped_flop : std_logic;
  signal l1a_time_ready_flag        : std_logic;
  -----------------------------------------------------------------------------
  -- Clock signals
  -----------------------------------------------------------------------------
  signal board_locked               : std_logic;
  signal cdr_locked                 : std_logic;
  signal boardclk_o_125             : std_logic;
  signal boardclk_o_125_90          : std_logic;
  signal boardclk_o_250             : std_logic;
  signal boardclk_o_200             : std_logic;
  signal boardclk_o_100             : std_logic;
  signal cdr_clk_s_bufg             : std_logic;
  signal cdr_clk_s                  : std_logic;
  signal cdrclk_o_125               : std_logic;
  signal cdrclk_o_125_90            : std_logic;
  signal cdrclk_o_250               : std_logic;
  signal cdrclk_o_200               : std_logic;
  signal cdrclk_o_100               : std_logic;
  signal cdrclk_o_3125              : std_logic;
  signal internal_clk_wire          : std_logic;
  -----------------------------------------------------------------------------
  -- ADUs internal signals
  -----------------------------------------------------------------------------
  signal test_pulse                 : std_logic_vector(2 downto 0);
  signal init_done_out              : std_logic_vector(2 downto 0);
  -- optional configuration bus
  signal config_din_valid           : std_logic_vector(2 downto 0);
  signal config_din_addr            : T_SLVV_32(2 downto 0);
  signal config_din_data            : T_SLVV_32(2 downto 0);

  signal config_dout_valid : std_logic_vector(2 downto 0);
  signal config_dout_addr  : T_SLVV_32(2 downto 0);
  signal config_dout_data  : T_SLVV_32(2 downto 0);
  -- connected to  user logic
  signal adca_user_clk     : std_logic_vector(2 downto 0);
  signal adca_raw_data     : T_SLVV_128(2 downto 0);
  signal adcb_user_clk     : std_logic_vector(2 downto 0);
  signal adcb_raw_data     : T_SLVV_128(2 downto 0);

  signal adu_enables        : std_logic_vector(2 downto 0);
  signal adu_clock_enables  : std_logic_vector(2 downto 0);
  signal cs_control         : T_SLVV_36(2 downto 0);  -- left open
  -- dac base address
  constant CONFIG_BASE_ADDR : std_logic_vector(31 downto 0) := X"00000010";
  -- dac configuratio done
  signal dac_config_done    : std_logic;

  -- Reset generator signals
  signal internal_reset         : std_logic := '1';
  signal internal_reset_counter : integer   := 0;
  signal reset_counter_running  : std_logic := '1';
  signal dlyctrl_ready          : std_logic;
-------------------------------------------------------------------------------
-- debug logic
-------------------------------------------------------------------------------
  signal adc_spi_clk_s          : std_logic_vector(2 downto 0);
  signal adc_spi_en_s           : std_logic_vector(2 downto 0);
  signal adc_spi_mosi_s         : std_logic_vector(2 downto 0);

  signal s_led, s_activity_led : std_logic;
  signal s_clk_cdr_in          : std_logic;
  signal local_time            : std_logic_vector(47 downto 0);
  signal local_time_from_BEC   : std_logic_vector(47 downto 0);
  signal local_time_GCU        : std_logic_vector(47 downto 0);
  signal time_to_send_dbg      : std_logic_vector(31 downto 0);
  signal aligned_s             : std_logic;

  signal trig_request    : std_logic_vector(2 downto 0);
  signal trig_request_or : std_logic;
  signal debug_clk_adc   : std_logic;

  signal gcu_id : std_logic_vector(15 downto 0);

  constant cdr_clk : boolean := false;  -- gcu / bec selector


begin  -- str

-------------------------------------------------------------------------------
-- Clock Manager, Delay manager and various clocking resources
-------------------------------------------------------------------------------
  -- clk selection ( BEC / GCU)
  clock_from_cdr : if cdr_clk = true generate
    internal_clk_wire <= cdr_clk_s;
    local_time        <= std_logic_vector(shift_right(unsigned(local_time_from_BEC), 1));
  end generate clock_from_cdr;

  clock_from_gcu : if cdr_clk = false generate
    internal_clk_wire <= board_clk;
    local_time        <= local_time_GCU;
  end generate clock_from_gcu;
-------------------------------------------------------------------------------
  clk_manager_1 : entity work.clk_manager
    port map (
      board_clk      => internal_clk_wire,
      cdr_clk        => '0',
      clkin_sel      => '1',
      glbl_rst       => '0',
      locked         => cdr_locked,
      clk_out_125    => cdrclk_o_125,
      clk_out_250    => cdrclk_o_250,
      clk_out_200    => cdrclk_o_200,
      clk_out_100    => cdrclk_o_100,
      clk_out_125_90 => cdrclk_o_125_90,
      clk_out_3125   => cdrclk_o_3125
      );

  Delay_manager_inst : entity work.delay_manager
    port map(
      ref_clk           => cdrclk_o_200,
      gtx_clk           => cdrclk_o_125,
      mmcm_locked       => cdr_locked,
      dlyctrl_ready     => dlyctrl_ready,
      -- debug
      dlyctrl_reset_dbg => dlyctrl_reset
      );

-----------------------------------------------------------
-- CDR clock input section
-----------------------------------------------------------
  IBUFDS_CDR1_CLK : IBUFDS
    generic map (
      DIFF_TERM    => true,             -- Differential Termination
      IBUF_LOW_PWR => false,  -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD   => "LVDS")
    port map (
      O  => s_clk_cdr_in,               -- Buffer output
      I  => clk_cdr1_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => clk_cdr1_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

--DIVIDE cdr clock by factor 2

  BUFR_inst : BUFR
    generic map (
      BUFR_DIVIDE => "2",  -- Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
      SIM_DEVICE  => "7SERIES"          -- Must be set to "7SERIES"
     --
      )
    port map (
      O   => cdr_clk_s,                 -- 1-bit output: Clock output port
      CE  => '1',          -- 1-bit input: Active high, clock enable input
      CLR => '0',                       -- 1-bit input: ACtive high reset input
      I   => s_clk_cdr_in  -- 1-bit input: Clock buffer input driven by an IBUFG, MMCM or local
      );


  -----------------------------------------------------------------------------
  -- reset generator ( after 3 sec. from boot)
  -----------------------------------------------------------------------------
  process (cdrclk_o_125) is
  begin  -- process
    if rising_edge(cdrclk_o_125) then   -- rising clock edge
      if reset_counter_running = '1' then
        internal_reset_counter <= internal_reset_counter + 1;
      end if;
      if internal_reset_counter = 3 * 125000000 then
        internal_reset        <= '0';
        reset_counter_running <= '0';
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- local time genrator without BEC
  -----------------------------------------------------------------------------
  local_time_generator : process (internal_clk_wire) is
  begin  -- process local_time_generator
    if rising_edge(internal_clk_wire) then  -- rising clock edge
      local_time_GCU <= std_logic_vector(unsigned(local_time_GCU) + 1);
    end if;
  end process local_time_generator;

-------------------------------------------------------------------------------
-- Ethernet and IPBUS subsystem
-------------------------------------------------------------------------------
  network_interface_i : network_interface
    port map (
      glbl_rst        => (not cdr_locked) or internal_reset,  --
      refclk          => cdrclk_o_200,
      ipb_gtx_pay_clk => cdrclk_o_3125,
      gtx_clk_90      => cdrclk_o_125_90,
      s_axi_aclk      => cdrclk_o_125,
      dcm_locked      => cdr_locked,
      phy_resetn      => open,
      reset_error     => '0',
      -- RGMII interface
      rgmii_txd       => rgmii_txd,
      rgmii_tx_ctl    => rgmii_tx_ctl,
      rgmii_txc       => rgmii_txc,
      rgmii_rxd       => rgmii_rxd,
      rgmii_rx_ctl    => rgmii_rx_ctl,
      rgmii_rxc       => rgmii_rxc,

      -- Internal connectivity
      ext_trigger       => ext_trigger,
      gcu_id_o          => gcu_id,
      adc_raw_data      => adca_raw_data,
      adc_user_clk      => adca_user_clk,
      adu_enables       => adu_enables,
      adu_clock_enables => adu_clock_enables,
      bec_connected     => bec_connected,
      -- interface with synch Link
      local_time        => local_time,
      l1a_time          => std_logic_vector(unsigned (l1a_time) srl 1),
      l1a_time_ready    => l1a_time_ready_mcp,
      trig_request      => trig_request,

      time_to_send  => time_to_send_dbg,
      aligned_i     => aligned_s,
      dlyctrl_ready => dlyctrl_ready,
      dlyctrl_reset => dlyctrl_reset
      );

  -- shaping  l1a_time ready

  l1a_time_ready_MCP_b : for adu_number in 0 to 2 generate

    mcp_block_1 : entity work.mcp_block
      generic map (
        DATA_WIDTH => l1a_time'length)
      port map (
        a_clk             => cdrclk_o_250,
        a_rst             => rst,
        a_data_in         => std_logic_vector(unsigned (l1a_time) srl 1),
        a_pulse_valid_in  => l1a_time_ready,
        b_clk             => adca_user_clk(adu_number),
        b_rst             => rst,
        b_data_out        => l1a_time_mcp(adu_number),
        b_pulse_valid_out => l1a_time_ready_mcp(adu_number));

  end generate l1a_time_ready_MCP_b;
-------------------------------------- ----------------------------------------
-- synch link
-------------------------------------------------------------------------------
  trig_request_or <= trig_request(0) or trig_request(1) or trig_request(2);
  synch_link_i : entity work.top_level
    port map (
      sys_clk_250      => cdrclk_o_250,
      sys_clk_200      => cdrclk_o_200,
      sys_clk_locked   => cdr_locked,
      cdr_clk_250      => cdrclk_o_250,
      cdr_clk_locked   => cdr_locked,
      gcuid_i          => gcu_id,
      xc7k_led0_o      => open,
      xc7k_led1_o      => s_activity_led,
      --xc7k_coax_n_o    => xc7k_coax_n_o,
      xc7k_coax_n_o    => open,
      xc7k_coax_p_o    => open,
      --bec_connected_i  => bec_connected,
      bec_connected_i  => '1',
      trg_i            => trig_request_or,
      cdr_scl_o        => open,
      cdr_sda_io       => open,
      cdr1_dataout_n_i => cdr1_dataout_n_i,
      cdr1_dataout_p_i => cdr1_dataout_p_i,
      cdr1_en_n_o      => cdr1_en_n_o,
      cdr1_in_n_o      => cdr1_in_n_o,
      cdr1_in_p_o      => cdr1_in_p_o,
      cdr1_lol_i       => cdr1_lol_i,
      slink1_rx_n_i    => slink1_rx_n_i,
      slink1_rx_p_i    => slink1_rx_p_i,
      slink1_tx_n_o    => slink1_tx_n_o,
      slink1_tx_p_o    => slink1_tx_p_o,
      dlyctrl_ready_i  => dlyctrl_ready,
      aligned_o        => aligned_s,
      l1a_time_o       => l1a_time,
      l1a_time_ready_o => l1a_time_ready,
      local_time_o     => local_time_from_BEC,
      -- debug
      time_to_send     => time_to_send_dbg
      );

-------------------------------------------------------------------------------
-- ADUs instances
-------------------------------------------------------------------------------
  adu_instances : for adu_number in 0 to 2 generate

    adu_top_wrapper_1 : entity work.adu_top_wrapper
      generic map (
        N => adu_number)
      port map (
        init_clk      => cdrclk_o_125,
        init_rst      => not adu_enables(adu_number),
        test_pulse    => test_pulse(adu_number),
        init_done_out => init_done_out(adu_number),

        -- ports connected to pins
        adca_dclkp        => adca_dclkp(adu_number),
        adca_dclkn        => adca_dclkn(adu_number),
        adca_dp           => adca_dp(adu_number),
        adca_dn           => adca_dn(adu_number),
        adca_syncp        => adca_syncp(adu_number),
        adca_syncn        => adca_syncn(adu_number),
        adca_scsb         => adca_scsb(adu_number),
        adcb_dclkp        => adcb_dclkp(adu_number),
        adcb_dclkn        => adcb_dclkn(adu_number),
        adcb_dp           => adcb_dp(adu_number),
        adcb_dn           => adcb_dn(adu_number),
        adcb_syncp        => adcb_syncp(adu_number),
        adcb_syncn        => adcb_syncn(adu_number),
        adcb_scsb         => adcb_scsb(adu_number),
        pll_le            => pll_le(adu_number),
        spi_clk           => adc_spi_clk(adu_number),
        spi_en            => adc_spi_en(adu_number),
        spi_mosi          => adc_spi_mosi(adu_number),
        spi_miso          => adc_spi_miso(adu_number),
        cal_ctrl          => cal_ctrl(adu_number),
        -- optional configuration bus
        config_din_valid  => config_din_valid(adu_number),
        config_din_addr   => config_din_addr(adu_number),
        config_din_data   => config_din_data(adu_number),
        config_dout_valid => config_dout_valid(adu_number),
        config_dout_addr  => config_dout_addr(adu_number),
        config_dout_data  => config_dout_data(adu_number),
        -- to user logic
        adca_user_clk     => adca_user_clk(adu_number),
        adca_raw_data     => adca_raw_data(adu_number),
        adcb_user_clk     => adcb_user_clk(adu_number),
        adcb_raw_data     => adcb_raw_data(adu_number),
        cs_control        => open);

-------------------------------------------------------------------------------
-- clock out for the 3 ADUs
-------------------------------------------------------------------------------
    ODDR_inst : ODDR
      generic map(
        DDR_CLK_EDGE => "OPPOSITE_EDGE",
        INIT         => '0',
        SRTYPE       => "SYNC")
      port map (
        Q  => ext_clk(adu_number),
        C  => cdrclk_o_125,
        CE => adu_clock_enables(adu_number),
        D1 => '1',
        D2 => '0',
        R  => '0',
        S  => '0'
        );

  end generate adu_instances;
-------------------------------------------------------------------------------
  -- Front end configurations signals
  adc_gcl <= '1';
  adc_gcm <= '1';
  adc_gch <= '0';
-------------------------------------------------------------------------------
-- DAC configuration instance
-------------------------------------------------------------------------------
  dac_config_wrapper_1 : entity work.dac_config_wrapper
    generic map (
      CONFIG_BASE_ADDR => CONFIG_BASE_ADDR)
    port map (
      clk => cdrclk_o_125,
      rst => internal_reset,

      config_done       => dac_config_done,
      config_din_valid  => '0',
      config_din_addr   => (others => '0'),
      config_din_data   => (others => '0'),
      config_dout_valid => open,
      config_dout_addr  => open,
      config_dout_data  => open,

      -- output ports
      dac_spi_ck    => dac_spi_ck,
      dac_spi_mosi  => dac_spi_mosi,
      dac_spi_miso  => '0',
      dac_spi_syncn => dac_spi_syncn,
      dac_ldac      => dac_ldac);

  dac_por <= '1';
  dac_clr <= '1';
-------------------------------------------------------------------------------
-- ethernet switch configuration core
-------------------------------------------------------------------------------
  picoblaze_i : entity work.picoblaze_top
    port map (
      board_clk => cdrclk_o_100,
      rst       => rst,

      uart_tx   => uart_tx,
      uart_rx   => uart_rx,
      spi_clk   => sja1105_spi_clk,
      spi_miso  => sja1105_spi_miso,
      spi_mosi  => sja1105_spi_mosi,
      spi_cs_n  => sja1105_spi_cs_n,
      sja_rst_n => sja1105_sja_rst_n,
      led       => open);

-------------------------------------------------------------------------------
-- diagnostic by led
-------------------------------------------------------------------------------
  self_test_pulse : if false generate

    slow_clock_pulse_2 : entity work.slow_clock_pulse
      generic map (
        ref_clk_period_ns      => 8,  -- input clock period width in nanoseconds
        output_pulse_period_ms => 1000,       -- output period in ms.
        n_pulse_up             => 2_500_000)  -- number of input clock periods that
      port map (
        ref_clk   => cdrclk_o_125,
        pulse_out => activity_led);
  end generate self_test_pulse;
  activity_led <= local_time(25);
-------------------------------------------------------------------------------
-- Debug logic via led indcators
-------------------------------------------------------------------------------
  adc_clock_monitor : if true generate

    slow_clock_pulse_1 : entity work.slow_clock_pulse
      generic map (
        ref_clk_period_ns      => 8,  -- input clock period width in nanoseconds
        output_pulse_period_ms => 1000,       -- output period in ms.
        n_pulse_up             => 2_500_000)  -- number of input clock periods that
      port map (
        ref_clk   => adca_user_clk(0),
        pulse_out => led);

  end generate adc_clock_monitor;
end str;
