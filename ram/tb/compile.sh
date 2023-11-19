# entities
ghdl -a ../ram_128x16.vhd
ghdl -e ram_128x16

# testbench
ghdl -a ram_128x16_tb.vhd
ghdl -e ram_128x16_tb

# run and view
ghdl -r ram_128x16_tb --wave=compiled/ram_128x16_tb.ghw
gtkwave compiled/ram_128x16_tb.ghw