# entities
ghdl -a ../rom_128x17.vhd
ghdl -e rom_128x17

# testbench
ghdl -a rom_128x17_tb.vhd
ghdl -e rom_128x17_tb

# run and view
ghdl -r rom_128x17_tb --wave=rom_128x17_tb.ghw
gtkwave rom_128x17_tb.ghw
