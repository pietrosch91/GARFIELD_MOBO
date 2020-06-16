--=================================================================================================--
--==================================== Module Information =========================================--
--=================================================================================================--
--                                                                                         
-- Company:                CERN (PH-ESE-BE)                                                         
-- Engineer:               Sophie Baron (sophie.baron@cern.ch)
--                                                                                                 
-- Project Name:           TTC                                                            
-- Module Name:            TTC encoder                                         
--                                                                                                 
-- Language:               VHDL'93                                                                  
--                                                                                                   
-- Target Device:          Kintex7 - KC705                                                         
-- Tool version:           ISE 14.5                                                                
--                                                                                                   
-- Version:                0.1                                                                      
--
-- Description:            
--
-- Versions history:       DATE         VERSION   AUTHOR            DESCRIPTION
--
--                         18/07/2013   1.0       Sophie BARON      - First .vhd module definition           
--
-- DATE:        24/11/2016
-- VERSION:     2.0
-- AUTHOR:      INFN
-- DESCRIPTION: changed vhdl coding style, design architecture review + design optimization.
--=================================================================================================--
--=================================================================================================--

--=================================================================================================--
--==================================== Additional Comments ========================================--
--=================================================================================================-- 
--
-- TTC FRAME (TDM of channels A and B):
-- A channel: No encoding, minimum latency.
-- B channel: short broadcast or long addressed commands. Hamming check bits

-- B Channel Content:
--
-- Short Broadcast, 16 bits:
-- 00SSSSSSEBHHHHH1: S=Command/Data, 6 bits. E=Event Counter Reset, 1 bit. B=Time Reset, 1 bit. 
--                   H=Hamming Code, 5 bits.
-- IDLE command:
-- 0011111100HHHHH1
-- It is important for channel alignment.
-- Long Addressed, 42 bits
-- 01AAAAAAAAAAAAAAAASSSSSSSSDDDDDDDDHHHHHHH1: A = TTCrx address, 16 bits. S = SubAddress, 8 bits. 
--                                             D = Data, 8 bits. H = Hamming Code, 7 bits.
-- 
-- TDM/BPM coding principle:
--  <   16.000 ns   >
--     X---A---X---B---X
--  X=======X=======X A=0, B=0 (no trigger, B=0) 
--  X=======X===1===X A=0, B=1 (no trigger, B=1). 
--  X===1===X=======X A=1, B=0 (trigger, B=0).
--  X===1===X===1===X A=1, B=1 (trigger, B=1)
-- 
-- After locked and whenever no data/commands are available to be transmitted downstream the CHB 
-- must carry IDLE commands.
-- No more than 5 consecutive '1' are allowed on the CHA for channel alignment reasons.
--
--=================================================================================================--
--=================================================================================================--

library ieee;
library unisim;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use unisim.vcomponents.all;
use work.GCUpack.all;

entity ttc_encoder is
  generic (
    g_pll_locked_delay : integer := 200;
    g_use_idelay       : boolean := true
    );
  port
    (
      locked_i           : in  std_logic;
      -------------------------------     
      --ttc_sys_clock_i  : in std_logic;  -- 62.5 MHz
      --clk_x2_i         : in std_logic;  -- 125 MHz
      clk_x4_i           : in  std_logic;  -- line rate clock
      clk_200_i          : in  std_logic;  -- 200 MHz
      -------------------------------
      sbit_err_inj_i     : in  std_logic;
      dbit_err_inj_i     : in  std_logic;
      err_pos1_i         : in  std_logic_vector(5 downto 0);
      err_pos2_i         : in  std_logic_vector(5 downto 0);
      --------------------------------------------------------
      -- Broadcast frame:
      -- broadcast command vector
      -- a '1' in one of these bits triggers a broadcast command 
      brd_cmd_vector_i   :     t_brd_command;
      l1a_i              : in  std_logic;
      ---------------------------------------------------------------------------------
      -- Long addressed frame:
      ----------------------------------
      long_frame1_i      : in  t_ttc_long_frame;
      long_frame2_i      : in  t_ttc_long_frame;  -- for timing 
      long_frame3_i      : in  t_ttc_long_frame;  -- for calibration
      -- output stream
      ttc_stream_o       : out std_logic;
      chb_busy_o         : out std_logic;
      chb_grant1_o       : out std_logic;
      chb_grant2_o       : out std_logic;
      chb_grant3_o       : out std_logic;
      chb_grant4_o       : out std_logic;
      chb_req1_i         : in  std_logic;
      chb_req2_i         : in  std_logic;
      chb_req3_i         : in  std_logic;
      chb_req4_i         : in  std_logic;
      tap_count_o        : out std_logic_vector(6 downto 0);  -- open if data delay is not needed
      tap_incr_i         : in  std_logic;  -- '0' if data delay is not needed
      tap_en_i           : in  std_logic_vector(3 downto 0);  -- '0' if data delay is not needed
      tap_load_i         : in  std_logic;
      delay_ctrl_ready_o : out std_logic;
      ready_o            : out std_logic
      );
