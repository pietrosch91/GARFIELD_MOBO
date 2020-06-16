-------------------------------------------------------------------------------
-- Title      : l1 cache
-- Project    : 
-------------------------------------------------------------------------------
-- File       : l1_cache.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    : 
-- Created    : 2018-03-13
-- Last update: 2019-07-05
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description:random access l1 cache
-------------------------------------------------------------------------------
-- Copyright (c) 2018 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-03-13  1.0      antonio Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ipbus.all;
use work.ipbus_reg_types.all;
use IEEE.math_real.all;
entity l1_cache is

  generic (
    channel_number : integer := 0;
    g_d_size       : integer := 16;
    g_a_size       : integer := 4);

  port (
    -- ip bus interface
    clk              : in  std_logic;
    reset            : in  std_logic;
    ipbus_in         : in  ipb_wbus;
    ipbus_out        : out ipb_rbus;
    -- 
    gcu_id           : in  std_logic_vector(15 downto 0);
    adc_data_i       : in  std_logic_vector (127 downto 0);
    adc_clk_i        : in  std_logic;
    pkg_data_o       : out std_logic_vector(127 downto 0);
    valid_data_o     : out std_logic;
    Trig_time        : in  std_logic_vector(47 downto 0);
    local_time       : in  std_logic_vector(47 downto 0);
    Validated_trig_i : in  std_logic;
    Trig_o           : out std_logic
    );

end l1_cache;


