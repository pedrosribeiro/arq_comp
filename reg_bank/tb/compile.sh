# entities
ghdl -a ../../register/register16.vhd
ghdl -e register16

ghdl -a ../reg_bank_8x16.vhd
ghdl -e reg_bank_8x16

# testbench
ghdl -a reg_bank_8x16_tb.vhd
ghdl -e reg_bank_8x16_tb

# run and view
ghdl -r reg_bank_8x16_tb --wave=compiled/reg_bank_8x16_tb.ghw
gtkwave compiled/reg_bank_8x16_tb.ghw