end ttc_encoder;

architecture rtl of ttc_encoder is

--========================================================================--       
--========================= Signal Declarations ==========================--
  signal s_rst                : std_logic;
  signal s_chb_released       : std_logic;
  signal s_brd_vector         : t_brd_command;
  signal s_chb_grant1         : std_logic;
  signal s_chb_grant2         : std_logic;
  signal s_chb_grant3         : std_logic;
  signal s_chb_grant4         : std_logic;
  signal s_mmcm_lock          : std_logic;
  signal reset_from_rst       : std_logic;
  signal locked_from_cdceSync : std_logic;
  signal s_bmc_data_in        : std_logic;
  signal s_chb                : std_logic;
  signal s_sel                : std_logic;
  signal s_brdcst_strobe      : std_logic;
  signal s_brd_strobe         : std_logic;
  signal s_brdcst_frame       : std_logic_vector(15 downto 0);
  signal s_long_strobe        : std_logic;
  signal s_long_frame         : std_logic_vector(41 downto 0);
  signal s_chb_busy           : std_logic;
  signal s_brdcst_cmd         : std_logic_vector(5 downto 0);
  signal s_bcntrst            : std_logic;
  signal s_ecntrst            : std_logic;
  signal s_long_address_i     : std_logic_vector(15 downto 0);
  signal s_long_subadd_i      : std_logic_vector(7 downto 0);
  signal s_long_data_i        : std_logic_vector(7 downto 0);
  signal s_long_cmd_strobe_i  : std_logic;
  signal s_tap_count1         : std_logic_vector(4 downto 0);
  signal s_tap_count2         : std_logic_vector(4 downto 0);
  signal s_tap_count3         : std_logic_vector(4 downto 0);
  signal s_tap_count4         : std_logic_vector(4 downto 0);
  signal s_ttc_stream         : std_logic;
  signal s_ttc_stream_2       : std_logic;
  signal s_ttc_stream_3       : std_logic;
  signal s_ttc_stream_4       : std_logic;
  signal s_tdm_synch          : std_logic;