architecture str of l1_cache is
  -----------------------------------------------------------------------------
  -- adc data alias definitions 
  -----------------------------------------------------------------------------

  alias adc_data_word_0 : std_logic_vector(15 downto 0) is adc_data_i(15 downto 0);
  alias adc_data_word_1 : std_logic_vector(15 downto 0) is adc_data_i(31 downto 16);
  alias adc_data_word_2 : std_logic_vector(15 downto 0) is adc_data_i(47 downto 32);
  alias adc_data_word_3 : std_logic_vector(15 downto 0) is adc_data_i(63 downto 48);
  alias adc_data_word_4 : std_logic_vector(15 downto 0) is adc_data_i(79 downto 64);
  alias adc_data_word_5 : std_logic_vector(15 downto 0) is adc_data_i(95 downto 80);
  alias adc_data_word_6 : std_logic_vector(15 downto 0) is adc_data_i(111 downto 96);
  alias adc_data_word_7 : std_logic_vector(15 downto 0) is adc_data_i(127 downto 112);

  signal adc_data_word_0_padded : std_logic_vector(18 downto 0);
  signal adc_data_word_1_padded : std_logic_vector(18 downto 0);
  signal adc_data_word_2_padded : std_logic_vector(18 downto 0);
  signal adc_data_word_3_padded : std_logic_vector(18 downto 0);
  signal adc_data_word_4_padded : std_logic_vector(18 downto 0);
  signal adc_data_word_5_padded : std_logic_vector(18 downto 0);
  signal adc_data_word_6_padded : std_logic_vector(18 downto 0);
  signal adc_data_word_7_padded : std_logic_vector(18 downto 0);
  -----------------------------------------------------------------------------
  -- IPBUS registers address  definition
  -----------------------------------------------------------------------------
  constant IPBUS_ADDR_WIDTH     : integer := 3;
  alias reg_address             : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) is ipbus_in.ipb_addr(IPBUS_ADDR_WIDTH - 1 downto 0);

  -- constant CONTROL_REG_ADDR    : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := std_logic_vector(to_unsigned(4, IPBUS_ADDR_WIDTH));
  -- constant PRE_TRIGGER_ADDR    : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := std_logic_vector(to_unsigned(0, IPBUS_ADDR_WIDTH));
  -- constant TRIGGER_WINDOW_ADDR : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := std_logic_vector(to_unsigned(1, IPBUS_ADDR_WIDTH));
  -- constant TRIGGER_RATE_ADDR   : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := std_logic_vector(to_unsigned(2, IPBUS_ADDR_WIDTH));
  -- constant TRIGGER_THRESH_ADDR : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := std_logic_vector(to_unsigned(3, IPBUS_ADDR_WIDTH));

  constant PRE_TRIGGER_ADDR          : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := "000";
  constant TRIGGER_WINDOW_ADDR       : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := "001";
  constant TRIGGER_RATE_ADDR         : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := "010";
  constant TRIGGER_THRESH_ADDR       : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := "011";
  constant CONTROL_REG_ADDR          : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := "100";
  constant TRIGGER_TSTAMP_L_REG_ADDR : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := "101";
  constant TRIGGER_TSTAMP_H_REG_ADDR : std_logic_vector(IPBUS_ADDR_WIDTH - 1 downto 0) := "110";

  constant PRE_TIRGGER_DEFAULT_VAL       : integer := 40;
  constant TRIGGER_WINDOW_DEFAULT_VAL    : integer := 60;
  constant TRIGGER_THRESHOLD_DEFAULT_VAL : integer := 9500;

  signal control_register : std_logic_vector(31 downto 0) := X"00000002";
  alias soft_reset        : std_logic is control_register(0);
  alias align_l1_cache    : std_logic is control_register(1);


  constant zero_pad_to_32_pre_trigger : std_logic_vector(32 - g_a_size - 1 downto 0) := (others => '0');
  signal pre_trigger                  : unsigned(g_a_size - 1 downto 0)              := to_unsigned(PRE_TIRGGER_DEFAULT_VAL, g_a_size);
  signal window_start                 : unsigned(g_a_size - 1 downto 0);

  constant zero_pad_to_32_trigger_window : std_logic_vector(32 - g_a_size - 1 downto 0) := (others => '0');
  constant zero_pad_to_48_trigger_time   : std_logic_vector(48 - g_a_size - 1 downto 0) := (others => '0');
  constant zero_pad_to_16_trigger_window : std_logic_vector(16 - g_a_size - 1 downto 0) := (others => '0');
  signal trigger_window                  : unsigned(g_a_size - 1 downto 0)              := to_unsigned(TRIGGER_WINDOW_DEFAULT_VAL, g_a_size);
  signal trigger_window_sync             : unsigned(g_a_size - 1 downto 0);


  constant zero_pad_to_32_trigger_threshold : std_logic_vector(15 downto 0) := (others => '0');
  signal trigger_threshold                  : unsigned(15 downto 0)         := to_unsigned(TRIGGER_THRESHOLD_DEFAULT_VAL, 16);

  signal trigger_rate          : unsigned(31 downto 0);
  -----------------------------------------------------------------------------
  -- state machine signals
  -----------------------------------------------------------------------------
  type state_t is (idle_st, prepare_ph0_st, prepare_ph1_st, prepare_ph2_st, start_frame_st, payload_frame_st, stop_frame_ph0_st, stop_frame_ph1_st);
  signal sm_state              : state_t;
  signal sm_counter            : unsigned(g_a_size - 1 downto 0) := (others => '0');
  signal read_pointer          : unsigned(g_a_size - 1 downto 0) := (others => '0');
  signal write_pointer         : unsigned(g_a_size - 1 downto 0) := (others => '0');
  signal delta                 : unsigned(g_a_size - 1 downto 0) := (others => '0');
  signal write_pointer_latched : unsigned(g_a_size - 1 downto 0) := (others => '0');
  signal trig_time_latched     : unsigned(g_a_size - 1 downto 0) := (others => '0');
  signal trig_timestamp        : std_logic_vector(47 downto 0);
  signal pkg_header            : std_logic_vector(127 downto 0);
  signal pkg_trailer           : std_logic_vector(127 downto 0);
  signal mem_out_buffer        : std_logic_vector(127 downto 0);
  signal trigger_number        : unsigned(15 downto 0)           := (others => '0');
  signal Validated_trig_s      : std_logic;
  -----------------------------------------------------------------------------
  -- RAM definition
  -----------------------------------------------------------------------------
  type RAM is array (integer range <>)of std_logic_vector (127 downto 0);
  constant MEM_DEPTH           : integer                         := 2**g_a_size;
  signal mem                   : RAM(0 to MEM_DEPTH -1)          := (others => (others => '0'));
  signal current_address       : unsigned(g_a_size - 1 downto 0) := (others => '0');

  -----------------------------------------------------------------------------
  -- Moving average registers
  -----------------------------------------------------------------------------
  constant AVERAGE_LEN      : integer := 4;
  constant ADC_CLK_FREQ     : integer := 125_000_000;  -- adc clk frquency (divided by 8)
  type moving_average_reg_t is array (integer range <>) of std_logic_vector(15 downto 0);
  signal moving_average_reg : moving_average_reg_t(0 to AVERAGE_LEN);
