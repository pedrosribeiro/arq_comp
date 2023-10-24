# entities
ghdl -a ../../mux/mux8x1.vhd
ghdl -e mux8x1

ghdl -a ../../alu/alu.vhd
ghdl -e alu

ghdl -a ../../register/register16.vhd
ghdl -e register16

ghdl -a ../../reg_bank/reg_bank_8x16.vhd
ghdl -e reg_bank_8x16

ghdl -a ../../mux/mux2x1.vhd
ghdl -e mux2x1

ghdl -a ../processor.vhd
ghdl -e processor

# testbench
ghdl -a processor_tb.vhd
ghdl -e processor_tb

# run and view
ghdl -r processor_tb --wave=compiled/processor_tb.ghw
gtkwave compiled/processor_tb.ghw