--========================================================================--  
  component ila_ttc_rx
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      CLK     : in    std_logic;
      TRIG0   : in    std_logic_vector(0 to 0);
      TRIG1   : in    std_logic_vector(0 to 0);
      TRIG2   : in    std_logic_vector(0 to 0);
      TRIG3   : in    std_logic_vector(0 to 0));
  end component;

  component bmc_generator
    port(
      data_i      : in  std_logic;
      reset_i     : in  std_logic;
      clk_250_i   : in  std_logic;
      sel_o       : out std_logic;
      tdm_synch_o : out std_logic;
      bmc_o       : out std_logic
      );
  end component;

  component broadcast_frame_maker
    port(
      reset_i         : in  std_logic;
      clk_i           : in  std_logic;
      brdcst_cmd_i    : in  std_logic_vector(5 downto 0);
      ecntrst_i       : in  std_logic;
      bcntrst_i       : in  std_logic;
      brdcst_strobe_i : in  std_logic;
      brdcst_frame_o  : out std_logic_vector(15 downto 0);
      strobe_o        : out std_logic
      );
  end component;

  component long_frame_maker
    port(
      reset_i               : in  std_logic;
      clk_i                 : in  std_logic;
      long_address_i        : in  std_logic_vector(15 downto 0);
      long_subadd_i         : in  std_logic_vector(7 downto 0);
      long_data_i           : in  std_logic_vector(7 downto 0);
      long_command_strobe_i : in  std_logic;
      long_frame_o          : out std_logic_vector(41 downto 0);
      strobe_o              : out std_logic
      );
  end component;

  component chb_shift_ctrl
    generic(g_cnt_width : integer := 6
            );
    port(
      clk_i           : in  std_logic;
      reset_i         : in  std_logic;
      brdcst_strobe_i : in  std_logic;
      long_strobe_i   : in  std_logic;
      sbit_err_inj_i  : in  std_logic;
      dbit_err_inj_i  : in  std_logic;
      err_pos1_i      : in  std_logic_vector(5 downto 0);
      err_pos2_i      : in  std_logic_vector(5 downto 0);
      brdcst_frame_i  : in  std_logic_vector(15 downto 0);
      long_frame_i    : in  std_logic_vector(41 downto 0);
      chb_o           : out std_logic;
      chb_busy_o      : out std_logic
      );
  end component;

  component BrdCommandEncoder
    port(
      clk_i           : in  std_logic;
      ttctx_ready_i   : in  std_logic;
      brdcst_cmd_o    : out std_logic_vector(5 downto 0);
      ecntrst_o       : out std_logic;
      bcntrst_o       : out std_logic;
      brdcst_strobe_o : out std_logic;
      tx_brd_vector_i :     t_brd_command
      );
  end component;

  component chb_traffic_light
    port(
      clk_i          : in  std_logic;
      rst_i          : in  std_logic;
      chb_released_i : in  std_logic;
      synch_i        : in  std_logic;
      chb_req1_i     : in  std_logic;
      chb_req2_i     : in  std_logic;
      chb_req3_i     : in  std_logic;
      chb_req4_i     : in  std_logic;
      chb_grant1_o   : out std_logic;
      chb_grant2_o   : out std_logic;
      chb_grant3_o   : out std_logic;
      chb_grant4_o   : out std_logic;
      chb_busy_o     : out std_logic
      );
  end component;

--attribute IODELAY_GROUP : STRING;
--attribute IODELAY_GROUP of IDELAYE2_1: label is "ttc_tx_stream";
--attribute IODELAY_GROUP of IDELAYE2_2: label is "ttc_tx_stream";
--attribute IODELAY_GROUP of IDELAYE2_3: label is "ttc_tx_stream";
--attribute IODELAY_GROUP of IDELAYE2_4: label is "ttc_tx_stream";
--attribute IODELAY_GROUP of IDELAYCTRL_inst: label is "ttc_tx_stream";
-----        --===================================================--
begin  --================== Architecture Body ==================-- 
-----        --===================================================--

  s_long_address_i <= long_frame1_i.long_address when s_chb_grant2 = '1' and s_chb_grant3 = '0' and s_chb_grant4 = '0' else
                      long_frame2_i.long_address when s_chb_grant3 = '1' and s_chb_grant2 = '0' and s_chb_grant4 = '0' else
                      long_frame3_i.long_address when s_chb_grant4 = '1' and s_chb_grant2 = '0' and s_chb_grant3 = '0' else
                      x"0000";
  s_long_subadd_i <= long_frame1_i.long_subadd when s_chb_grant2 = '1' and s_chb_grant3 = '0' and s_chb_grant4 = '0' else
                     long_frame2_i.long_subadd when s_chb_grant3 = '1' and s_chb_grant2 = '0' and s_chb_grant4 = '0' else
                     long_frame3_i.long_subadd when s_chb_grant4 = '1' and s_chb_grant2 = '0' and s_chb_grant3 = '0' else
                     x"00";
  s_long_data_i <= long_frame1_i.long_data when s_chb_grant2 = '1' and s_chb_grant3 = '0' and s_chb_grant4 = '0' else
                   long_frame2_i.long_data when s_chb_grant3 = '1' and s_chb_grant2 = '0' and s_chb_grant4 = '0' else
                   long_frame3_i.long_data when s_chb_grant4 = '1' and s_chb_grant2 = '0' and s_chb_grant3 = '0' else
                   x"00";
  s_long_cmd_strobe_i <= (long_frame1_i.long_strobe and s_chb_grant2) or (long_frame2_i.long_strobe and s_chb_grant3) or (long_frame3_i.long_strobe and s_chb_grant4);