--  signal sum                : unsigned(integer(ceil(log2(real(AVERAGE_LEN)))) + 15 downto 0);
  signal sum                : unsigned(18 downto 0);
  signal average            : unsigned(15 downto 0);
begin  -- str
  assert g_a_size < 48 report "g_a_size is TOO big" severity failure;

  -----------------------------------------------------------------------------
  -- Trigger primitive generation
  -----------------------------------------------------------------------------
  adc_data_word_0_padded <= "000" & adc_data_word_0;
  adc_data_word_1_padded <= "000" & adc_data_word_1;
  adc_data_word_2_padded <= "000" & adc_data_word_2;
  adc_data_word_3_padded <= "000" & adc_data_word_3;
  adc_data_word_4_padded <= "000" & adc_data_word_4;
  adc_data_word_5_padded <= "000" & adc_data_word_5;
  adc_data_word_6_padded <= "000" & adc_data_word_6;
  adc_data_word_7_padded <= "000" & adc_data_word_7;

  -- "Moving" average calculation
  process (adc_clk_i) is
  begin  -- process
    if rising_edge(adc_clk_i) then      -- rising clock edge
      sum <= ((unsigned(adc_data_word_0_padded) +
               unsigned(adc_data_word_1_padded)) +
              (unsigned(adc_data_word_2_padded) +
               unsigned(adc_data_word_3_padded))) +
             ((unsigned(adc_data_word_4_padded) +
               unsigned(adc_data_word_5_padded)) +
              (unsigned(adc_data_word_6_padded) +
               unsigned(adc_data_word_7_padded)));
      average <= sum(18 downto 3);
      if average < trigger_threshold then
        Trig_o <= '1';
      else
        Trig_o <= '0';
      end if;
    end if;
  end process;

  -- Trigger in counters
  -----------------------------------------------------------------------------
  --   L1 cache memory management
  -----------------------------------------------------------------------------
  -- purpose: L1 cache continously filled by ADC data
  -- type   : sequential
  -- inputs : adc_clk_i, reset
  -- outputs: mem
  write_pointer_manager : process (adc_clk_i) is
    type state_t is (idle_st, clock_not_present_st, clock_present_st, l1_cache_aligned_st);
    variable state      : state_t := idle_st;
    variable counter    : integer := 0;
    constant ONE_SECOND : integer := 125_000_000;
  begin  -- process write_pointer_manager
    if rising_edge(adc_clk_i) then      -- rising clock edge
      case state is
        when idle_st =>
          counter       := 0;
          write_pointer <= (others => '0');
          state         := clock_not_present_st;
        when clock_not_present_st =>
          counter := counter + 1;
          if counter = ONE_SECOND then
            state := clock_present_st;
          end if;
        when clock_present_st =>
          if unsigned(local_time(g_a_size - 1 downto 0)) = 0 then
            state         := l1_cache_aligned_st;
            write_pointer <= to_unsigned(1, g_a_size);
          end if;
        when l1_cache_aligned_st =>
          write_pointer <= write_pointer + 1;
          if unsigned(local_time(g_a_size - 1 + 9 downto 0)) = 0 and align_l1_cache = '1' then
            write_pointer <= (others => '0');
          end if;
          null;
        when others =>
          state := idle_st;
      end case;
    end if;
  end process write_pointer_manager;
  -----------------------------------------------------------------------------
  continous_fill : process (adc_clk_i) is
  begin  -- process continous_fill
    if rising_edge(adc_clk_i) then      -- rising clock edge
      mem(to_integer(write_pointer)) <= adc_data_i;
    end if;
  end process continous_fill;
  -----------------------------------------------------------------------------
  read_ram : process (adc_clk_i) is
  begin  -- process read_ram
    if rising_edge(adc_clk_i) then      -- rising clock edge
      mem_out_buffer <= mem(to_integer(read_pointer));
    end if;
  end process read_ram;
  -----------------------------------------------------------------------------
  -- Header and trailer definitions
  -----------------------------------------------------------------------------
  sync_trigger_window: for i in trigger_window'range generate
    
  synchronizer_1: entity work.synchronizer
    generic map (
      NUM_FLIP_FLOPS => 2)
    port map (
      rst      => reset,
      clk      => adc_clk_i,
      data_in  => trigger_window(i),
      data_out => trigger_window_sync(i) );
  end generate sync_trigger_window;

  pkg_header <= X"805a" &
                std_logic_vector(to_unsigned(channel_number, 16)) &
                zero_pad_to_16_trigger_window &
                std_logic_vector(trigger_window_sync) &
                --std_logic_vector(delta) &
                --X"0000" &
                std_logic_vector(trigger_number) &
                X"0000" &
                -- zero_pad_to_48_trigger_time &
                -- std_logic_vector(trig_time_latched);
                trig_timestamp;
  pkg_trailer <= X"55aa" &
                 X"0123" &
                 X"4567" &
                 X"89ab" &
                 X"cdef" &
                 X"ff00" &
                 gcu_id &
                 X"0869";
  -----------------------------------------------------------------------------
  -- Main packager state machine + Flag generator for validate_trigger
  -----------------------------------------------------------------------------
  edge_detector_1 : entity work.edge_detector
    port map (
      clk   => adc_clk_i,
      rst   => reset,
      input => Validated_trig_i,
      pulse => Validated_trig_s);
  -----------------------------------------------------------------------------
  frame_extraction_sm : process (adc_clk_i) is
  begin  -- process frame_extraction_sm
    if rising_edge(adc_clk_i) then      -- rising clock edge
      if reset = '1' or soft_reset = '1' then  -- synchronous reset (active high)
        sm_state     <= idle_st;
        read_pointer <= (others => '0');
        sm_counter   <= (others => '0');
      else
        case sm_state is
          when idle_st =>
            valid_data_o <= '0';
            sm_counter   <= (others => '0');
            if Validated_trig_s = '1' then
              trig_time_latched <= unsigned(Trig_time(g_a_size - 1 downto 0));
              trig_timestamp    <= Trig_time;
              trigger_number    <= trigger_number + 1;
              delta             <= unsigned(local_time(g_a_size - 1 downto 0));
              --  write_pointer_latched <= write_pointer;
              sm_state          <= prepare_ph0_st;
            end if;
          when prepare_ph0_st =>
            window_start <= (trig_time_latched - pre_trigger);
            sm_state     <= prepare_ph1_st;
          when prepare_ph1_st =>
            read_pointer <= window_start;
            sm_counter   <= sm_counter + 1;
            sm_state     <= prepare_ph2_st;
          when prepare_ph2_st =>
            sm_counter   <= sm_counter + 1;
            read_pointer <= window_start + sm_counter;
            sm_state     <= start_frame_st;
          when start_frame_st =>
            valid_data_o <= '1';
            pkg_data_o   <= pkg_header;
            -- prepare read pointer for the payload frame extraction
            sm_counter   <= sm_counter + 1;
            read_pointer <= window_start + sm_counter;
            sm_state     <= payload_frame_st;
          when payload_frame_st =>
            sm_counter   <= sm_counter + 1;
            read_pointer <= window_start + sm_counter;
            pkg_data_o   <= mem_out_buffer;
            if sm_counter = trigger_window then
              sm_state <= stop_frame_ph0_st;
            end if;
          when stop_frame_ph0_st =>
            pkg_data_o <= pkg_trailer;
            sm_state   <= stop_frame_ph1_st;
          when stop_frame_ph1_st =>     -- 2 phases are needed to generate the
            -- valid data <='0' with 1 clock cycle delay
            sm_state <= idle_st;
          when others =>
            sm_state <= idle_st;
        end case;
      end if;
    end if;
  end process frame_extraction_sm;

