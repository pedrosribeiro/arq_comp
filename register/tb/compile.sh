# entities
ghdl -a ../register16.vhd
ghdl -e register16

# testbench
ghdl -a register16_tb.vhd
ghdl -e register16_tb

# run and view
ghdl -r register16_tb --wave=compiled/register16_tb.ghw
gtkwave compiled/register16_tb.ghw