--------------------------Broadcast Command Encoder---------------------------------
------------------------------------------------------------------------------------

  Inst_BrdCommandEncoder : BrdCommandEncoder
    port map(
      clk_i           => clk_x4_i,
      ttctx_ready_i   => s_mmcm_lock,
      brdcst_cmd_o    => s_brdcst_cmd,
      ecntrst_o       => s_ecntrst,
      bcntrst_o       => s_bcntrst,
      brdcst_strobe_o => s_brd_strobe,
      tx_brd_vector_i => s_brd_vector
      );

  s_brd_vector.idle           <= brd_cmd_vector_i.idle and s_chb_grant1;
  s_brd_vector.rst_time       <= brd_cmd_vector_i.rst_time and s_chb_grant1;
  s_brd_vector.rst_event      <= brd_cmd_vector_i.rst_event and s_chb_grant1;
  s_brd_vector.rst_time_event <= brd_cmd_vector_i.rst_time_event and s_chb_grant1;
  s_brd_vector.supernova      <= brd_cmd_vector_i.supernova and s_chb_grant1;
  s_brd_vector.test_pulse     <= brd_cmd_vector_i.test_pulse and s_chb_grant1;
  s_brd_vector.time_request   <= brd_cmd_vector_i.time_request and s_chb_grant1;
  s_brd_vector.rst_errors     <= brd_cmd_vector_i.rst_errors and s_chb_grant1;
  s_brd_vector.autotrigger    <= brd_cmd_vector_i.autotrigger and s_chb_grant1;
  s_brd_vector.en_acquisition <= brd_cmd_vector_i.en_acquisition and s_chb_grant1;
--===================================================-- 
--delay before starting the A and B channel extraction
--===================================================--

  p_delay_after_lock : process(clk_x4_i, locked_i)
    variable timer : integer := 200;
  begin
    if locked_i = '0' then
    timer       := g_pll_locked_delay;
    s_mmcm_lock <= '0';
  elsif rising_edge(clk_x4_i) then
    if timer = 0 then
      s_mmcm_lock <= '1';
    else
      timer := timer-1;
    end if;
  end if;
end process;

s_rst   <= not s_mmcm_lock;
ready_o <= s_mmcm_lock;

------------------------------BMC CHANNEL ENCODING-------------------------------
Inst_bmc_generator : bmc_generator port map(
  data_i      => s_bmc_data_in,
  reset_i     => s_rst,
  clk_250_i   => clk_x4_i,
  sel_o       => s_sel,
  tdm_synch_o => s_tdm_synch,
  bmc_o       => s_ttc_stream
  );


-------------------------------DELAY CALIBRATION----------------------------------
GEN_IDELAY : if g_use_idelay generate

  IDELAYCTRL_inst : IDELAYCTRL
    port map (
      RDY    => delay_ctrl_ready_o,     -- 1-bit output: Ready output
      REFCLK => clk_200_i,              -- 1-bit input: Reference clock input
      RST    => s_rst                   -- 1-bit input: Active high reset input
      );

