-------------------------------------------------------------------------------
-- Title      : ethernet mac and tx/rx fifo wrapper
-- Project    :
-------------------------------------------------------------------------------
-- File       : network_interface.vhd
-- Author     : Antonio Bergnoli  <bergnoli@pd.infn.it>
-- Company    :
-- Created    : 2019-03-14
-- Last update: 2020-02-19
-- Platform   :
-- Standard   : VHDL'08
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2019
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-03-14  1.0      antonio Created
-------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- File       : tri_mode_ethernet_mac_0_example_design.vhd
-- Author     : Xilinx Inc.
-- -----------------------------------------------------------------------------
-- (c) Copyright 2004-2013 Xilinx, Inc. All rights reserved.
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
-- Description:  This is the VHDL example design for the Tri-Mode
--               Ethernet MAC core. It is intended that this example design
--               can be quickly adapted and downloaded onto an FPGA to provide
--               a real hardware test environment.
--
--               This level:
--
--               * Instantiates the FIFO Block wrapper, containing the
--                 block level wrapper and an RX and TX FIFO with an
--                 AXI-S interface;
--
--               * Instantiates transmitter clocking circuitry
--                   -the User side of the FIFOs are clocked at gtx_clk
--                    at all times
--
--               * Instantiates a state machine which drives the configuration
--                 vector to bring the TEMAC up in the correct state
--
--               * Ties unused inputs off to reduce the number of IO
--
--               Please refer to the Datasheet, Getting Started Guide, and
--               the Tri-Mode Ethernet MAC User Gude for further information.
--
--
--------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ipbus.all;
use work.ipbus_reg_types.all;
use work.global_types.all;
use work.utils_package.all;

library unisim;
use unisim.vcomponents.all;

entity network_interface is
  port (
    -- asynchronous reset
    glbl_rst        : in  std_logic;
    -- clock input from mmcm
    refclk          : in  std_logic;
    ipb_gtx_pay_clk : in  std_logic;
    gtx_clk_90      : in  std_logic;
    s_axi_aclk      : in  std_logic;
    dcm_locked      : in  std_logic;
    phy_resetn      : out std_logic;


    -- RGMII Interface
    ------------------
    rgmii_txd    : out std_logic_vector(3 downto 0);
    rgmii_tx_ctl : out std_logic;
    rgmii_txc    : out std_logic;
    rgmii_rxd    : in  std_logic_vector(3 downto 0);
    rgmii_rx_ctl : in  std_logic;
    rgmii_rxc    : in  std_logic;

    reset_error       : in  std_logic;
    -- Internal connectivity
    gcu_id_o          : out std_logic_vector(15 downto 0);
    ext_trigger       : in  std_logic;
    adc_raw_data      : in  T_SLVV_128(2 downto 0);
    adc_user_clk      : in  std_logic_vector(2 downto 0);
    adu_enables       : out std_logic_vector(2 downto 0);
    adu_clock_enables : out std_logic_vector(2 downto 0);
    bec_connected     : out std_logic;
    local_time        : in  std_logic_vector(47 downto 0);
    -- HV UART
    uart_tx_o         : out std_logic_vector(2 downto 0);
    uart_rx_i         : in  std_logic_vector(2 downto 0);
    tx_en_o           : out std_logic;
    -- debug
    l1a_time          : in  std_logic_vector(47 downto 0);
    l1a_time_ready    : in  std_logic_vector(2 downto 0);
    trig_request      : out std_logic_vector(2 downto 0);
    time_to_send      : in  std_logic_vector(31 downto 0);
    aligned_i         : in  std_logic;
    dlyctrl_ready     : in  std_logic;
    dlyctrl_reset     : in  std_logic
    );
end network_interface;

