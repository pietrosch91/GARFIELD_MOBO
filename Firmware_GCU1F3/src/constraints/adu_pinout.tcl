#reset on dipswitch 0
# set_property PACKAGE_PIN  AH15  [get_ports RESET_IN ]
# set_property PULLDOWN true [get_ports RESET_IN ]
# set_property IOSTANDARD LVCMOS18 [get_ports RESET_IN ]

#SPI port for the three ADU
#ADU 0
set_property PACKAGE_PIN  B19   [get_ports {adc_spi_clk[0]}]
set_property PACKAGE_PIN	A20 	[get_ports {adc_spi_en[0]}]
set_property PACKAGE_PIN	B18	  [get_ports {adc_spi_mosi[0]}]
set_property PACKAGE_PIN	A18	  [get_ports {adc_spi_miso[0]}]
set_property PACKAGE_PIN	D23	  [get_ports {pll_le[0]}]
set_property PACKAGE_PIN	C19	  [get_ports {adcb_scsb[0]}]
set_property PACKAGE_PIN	A21	  [get_ports {adca_scsb[0]}]

set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_clk[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_en[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_mosi[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_miso[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {pll_le[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adcb_scsb[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adca_scsb[0]}]

#ADU 1
set_property PACKAGE_PIN  E21 [get_ports {adc_spi_clk[1]}]
set_property PACKAGE_PIN	U23 [get_ports {adc_spi_en[1]}]
set_property PACKAGE_PIN	E23 [get_ports {adc_spi_mosi[1]}]
set_property PACKAGE_PIN	B23 [get_ports {adc_spi_miso[1]}]
set_property PACKAGE_PIN	F23 [get_ports {pll_le[1]}]
set_property PACKAGE_PIN	W21 [get_ports {adcb_scsb[1]}]
set_property PACKAGE_PIN	V21 [get_ports {adca_scsb[1]}]

set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_clk[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_en[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_mosi[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_miso[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {pll_le[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adcb_scsb[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adca_scsb[1]}]


#ADU 2
set_property PACKAGE_PIN  V22 	[get_ports {adc_spi_clk[2]}]
set_property PACKAGE_PIN	E25		[get_ports {adc_spi_en[2]}]
set_property PACKAGE_PIN	V24		[get_ports {adc_spi_mosi[2]}]
set_property PACKAGE_PIN	U24		[get_ports {adc_spi_miso[2]}]
set_property PACKAGE_PIN	F25		[get_ports {pll_le[2]}]
set_property PACKAGE_PIN	W19		[get_ports {adcb_scsb[2]}]
set_property PACKAGE_PIN	E24		[get_ports {adca_scsb[2]}]

set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_clk[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_en[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_mosi[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_spi_miso[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {pll_le[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adcb_scsb[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {adca_scsb[2]}]


# DAC

set_property PACKAGE_PIN A26   	[get_ports dac_spi_ck]
set_property PACKAGE_PIN B22 		[get_ports dac_spi_syncn]
set_property PACKAGE_PIN A22 		[get_ports dac_spi_mosi]
set_property PACKAGE_PIN A25 		[get_ports dac_ldac]
#set to '1' fixed on top level
set_property PACKAGE_PIN C22 		[get_ports dac_clr]
#set to '1' fixed on top level
set_property PACKAGE_PIN D22 		[get_ports dac_por]

set_property IOSTANDARD LVCMOS25 [get_ports dac_spi_ck]
set_property IOSTANDARD LVCMOS25 [get_ports dac_spi_syncn]
set_property IOSTANDARD LVCMOS25 [get_ports dac_spi_mosi]
set_property IOSTANDARD LVCMOS25 [get_ports dac_ldac]
set_property IOSTANDARD LVCMOS25 [get_ports dac_clr]
set_property IOSTANDARD LVCMOS25 [get_ports dac_por]

#test pulse out

set_property PACKAGE_PIN A23	[get_ports {cal_ctrl[0]}]
set_property PACKAGE_PIN W22 	[get_ports {cal_ctrl[1]}]
set_property PACKAGE_PIN W23 	[get_ports {cal_ctrl[2]}]

set_property IOSTANDARD  LVCMOS25 [get_ports {cal_ctrl[0]}]
set_property IOSTANDARD	 LVCMOS25 [get_ports {cal_ctrl[1]}]
set_property IOSTANDARD	 LVCMOS25 [get_ports {cal_ctrl[2]}]
#ADU reference clock 
set_property PACKAGE_PIN G19 [get_ports {ext_clk[0]}]
set_property PACKAGE_PIN M19 [get_ports {ext_clk[1]}]
set_property PACKAGE_PIN R24 [get_ports {ext_clk[2]}]

set_property IOSTANDARD LVCMOS25 [get_ports {ext_clk[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ext_clk[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ext_clk[2]}]

# FEC
#Fec, set '1' fixed on top level

set_property PACKAGE_PIN AE26  [get_ports adc_gcl]
set_property PACKAGE_PIN AE28  [get_ports adc_gcm]
set_property IOSTANDARD  LVTTL [get_ports adc_gcl]
set_property IOSTANDARD  LVTTL [get_ports adc_gcm]
#Fec, set '0' fixed on top level
set_property PACKAGE_PIN Y26 [get_ports adc_gch]
set_property IOSTANDARD  LVTTL [get_ports adc_gch]


#ADC DATA and clock
# ADU 0 ADC A
set_property PACKAGE_PIN  D17    [get_ports {adca_dclkp[0]}]

set_property PACKAGE_PIN  F15   [get_ports {adca_dp[0][0]}]
set_property PACKAGE_PIN	H15		[get_ports {adca_dp[0][1]}]
set_property PACKAGE_PIN	J17		[get_ports {adca_dp[0][2]}]
set_property PACKAGE_PIN	L17		[get_ports {adca_dp[0][3]}]
set_property PACKAGE_PIN	L16		[get_ports {adca_dp[0][4]}]
set_property PACKAGE_PIN	D26		[get_ports {adca_dp[0][5]}]
set_property PACKAGE_PIN	H11		[get_ports {adca_dp[0][6]}]
set_property PACKAGE_PIN	L15		[get_ports {adca_dp[0][7]}]
set_property PACKAGE_PIN	F11		[get_ports {adca_dp[0][8]}]
set_property PACKAGE_PIN	K13		[get_ports {adca_dp[0][9]}]
set_property PACKAGE_PIN	C17		[get_ports {adca_dp[0][10]}]
set_property PACKAGE_PIN	A16		[get_ports {adca_dp[0][11]}]
set_property PACKAGE_PIN	C15		[get_ports {adca_dp[0][12]}]
set_property PACKAGE_PIN	B13		[get_ports {adca_dp[0][13]}]

set_property PACKAGE_PIN  C25   [get_ports adca_syncp[0]]

set_property IOSTANDARD LVDS_25 [get_ports adca_dclkp[0]]

set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][0]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][1]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][2]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][3]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][4]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][5]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][6]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][7]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][8]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][9]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][10]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][11]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][12]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[0][13]}]

set_property IOSTANDARD LVDS_25 [get_ports adca_syncp[0]]


# ADU 0 ADC B
set_property PACKAGE_PIN  D12    [get_ports adcb_dclkp[0]]

set_property PACKAGE_PIN  F12   [get_ports {adcb_dp[0][0]}]
set_property PACKAGE_PIN  J11   [get_ports {adcb_dp[0][1]}]
set_property PACKAGE_PIN  K14   [get_ports {adcb_dp[0][2]}]
set_property PACKAGE_PIN  L11   [get_ports {adcb_dp[0][3]}]
set_property PACKAGE_PIN  C12   [get_ports {adcb_dp[0][4]}]
set_property PACKAGE_PIN  A11   [get_ports {adcb_dp[0][5]}]
set_property PACKAGE_PIN  H21   [get_ports {adcb_dp[0][6]}]
set_property PACKAGE_PIN  D21   [get_ports {adcb_dp[0][7]}]
set_property PACKAGE_PIN  C20   [get_ports {adcb_dp[0][8]}]
set_property PACKAGE_PIN  G17   [get_ports {adcb_dp[0][9]}]
set_property PACKAGE_PIN  B14   [get_ports {adcb_dp[0][10]}]
set_property PACKAGE_PIN  E14   [get_ports {adcb_dp[0][11]}]
set_property PACKAGE_PIN  D14   [get_ports {adcb_dp[0][12]}]
set_property PACKAGE_PIN  D11   [get_ports {adcb_dp[0][13]}]

set_property PACKAGE_PIN  G13   [get_ports adcb_syncp[0]]

set_property IOSTANDARD LVDS_25 [get_ports adcb_dclkp[0]]

set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][0]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][1]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][2]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][3]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][4]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][5]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][6]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][7]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][8]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][9]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][10]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][11]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][12]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[0][13]}]