--  Variable Delay Element
--  
-- Xilinx HDL Language Template, version 14.7

  IDELAYE2_1 : IDELAYE2
    generic map (
      CINVCTRL_SEL          => "FALSE",  -- Enable dynamic clock inversion (FALSE, TRUE)
      DELAY_SRC             => "DATAIN",   -- Delay input (IDATAIN, DATAIN)
      HIGH_PERFORMANCE_MODE => "TRUE",  -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
      IDELAY_TYPE           => "VARIABLE",  -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      IDELAY_VALUE          => 0,       -- Input delay tap setting (0-31)
      PIPE_SEL              => "FALSE",  -- Select pipelined mode, FALSE, TRUE
      REFCLK_FREQUENCY      => 200.0,  -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
      SIGNAL_PATTERN        => "DATA"   -- DATA, CLOCK input signal
      )
    port map (
      CNTVALUEOUT => s_tap_count1,      -- 5-bit output: Counter value output
      DATAOUT     => s_ttc_stream_2,    -- 1-bit output: Delayed data output
      C           => clk_x4_i,          -- 1-bit input: Clock input
      CE          => tap_en_i(0),  -- 1-bit input: Active high enable increment/decrement input
      CINVCTRL    => '0',  -- 1-bit input: Dynamic clock inversion input
      CNTVALUEIN  => "00000",           -- 5-bit input: Counter value input
      DATAIN      => s_ttc_stream,  -- 1-bit input: Internal delay data input
      IDATAIN     => '0',               -- 1-bit input: Data input from the I/O
      INC         => tap_incr_i,  -- 1-bit input: Increment / Decrement tap delay input
      LD          => s_rst or tap_load_i,  -- 1-bit input: Load IDELAY_VALUE input
      LDPIPEEN    => '0',  -- 1-bit input: Enable PIPELINE register to load data input
      REGRST      => '0'   -- 1-bit input: Active-high reset tap-delay input
      );

  IDELAYE2_2 : IDELAYE2
    generic map (
      CINVCTRL_SEL          => "FALSE",  -- Enable dynamic clock inversion (FALSE, TRUE)
      DELAY_SRC             => "DATAIN",   -- Delay input (IDATAIN, DATAIN)
      HIGH_PERFORMANCE_MODE => "TRUE",  -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
      IDELAY_TYPE           => "VARIABLE",  -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      IDELAY_VALUE          => 0,       -- Input delay tap setting (0-31)
      PIPE_SEL              => "FALSE",  -- Select pipelined mode, FALSE, TRUE
      REFCLK_FREQUENCY      => 200.0,  -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
      SIGNAL_PATTERN        => "DATA"   -- DATA, CLOCK input signal
      )
    port map (
      CNTVALUEOUT => s_tap_count2,      -- 5-bit output: Counter value output
      DATAOUT     => s_ttc_stream_3,    -- 1-bit output: Delayed data output
      C           => clk_x4_i,          -- 1-bit input: Clock input
      CE          => tap_en_i(1),  -- 1-bit input: Active high enable increment/decrement input
      CINVCTRL    => '0',  -- 1-bit input: Dynamic clock inversion input
      CNTVALUEIN  => "00000",           -- 5-bit input: Counter value input
      DATAIN      => s_ttc_stream_2,  -- 1-bit input: Internal delay data input
      IDATAIN     => '0',               -- 1-bit input: Data input from the I/O
      INC         => tap_incr_i,  -- 1-bit input: Increment / Decrement tap delay input
      LD          => s_rst or tap_load_i,  -- 1-bit input: Load IDELAY_VALUE input
      LDPIPEEN    => '0',  -- 1-bit input: Enable PIPELINE register to load data input
      REGRST      => '0'   -- 1-bit input: Active-high reset tap-delay input
      );

  IDELAYE2_3 : IDELAYE2
    generic map (
      CINVCTRL_SEL          => "FALSE",  -- Enable dynamic clock inversion (FALSE, TRUE)
      DELAY_SRC             => "DATAIN",   -- Delay input (IDATAIN, DATAIN)
      HIGH_PERFORMANCE_MODE => "TRUE",  -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
      IDELAY_TYPE           => "VARIABLE",  -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      IDELAY_VALUE          => 0,       -- Input delay tap setting (0-31)
      PIPE_SEL              => "FALSE",  -- Select pipelined mode, FALSE, TRUE
      REFCLK_FREQUENCY      => 200.0,  -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
      SIGNAL_PATTERN        => "DATA"   -- DATA, CLOCK input signal
      )
    port map (
      CNTVALUEOUT => s_tap_count3,      -- 5-bit output: Counter value output
      DATAOUT     => s_ttc_stream_4,    -- 1-bit output: Delayed data output
      C           => clk_x4_i,          -- 1-bit input: Clock input
      CE          => tap_en_i(2),  -- 1-bit input: Active high enable increment/decrement input
      CINVCTRL    => '0',  -- 1-bit input: Dynamic clock inversion input
      CNTVALUEIN  => "00000",           -- 5-bit input: Counter value input
      DATAIN      => s_ttc_stream_3,  -- 1-bit input: Internal delay data input
      IDATAIN     => '0',               -- 1-bit input: Data input from the I/O
      INC         => tap_incr_i,  -- 1-bit input: Increment / Decrement tap delay input
      LD          => s_rst or tap_load_i,  -- 1-bit input: Load IDELAY_VALUE input
      LDPIPEEN    => '0',  -- 1-bit input: Enable PIPELINE register to load data input
      REGRST      => '0'   -- 1-bit input: Active-high reset tap-delay input
      );

  IDELAYE2_4 : IDELAYE2
    generic map (
      CINVCTRL_SEL          => "FALSE",  -- Enable dynamic clock inversion (FALSE, TRUE)
      DELAY_SRC             => "DATAIN",   -- Delay input (IDATAIN, DATAIN)
      HIGH_PERFORMANCE_MODE => "TRUE",  -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
      IDELAY_TYPE           => "VARIABLE",  -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      IDELAY_VALUE          => 0,       -- Input delay tap setting (0-31)
      PIPE_SEL              => "FALSE",  -- Select pipelined mode, FALSE, TRUE
      REFCLK_FREQUENCY      => 200.0,  -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
      SIGNAL_PATTERN        => "DATA"   -- DATA, CLOCK input signal
      )
    port map (
      CNTVALUEOUT => s_tap_count4,      -- 5-bit output: Counter value output
      DATAOUT     => ttc_stream_o,      -- 1-bit output: Delayed data output
      C           => clk_x4_i,          -- 1-bit input: Clock input
      CE          => tap_en_i(3),  -- 1-bit input: Active high enable increment/decrement input
      CINVCTRL    => '0',  -- 1-bit input: Dynamic clock inversion input
      CNTVALUEIN  => "00000",           -- 5-bit input: Counter value input
      DATAIN      => s_ttc_stream_4,  -- 1-bit input: Internal delay data input
      IDATAIN     => '0',               -- 1-bit input: Data input from the I/O
      INC         => tap_incr_i,  -- 1-bit input: Increment / Decrement tap delay input
      LD          => s_rst or tap_load_i,  -- 1-bit input: Load IDELAY_VALUE input
      LDPIPEEN    => '0',  -- 1-bit input: Enable PIPELINE register to load data input
      REGRST      => '0'   -- 1-bit input: Active-high reset tap-delay input
      );

  p_tap_count : process(clk_x4_i)
  begin
    if rising_edge(clk_x4_i) then
      tap_count_o <= std_logic_vector(resize(unsigned(s_tap_count1), 7) + resize(unsigned(s_tap_count2), 7)
                                      + resize(unsigned(s_tap_count3), 7) + resize(unsigned(s_tap_count4), 7));
    end if;
  end process;

