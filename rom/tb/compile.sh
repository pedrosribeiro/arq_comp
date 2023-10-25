# entities
ghdl -a ../rom_128x17.vhd
ghdl -e rom_128x17

# testbench
ghdl -a rom_128x17_tb.vhd
ghdl -e rom_128x17_tb

# run and view
ghdl -r rom_128x17_tb --wave=compiled/rom_128x17_tb.ghw
gtkwave compiled/rom_128x17_tb.ghw
