-- file: tri_mode_ethernet_mac_0_clk_wiz.vhd
--
-- -----------------------------------------------------------------------------
-- (c) Copyright 2008-2013 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- -----------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
-- Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
------------------------------------------------------------------------------
-- CLK_OUT1   125.000      0.000      50.0       91.364     85.928
-- CLK_OUT2   100.000      0.000      50.0       70.716     85.928

-- CLK_OUT2   200.000      0.000      50.0            

--
------------------------------------------------------------------------------
-- Input Clock   Input Freq (MHz)   Input Jitter (UI)
------------------------------------------------------------------------------
-- primary         200.000            0.010

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity tri_mode_ethernet_mac_0_clk_wiz is
  port
    (                                   -- Clock in ports
      CLK_IN1  : in  std_logic;
      -- Clock out ports
      CLK_OUT1 : out std_logic;
      CLK_OUT2 : out std_logic;
      CLK_OUT3 : out std_logic;
      CLK_OUT4 : out std_logic;
      -- Status and control signals
      RESET    : in  std_logic;
      LOCKED   : out std_logic
      );
end tri_mode_ethernet_mac_0_clk_wiz;

architecture xilinx of tri_mode_ethernet_mac_0_clk_wiz is
  -- Input clock buffering / unused connectors
  signal clkin1              : std_logic;
  -- Output clock buffering / unused connectors
  signal clkfbout            : std_logic;
  signal clkfboutb_unused    : std_logic;
  signal clkout0             : std_logic;
  signal clkout0b_unused     : std_logic;
  signal clkout1             : std_logic;
  signal clkout1b_unused     : std_logic;
  signal clkout2             : std_logic;
  signal clkout2b_unused     : std_logic;
  signal clkout3             : std_logic;
  signal clkout3b_unused     : std_logic;
  signal clkout4_unused      : std_logic;
  signal clkout5_unused      : std_logic;
  signal clkout6_unused      : std_logic;
  -- Dynamic programming unused signals
  signal do_unused           : std_logic_vector(15 downto 0);
  signal drdy_unused         : std_logic;
  -- Dynamic phase shift unused signals
  signal psdone_unused       : std_logic;
  -- Unused status signals
  signal clkfbstopped_unused : std_logic;
  signal clkinstopped_unused : std_logic;

begin


  -- Clocking primitive
  --------------------------------------
  -- Instantiation of the MMCM primitive
  --    * Unused inputs are tied off
  --    * Unused outputs are labeled unused


  -- mmcm_adv_inst : MMCME2_ADV

  --   generic map
  --   (BANDWIDTH => "OPTIMIZED",

  --    COMPENSATION => "ZHOLD",

  --    DIVCLK_DIVIDE      => 1,
  --    CLKFBOUT_MULT_F    => 8.000,
  --    CLKFBOUT_PHASE     => 0.000,
  --    CLKOUT0_DIVIDE_F   => 8.000,
  --    CLKOUT0_PHASE      => 0.000,
  --    CLKOUT0_DUTY_CYCLE => 0.500,
  --    CLKOUT1_DIVIDE     => 10,
  --    CLKOUT1_PHASE      => 0.000,
  --    CLKOUT1_DUTY_CYCLE => 0.500,

  --    CLKOUT2_DIVIDE => 5,

  --    CLKOUT2_PHASE      => 0.000,
  --    CLKOUT2_DUTY_CYCLE => 0.500,

  --    CLKOUT3_DIVIDE => 8,

  --    CLKOUT3_PHASE      => 0.000,
  --    CLKOUT3_DUTY_CYCLE => 0.500,

  --    CLKIN1_PERIOD => 8.000,
  --    REF_JITTER1   => 0.010)
  --   port map
  --   -- Output clocks
  --   (CLKFBOUT  => clkfbout,
  --    CLKFBOUTB => clkfboutb_unused,
  --    CLKOUT0   => clkout0,
  --    CLKOUT0B  => clkout0b_unused,
  --    CLKOUT1   => clkout1,
  --    CLKOUT1B  => clkout1b_unused,
  --    CLKOUT2   => clkout2,
  --    CLKOUT2B  => clkout2b_unused,
  --    CLKOUT3   => clkout3,
  --    CLKOUT3B  => clkout3b_unused,
  --    CLKOUT4   => clkout4_unused,
  --    CLKOUT5   => clkout5_unused,
  --    CLKOUT6   => clkout6_unused,
  --    -- Input clock control
  --    CLKFBIN   => clkfbout,
  --    CLKIN1    => CLK_IN1,
  --    CLKIN2    => '0',
  --    -- Tied to always select the primary input clock
  --    CLKINSEL  => '1',
  --    -- Ports for dynamic reconfiguration
  --    DADDR     => (others => '0'),
  --    DCLK      => '0',
  --    DEN       => '0',
  --    DI        => (others => '0'),
  --    DO        => do_unused,
  --    DRDY      => drdy_unused,
  --    DWE       => '0',
  --    -- Ports for dynamic phase shift
  --    PSCLK     => '0',
  --    PSEN      => '0',
  --    PSINCDEC  => '0',
  --    PSDONE    => psdone_unused,

  --    -- Other control and status signals
  --    LOCKED => LOCKED,

  --    CLKINSTOPPED => clkinstopped_unused,
  --    CLKFBSTOPPED => clkfbstopped_unused,
  --    PWRDWN       => '0',
  --    RST          => RESET);