set_property IOSTANDARD LVDS_25 [get_ports adcb_syncp[0]]


# ADU 1 ADC A
set_property PACKAGE_PIN  L25    [get_ports adca_dclkp[1]]

set_property PACKAGE_PIN  J27   [get_ports {adca_dp[1][0]}]
set_property PACKAGE_PIN  G27   [get_ports {adca_dp[1][1]}]
set_property PACKAGE_PIN  G28   [get_ports {adca_dp[1][2]}]
set_property PACKAGE_PIN  K23   [get_ports {adca_dp[1][3]}]
set_property PACKAGE_PIN  J23   [get_ports {adca_dp[1][4]}]
set_property PACKAGE_PIN  J21   [get_ports {adca_dp[1][5]}]
set_property PACKAGE_PIN  G22   [get_ports {adca_dp[1][6]}]
set_property PACKAGE_PIN  J29   [get_ports {adca_dp[1][7]}]
set_property PACKAGE_PIN  H30   [get_ports {adca_dp[1][8]}]
set_property PACKAGE_PIN  G29   [get_ports {adca_dp[1][9]}]
set_property PACKAGE_PIN  E29   [get_ports {adca_dp[1][10]}]
set_property PACKAGE_PIN  D29   [get_ports {adca_dp[1][11]}]
set_property PACKAGE_PIN  B30   [get_ports {adca_dp[1][12]}]
set_property PACKAGE_PIN  F26   [get_ports {adca_dp[1][13]}]

