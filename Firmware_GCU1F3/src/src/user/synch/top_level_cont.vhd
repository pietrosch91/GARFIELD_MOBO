----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:52:34 09/17/2018 
-- Design Name: 
-- Module Name:    top_level - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: TTC test impulsing continuosly
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.GCUpack.all;
use work.TTCtestpack.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity top_level is
  port(
    sys_clk_250      : in    std_logic;
    sys_clk_200      : in    std_logic;
    sys_clk_locked   : in    std_logic;
    cdr_clk_250      : in    std_logic;
    cdr_clk_locked   : in    std_logic;
    xc7k_led0_o      : out   std_logic;  -- heart beat - system clock
    xc7k_led1_o      : out   std_logic;
    xc7k_coax_n_o    : out   std_logic;  -- system clock Jitter test to PX7 
    xc7k_coax_p_o    : out   std_logic;  -- system clock Jitter test to PX8
    bec_connected_i  : in    std_logic;
    trg_i            : in    std_logic;  -- trigger requests
    gcuid_i          : in    std_logic_vector(15 downto 0);
    -- cdr i2c: not used yet 
    cdr_scl_o        : out   std_logic;  -- ext CDR I2C clock
    cdr_sda_io       : inout std_logic;  -- ext CDR I2C data
    -- Synk link 1:
    -- Synk link and clock data recovery
    cdr1_dataout_n_i : in    std_logic;  -- recovered data from ext ADN2817ACPZ
    cdr1_dataout_p_i : in    std_logic;
    cdr1_en_n_o      : out   std_logic;  -- enable ext CDR. If high ADN2817ACPZ 
    -- clock and data outputs are disabled
    cdr1_in_n_o      : out   std_logic;  -- synch link data forwarded to ext CDR
    cdr1_in_p_o      : out   std_logic;
    cdr1_lol_i       : in    std_logic;  -- CDR ext, loss of lock rndicator
    -- synch link
    slink1_rx_n_i    : in    std_logic;
    slink1_rx_p_i    : in    std_logic;
    slink1_tx_n_o    : out   std_logic;
    slink1_tx_p_o    : out   std_logic;
    -- delayctrl
    dlyctrl_ready_i  : in    std_logic;
    aligned_o        : out   std_logic;
    -- l1a timestamps
    l1a_time_o       : out   std_logic_vector(47 downto 0);
    l1a_time_ready_o : out   std_logic;
    local_time_o     : out   std_logic_vector(47 downto 0);
    -- debug
    time_to_send     : out   std_logic_vector(31 downto 0)
    );
end top_level;

architecture rtl of top_level is

  signal s_brd_gen_clk       : std_logic;
  signal sys_clk_250_bufh    : std_logic;
  signal cdr_clk_250_bufh    : std_logic;
  signal s_slink_rx          : std_logic;
  signal s_cdr_data          : std_logic;
  signal sv_start_number     : std_logic_vector(15 downto 0);
  signal sv_eff_start_number : std_logic_vector(47 downto 0);
  signal s_vio_trigg         : std_logic;
  signal s_chb_req1          : std_logic;
  signal s_chb_grant1        : std_logic;
  signal s_chb_grant2        : std_logic;
  signal s_chb_busy          : std_logic;
  signal s_ttctx_ready       : std_logic;
  signal s_sending           : std_logic;
  signal rc_brd_vector       : t_brd_command;
  signal s_l1a_tx            : std_logic;
  signal s_start             : std_logic;
  signal ttc_stream_o_in     : std_logic;
  signal s_l1a_rx            : std_logic;
  signal rc_cmd_vector_rx    : t_brd_command;
  signal s_single_bit_err,
    s_double_bit_err,
    s_comm_bit_err : std_logic_vector(31 downto 0);
  signal s_ttcrx_ready,
    s_no_errors,
    s_aligned,
    s_NIT : std_logic;
  signal s_stop          : std_logic;
  signal rc_stop_numbers : TTCtest_rx_results;
  signal s_rst_cdrclk_x1,
    s_rst_brd_gen : std_logic;
  signal s_chb_req1_tap_cal            : std_logic;
  signal sv_tap_count                  : std_logic_vector(6 downto 0);
  signal s_tap_incr                    : std_logic;
  signal sv_tap_en                     : std_logic_vector(3 downto 0);
  signal s_tap_load                    : std_logic;
  signal s_delay_ctrl_ready            : std_logic;
  signal rc_brd_vector_ored            : t_brd_command;
  signal s_cal_idle                    : std_logic;
  signal s_cal_rst_errors              : std_logic;
  signal s_ttc_tap_incr                : std_logic;
  signal s_ttc_tap_decr                : std_logic;
  signal s_ttc_tap_reset               : std_logic;
  signal s_pulse                       : std_logic;
  signal sg_time_count                 : signed(47 downto 0);
  signal sv_local_time                 : std_logic_vector(47 downto 0);
  signal rc_long_frame_in2             : t_ttc_long_frame;
  signal rc_long_frame_in1             : t_ttc_long_frame;
  signal s_chb_grant3                  : std_logic;
  signal s_chb_req3                    : std_logic;
  signal s_chb_req2                    : std_logic;
  signal sv_synch                      : std_logic_vector(47 downto 0);
  signal sv_delay                      : std_logic_vector(47 downto 0);
  signal s_l1a_time                    : std_logic_vector(47 downto 0);
  signal offset                        : signed(47 downto 0);
  signal s_byte5                       : std_logic;
  signal s_l1a_time_ready              : std_logic;
  signal s_synch_req                   : std_logic;
  signal s_bec_connected               : std_logic;
