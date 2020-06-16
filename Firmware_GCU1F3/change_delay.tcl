set partNum xc7k325tffg900-2
set outputDir ./results
set topentityname top_gcu1f3
set bitstreamname firmware.bit
set flash_bitstreamname firmware.mcs
file mkdir $outputDir

open_checkpoint $outputDir/post_route.dcp

set_property IDELAY_VALUE 0 [get_cells network_interface_i/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/U0/rgmii_interface/delay_rgmii_rx_ctl]
set_property IDELAY_VALUE 0 [get_cells {network_interface_i/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/U0/rgmii_interface/rxdata_bus[0].delay_rgmii_rxd}]
set_property IDELAY_VALUE 0 [get_cells {network_interface_i/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/U0/rgmii_interface/rxdata_bus[1].delay_rgmii_rxd}]
set_property IDELAY_VALUE 0 [get_cells {network_interface_i/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/U0/rgmii_interface/rxdata_bus[2].delay_rgmii_rxd}]
set_property IDELAY_VALUE 0 [get_cells {network_interface_i/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/U0/rgmii_interface/rxdata_bus[3].delay_rgmii_rxd}]

set_property BITSTREAM.CONFIG.USR_ACCESS 0x00021512 [current_design]
#                                             ^^
#                                             ||
#                                        GCU ID MAC ADDRESS ( last 16 bit ) 
# genderate a smaller bitstream
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
write_bitstream -force $outputDir/$bitstreamname
#program fpga
open_hw
connect_hw_server
open_hw_target
current_hw_device [get_hw_devices xc6slx25_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc6slx25_0] 0]
current_hw_device [get_hw_devices xc7k325t_1]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7k325t_1] 0]
set_property PROBES.FILE {} [get_hw_devices xc7k325t_1]
set_property FULL_PROBES.FILE {} [get_hw_devices xc7k325t_1]
set_property PROGRAM.FILE {/home/filippo/git/Firmware_GCU1F3/results/firmware.bit} [get_hw_devices xc7k325t_1]
program_hw_devices [get_hw_devices xc7k325t_1]
refresh_hw_device [lindex [get_hw_devices xc7k325t_1] 0]