architecture wrapper of network_interface is 

  -----------------------------------------------------------------------------
  -- component declarations 
  -----------------------------------------------------------------------------
  component tri_mode_ethernet_mac_0 is
    port (
      gtx_clk                 : in  std_logic;
      gtx_clk90               : in  std_logic;
      glbl_rstn               : in  std_logic;
      rx_axi_rstn             : in  std_logic;
      tx_axi_rstn             : in  std_logic;
      rx_statistics_vector    : out std_logic_vector(27 downto 0);
      rx_statistics_valid     : out std_logic;
      rx_mac_aclk             : out std_logic;
      rx_reset                : out std_logic;
      rx_axis_mac_tdata       : out std_logic_vector(7 downto 0);
      rx_axis_mac_tvalid      : out std_logic;
      rx_axis_mac_tlast       : out std_logic;
      rx_axis_mac_tuser       : out std_logic;
      tx_ifg_delay            : in  std_logic_vector(7 downto 0);
      tx_statistics_vector    : out std_logic_vector(31 downto 0);
      tx_statistics_valid     : out std_logic;
      tx_mac_aclk             : out std_logic;
      tx_reset                : out std_logic;
      tx_axis_mac_tdata       : in  std_logic_vector(7 downto 0);
      tx_axis_mac_tvalid      : in  std_logic;
      tx_axis_mac_tlast       : in  std_logic;
      tx_axis_mac_tuser       : in  std_logic_vector(0 downto 0);
      tx_axis_mac_tready      : out std_logic;
      pause_req               : in  std_logic;
      pause_val               : in  std_logic_vector(15 downto 0);
      speedis100              : out std_logic;
      speedis10100            : out std_logic;
      rgmii_txd               : out std_logic_vector(3 downto 0);
      rgmii_tx_ctl            : out std_logic;
      rgmii_txc               : out std_logic;
      rgmii_rxd               : in  std_logic_vector(3 downto 0);
      rgmii_rx_ctl            : in  std_logic;
      rgmii_rxc               : in  std_logic;
      inband_link_status      : out std_logic;
      inband_clock_speed      : out std_logic_vector(1 downto 0);
      inband_duplex_status    : out std_logic;
      rx_configuration_vector : in  std_logic_vector(79 downto 0);
      tx_configuration_vector : in  std_logic_vector(79 downto 0));
  end component tri_mode_ethernet_mac_0;

  component mac_fifo_axi4 is
    port (
      m_aclk        : in  STD_LOGIC;
      s_aclk        : in  STD_LOGIC;
      s_aresetn     : in  STD_LOGIC;
      s_axis_tvalid : in  STD_LOGIC;
      s_axis_tready : out STD_LOGIC;
      s_axis_tdata  : in  STD_LOGIC_VECTOR (7 downto 0);
      s_axis_tlast  : in  STD_LOGIC;
      s_axis_tuser  : in  STD_LOGIC_VECTOR (0 to 0);
      m_axis_tvalid : out STD_LOGIC;
      m_axis_tready : in  STD_LOGIC;
      m_axis_tdata  : out STD_LOGIC_VECTOR (7 downto 0);
      m_axis_tlast  : out STD_LOGIC;
      m_axis_tuser  : out STD_LOGIC_VECTOR (0 to 0));
  end component mac_fifo_axi4;



  ------------------------------------------------------------------------------
  -- internal signals used in this top level wrapper.
  ------------------------------------------------------------------------------

  -- example design clocks
  signal gtx_clk_bufg   : std_logic;
  signal pay_clk        : std_logic;
  signal refclk_bufg    : std_logic;
  signal ipbus_clk_bufg : std_logic;
  signal rx_mac_aclk    : std_logic;
  signal tx_mac_aclk    : std_logic;
  signal phy_resetn_int : std_logic;
  -- resets (and reset generation)
  signal vector_resetn  : std_logic;
  signal chk_resetn     : std_logic;

  signal gtx_resetn : std_logic;

  signal rx_reset : std_logic;
  signal tx_reset : std_logic;

  --signal dcm_locked      : std_logic;
  signal glbl_rst_int    : std_logic;
  signal phy_reset_count : unsigned(5 downto 0) := (others => '0');
  signal glbl_rst_intn   : std_logic;

  -- USER side RX AXI-S interface
  signal rx_fifo_clock  : std_logic;
  signal rx_fifo_resetn : std_logic;

  signal rx_axis_fifo_tdata : std_logic_vector(7 downto 0);

  signal rx_axis_fifo_tvalid : std_logic;
  signal rx_axis_fifo_tlast  : std_logic;
  signal rx_axis_fifo_tready : std_logic;


  -- USER side TX AXI-S interface
  signal tx_fifo_clock  : std_logic;
  signal tx_fifo_resetn : std_logic;

  signal tx_axis_fifo_tdata : std_logic_vector(7 downto 0);

  signal tx_axis_fifo_tvalid : std_logic;
  signal tx_axis_fifo_tlast  : std_logic;
  signal tx_axis_fifo_tready : std_logic;

  signal rx_configuration_vector : std_logic_vector(79 downto 0);
  signal tx_configuration_vector : std_logic_vector(79 downto 0);


  -- set board defaults - only updated when reprogrammed


  signal mac_addr       : std_logic_vector(47 downto 0);  -- MAC address
  signal ip_addr        : std_logic_vector(31 downto 0);  -- IP address
  signal ipb_in         : ipb_rbus;                       -- ipbus
  signal ipb_out        : ipb_wbus;
  -----------------------------------------------------------------------------
  signal rst_ipb        : std_logic := '1';
  signal ipbus_in       : ipb_wbus;
  signal ipbus_out      : ipb_rbus;
  signal ipbus_shim_out : ipb_wbus;
  signal ipbus_shim_in  : ipb_rbus;
  -----------------------------------------------------------------------------
  signal user_data      : std_logic_vector(31 downto 0);




  -----------------------------------------------------------------------------
  -- signal rx_mac_aclk             : std_logic;                      -- [out]
 --  signal rx_reset                : std_logic;                      -- [out]
 

  signal rx_axis_mac_tdata       : std_logic_vector(7 downto 0);   -- [out]
  signal rx_axis_mac_tvalid      : std_logic;                      -- [out]
  signal rx_axis_mac_tlast       : std_logic;                      -- [out]
  signal rx_axis_mac_tuser       : std_logic;                      -- [out]
  
  signal tx_axis_mac_tdata       : std_logic_vector(7 downto 0);   -- [in]
  signal tx_axis_mac_tvalid      : std_logic;                      -- [in]
  signal tx_axis_mac_tlast       : std_logic;                      -- [in]
  signal tx_axis_mac_tuser       : std_logic_vector(0 downto 0);   -- [in]
  signal tx_axis_mac_tready      : std_logic;                      -- [out]




  signal m_axis_tvalid : STD_LOGIC;                      -- [out]
  signal m_axis_tready : STD_LOGIC;                      -- [in]
  signal m_axis_tdata  : STD_LOGIC_VECTOR (7 downto 0);  -- [out]
  signal m_axis_tlast  : STD_LOGIC;                      -- [out]

  signal s_axis_tuser  : STD_LOGIC_VECTOR (0 to 0);      -- [in]
  signal m_axis_tuser  : STD_LOGIC_VECTOR (0 to 0);      -- [out]
  ------------------------------------------------------------------------------
  -- Begin architecture
  ------------------------------------------------------------------------------

