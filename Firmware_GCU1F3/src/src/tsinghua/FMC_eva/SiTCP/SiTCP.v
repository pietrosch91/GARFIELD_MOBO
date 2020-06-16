/*******************************************************************************
*                                                                              *
* System      : BELLE-II CDC readout module                                    *
* Version     : v 4.0.3 2013/06/12                                             *
*                                                                              *
* Description : Top Module                                                     *
*                                                                              *
* Designer    : Tomohisa Uchida                                                *
*                                                                              *
*                Copyright (c) 2011 Tomohisa Uchida                            *
*                All rights reserved                                           *
*                                                                              *
*******************************************************************************/
module SiTCP #(
  parameter [31:0]  BASE_IP_ADDR  = 32'hC0A8_0A10,  //192.168.10.16
  parameter [4 :0]  PHY_ADDRESS   = 5'b0
)(
// System
  input           RST,        // Reset
  input           CLK,        // TCP/UDP clk, may be 125MHz
  input				CLK200,
  output          CLKOUT,     // 125MHz BUFG clock out
// SiTCP setting
  input   [2 : 0] MAC_SELECT,
  input   [2 : 0] IP_SELECT,
  output          TIM_1US,    // out  : 1 us interval
  output          TIM_1MS,    // out  : 1 ms interval
  output          TIM_1S,     // out  : 1 s interval
  output          TIM_1M,     // out  : 1 m interval
// TCP port
  output          TCP_OPEN,
  output          TCP_ERROR,
  output          TCP_RST,
  output          TCP_CLOSE,
  input   [15: 0] TCP_RX_WC,
  output          TCP_RX_WR,
  output  [7 : 0] TCP_RX_DATA,
  output          TCP_TX_FULL,
  input           TCP_TX_WR,
  input   [7 : 0] TCP_TX_DATA,
// UDP port
  output  [31: 0] RBCP_ADDR,
  output          RBCP_WE,
  output  [7 : 0] RBCP_WD,
  output          RBCP_RE,
  output          RBCP_ACT,
  input           RBCP_ACK,
  input   [7 : 0] RBCP_RD,
  
//// 1000Base-T PHY
//  output          PHY_RSTn,
//  // RGMII physical interface: these will be at pins on the FPGA
//  output          RGMII_TXC,
//  output  [3 : 0] RGMII_TXD,
//  output          RGMII_TX_CTL,
//  input           RGMII_RXC,
//  input   [3 : 0] RGMII_RXD,
//  input           RGMII_RX_CTL,
//  // MDIO physical interface: these will be pins on the FPGA
//  output          MDC,
//  inout           MDIO

// SFP
  // input          mgtrefclkp_116,   // SFP, Reference Clock
  // input          mgtrefclkn_116,
  input           GTREFCLK,      // gtp ref clkin
  output          SFP_TXP,    // Tx signal line
  output          SFP_TXN,    //
  input           SFP_RXP,    // Rx signal line
  input           SFP_RXN     //
  
);

TIMER #(
  .CLK_FREQ(8'd125)
)TIMER(
// System
  .CLK(CLK),            // in: System clock
  .RST(RST),            // in: System reset
// Intrrupts
  .TIM_1US(TIM_1US),    // out: 1 us interval
  .TIM_1MS(TIM_1MS),    // out: 1 ms interval
  .TIM_1S(TIM_1S),      // out: 1 s interval
  .TIM_1M(TIM_1M)       // out: 1 min interval
);

//------------------------------------------------------------------------------
//  SiTCP library
//------------------------------------------------------------------------------
wire [47:0] tcp_server_mac;
wire [31:0] tcp_server_addr;
wire [15:0] tcp_server_port;

wire        tcp_open_error;
wire        tcp_tx_ow_error;
assign TCP_ERROR = tcp_open_error | tcp_tx_ow_error;

wire        eth_rstn;
assign PHY_RSTn = eth_rstn;

