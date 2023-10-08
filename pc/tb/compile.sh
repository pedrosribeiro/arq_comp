# entities
ghdl -a ../pc_7.vhd
ghdl -e pc_7

# testbench
ghdl -a pc_7_tb.vhd
ghdl -e pc_7_tb

# run and view
ghdl -r pc_7_tb --wave=compiled/pc_7_tb.ghw
gtkwave compiled/pc_7_tb.ghw