begin
  -----------------------------------------------------------------------------
  -- ETH mac IP core
  -----------------------------------------------------------------------------
  tri_mode_ethernet_mac_0_1: tri_mode_ethernet_mac_0
    port map (
      gtx_clk                 => s_axi_aclk,    
      gtx_clk90               => gtx_clk_90,  
      glbl_rstn               => dcm_locked,
      rx_axi_rstn             => '1',
      tx_axi_rstn             => '1',   
      rx_statistics_vector    => open ,  
      rx_statistics_valid     => open ,   
      rx_mac_aclk             => rx_mac_aclk, 
      rx_reset                => rx_reset,  
      rx_axis_mac_tdata       => rx_axis_mac_tdata, 
      rx_axis_mac_tvalid      => rx_axis_mac_tvalid,
      rx_axis_mac_tlast       => rx_axis_mac_tlast, 
      rx_axis_mac_tuser       => rx_axis_mac_tuser,
      tx_ifg_delay            => X"00",  
      tx_statistics_vector    => open ,  
      tx_statistics_valid     => open ,   
      tx_mac_aclk             => open ,   
      tx_reset                => open ,  
      tx_axis_mac_tdata       => tx_axis_mac_tdata,  -- [in  std_logic_vector(7 downto 0)]
      tx_axis_mac_tvalid      => tx_axis_mac_tvalid,  -- [in  std_logic]
      tx_axis_mac_tlast       => tx_axis_mac_tlast,  -- [in  std_logic]
      tx_axis_mac_tuser       => tx_axis_mac_tuser,  -- [in  std_logic_vector(0 downto 0)]
      tx_axis_mac_tready      => tx_axis_mac_tready,  -- [out std_logic]
      pause_req               => '0',  
      pause_val               => X"0000", 
      speedis100              => open ,   
      speedis10100            => open ,  
      rgmii_txd               => rgmii_txd, 
      rgmii_tx_ctl            => rgmii_tx_ctl,
      rgmii_txc               => rgmii_txc,  
      rgmii_rxd               => rgmii_rxd,  
      rgmii_rx_ctl            => rgmii_rx_ctl,
      rgmii_rxc               => rgmii_rxc,
      inband_link_status      => open ,  
      inband_clock_speed      => open ,  
      inband_duplex_status    => open , 
      rx_configuration_vector => X"0000_0000_0000_0000_0812",
      tx_configuration_vector => X"0000_0000_0000_0000_0012");


  s_axis_tuser(0) <= rx_axis_mac_tuser;
  -----------------------------------------------------------------------------
  -- axi FIFO
  -----------------------------------------------------------------------------

  
  mac_fifo_axi4_1: mac_fifo_axi4
    port map (
      m_aclk        => s_axi_aclk,      
      s_aclk        => rx_mac_aclk,        
      s_aresetn     => not rx_reset,     
      s_axis_tvalid => rx_axis_mac_tvalid,  
      s_axis_tready => open ,  
      s_axis_tdata  => rx_axis_mac_tdata, 
      s_axis_tlast  => rx_axis_mac_tlast,    
      s_axis_tuser  => s_axis_tuser,
  
      m_axis_tvalid => m_axis_tvalid,  
      m_axis_tready => '1',  
      m_axis_tdata  => m_axis_tdata,   
      m_axis_tlast  => m_axis_tlast,  
      m_axis_tuser  => m_axis_tuser); 