-- debug
  signal cha_time_domain_decoder_debug : std_logic;
  signal toggle_channel_decoder_debug  : std_logic;
  signal toggle_shift_decoder_debug    : std_logic;
  signal bmc_data_toggle_decoder_debug : std_logic;
  signal brc_cmd_decoder_debug         : std_logic_vector(5 downto 0);
  signal brc_cmd_strobe_decoder_debug  : std_logic;
  signal cdr_data_decoder_debug        : std_logic_vector(1 downto 0);
  signal brc_rst_t_decoder_debug       : std_logic;
  signal brc_rst_e_decoder_debug       : std_logic;
  signal s_man_trigger                 : std_logic;
  signal s_1bit_err_pulse,
    s_2bit_err_pulse,
    s_comm_err_pulse,
    s_1bit_err_pulse2,
    s_2bit_err_pulse2,
    s_comm_err_pulse2 : std_logic;
  signal sv_norst_1bit_error_counter,
    sv_norst_2bit_error_counter,
    sv_norst_comm_error_counter,
    sv_norst_1bit_error_counter2,
    sv_norst_2bit_error_counter2,
    sv_norst_comm_error_counter2 : std_logic_vector(47 downto 0);
  signal sv_rx_time_debug      : std_logic_vector(47 downto 0);
  signal sv_tx_time_debug      : std_logic_vector(47 downto 0);
  signal s_catch_tx_time_debug : std_logic;
  signal s_catch_rx_time_debug : std_logic;
-- chipscope signals
  signal sv_control0,
    sv_control1,
    sv_control2 : std_logic_vector(35 downto 0);
  signal vio_trigg              : std_logic;
  signal vio_man_trigg          : std_logic;
  signal vio_trwt               : std_logic_vector(31 downto 0);
  signal vio_ttcrx_coarse_delay : std_logic_vector(4 downto 0);

  -----------------------------------------------------------------------------
  -- Debug attributes
  -----------------------------------------------------------------------------
  --attribute dont_touch : string;
  attribute mark_debug : string;
  --attribute dont_touch of s_byte5 : signal is "true";
--  attribute mark_debug of s_byte5 : signal is "true";
  -- attribute dont_touch of s_ttctx_ready : signal is "true";
  -- attribute dont_touch of sv_local_time : signal is "true";
  -- attribute dont_touch of trg_i : signal is "true";
  -- attribute dont_touch of s_chb_grant2 : signal is "true";
  -- attribute dont_touch of s_chb_req2 : signal is "true";
  -- attribute dont_touch of s_l1a_time : signal is "true";
  -- attribute dont_touch of s_l1a_time_ready : signal is "true";
--  attribute mark_debug of s_ttctx_ready : signal is "true";
--  attribute mark_debug of sv_local_time : signal is "true";
  -- attribute mark_debug of trg_i      : signal is "true";
--  attribute mark_debug of s_chb_grant2 : signal is "true";
--  attribute mark_debug of s_chb_req2 : signal is "true";
  -- attribute mark_debug of s_l1a_time : signal is "true";