set_property PACKAGE_PIN  E28   [get_ports adca_syncp[1]]

set_property IOSTANDARD LVDS_25 [get_ports adca_dclkp[1]]

set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][0]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][1]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][2]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][3]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][4]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][5]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][6]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][7]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][8]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][9]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][10]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][11]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][12]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[1][13]}]

set_property IOSTANDARD LVDS_25 [get_ports adca_syncp[1]]


# ADU 1 ADC B
set_property PACKAGE_PIN  D27   [get_ports adcb_dclkp[1]]

set_property PACKAGE_PIN  C29   [get_ports {adcb_dp[1][0]}]
set_property PACKAGE_PIN  C24   [get_ports {adcb_dp[1][1]}]
set_property PACKAGE_PIN  G23   [get_ports {adcb_dp[1][2]}]
set_property PACKAGE_PIN  L21   [get_ports {adcb_dp[1][3]}]
set_property PACKAGE_PIN  B28   [get_ports {adcb_dp[1][4]}]
set_property PACKAGE_PIN  B27   [get_ports {adcb_dp[1][5]}]
set_property PACKAGE_PIN  K19   [get_ports {adcb_dp[1][6]}]
set_property PACKAGE_PIN  K18   [get_ports {adcb_dp[1][7]}]
set_property PACKAGE_PIN  M20   [get_ports {adcb_dp[1][8]}]
set_property PACKAGE_PIN  E19   [get_ports {adcb_dp[1][9]}]
set_property PACKAGE_PIN  J19   [get_ports {adcb_dp[1][10]}]
set_property PACKAGE_PIN  G18   [get_ports {adcb_dp[1][11]}]
set_property PACKAGE_PIN  D16   [get_ports {adcb_dp[1][12]}]
set_property PACKAGE_PIN  J16   [get_ports {adcb_dp[1][13]}]

set_property PACKAGE_PIN  F20   [get_ports adcb_syncp[1]]