-------------------------------------------------------------------------------
-- IPBUS reset
-------------------------------------------------------------------------------
  process (s_axi_aclk) is
    variable reset_counter_running  : std_logic := '1';
    variable internal_reset_counter : integer   := 0;
  begin  -- process
    if rising_edge(s_axi_aclk) then  -- rising clock edge
      if reset_counter_running = '1' then
        internal_reset_counter := internal_reset_counter + 1;
        rst_ipb                <= '1';
      end if;
      if internal_reset_counter = 62500000 then
        rst_ipb               <= '0';
        reset_counter_running := '0';
      end if;
    end if;
  end process;
-------------------------------------------------------------------------------
-- ipbus subsystem: controller and payload
-------------------------------------------------------------------------------


  ipbus_ctrl_1 : entity work.ipbus_ctrl
    generic map (
      ADDRWIDTH     => 12,       -- [natural]
      INTERNALWIDTH => 2)
    port map (
      -- all inputs
      mac_clk    => s_axi_aclk,        -- Ethernet MAC clock (125MHz)

      rst_macclk => rst_ipb,   -- MAC clock domain sync reset 
      -- active high
      ipb_clk    => ipb_gtx_pay_clk,      -- IPbus clock
      rst_ipb    => rst_ipb,             -- IPbus clock domain sync reset
      -- active high

      mac_rx_data  => m_axis_tdata,   -- AXI4 style MAC signals
      mac_rx_valid => m_axis_tvalid,  -- 
      mac_rx_last  => m_axis_tlast,   -- all input
      mac_rx_error => m_axis_tuser(0),                  -- 

      mac_tx_data  => tx_axis_mac_tdata,   -- 
      mac_tx_valid => tx_axis_mac_tvalid,  -- 
      mac_tx_last  => tx_axis_mac_tlast,   -- all output
      mac_tx_error => tx_axis_mac_tuser(0),                 --
      mac_tx_ready => tx_axis_mac_tready,  -- input

      ipb_out  => ipb_out,              -- wbus IPbus bus signals
      ipb_in   => ipb_in,               -- rbus
      --
      -- ipb_req     => ipb_req,         -- out
      -- ipb_grant   => ipb_grant,       -- have a default value 
      mac_addr => mac_addr,             -- Static MAC and IP addresses
      ip_addr  => X"0a0a0a10" ,              --  Static IP address

      -- enable      => enable,          -- have a default value
      RARP_select => '1'                -- have a default value
     -- pkt         => pkt,             -- out
     -- pkt_oob     => pkt_oob,         --  out
     -- oob_in      => oob_in,          --  have a default value
     -- oob_out     => oob_out          -- out
      );
  -----------------------------------------------------------------------------
  -- MAC Address read from usr access register
  -----------------------------------------------------------------------------
  USR_ACCESSE2_inst : USR_ACCESSE2
    port map (
      CFGCLK    => open,       -- 1-bit output: Configuration Clock output
      DATA      => user_data,  -- 32-bit output: Configuration Data output
      DATAVALID => open        -- 1-bit output: Active high data valid output

      );

  mac_addr <= X"020ddba1" & user_data(15 downto 0);
  gcu_id_o <= user_data(31 downto 16);

