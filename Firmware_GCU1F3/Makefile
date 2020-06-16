ip_cores: 
	$(MAKE) -C src/ip_cores

src/picoblaze/asm/rom.vhd: src/picoblaze/asm/*asm
	$(MAKE) -C src/picoblaze/asm/

src/user/ipbus_utils/ipbus_decode_gcu1f3.vhd:
	$(MAKE) -C uhal_scripts/

results/firmware.bit: src/user/ipbus_utils/ipbus_decode_gcu1f3.vhd ip_cores src/user/ipbus_utils/ipbus_decode_gcu1f3.vhd src/picoblaze/asm/rom.vhd
	vivado -nolog -nojournal -mode batch -source create_bitstream.tcl

clean:
	rm -rf results vivado*.jou vivado*.log usage*
	$(MAKE) -C src/picoblaze/asm/ clean

ip_cores_clean: clean
	$(MAKE) -C src/ip_cores clean

program_lab: 
	vivado_lab -nolog -nojournal -mode batch -source program_k7.tcl

program: 
	vivado -nolog -nojournal -mode batch -source program_k7.tcl
all: results/firmware.bit
