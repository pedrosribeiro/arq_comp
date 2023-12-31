# entities
ghdl -a ../../mux/mux4x1.vhd
ghdl -e mux4x1

ghdl -a ../alu.vhd
ghdl -e alu

# testbench
ghdl -a alu_tb.vhd
ghdl -e alu_tb

# run and view
ghdl -r alu_tb --wave=compiled/alu_tb.ghw
gtkwave compiled/alu_tb.ghw