-----------------------------------------------------------------------------
-- IPBus engine
-----------------------------------------------------------------------------

-- ipbus write process (synchronous with ipb clk ) 
  ipbus_write : process (clk) is
  begin  -- process ipbus_manager
    if rising_edge(clk) then            -- rising clock edge
      if reset = '1' then               -- synchronous reset (active high)
        null;
      elsif ipbus_in.ipb_strobe = '1' and ipbus_in.ipb_write = '1' then
        case reg_address is
          when CONTROL_REG_ADDR =>
            control_register <= ipbus_in.ipb_wdata;
          when PRE_TRIGGER_ADDR =>
            pre_trigger <= unsigned(ipbus_in.ipb_wdata(g_a_size - 1 downto 0));
          when TRIGGER_WINDOW_ADDR =>
            trigger_window <= unsigned(ipbus_in.ipb_wdata(g_a_size - 1 downto 0));
          when TRIGGER_THRESH_ADDR =>
            trigger_threshold <= unsigned(ipbus_in.ipb_wdata(trigger_threshold'high downto 0));
          when others => null;
        end case;
      end if;
      if soft_reset = '1' then
        soft_reset        <= '0';
        -- restoring default values
        trigger_threshold <= to_unsigned(TRIGGER_THRESHOLD_DEFAULT_VAL, 16);
        trigger_window    <= to_unsigned(TRIGGER_WINDOW_DEFAULT_VAL, g_a_size);
        pre_trigger       <= to_unsigned(PRE_TIRGGER_DEFAULT_VAL, g_a_size);
      end if;
    end if;
  end process ipbus_write;

-- purpose: pure combinatorial readback process
-- type   : combinational
-- inputs : all
-- outputs: ipbus_out
  ipbus_read : process (pre_trigger, reg_address, trigger_window) is
  begin  -- process ipbus_read
    case reg_address is
      when PRE_TRIGGER_ADDR =>
        ipbus_out.ipb_rdata <= zero_pad_to_32_pre_trigger & std_logic_vector(pre_trigger);
      when TRIGGER_WINDOW_ADDR =>
        ipbus_out.ipb_rdata <= zero_pad_to_32_trigger_window & std_logic_vector(trigger_window);
      when TRIGGER_THRESH_ADDR =>
        ipbus_out.ipb_rdata <= zero_pad_to_32_trigger_threshold & std_logic_vector(trigger_threshold);
      when TRIGGER_RATE_ADDR =>
        ipbus_out.ipb_rdata <= std_logic_vector(trigger_rate);
      when TRIGGER_TSTAMP_L_REG_ADDR =>
        ipbus_out.ipb_rdata <= trig_timestamp(31 downto 0);
      when TRIGGER_TSTAMP_H_REG_ADDR =>
        ipbus_out.ipb_rdata <= X"0000" & trig_timestamp(47 downto 32);
      when others => null;
    end case;
  end process ipbus_read;

  ipbus_out.ipb_ack <= ipbus_in.ipb_strobe;
  ipbus_out.ipb_err <= '0';

end str;