end generate GEN_IDELAY;

             GEN_NO_IDELAY : if not g_use_idelay generate
               ttc_stream_o       <= s_ttc_stream;
               tap_count_o        <= (others => '0');
               delay_ctrl_ready_o <= '0';
             end generate GEN_NO_IDELAY;

---------------------------------------TDM----------------------------------------

                             s_bmc_data_in <= l1a_i when s_sel = '0' else
                                              s_chb;

--   p_toggle : process(clk_x2_i)
--   begin
--     if rising_edge(clk_x2_i) then
--       if s_rst = '1' then
--         s_sel <= '0';
--       else
--         s_sel <= not s_sel;
--       end if;
--     end if;
--   end process;

--------------------------------------CHB FSM--------------------------------------
                             Inst_chb_fsm : chb_shift_ctrl
                               generic map (
                                 g_cnt_width => 6
                                 )
                               port map (
                                 clk_i           => clk_x4_i,
                                 reset_i         => s_rst,
                                 brdcst_strobe_i => s_brdcst_strobe,
                                 long_strobe_i   => s_long_strobe,
                                 brdcst_frame_i  => s_brdcst_frame,
                                 long_frame_i    => s_long_frame,
                                 sbit_err_inj_i  => sbit_err_inj_i,
                                 dbit_err_inj_i  => dbit_err_inj_i,
                                 err_pos1_i      => err_pos1_i,
                                 err_pos2_i      => err_pos2_i,
                                 chb_o           => s_chb,
                                 chb_busy_o      => s_chb_busy
                                 );


                             Inst_chb_busy_fall_edge_detect : entity work.f_edge_detect
                               generic map(
                                 g_clk_rise => "TRUE"
                                 )
                               port map(
                                 clk_i => clk_x4_i,
                                 sig_i => s_chb_busy,
                                 sig_o => s_chb_released
                                 );




