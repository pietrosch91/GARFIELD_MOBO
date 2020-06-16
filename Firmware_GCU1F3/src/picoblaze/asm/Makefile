SRCS=scratchpad_manager.asm sja1105_terminal.asm sja_config.asm  software_delays.asm spi_routines.asm uart_interface_routines.asm
rom.vhd:$(SRCS) 
	#opbasm -c -r -d --m4  -x   -6  -i sja1105_terminal.asm  -m 2048 -n rom -t ../ROM_form_templates/ROM_form_JTAGLoader_Vivado_2June14.vhd
	opbasm -c -r -d --m4  -x   -6  -i sja1105_terminal.asm  -m 4096 -n rom -t ../ROM_form_templates/ROM_form_7S_4K_14March13.vhd 
clean:
	rm -f  *fmt *psm *vhd *log *hex

all: rom.vhd