PLLE2_BASE_inst : PLLE2_BASE
   generic map (
      BANDWIDTH => "OPTIMIZED",  -- OPTIMIZED, HIGH, LOW
      CLKFBOUT_MULT => 8,        -- Multiply value for all CLKOUT, (2-64)
      CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB, (-360.000-360.000).
      CLKIN1_PERIOD => 8.0,      -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
      CLKOUT0_DIVIDE => 8,
      CLKOUT1_DIVIDE => 10,
      CLKOUT2_DIVIDE => 5,
      CLKOUT3_DIVIDE => 8,
      CLKOUT4_DIVIDE => 1,
      CLKOUT5_DIVIDE => 1,
      -- CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
      CLKOUT0_DUTY_CYCLE => 0.5,
      CLKOUT1_DUTY_CYCLE => 0.5,
      CLKOUT2_DUTY_CYCLE => 0.5,
      CLKOUT3_DUTY_CYCLE => 0.5,
      CLKOUT4_DUTY_CYCLE => 0.5,
      CLKOUT5_DUTY_CYCLE => 0.5,
      -- CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      CLKOUT0_PHASE => 0.0,
      CLKOUT1_PHASE => 0.0,
      CLKOUT2_PHASE => 0.0,
      CLKOUT3_PHASE => 0.0,
      CLKOUT4_PHASE => 0.0,
      CLKOUT5_PHASE => 0.0,
      DIVCLK_DIVIDE => 1,        -- Master division value, (1-56)
      REF_JITTER1 => 0.0,        -- Reference input jitter in UI, (0.000-0.999).
      STARTUP_WAIT => "FALSE"    -- Delay DONE until PLL Locks, ("TRUE"/"FALSE")
   )
   port map (
      -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
      CLKOUT0 => CLKOUT0,   -- 1-bit output: CLKOUT0
      CLKOUT1 => CLKOUT1,   -- 1-bit output: CLKOUT1
      CLKOUT2 => CLKOUT2,   -- 1-bit output: CLKOUT2
      CLKOUT3 => CLKOUT3,   -- 1-bit output: CLKOUT3
      CLKOUT4 => CLKOUT4_unused,   -- 1-bit output: CLKOUT4
      CLKOUT5 => CLKOUT5_unused,   -- 1-bit output: CLKOUT5
      -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
      CLKFBOUT => clkfbout, -- 1-bit output: Feedback clock
      LOCKED => LOCKED,     -- 1-bit output: LOCK
      CLKIN1 => CLK_IN1,     -- 1-bit input: Input clock
      -- Control Ports: 1-bit (each) input: PLL control ports
      PWRDWN => '0',     -- 1-bit input: Power-down
      RST => RESET,           -- 1-bit input: Reset
      -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
      CLKFBIN => clkfbout    -- 1-bit input: Feedback clock
   );

  -- Output buffering
  -------------------------------------

  clkout1_buf : BUFGCE
    port map
    (O  => CLK_OUT1,
     CE => '1',
     I  => clkout0);

  clkout2_buf : BUFGCE
    port map
    (O  => CLK_OUT2,
     CE => '1',
     I  => clkout1);

  clkout3_buf : BUFGCE
    port map
    (O  => CLK_OUT3,
     CE => '1',
     I  => clkout2);


  clkout4_buf : BUFGCE
    port map
    (O  => CLK_OUT4,
     CE => '1',
     I  => clkout3);

end xilinx;