------------------------------broadcast frame maker--------------------------------
                             -- Comment: at each ttc_sys_clock_i cycle, upon strobe request, creates a 16 bits 
                             -- broadcast frame as defined below: 
                             -- 00SSSSSSEBHHHHH1: S=Command/Data, 6 bits. E=Event Counter Reset, 1 bit. 
                             -- B=local Time Counter Reset, 1 bit. H=Hamming Code, 5 bits.

                             Inst_broadcast_frame_maker : broadcast_frame_maker
                               port map (
                                 reset_i         => s_rst,
                                 clk_i           => clk_x4_i,
                                 brdcst_cmd_i    => s_brdcst_cmd,
                                 ecntrst_i       => s_ecntrst,
                                 bcntrst_i       => s_bcntrst,
                                 brdcst_strobe_i => s_brd_strobe,
                                 brdcst_frame_o  => s_brdcst_frame,
                                 strobe_o        => s_brdcst_strobe
                                 );

--------------------------------long frame maker-----------------------------------   
                             -- Comment: at each ttc_sys_clock_i cycle, upon strobe request, creates a 42 bits 
                             -- individually addressed frame as defined below: 
                             -- 01AAAAAAAAAAAAAAAASSSSSSSSDDDDDDDDHHHHHHH1: A= TTCrx address, 16 bits.
                             -- S=SubAddress, 8 bits. D=Data, 8 bits. H=Hamming Code, 7 bits. 

                             Inst_long_frame_maker : long_frame_maker
                               port map (
                                 reset_i               => s_rst,
                                 clk_i                 => clk_x4_i,
                                 long_address_i        => s_long_address_i,
                                 long_subadd_i         => s_long_subadd_i,
                                 long_data_i           => s_long_data_i,
                                 long_command_strobe_i => s_long_cmd_strobe_i,
                                 long_frame_o          => s_long_frame,
                                 strobe_o              => s_long_strobe
                                 );

---------------------------------chb traffic light--------------------------------

                             Inst_chb_traffic_light : chb_traffic_light
                               port map(
                                 clk_i          => clk_x4_i,
                                 rst_i          => s_rst,
                                 synch_i        => s_tdm_synch,
                                 chb_released_i => s_chb_released,
                                 chb_req1_i     => chb_req1_i,
                                 chb_req2_i     => chb_req2_i,
                                 chb_req3_i     => chb_req3_i,
                                 chb_req4_i     => chb_req4_i,
                                 chb_grant1_o   => s_chb_grant1,
                                 chb_grant2_o   => s_chb_grant2,
                                 chb_grant3_o   => s_chb_grant3,
                                 chb_grant4_o   => s_chb_grant4,
                                 chb_busy_o     => chb_busy_o
                                 );

                             chb_grant1_o <= s_chb_grant1;
                             chb_grant2_o <= s_chb_grant2;
                             chb_grant3_o <= s_chb_grant3;
                             chb_grant4_o <= s_chb_grant4;

                             end rtl;


