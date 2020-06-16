-------------------------------------------------------------------------------
-- Title      : clk wizard
-- Project    : 
-------------------------------------------------------------------------------
-- File       : clk_wiz.vhd
-- Author     : Filippo Marini   <filippo.marini@pd.infn.it>
-- Company    : Universita degli studi di Padova
-- Created    : 2019-05-03
-- Last update: 2019-10-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MMCM for clock generation 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 Universita degli studi di Padova
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-03  1.0      filippo Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;


entity clk_wiz is
  port (
    clk_in1   : in  std_logic;          -- 125 MHz
    clk_in2   : in  std_logic;          -- 125 MHz
    clkin_sel : in  std_logic;
    reset     : in  std_logic;
    clk_out0  : out std_logic;          -- 125 MHz
    clk_out1  : out std_logic;          -- 250 MHz
    clk_out2  : out std_logic;          -- 200 MHz
    clk_out3  : out std_logic;          -- 100 MHz
    clk_out4  : out std_logic;          -- 125 MHz 90 degrees shift
    clk_out5  : out std_logic;          -- 31.25 MHz  for Si5345 reference
    locked    : out std_logic);
end entity clk_wiz;

architecture behavioural of clk_wiz is

  signal clk_fbout           : std_logic;
  signal clk_fbout_in        : std_logic;
  signal clk_fboutb_unused   : std_logic;
  signal clk_out0_in         : std_logic;
  signal clk_out0b_unused    : std_logic;
  signal clk_out1_in         : std_logic;
  signal clk_out1b_unused    : std_logic;
  signal clk_out2_in         : std_logic;
  signal clk_out2b_unused    : std_logic;
  signal clk_out3_in         : std_logic;
  signal clk_out3b_unused    : std_logic;
  signal clk_out4_in         : std_logic;
  signal clk_out5_in         : std_logic;
  signal clk_out5b_unused    : std_logic;
  signal clk_out6_unused     : std_logic;
  signal do_unused           : std_logic_vector(15 downto 0);
  signal drdy_unused         : std_logic;
  signal psdone_unused       : std_logic;
  signal clkinstopped_unused : std_logic;
  signal clkfbstopped_unused : std_logic;


begin

  -----------------------------------------------------------------------------
  -- MMCM Instantiation
  -----------------------------------------------------------------------------
  mmcm_adv_inst : MMCME2_ADV
    generic map
    (BANDWIDTH          => "OPTIMIZED",
     COMPENSATION       => "ZHOLD",
     DIVCLK_DIVIDE      => 1,
     CLKFBOUT_MULT_F    => 8.000,
     CLKFBOUT_PHASE     => 0.000,
     CLKOUT0_DIVIDE_F   => 8.000,
     CLKOUT0_PHASE      => 0.000,
     CLKOUT0_DUTY_CYCLE => 0.500,
     CLKOUT1_DIVIDE     => 4,
     CLKOUT1_PHASE      => 0.000,
     CLKOUT1_DUTY_CYCLE => 0.500,
     CLKOUT2_DIVIDE     => 5,
     CLKOUT2_PHASE      => 0.000,
     CLKOUT2_DUTY_CYCLE => 0.500,
     CLKOUT3_DIVIDE     => 10,
     CLKOUT3_PHASE      => 0.000,
     CLKOUT3_DUTY_CYCLE => 0.500,
     CLKOUT4_DIVIDE     => 8,
     CLKOUT4_PHASE      => 90.000,
     CLKOUT4_DUTY_CYCLE => 0.500,
     CLKOUT5_DIVIDE     => 32,
     CLKOUT5_PHASE      => 0.000,
     CLKOUT5_DUTY_CYCLE => 0.500,
     CLKIN1_PERIOD      => 16.000,
     CLKIN2_PERIOD      => 16.000,
     REF_JITTER1        => 0.010)
    port map
    -- Output clocks
    (CLKFBOUT     => clk_fbout_in,
     CLKFBOUTB    => clk_fboutb_unused,
     CLKOUT0      => clk_out0_in,
     CLKOUT0B     => clk_out0b_unused,
     CLKOUT1      => clk_out1_in,
     CLKOUT1B     => clk_out1b_unused,
     CLKOUT2      => clk_out2_in,
     CLKOUT2B     => clk_out2b_unused,
     CLKOUT3      => clk_out3_in,
     CLKOUT3B     => clk_out3b_unused,
     CLKOUT4      => clk_out4_in ,
     CLKOUT5      => clk_out5_in,
     CLKOUT6      => clk_out6_unused,
     -- Input clock control
     CLKFBIN      => clk_fbout,
     CLKIN1       => clk_in1,
     CLKIN2       => clk_in2,
     -- Tied to always select the primary input clock
     CLKINSEL     => clkin_sel,
     -- Ports for dynamic reconfiguration
     DADDR        => (others => '0'),
     DCLK         => '0',
     DEN          => '0',
     DI           => (others => '0'),
     DO           => do_unused,
     DRDY         => drdy_unused,
     DWE          => '0',
     -- Ports for dynamic phase shift
     PSCLK        => '0',
     PSEN         => '0',
     PSINCDEC     => '0',
     PSDONE       => psdone_unused,
     -- Other control and status signals
     LOCKED       => locked,
     CLKINSTOPPED => clkinstopped_unused,
     CLKFBSTOPPED => clkfbstopped_unused,
     PWRDWN       => '0',
     RST          => reset);

  -------------------------------------------------------------------------------
  -- Output buffers
  -------------------------------------------------------------------------------
  clkfbout_buf : BUFG
    port map (
      O => clk_fbout,                   -- 1-bit output: Clock output
      I => clk_fbout_in                 -- 1-bit input: Clock input
      );

  clkout0_buf : BUFGCE
    port map
    (O  => clk_out0,
     CE => '1',
     I  => clk_out0_in);

  clkout1_buf : BUFGCE
    port map
    (O  => clk_out1,
     CE => '1',
     I  => clk_out1_in);

  clkout2_buf : BUFGCE
    port map
    (O  => clk_out2,
     CE => '1',
     I  => clk_out2_in);

  clkout3_buf : BUFGCE
    port map
    (O  => clk_out3,
     CE => '1',
     I  => clk_out3_in);

  clkout4_buf : BUFGCE
    port map
    (O  => clk_out4,
     CE => '1',
     I  => clk_out4_in);

  clkout5_buf : BUFGCE
    port map
    (O  => clk_out5,
     CE => '1',
     I  => clk_out5_in);

end architecture behavioural;
