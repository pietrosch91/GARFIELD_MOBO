tri_mode_ethernet_mac_0.dcp: tri_mode_ethernet_mac_0.xci
	vivado -mode batch -source create_ip.tcl
	patch -p0  < tri_mode_ethernet_mac_0_rgmii_v2_0_if.vhd.diff
	vivado -mode batch -source synth_ip.tcl

clean:
	./clean.sh