-------------------------------------------------------------------------------
-- enable/disable ipbus shim
-------------------------------------------------------------------------------

  ipbus_shim_1 : entity work.ipbus_shim
    generic map (
      ENABLE => false)
    port map (
      clk            => ipb_gtx_pay_clk,
      reset          => '0',
      ipbus_in       => ipb_out,
      ipbus_out      => ipb_in,
      ipbus_shim_out => ipbus_shim_out,
      ipbus_shim_in  => ipbus_shim_in);


  payload_1 : entity work.payload
    port map (
      board_clk         => '0',
      ipb_clk           => ipb_gtx_pay_clk,  -- in 
      ipb_rst           => '0',
      ipb_in            => ipbus_shim_out,  -- in 
      ipb_out           => ipbus_shim_in,   -- out
      clk               => s_axi_aclk,    -- in
      rst               => '0',             -- in
      nuke              => open,            -- out
      soft_rst          => open,            -- out
      userled           => open,            -- out
      ext_trigger       => ext_trigger,
      adc_raw_data      => adc_raw_data,
      adc_user_clk      => adc_user_clk,
      adu_enables       => adu_enables,
      adu_clock_enables => adu_clock_enables,
      gcu_id            => user_data(31 downto 16),
      bec_connected     => bec_connected,
      -- interface with synch link
      local_time        => local_time,
      l1a_time          => l1a_time,
      l1a_time_ready    => l1a_time_ready,
      trig_request      => trig_request,

      time_to_send      => time_to_send,
      aligned_i         => aligned_i,
      dlyctrl_ready     => dlyctrl_ready,
      dlyctrl_reset     => dlyctrl_reset
      );

end wrapper;