set_property IOSTANDARD LVDS_25 [get_ports adcb_dclkp[1]]

set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][0]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][1]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][2]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][3]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][4]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][5]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][6]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][7]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][8]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][9]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][10]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][11]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][12]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[1][13]}]

set_property IOSTANDARD LVDS_25 [get_ports adcb_syncp[1]]




# ADU 2 ADC A
set_property PACKAGE_PIN  U27    [get_ports adca_dclkp[2]]

set_property PACKAGE_PIN V25    [get_ports {adca_dp[2][0]}]
set_property PACKAGE_PIN V19    [get_ports {adca_dp[2][1]}]
set_property PACKAGE_PIN V26    [get_ports {adca_dp[2][2]}]
set_property PACKAGE_PIN T25    [get_ports {adca_dp[2][3]}]
set_property PACKAGE_PIN N25    [get_ports {adca_dp[2][4]}]
set_property PACKAGE_PIN M24    [get_ports {adca_dp[2][5]}]
set_property PACKAGE_PIN N21    [get_ports {adca_dp[2][6]}]
set_property PACKAGE_PIN M22    [get_ports {adca_dp[2][7]}]
set_property PACKAGE_PIN H26    [get_ports {adca_dp[2][8]}]
set_property PACKAGE_PIN H24    [get_ports {adca_dp[2][9]}]
set_property PACKAGE_PIN L22    [get_ports {adca_dp[2][10]}]
set_property PACKAGE_PIN V29    [get_ports {adca_dp[2][11]}]
set_property PACKAGE_PIN U29    [get_ports {adca_dp[2][12]}]
set_property PACKAGE_PIN R30    [get_ports {adca_dp[2][13]}]

set_property PACKAGE_PIN  T26  [get_ports adca_syncp[2]]

set_property IOSTANDARD LVDS_25 [get_ports adca_dclkp[2]]

set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][0]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][1]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][2]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][3]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][4]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][5]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][6]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][7]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][8]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][9]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][10]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][11]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][12]}]
set_property IOSTANDARD LVDS_25 [get_ports {adca_dp[2][13]}]

set_property IOSTANDARD LVDS_25 [get_ports adca_syncp[2]]


# ADU 2 ADC B
set_property PACKAGE_PIN  M28   [get_ports adcb_dclkp[2]]

set_property PACKAGE_PIN P29    [get_ports {adcb_dp[2][0]}]
set_property PACKAGE_PIN P26    [get_ports {adcb_dp[2][1]}]
set_property PACKAGE_PIN P27    [get_ports {adcb_dp[2][2]}] 
set_property PACKAGE_PIN N27    [get_ports {adcb_dp[2][3]}]
set_property PACKAGE_PIN T20    [get_ports {adcb_dp[2][4]}]
set_property PACKAGE_PIN T22    [get_ports {adcb_dp[2][5]}]
set_property PACKAGE_PIN P21    [get_ports {adcb_dp[2][6]}]
set_property PACKAGE_PIN P23    [get_ports {adcb_dp[2][7]}]
set_property PACKAGE_PIN N19    [get_ports {adcb_dp[2][8]}]
set_property PACKAGE_PIN H20    [get_ports {adcb_dp[2][9]}]
set_property PACKAGE_PIN N29    [get_ports {adcb_dp[2][10]}]
set_property PACKAGE_PIN M29    [get_ports {adcb_dp[2][11]}]
set_property PACKAGE_PIN K26    [get_ports {adcb_dp[2][12]}]
set_property PACKAGE_PIN L30    [get_ports {adcb_dp[2][13]}]

set_property PACKAGE_PIN  K28   [get_ports adcb_syncp[2]]

set_property IOSTANDARD LVDS_25 [get_ports adcb_dclkp[2]]

set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][0]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][1]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][2]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][3]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][4]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][5]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][6]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][7]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][8]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][9]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][10]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][11]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][12]}]
set_property IOSTANDARD LVDS_25 [get_ports {adcb_dp[2][13]}]

set_property IOSTANDARD LVDS_25 [get_ports adcb_syncp[2]]
