##---------------------------------CDR1--------------------------------------##
set_property PACKAGE_PIN AD14 [get_ports cdr1_dataout_n_i]
set_property PACKAGE_PIN AC14 [get_ports cdr1_dataout_p_i]
set_property PACKAGE_PIN AK26 [get_ports cdr1_en_n_o]
set_property PACKAGE_PIN AA21 [get_ports cdr1_in_n_o]
set_property PACKAGE_PIN Y21 [get_ports cdr1_in_p_o]
set_property PACKAGE_PIN AK30 [get_ports cdr1_lol_i]
#set_property PACKAGE_PIN AJ28 [get_ports cdr_scl_o]
#set_property PACKAGE_PIN AK28 [get_ports cdr_sda_io]
set_property PACKAGE_PIN AG17 [get_ports clk_cdr1_n_i]
set_property PACKAGE_PIN AF17 [get_ports clk_cdr1_p_i]
set_property PACKAGE_PIN AB15 [get_ports slink1_rx_n_i]
set_property PACKAGE_PIN AA15 [get_ports slink1_rx_p_i]
set_property PACKAGE_PIN AE21 [get_ports slink1_tx_n_o]
set_property PACKAGE_PIN AD21 [get_ports slink1_tx_p_o]
set_property PACKAGE_PIN AD16 [get_ports xc7k_coax_n_o]
#set_property PACKAGE_PIN AD17 [get_ports xc7k_coax_p_o]

set_property IOSTANDARD LVDS [get_ports cdr1_dataout_n_i]
set_property IOSTANDARD LVDS [get_ports cdr1_dataout_p_i]
set_property IOSTANDARD LVTTL [get_ports cdr1_en_n_o]
set_property IOSTANDARD LVDS_25 [get_ports cdr1_in_n_o]
set_property IOSTANDARD LVDS_25 [get_ports cdr1_in_p_o]
set_property IOSTANDARD LVTTL [get_ports cdr1_lol_i]
#set_property IOSTANDARD  LVCMOS33 [get_ports cdr_scl_o]
#set_property IOSTANDARD  LVCMOS33 [get_ports cdr_sda_io]
set_property IOSTANDARD LVDS [get_ports clk_cdr1_n_i]
set_property IOSTANDARD LVDS [get_ports clk_cdr1_p_i]
set_property IOSTANDARD LVDS [get_ports slink1_rx_n_i]
set_property IOSTANDARD LVDS [get_ports slink1_rx_p_i]
set_property IOSTANDARD LVDS_25 [get_ports slink1_tx_n_o]
set_property IOSTANDARD LVDS_25 [get_ports slink1_tx_p_o]
set_property IOSTANDARD LVCMOS18  [get_ports xc7k_coax_n_o]
#set_property IOSTANDARD LVCMOS18  [get_ports xc7k_coax_p_o]
#--

#set_property PACKAGE_PIN Y18 [get_ports xc7k_led0_o]
#set_property IOSTANDARD LVCMOS18 [get_ports xc7k_led0_o]
#set_property PACKAGE_PIN AB17 [get_ports xc7k_led1_o]
#set_property IOSTANDARD LVCMOS18 [get_ports xc7k_led1_o]
##----------------------------SYSTEM MONITOR-------------------------##
#NET "xc7k_led1_o" LOC = AB17 | IOSTANDARD = "LVCMOS18"; #done
#NET "xc7k_led0_o" LOC = Y18 | IOSTANDARD = "LVCMOS18"; #done

#NET "xc7k_coax_n_o" LOC = AD16 | IOSTANDARD = "LVCMOS18"; #done
#NET "xc7k_coax_p_o" LOC = AD17 | IOSTANDARD = "LVCMOS18"; #done

#Clocks
#TIMESPEC TS_clk_cdr_out = PERIOD s_clk_cdr_in 4 ns HIGH 50 %;
create_clock -period 4.000 -name clk_cdr [get_ports clk_cdr1_p_i]
