ghdl -a mux8x1.vhd
ghdl -e mux8x1

ghdl -a alu.vhd
ghdl -e alu

ghdl -a register16.vhd
ghdl -e register16

ghdl -a reg_bank_8x16.vhd
ghdl -e reg_bank_8x16

ghdl -a mux2x1.vhd
ghdl -e mux2x1

ghdl -a processing_unit_tb.vhd
ghdl -e processing_unit_tb

ghdl -r processing_unit_tb --wave=processing_unit_tb.ghw
gtkwave processing_unit_tb.ghw