wire        eth_tx_clk;
wire        eth_tx_clk90;
wire  [7:0] eth_tx_d;
wire        eth_tx_en;
wire        eth_tx_er;
wire        eth_rx_clk;
wire  [7:0] eth_rx_d;
wire        eth_rx_dv;
wire        eth_rx_er;
wire        eth_crs;
wire        eth_col;
wire        mdc_sys, mdio_i_sys, mdio_o_sys, mdio_i_sys_oe;

assign eth_tx_clk = eth_rx_clk;
//------------------------------------------------------------------------------
//  SiTCP library
//------------------------------------------------------------------------------
SiTCP_XC7K_32K_BBT_V80 SiTCP_XC7K_32K_BBT_V80(
  .CLK(CLK),                                      // in: System clock
  .RST(RST),                                      // in: System reset
  .TIM_1US(TIM_1US),                              // in: 1 us interval
  .TIM_1MS(TIM_1MS),                              // in: 1 ms interval
  .TIM_1S(TIM_1S),                                // in: 1 s interval
  .TIM_1M(TIM_1M),                                // in: 1 min interval
// Configuration parameters
  .FORCE_DEFAULTn(1'b0),                          // in: Load default values
  .MODE_GMII(1'b1),                               // in: PHY I/F mode (0:MII, 1:GMII)
  .MIN_RX_IPG(4'd4),                              // in: Min. IPG byte[3:0] range of 3 to 15
  .IP_ADDR_IN(BASE_IP_ADDR[31:0]+IP_SELECT[2:0]), // in: My IP address[31:0]
  .IP_ADDR_DEFAULT(),                             // out: Default value for my IP address[31:0]
  .TCP_MAIN_PORT_IN(16'd24),                      // in: My TCP main-port #[15:0]
  .TCP_MAIN_PORT_DEFAULT(),                       // out: Default value for my TCP main-port #[15:0]
  .TCP_SUB_PORT_IN(16'b0),                        // in: My TCP sub-port #[15:0]
  .TCP_SUB_PORT_DEFAULT(),                        // out: Default value for my TCP sub-port #[15:0]
  .TCP_SERVER_MAC_IN(tcp_server_mac[47:0]),       // in: Client mode, Server MAC address[47:0]
  .TCP_SERVER_MAC_DEFAULT(tcp_server_mac[47:0]),  // out: Default value for the server's MAC address
  .TCP_SERVER_ADDR_IN(tcp_server_addr[31:0]),     // in: Client mode, Server IP address[31:0]
  .TCP_SERVER_ADDR_DEFAULT(tcp_server_addr[31:0]),// out: Default value for the server's IP address
  .TCP_SERVER_PORT_IN(tcp_server_port[15:0]),     // in: Client mode, Server wating port#[15:0]
  .TCP_SERVER_PORT_DEFAULT(tcp_server_port[15:0]),// out: Default value for the server port #[15:0] RBCP_PORT_IN    , // in: My UDP RBCP-port #[15:0]
  .RBCP_PORT_IN(16'd4660),                        // in: My UDP RBCP-port #[15:0]
  .RBCP_PORT_DEFAULT(),                           // out: Default value for my UDP RBCP-port #[15:0]
  .PHY_ADDR(PHY_ADDRESS[4:0]),                    // in: PHY-device MIF address[4:0]
// EEPROM
  .EEPROM_CS(),
  .EEPROM_SK(),
  .EEPROM_DI(),
  .EEPROM_DO(1'b0),
// User data
  .USR_REG_X3C(),
  .USR_REG_X3D(),
  .USR_REG_X3E(),
  .USR_REG_X3F(),
// MII interface
  .GMII_1000M(1'b1),                              // in: GMII mode (0:MII, 1:GMII)
  .GMII_RSTn(eth_rstn),                           // out:PHY reset
  // TX
  .GMII_TX_CLK(eth_tx_clk),                       // in: Tx clock(2.5 or 25MHz or 125MHz)
  .GMII_TX_EN(eth_tx_en),                         // out: Tx enable
  .GMII_TXD(eth_tx_d[7:0]),                       // out: Tx data[7:0]
  .GMII_TX_ER(eth_tx_er),                         // out: TX error
  // RX
  .GMII_RX_CLK(eth_rx_clk),                       // in: Rx clock(2.5 or 25MHz or 125MHz)
  .GMII_RX_DV(eth_rx_dv),                         // in: Rx data valid
  .GMII_RXD(eth_rx_d[7:0]),                       // in: Rx data[7:0]
  .GMII_RX_ER(eth_rx_er),                         // in: Rx error
  .GMII_CRS(1'b0),                             // in: Carrier sense
  .GMII_COL(1'b0),                             // in: Collision detected
  // Management IF
  .GMII_MDC(),                             // out: Clock for MDIO
  .GMII_MDIO_IN(1'b1),                      // in: Data
  .GMII_MDIO_OUT(),                     // out: Data, when GMII_MDIO_OE = 0, GMII_MDIO_OUT = 0. must be pullup
  .GMII_MDIO_OE(),                   // out: MDIO output enable
// User I/F
  .SiTCP_RST(TCP_RST),                            // out: Reset for SiTCP and related circuits
  // TCP connection control
  .OPEN_REQ(1'b0),                                // in: Request to connect connection
  .MAIN_OPEN_ACK(TCP_OPEN),                       // out: Acknowledge for open (=Socket busy)
  .SUB_OPEN_ACK(),                                // out: Acknowledge for the alternative port    .TCP_OPEN_ERROR     (TCP_OPEN_ERROR   ),  // out: TCP client mode / TCP connection error ---- V2.4 -----
  .TCP_OPEN_ERROR(tcp_open_error),                // out: TCP client mode / TCP connection error ---- V2.4 -----
  .TCP_TX_OW_ERROR(tcp_tx_ow_error),              // out: TCP TX buffer, over write error ---- V2.4 -----
  .CLOSE_REQ(TCP_CLOSE),                          // out: Connection close
  .CLOSE_ACK(TCP_CLOSE),                          // in: Acknowledge for close
  // FIFO I/F
  .RX_FILL(TCP_RX_WC[15:0]),                      // in: Fill level[15:0]
  .RX_WR(TCP_RX_WR),                              // out: Write enable
  .RX_DATA(TCP_RX_DATA[7:0]),                     // out: Write data[7:0]
  .TX_FULL(TCP_TX_FULL),                          // out: Almost full flag
  .TX_FILL(),                                     // out: Fill level[15:0]
  .TX_WR(TCP_TX_WR),                              // in: Write enable
  .TX_DATA(TCP_TX_DATA[7:0]),                     // in: Write data[7:0]
  // RBCP
  .LOC_ACT(RBCP_ACT),                             // out: RBCP active
  .LOC_ADDR(RBCP_ADDR[31:0]),                     // out: Address[31:0]
  .LOC_WD(RBCP_WD[7:0]),                          // out: Data[7:0]
  .LOC_WE(RBCP_WE),                               // out: Write enable
  .LOC_RE(RBCP_RE),                               // out: Read enable
  .LOC_ACK(RBCP_ACK),                             // in: Access acknowledge
  .LOC_RD(RBCP_RD[7:0]),                          // in: Read data[7:0]
  .MAC_SELECT(MAC_SELECT[2:0])                    // in: User can select MAC Adrress
);

////---------------------------------------------------------------------------
//// Instantiate RGMII Interface
////---------------------------------------------------------------------------
//wire          link_status;
//wire  [1 : 0] clock_speed;
//wire          duplex_status;
//wire          mdc_out;
//wire          mdio_miso;
//wire          mdio_mosi;
//wire          mdio_mosi_tri;
//// Instantiate the RGMII physical interface logic
//tri_mode_eth_mac_v5_5_rgmii_v2_0_if rgmii_interface (
//  // Synchronous resets
//  .tx_reset         (RST),              // in : Synchronous resets
//  .rx_reset         (RST),              // in : Synchronous resets
//  //----------------------------------------------
//  // MDIO Interface
//  .mdio             (MDIO),             // inout:
//  .mdc              (MDC),              // out:
//  .mdc_i            (mdc_out),          // in :
//  .mdio_o           (mdio_mosi),        // in :
//  .mdio_i           (mdio_miso),        // out:
//  .mdio_t           (mdio_mosi_tri),    // in :
//  // RGMII physical interface: these will be at pins on the FPGA
//  .rgmii_txd        (RGMII_TXD[3:0]),   // out:
//  .rgmii_tx_ctl     (RGMII_TX_CTL),     // out:
//  .rgmii_txc        (RGMII_TXC),        // out:
//  .rgmii_rxd        (RGMII_RXD[3:0]),   // in :
//  .rgmii_rx_ctl     (RGMII_RX_CTL),     // in :
//  .rgmii_rxc        (RGMII_RXC),        // in :
//  // RGMII in-band status signals
//  .link_status      (link_status),      // out:
//  .clock_speed      (clock_speed[1:0]), // out:
//  .duplex_status    (duplex_status),    // out:
//  // internal GMII connections from IOB logic to the MAC core
//  .tx_clk           (eth_tx_clk),       // in :
//  .tx_clk90         (eth_tx_clk90),     // in :
//  .txd_from_mac     (eth_tx_d[7:0]),    // in :
//  .tx_en_from_mac   (eth_tx_en),        // in :
//  .tx_er_from_mac   (eth_tx_er),        // in :
//  // Receiver clock for the MAC and Client Logic
//  .rx_clk           (eth_rx_clk),       // out:
//  .rxd_to_mac       (eth_rx_d[7:0]),    // out:
//  .rx_dv_to_mac     (eth_rx_dv),        // out:
//  .rx_er_to_mac     (eth_rx_er),        // out:
//  .col_to_mac       (eth_col),          // out:
//  .crs_to_mac       (eth_crs)           // out:
//);
//
//MMCM125 mmcm125
// (// Clock in ports
//  .CLK_IN1(eth_rx_clk),     // IN
//  // Clock out ports
//  .CLK_OUT1(eth_tx_clk),    // OUT
//  .CLK_OUT2(eth_tx_clk90),  // OUT
//  // Status and control signals
//  .RESET(RST),              // IN
//  .LOCKED()                 // OUT
//);


wire mdc;
wire mdio_out;
gig_eth_pcs_pma_example_design gig_eth_pcs_pma (
    .independent_clock(CLK200),
	 .gtrefclk(GTREFCLK),
    .txp(SFP_TXP), 
    .txn(SFP_TXN), 
    .rxp(SFP_RXP), 
    .rxn(SFP_RXN), 
    .gmii_tx_clk(eth_tx_clk), 
    .gmii_rx_clk(eth_rx_clk), 
    .gmii_txd(eth_tx_d[7:0]), 
    .gmii_tx_en(eth_tx_en), 
    .gmii_tx_er(eth_tx_er), 
    .gmii_rxd(eth_rx_d[7:0]), 
    .gmii_rx_dv(eth_rx_dv), 
    .gmii_rx_er(eth_rx_er), 
    .mdc(mdc), 
    .mdio_i(mdio_out), 
    .mdio_o(), 
    .mdio_t(), 
    .phyad(PHY_ADDRESS), 
    .configuration_vector(5'd0), 
    .configuration_valid(1'b0), 
    .an_interrupt(), 
    .an_adv_config_vector(16'd0), 
    .an_adv_config_val(1'b0), 
    .an_restart_config(1'b0), 
    .link_timer_value(9'b100111101), 
    .status_vector(), 
    .reset(~eth_rstn), 
    .signal_detect(1'b1)
    ); 
	 
assign CLKOUT = eth_rx_clk;

wire mdio_complete;
mdio_init mdio_init(
  .clk(eth_rx_clk),             // in : system clock (125M)
  .rst(TCP_RST),            // in : system reset
  .phyaddr(PHY_ADDRESS),    // in : [4:0] PHY address
  .mdc(mdc),           // out: clock (1/128 system clock)
  .mdio_out(mdio_out),   // out: connect this to "PCS/PMA + RocketIO" module .mdio?_i()
  .complete(mdio_complete)  // out: initializing sequence has completed (active H)
);

endmodule
//-------------------------------------------------------------------
