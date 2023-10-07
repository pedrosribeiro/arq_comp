ghdl -a ../rom_128x17.vhd
ghdl -e rom_128x17

ghdl -a rom_128x17_tb.vhd
ghdl -e rom_128x17_tb

ghdl -r rom_128x17_tb --wave=rom_128x17_tb.ghw
gtkwave rom_128x17_tb.ghw