--  attribute mark_debug of s_l1a_time_ready : signal is "true";

begin

  s_delay_ctrl_ready <= dlyctrl_ready_i;

  ------------------------------------------
  -- Input Buffers
  ------------------------------------------  
  -- Slink rx Buffers
  IBUFDS_SLINK1_RX : IBUFDS
    generic map (
      DIFF_TERM    => true,             -- Differential Termination 
      IBUF_LOW_PWR => false,  -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD   => "LVDS_25")
    port map (
      O  => s_slink_rx,                 -- Buffer output
      I  => slink1_rx_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => slink1_rx_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  -- CDR Data and Clock Buffers
  IBUFDS_CDR1_DATA : IBUFDS
    generic map (
      DIFF_TERM    => true,             -- Differential Termination 
      IBUF_LOW_PWR => false,  -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD   => "LVDS")
    port map (
      O  => s_cdr_data,                 -- Buffer output
      I  => cdr1_dataout_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => cdr1_dataout_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  ------------------------------------------
  -- Output Buffers
  ------------------------------------------
  OBUFDS_TTC_STREAM1 : OBUFDS
    generic map (
      IOSTANDARD => "LVDS_25",          -- Specify the output I/O standard
      SLEW       => "SLOW")             -- Specify the output slew rate
    port map (
      O  => slink1_tx_p_o,  -- Diff_p output (connect directly to top-level port)
      OB => slink1_tx_n_o,  -- Diff_n output (connect directly to top-level port)
      I  => ttc_stream_o_in             -- Buffer input 
      );

  OBUFDS_CDR1_IN : OBUFDS
    generic map (
      IOSTANDARD => "LVDS_25",          -- Specify the output I/O standard
      SLEW       => "FAST")             -- Specify the output slew rate
    port map (
      O  => cdr1_in_p_o,  -- Diff_p output (connect directly to top-level port)
      OB => cdr1_in_n_o,  -- Diff_n output (connect directly to top-level port)
      I  => s_slink_rx                  -- Buffer input 
      );

  OBUF_COAX_P : OBUF
    generic map (
      DRIVE      => 12,
      IOSTANDARD => "DEFAULT",
      SLEW       => "SLOW")
    port map (
      O => xc7k_coax_p_o,  -- Buffer output (connect directly to top-level port)
      I => '0'                          -- Buffer input 
      );

  OBUF_COAX_N : OBUF
    generic map (
      DRIVE      => 12,
      IOSTANDARD => "DEFAULT",
      SLEW       => "SLOW")
    port map (
      O => xc7k_coax_n_o,  -- Buffer output (connect directly to top-level port)
      I => s_pulse                      -- Buffer input 
      );


  ------------------------------------------
  -- CDR configuration signals
  ------------------------------------------
  cdr1_en_n_o <= '0';
  cdr_scl_o   <= '0';
  cdr_sda_io  <= '0';

  -----------------------------
  -- Local time
  -----------------------------
  Proc_time_counter : process(s_brd_gen_clk)
  begin
    if rising_edge(s_brd_gen_clk) then
      if s_ttcrx_ready = '0' or rc_cmd_vector_rx.rst_time = '1' then
        sg_time_count <= (others => '0');
      else
        sg_time_count <= sg_time_count + 1 + offset;
      end if;
    end if;
  end process Proc_time_counter;
  sv_local_time <= std_logic_vector(sg_time_count);

  -----------------------------
  -- Select brd gen clk
  -----------------------------
  -- BUFH for BUFG - BUFG connection
  -- sysclk250_bufh : BUFH
  --   port map (
  --     O => sys_clk_250_bufh,            -- 1-bit output: Clock output
  --     I => sys_clk_250                  -- 1-bit input: Clock input
  --     );

  -- cdrclk250_bufh : BUFH
  --   port map (
  --     O => cdr_clk_250_bufh,            -- 1-bit output: Clock output
  --     I => cdr_clk_250                  -- 1-bit input: Clock input
  --     );

  --   BUFGMUX_CTRL_inst : BUFGMUX_CTRL
  --   port map (
  --     O  => s_brd_gen_clk,              -- 1-bit output: Clock output
  --     I0 => sys_clk_250_bufh,           -- 1-bit input: Clock input (S=0)
  --     I1 => cdr_clk_250_bufh,           -- 1-bit input: Clock input (S=1)
  --     S  => s_bec_connected             -- 1-bit input: Clock select
  --     );

  --s_brd_gen_clk   <= sys_clk_250;
  s_brd_gen_clk   <= cdr_clk_250;
  s_bec_connected <= bec_connected_i;

  ------------------------------------------
  -- TTC Encoder
  ------------------------------------------
  rc_brd_vector_ored.idle           <= s_cal_idle;
  rc_brd_vector_ored.rst_time       <= '0';
  rc_brd_vector_ored.rst_event      <= '0';
  rc_brd_vector_ored.rst_time_event <= '0';
  rc_brd_vector_ored.supernova      <= '0';
  rc_brd_vector_ored.test_pulse     <= '0';
  rc_brd_vector_ored.time_request   <= '0';
  rc_brd_vector_ored.rst_errors     <= s_cal_rst_errors;
  rc_brd_vector_ored.autotrigger    <= '0';
  rc_brd_vector_ored.en_acquisition <= '0';

  Inst_ttc_encoder : entity work.ttc_encoder
    generic map (
      g_pll_locked_delay => 200,
      g_use_idelay       => true
      )
    port map (
      locked_i         => cdr_clk_locked or sys_clk_locked,
      clk_x4_i         => s_brd_gen_clk,
      clk_200_i        => sys_clk_200,
      -------------------------------
      sbit_err_inj_i   => '0',
      dbit_err_inj_i   => '0',
      err_pos1_i       => (others => '0'),
      err_pos2_i       => (others => '0'),
      -- Broadcast frame:
      -- broadcast command vector
      -- a '1' in one of these bits triggers a broadcast command 
      brd_cmd_vector_i => rc_brd_vector_ored,
      l1a_i            => trg_i,
      -- Long addressed frame:
      long_frame1_i    => rc_long_frame_in1,
      long_frame2_i    => rc_long_frame_in2,  -- for timing  
      long_frame3_i    => ((others => '0'), (others => '0'), (others => '0'), '0'),  -- for calibration
      -- output stream
      ttc_stream_o     => ttc_stream_o_in,
      chb_busy_o       => s_chb_busy,
      chb_grant1_o     => s_chb_grant1,
      chb_grant2_o     => s_chb_grant2,
      chb_grant3_o     => s_chb_grant3,
      chb_grant4_o     => open,
      chb_req1_i       => s_chb_req1 or s_chb_req1_tap_cal,
      chb_req2_i       => s_chb_req2,
      chb_req3_i       => s_chb_req3,
      chb_req4_i       => '0',
      tap_count_o      => sv_tap_count,  -- open if data delay is not needed
      tap_incr_i       => s_tap_incr,   -- '0' if data delay is not needed
      tap_en_i         => sv_tap_en,    -- '0' if data delay is not needed
      tap_load_i       => s_tap_load,
      -- delay_ctrl_ready_o => s_delay_ctrl_ready,
      ready_o          => s_ttctx_ready
      );
  -- Delay Calibration
  Inst_tap_control : entity work.ttctx_delay_control
    port map (
      clk_i              => cdr_clk_250,      -- 250 MHz
      ttc_tap_incr_i     => s_ttc_tap_incr,
      ttc_tap_decr_i     => s_ttc_tap_decr,
      ttc_tap_reset_i    => s_ttc_tap_reset,
      ttc_tx_ready_i     => s_ttctx_ready,
      delay_calibrated_i => s_delay_ctrl_ready,
      chb_grant1_i       => s_chb_grant1,
      chb_req1_o         => s_chb_req1_tap_cal,
      rst_errors_o       => s_cal_rst_errors,
      idle_o             => s_cal_idle,
      load_o             => s_tap_load,
      tap_incr_o         => s_tap_incr,
      debug_fsm_o        => open,
      tap_en_o           => sv_tap_en
      );

  -- Timing synchronization
  Inst_GCU_1588_ptp : entity work.GCU_1588_ptp
    port map(
      clk_i                 => cdr_clk_250,
      rst_i                 => (not s_ttcrx_ready) or (not s_ttctx_ready),
      enable_i              => '1',
      byte_5_i              => s_byte5,
      synch_req_i           => s_synch_req,
      chb_grant_i           => s_chb_grant3,
      period_i              => x"04000000",  --s_1588ptp_timeout
      local_time_i          => sv_local_time,
      trwt                  => vio_trwt,     -- BEC postponed time
      synch_i               => sv_synch,
      delay_i               => sv_delay,
      chb_req_o             => s_chb_req3,
      debug_fsm_o           => open,
      ttc_long_o            => rc_long_frame_in2,
      control_i             => open,
      offset_o              => offset,
      --debug
      rx_time_debug_o       => sv_rx_time_debug,
      tx_time_debug_o       => sv_tx_time_debug,
      catch_tx_time_debug_o => s_catch_tx_time_debug,
      catch_rx_time_debug_o => s_catch_rx_time_debug
      );

  s_pulse <= sv_local_time(25);

  -----------------------------------------------------------------------------
  -- Trigger timestamp via ttc
  -----------------------------------------------------------------------------
  ttc_trg_time_1 : entity work.ttc_trg_time
    port map (
      clk_i           => s_brd_gen_clk,
      rst_i           => s_rst_brd_gen,
      ttctx_ready_i   => s_ttctx_ready,
      local_time_i    => sv_local_time,
      local_trigger_i => '0',
      chb_grant_i     => s_chb_grant2,
      chb_req_o       => s_chb_req2,
      ttc_long_o      => rc_long_frame_in1,
      -- debug
      time_to_send    => time_to_send
      );

  ------------------------------------------
  -- TTC Decoder
  ------------------------------------------
  -- Channel 1
  Inst_ttc_decoder : entity work.ttc_decoder_core
    generic map (
      g_pll_locked_delay => 200,
      g_Hamming          => true,
      g_max_trigg_len    => 30,
      g_TTC_memory_deep  => 25
      )
    port map (
      --== cdr interface ==--
      locked_i              => cdr_clk_locked,
      --cdrclk_i                 : in std_logic;  -- 62.5 MHz clock from CDR  
      cdrclk_x4_i           => cdr_clk_250,
      cdrdata_i             => s_cdr_data,  -- data stream from CDR 
      ttcrx_coarse_delay_i  => vio_ttcrx_coarse_delay,
      gcuid_i               => gcuid_i,
      --== ttc decoder output ==--
      cha_o                 => s_l1a_rx,
      brd_command_vector_o  => rc_cmd_vector_rx,
      l1a_time_o            => s_l1a_time,
      synch_o               => sv_synch,
      delay_o               => sv_delay,
      ttc_ctrl_o            => open,
      delay_req_o           => open,
      synch_req_o           => s_synch_req,
      byte5_o               => s_byte5,
      l1a_time_ready_o      => s_l1a_time_ready,
      tap_incr_o            => s_ttc_tap_incr,
      tap_decr_o            => s_ttc_tap_decr,
      tap_reset_o           => s_ttc_tap_reset,
      -- Error counters
      single_bit_err_o      => s_single_bit_err,
      duble_bit_err_o       => s_double_bit_err,
      comm_err_o            => s_comm_bit_err,
      --== ttc decoder aux flags ==--
      ready_o               => s_ttcrx_ready,
      no_errors_o           => s_no_errors,
      aligned_o             => aligned_o,
      not_in_table_o        => s_NIT,
      cha_time_domain_o     => cha_time_domain_decoder_debug,
      -- debug
      toggle_channel_debug  => open,
      toggle_shift_debug    => open,
      bmc_data_toggle_debug => open,
      cdr_data_debug        => open,
      brc_cmd_debug         => open,
      brc_cmd_strobe_debug  => open,
      brc_rst_t_debug       => open,
      brc_rst_e_debug       => open,
      error_1bit_pulse_test => s_1bit_err_pulse,
      error_2bit_pulse_test => s_2bit_err_pulse,
      error_comm_pulse_test => s_comm_err_pulse
      );

  l1a_time_ready_o <= s_l1a_time_ready;
  l1a_time_o       <= s_l1a_time;

  vio_trwt               <= (others => '0');
  vio_ttcrx_coarse_delay <= (others => '0');

  ---------------------
  -- LED control
  ---------------------
  xc7k_led0_o <= cdr_clk_locked and (not cdr1_lol_i);
  xc7k_led1_o <= sv_local_time(27);


  local_time_o <= sv_local_time;



end rtl;
