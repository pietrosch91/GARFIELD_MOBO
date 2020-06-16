----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:08:05 09/18/2018 
-- Design Name: 
-- Module Name:    system_clocks - rtl 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity system_clocks is
    Port ( 
		sysclk_i : in  STD_LOGIC;
		sysclk_x4_o : out  STD_LOGIC;
		sysclk_idlyctrl_o : out  STD_LOGIC;
		locked_o : out  STD_LOGIC
		);
end system_clocks;

architecture rtl of system_clocks is

signal s_dcm_locked 		: std_logic;
signal s_fb_txclk,
		 s_fb_txclk_in		: std_logic;
  constant mmcm_over_pll : boolean := false;

begin

	-----------
	-- FB CLK Buffer
	-----------
	-- BUFG_SYS_CLK_FB : BUFG
  --   port map (
  --     O => s_fb_txclk,    -- fb TX PLL
  --     I => s_fb_txclk_in
  --     );
  s_fb_txclk <= s_fb_txclk_in;
	
	-----------
	-- MMCME2_ADV
	-----------
  use_mmcm: if mmcm_over_pll generate
    
	MMCME2_ADV_TX_PLL : MMCME2_ADV
		generic map (
			BANDWIDTH => "OPTIMIZED",      -- Jitter programming (OPTIMIZED, HIGH, LOW)
			CLKFBOUT_MULT_F => 16.000,        -- Multiply value for all CLKOUT (2.000-64.000).
			CLKFBOUT_PHASE => 0.0,         -- Phase offset in degrees of CLKFB (-360.000-360.000).
			-- CLKIN_PERIOD: Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
			CLKIN1_PERIOD => 8.0,
			CLKIN2_PERIOD => 0.0,
			-- CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for CLKOUT (1-128)
			CLKOUT1_DIVIDE => 5,
			CLKOUT2_DIVIDE => 1,
			CLKOUT3_DIVIDE => 1,
			CLKOUT4_DIVIDE => 1,
			CLKOUT5_DIVIDE => 1,
			CLKOUT6_DIVIDE => 1,
			CLKOUT0_DIVIDE_F => 4.000,       -- Divide amount for CLKOUT0 (1.000-128.000).
			-- CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for CLKOUT outputs (0.01-0.99).
			CLKOUT0_DUTY_CYCLE => 0.5,
			CLKOUT1_DUTY_CYCLE => 0.5,
			CLKOUT2_DUTY_CYCLE => 0.5,
			CLKOUT3_DUTY_CYCLE => 0.5,
			CLKOUT4_DUTY_CYCLE => 0.5,
			CLKOUT5_DUTY_CYCLE => 0.5,
			CLKOUT6_DUTY_CYCLE => 0.5,
			-- CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for CLKOUT outputs (-360.000-360.000).
			CLKOUT0_PHASE => 0.0,
			CLKOUT1_PHASE => 0.0,
			CLKOUT2_PHASE => 0.0,
			CLKOUT3_PHASE => 0.0,
			CLKOUT4_PHASE => 0.0,
			CLKOUT5_PHASE => 0.0,
			CLKOUT6_PHASE => 0.0,
			CLKOUT4_CASCADE => FALSE,      -- Cascade CLKOUT4 counter with CLKOUT6 (FALSE, TRUE)
			COMPENSATION => "ZHOLD",       -- ZHOLD, BUF_IN, EXTERNAL, INTERNAL
			DIVCLK_DIVIDE => 2,            -- Master division value (1-106)
			-- REF_JITTER: Reference input jitter in UI (0.000-0.999).
			REF_JITTER1 => 0.0,
			REF_JITTER2 => 0.0,
			STARTUP_WAIT => FALSE,         -- Delays DONE until MMCM is locked (FALSE, TRUE)
			-- Spread Spectrum: Spread Spectrum Attributes
			SS_EN => "FALSE",              -- Enables spread spectrum (FALSE, TRUE)
			SS_MODE => "CENTER_HIGH",      -- CENTER_HIGH, CENTER_LOW, DOWN_HIGH, DOWN_LOW
			SS_MOD_PERIOD => 10000,        -- Spread spectrum modulation period (ns) (VALUES)
			-- USE_FINE_PS: Fine phase shift enable (TRUE/FALSE)
			CLKFBOUT_USE_FINE_PS => FALSE,
			CLKOUT0_USE_FINE_PS => FALSE,
			CLKOUT1_USE_FINE_PS => FALSE,
			CLKOUT2_USE_FINE_PS => FALSE,
			CLKOUT3_USE_FINE_PS => FALSE,
			CLKOUT4_USE_FINE_PS => FALSE,
			CLKOUT5_USE_FINE_PS => FALSE,
			CLKOUT6_USE_FINE_PS => FALSE 
			)
		port map (
			-- Clock Outputs: 1-bit (each) output: User configurable clock outputs
			CLKOUT0 => sysclk_x4_o,              -- system clock 250 MHz
			CLKOUT0B => open,     
			CLKOUT1 => sysclk_idlyctrl_o,                  -- system clock 200 MHz
			CLKOUT1B => open,      
			CLKOUT2 => open,               
			CLKOUT2B => open,      
			CLKOUT3 => open,                    
			CLKOUT3B => open,         
			CLKOUT4 => open,                 
			CLKOUT5 => open,           
			CLKOUT6 => open,          
			-- DRP Ports: 16-bit (each) output: Dynamic reconfiguration ports
			DO => open,                    
			DRDY => open,                
			-- Dynamic Phase Shift Ports: 1-bit (each) output: Ports used for dynamic phase shifting of the outputs
			PSDONE => open,            
			-- Feedback Clocks: 1-bit (each) output: Clock feedback ports
			CLKFBOUT => s_fb_txclk_in,        
			CLKFBOUTB => open,       
			-- Status Ports: 1-bit (each) output: MMCM status ports
			CLKFBSTOPPED => open, 
			CLKINSTOPPED => open, 
			LOCKED => s_dcm_locked,             
			-- Clock Inputs: 1-bit (each) input: Clock inputs
			CLKIN1 => sysclk_i,             
			CLKIN2 => '0',             
			-- Control Ports: 1-bit (each) input: MMCM control ports
			CLKINSEL => '1',         
			PWRDWN => '0',           
			RST => '0',                
			-- DRP Ports: 7-bit (each) input: Dynamic reconfiguration ports
			DADDR => (others => '0'),               
			DCLK => '0',                 
			DEN => '0',                   
			DI => (others => '0'),                     
			DWE => '0',                   
			-- Dynamic Phase Shift Ports: 1-bit (each) input: Ports used for dynamic phase shifting of the outputs
			PSCLK => '0',               -- 1-bit input: Phase shift clock
			PSEN => '0',                 -- 1-bit input: Phase shift enable
			PSINCDEC => '0',         -- 1-bit input: Phase shift increment/decrement
			-- Feedback Clocks: 1-bit (each) input: Clock feedback ports
			CLKFBIN => s_fb_txclk            -- 1-bit input: Feedback clock
			);
  
  end generate use_mmcm;

  use_pll: if not mmcm_over_pll generate
    
    -----------------------------------------------------------------------------
    -- PLL
    -----------------------------------------------------------------------------
    PLLE2_BASE_inst : PLLE2_BASE
      generic map (
        BANDWIDTH => "OPTIMIZED",  -- OPTIMIZED, HIGH, LOW
        CLKFBOUT_MULT => 16,        -- Multiply value for all CLKOUT, (2-64)
        CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB, (-360.000-360.000).
        CLKIN1_PERIOD => 8.0,      -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
        -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
        CLKOUT0_DIVIDE => 4,
        CLKOUT1_DIVIDE => 5,
        CLKOUT2_DIVIDE => 1,
        CLKOUT3_DIVIDE => 1,
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
        DIVCLK_DIVIDE => 2,        -- Master division value, (1-56)
        REF_JITTER1 => 0.0,        -- Reference input jitter in UI, (0.000-0.999).
        STARTUP_WAIT => "FALSE"    -- Delay DONE until PLL Locks, ("TRUE"/"FALSE")
        )
      port map (
        -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
        CLKOUT0 => sysclk_x4_o,   -- 1-bit output: CLKOUT0
        CLKOUT1 => sysclk_idlyctrl_o,   -- 1-bit output: CLKOUT1
        CLKOUT2 => open,   -- 1-bit output: CLKOUT2
        CLKOUT3 => open,   -- 1-bit output: CLKOUT3
        CLKOUT4 => open,   -- 1-bit output: CLKOUT4
        CLKOUT5 => open,   -- 1-bit output: CLKOUT5
        -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
        CLKFBOUT => s_fb_txclk_in, -- 1-bit output: Feedback clock
        LOCKED => s_dcm_locked,     -- 1-bit output: LOCK
        CLKIN1 => sysclk_i,     -- 1-bit input: Input clock
        -- Control Ports: 1-bit (each) input: PLL control ports
        PWRDWN => '0',     -- 1-bit input: Power-down
        RST => '0',           -- 1-bit input: Reset
        -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
        CLKFBIN => s_fb_txclk    -- 1-bit input: Feedback clock
        );

  end generate use_pll;


  locked_o <= s_dcm_locked;

end rtl;

