ghdl -a ../pc_7.vhd
ghdl -e pc_7

ghdl -a pc_7_tb.vhd
ghdl -e pc_7_tb

ghdl -r pc_7_tb --wave=compiled/pc_7_tb.ghw
gtkwave compiled/pc_7_tb.ghw